// sinful.js
// ----------
//
// For the rationale and documentation,
// refer to http://github.com/guipn/sinful.js
//
///////////////////////////////////////////////


void function (bless) {

    'use strict';

    var own      = Object.getOwnPropertyNames,
        bind     = Function.prototype.bind,
        liberate = bind.bind(Function.prototype.call),
        reduce   = liberate(Array.prototype.reduce),
        slice    = liberate(Array.prototype.slice);


    bless = bless || function (thing, name, content) {
        
        if (typeof thing[name] !== 'undefined') {
            throw new Error('Sinful: ' + name + ' is already defined.');
        }

        thing[name] = content;
    };


    // Fixing Floating-point math
    
    // Computes the multiplier necessary to make x >= 1,
    // effectively eliminating miscalculations caused by
    // finite precision.

    function multiplier(x) {

        var parts = x.toString().split('.');

        if (parts.length < 2) {
            return 1;
        }

        return Math.pow(10, parts[1].length);
    }


    // Given a variable number of arguments, returns the maximum
    // multiplier that must be used to normalize an operation involving
    // all of them.

    function correctionFactor() {

        return reduce(arguments, function (prev, next) {

            var mp = multiplier(prev),
                mn = multiplier(next);

        return mp > mn ? mp : mn;

        }, -Infinity);

    }


    // Begin augmenting

    [
        // String interpolation function proposed in Crockford's The Good Parts 

        [String.prototype, 'interp', function (expansions) {

            var that = this;
            own(expansions).forEach(function (key) {
                that = that.replace(new RegExp('\{' + key + '\}', 'g'), expansions[key]);
            });

            return that;
        }],

        [String.prototype, 'reverse', function () {
            return this.split('').reverse().join('');
        }],

        [String.prototype, 'repeat', function (times, sep) {

            sep = sep || '';
        
            return times > 0 ?
                    new Array(times + 1).join(this + sep) :
                    '';
        }],

        [String.prototype, 'truncate', function (maxLen, suffix) {

            maxLen = maxLen || 50;
            suffix = suffix || '...';

            if (maxLen - suffix.length < 0) {
                throw new Error('The suffix "' + suffix + '" is wider than ' + maxLen);
            }

            return this.length > maxLen ?
                    this.slice(0, maxLen - suffix.length) + suffix :
                    this;
        }],
        [Array, 'shortest', function () {

            return slice(arguments).reduce(function (p, c) {
                return (p.length < c.length) ? p : c;
            });
        }],

        [Array, 'longest', function () {

            return slice(arguments).reduce(function (p, c) {
                return (p.length > c.length) ? p : c;
            });
        }],

        [Array, 'zip', function () {

            var args     = slice(arguments),
                shortest = Array.shortest.apply(null, args);

            return shortest.reduce(function (prev, cur, i) {

                prev.push(args.map(function (array) {
                    return array[i];
                }));

                return prev;

            }, []);
        }],

        [Array, 'greedyZip', function () {

            var args    = slice(arguments),
                longest = Array.longest.apply(null, args);

            return longest.reduce(function (prev, cur, i) {

                prev.push(args.map(function (array) {
                    return array[i];
                }));

                return prev;

            }, []);
        }],

        [Array, 'zipWith', function () {

            var zipper   = arguments[0],
                args     = slice(arguments, 1),
                shortest = Array.shortest.apply(null, args);

            return shortest.reduce(function (prev, cur, i) {

                prev.push(zipper.apply(null, args.map(function (array) {
                    return array[i];
                })));

                return prev;
            }, []);

        }],

        [Array, 'greedyZipWith', function () {

            var zipper  = arguments[0],
                args    = slice(arguments, 1),
                longest = Array.longest.apply(null, args);

            return longest.reduce(function (prev, cur, i) {

                prev.push(zipper.apply(null, args.map(function (array) {
                    return array[i];
                })));

                return prev;
            }, []);

        }],

        [Array.prototype, 'unique', function (search) {

            search = search || this.indexOf;

            return this.reduce(function (result, each) {

                if (search.call(result, each) === -1) {
                    result.push(each);
                }

                return result;
            }, []);
        }],

        [Array.prototype, 'partition', function (length) {

            var result, each;

            if (typeof length === 'undefined' || length <= 0) {
                return [];
            }

            result = [];
            each   = [];

            this.forEach(function (value) {

                each.push(value);

                if (each.length === length) {
                    result.push(each);
                    each = [];
                }

            });

            return result.concat(each.length > 0 ? [ each ] : []);
        }],

        [Array.prototype, 'last', function () {
            return this[ this.length - 1 ];
        }],



        [Number.prototype, 'limit', function (lower, upper) {

            if (this > upper) {
                return upper;
            } 
            else if (this < lower) {
                return lower;
            }

            return this.valueOf();
        }],

        [Number.prototype, 'times', function (fun) {
            var result = [];

            for (var i = 0; i < this; i++) {
                result.push(fun(i));
            }

            return result;
        }],

        [Number.prototype, 'to', function (limit, stepper) {

            var list = [],
                i    = this.valueOf(),
                continuePred;
            
            stepper = stepper || function (x) { return x + 1; };

            continuePred = (stepper(i) > i) ? function (x) { return x <= limit; } :
                                              function (x) { return x >= limit; };

            while (continuePred(i)) {
                list.push(i);
                i = stepper(i);
            }

            return list;
        }],



        [Math, 'add', function () {

            var corrFactor = correctionFactor.apply(null, arguments);

            function cback(accum, curr, currI, O) {
                return accum + corrFactor * curr;
            }

            return reduce(arguments, cback, 0) / corrFactor;
        }],

        [Math, 'sub', function () {

            var corrFactor = correctionFactor.apply(null, arguments),
                first      = arguments[0];

            function cback(accum, curr, currI, O) {
                return accum - corrFactor * curr;
            }

            delete arguments[0];

            return reduce(arguments, 
                    cback, first * corrFactor) / corrFactor;
        }],

        [Math, 'mul', function () {

            function cback(accum, curr, currI, O) {

                var corrFactor = correctionFactor(accum, curr);

                return (accum * corrFactor) * (curr * corrFactor) /
                    (corrFactor * corrFactor);
            }

            return reduce(arguments, cback, 1);
        }],

        [Math, 'div', function () {

            function cback(accum, curr, currI, O) {

                var corrFactor = correctionFactor(accum, curr);

                return (accum * corrFactor) / (curr * corrFactor);
            }

            return reduce(arguments, cback);
        }],


    ].forEach(function (blessing) {
        bless(blessing.shift(), blessing.shift(), blessing.shift());
    });
}(/* Provide your own 'bless' to be used as above if custom behavior needed. */);
