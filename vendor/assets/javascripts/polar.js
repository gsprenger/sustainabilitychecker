/*!
 * polar.js
 * https://github.com/gsprenger/polar-iaste
 *
 * Copyright 2014 Gabriel Sprenger
 * Released under the MIT license
 * https://github.com/gsprenger/polar-iaste/blob/master/LICENSE.md
 */

//Define the global Chart Variable as a class.
window.Chart = function(context, paramMargin){
	var chart = this;

	//Easing functions adapted from Robert Penner's easing equations
	//http://www.robertpenner.com/easing/
	var animationOptions = {
		linear : function (t){
			return t;
		},
		easeInQuad: function (t) {
			return t*t;
		},
		easeOutQuad: function (t) {
			return -1 *t*(t-2);
		},
		easeInOutQuad: function (t) {
			if ((t/=1/2) < 1) return 1/2*t*t;
			return -1/2 * ((--t)*(t-2) - 1);
		},
		easeInCubic: function (t) {
			return t*t*t;
		},
		easeOutCubic: function (t) {
			return 1*((t=t/1-1)*t*t + 1);
		},
		easeInOutCubic: function (t) {
			if ((t/=1/2) < 1) return 1/2*t*t*t;
			return 1/2*((t-=2)*t*t + 2);
		},
		easeInQuart: function (t) {
			return t*t*t*t;
		},
		easeOutQuart: function (t) {
			return -1 * ((t=t/1-1)*t*t*t - 1);
		},
		easeInOutQuart: function (t) {
			if ((t/=1/2) < 1) return 1/2*t*t*t*t;
			return -1/2 * ((t-=2)*t*t*t - 2);
		},
		easeInQuint: function (t) {
			return 1*(t/=1)*t*t*t*t;
		},
		easeOutQuint: function (t) {
			return 1*((t=t/1-1)*t*t*t*t + 1);
		},
		easeInOutQuint: function (t) {
			if ((t/=1/2) < 1) return 1/2*t*t*t*t*t;
			return 1/2*((t-=2)*t*t*t*t + 2);
		},
		easeInSine: function (t) {
			return -1 * Math.cos(t/1 * (Math.PI/2)) + 1;
		},
		easeOutSine: function (t) {
			return 1 * Math.sin(t/1 * (Math.PI/2));
		},
		easeInOutSine: function (t) {
			return -1/2 * (Math.cos(Math.PI*t/1) - 1);
		},
		easeInExpo: function (t) {
			return (t==0) ? 1 : 1 * Math.pow(2, 10 * (t/1 - 1));
		},
		easeOutExpo: function (t) {
			return (t==1) ? 1 : 1 * (-Math.pow(2, -10 * t/1) + 1);
		},
		easeInOutExpo: function (t) {
			if (t==0) return 0;
			if (t==1) return 1;
			if ((t/=1/2) < 1) return 1/2 * Math.pow(2, 10 * (t - 1));
			return 1/2 * (-Math.pow(2, -10 * --t) + 2);
			},
		easeInCirc: function (t) {
			if (t>=1) return t;
			return -1 * (Math.sqrt(1 - (t/=1)*t) - 1);
		},
		easeOutCirc: function (t) {
			return 1 * Math.sqrt(1 - (t=t/1-1)*t);
		},
		easeInOutCirc: function (t) {
			if ((t/=1/2) < 1) return -1/2 * (Math.sqrt(1 - t*t) - 1);
			return 1/2 * (Math.sqrt(1 - (t-=2)*t) + 1);
		},
		easeInElastic: function (t) {
			var s=1.70158;var p=0;var a=1;
			if (t==0) return 0;  if ((t/=1)==1) return 1;  if (!p) p=1*.3;
			if (a < Math.abs(1)) { a=1; var s=p/4; }
			else var s = p/(2*Math.PI) * Math.asin (1/a);
			return -(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*1-s)*(2*Math.PI)/p ));
		},
		easeOutElastic: function (t) {
			var s=1.70158;var p=0;var a=1;
			if (t==0) return 0;  if ((t/=1)==1) return 1;  if (!p) p=1*.3;
			if (a < Math.abs(1)) { a=1; var s=p/4; }
			else var s = p/(2*Math.PI) * Math.asin (1/a);
			return a*Math.pow(2,-10*t) * Math.sin( (t*1-s)*(2*Math.PI)/p ) + 1;
		},
		easeInOutElastic: function (t) {
			var s=1.70158;var p=0;var a=1;
			if (t==0) return 0;  if ((t/=1/2)==2) return 1;  if (!p) p=1*(.3*1.5);
			if (a < Math.abs(1)) { a=1; var s=p/4; }
			else var s = p/(2*Math.PI) * Math.asin (1/a);
			if (t < 1) return -.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*1-s)*(2*Math.PI)/p ));
			return a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*1-s)*(2*Math.PI)/p )*.5 + 1;
		},
		easeInBack: function (t) {
			var s = 1.70158;
			return 1*(t/=1)*t*((s+1)*t - s);
		},
		easeOutBack: function (t) {
			var s = 1.70158;
			return 1*((t=t/1-1)*t*((s+1)*t + s) + 1);
		},
		easeInOutBack: function (t) {
			var s = 1.70158; 
			if ((t/=1/2) < 1) return 1/2*(t*t*(((s*=(1.525))+1)*t - s));
			return 1/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2);
		},
		easeInBounce: function (t) {
			return 1 - animationOptions.easeOutBounce (1-t);
		},
		easeOutBounce: function (t) {
			if ((t/=1) < (1/2.75)) {
				return 1*(7.5625*t*t);
			} else if (t < (2/2.75)) {
				return 1*(7.5625*(t-=(1.5/2.75))*t + .75);
			} else if (t < (2.5/2.75)) {
				return 1*(7.5625*(t-=(2.25/2.75))*t + .9375);
			} else {
				return 1*(7.5625*(t-=(2.625/2.75))*t + .984375);
			}
		},
		easeInOutBounce: function (t) {
			if (t < 1/2) return animationOptions.easeInBounce (t*2) * .5;
			return animationOptions.easeOutBounce (t*2-1) * .5 + 1*.5;
		}
	};

	//Variables global to the chart
  var margin = (paramMargin == null ? 0 : paramMargin);
  var originalWidth = context.canvas.width;
	var originalHeight = context.canvas.height;
  var height = originalHeight - 2*margin;
  var width = originalWidth - 2*margin;
  var centerX = originalWidth/2;
  var centerY = originalHeight/2;
	var position;

	//High pixel density displays - multiply the size of the canvas height/width by the device pixel ratio, then scale.
	if (window.devicePixelRatio) {
		context.canvas.style.width = originalWidth + "px";
		context.canvas.style.height = originalHeight + "px";
		context.canvas.height = originalHeight * window.devicePixelRatio;
		context.canvas.width = originalWidth * window.devicePixelRatio;
		context.scale(window.devicePixelRatio, window.devicePixelRatio);
	}

	this.PolarArea = function(data,options){
		chart.PolarArea.defaults = {
			scaleOverlay : true,
			scaleOverride : false,
			scaleSteps : null,
			scaleStepWidth : null,
			scaleStartValue : null,
			scaleShowLine : true,
			scaleLineColor : "rgba(0,0,0,.1)",
			scaleLineWidth : 1,
			scaleShowLabels : true,
			scaleLabel : "<%=value%>",
			scaleFontFamily : "'Arial'",
			scaleFontSize : 12,
			scaleFontStyle : "normal",
			scaleFontColor : "#666",
			scaleShowLabelBackdrop : true,
			scaleBackdropColor : "rgba(255,255,255,0.75)",
			scaleBackdropPaddingY : 2,
			scaleBackdropPaddingX : 2,
			segmentShowStroke : true,
			segmentStrokeColor : "#fff",
			segmentStrokeWidth : 2,
			animation : true,
			animationSteps : 100,
			animationEasing : "easeOutBounce",
			animateRotate : true,
			animateScale : false,
			onAnimationComplete : null,
      showLabels: false
		};
		var config = (options)? mergeChartConfig(chart.PolarArea.defaults,options) : chart.PolarArea.defaults;
		return new PolarArea(data,config,context);
	};
	
	var clear = function(c){
		c.clearRect(0, 0, originalWidth, originalHeight);
	};

	function calculateOffset(val,calculatedScale,scaleHop){
		var outerValue = calculatedScale.steps * calculatedScale.stepValue;
		var adjustedValue = val - calculatedScale.graphMin;
		var scalingFactor = CapValue(adjustedValue/outerValue,1,0);
		return (scaleHop*calculatedScale.steps) * scalingFactor;
	}
	
	function animationLoop(config,drawScale,drawData,ctx){
		var animFrameAmount = (config.animation)? 1/CapValue(config.animationSteps,Number.MAX_VALUE,1) : 1,
			easingFunction = animationOptions[config.animationEasing],
			percentAnimComplete =(config.animation)? 0 : 1;
		if (typeof drawScale !== "function") drawScale = function(){};
		requestAnimFrame(animLoop);
		
		function animateFrame(){
			var easeAdjustedAnimationPercent =(config.animation)? CapValue(easingFunction(percentAnimComplete),null,0) : 1;
			clear(ctx);
			if(config.scaleOverlay){
				drawData(easeAdjustedAnimationPercent);
				drawScale();
			} else {
				drawScale();
				drawData(easeAdjustedAnimationPercent);
			}				
		}

		function animLoop(){
			//We need to check if the animation is incomplete (less than 1), or complete (1).
			percentAnimComplete += animFrameAmount;
			animateFrame();	
			//Stop the loop continuing forever
			if (percentAnimComplete <= 1){
				requestAnimFrame(animLoop);
			}
			else{
				// Get the final position of the canvas
				position = getPosition(context.canvas);
				if (typeof config.onAnimationComplete == "function") config.onAnimationComplete();
			}
		}		
	}

	// shim layer with setTimeout fallback
	var requestAnimFrame = (function(){
		return window.requestAnimationFrame ||
			window.webkitRequestAnimationFrame ||
			window.mozRequestAnimationFrame ||
			window.oRequestAnimationFrame ||
			window.msRequestAnimationFrame ||
			function(callback) {
				window.setTimeout(callback, 1000 / 60);
			};
	})();

	function calculateScale(drawingHeight,maxSteps,minSteps,maxValue,minValue,labelTemplateString){
			var graphMin,graphMax,graphRange,stepValue,numberOfSteps,valueRange,rangeOrderOfMagnitude,decimalNum;
			valueRange = maxValue - minValue;
			rangeOrderOfMagnitude = calculateOrderOfMagnitude(valueRange);
    	graphMin = Math.floor(minValue / (1 * Math.pow(10, rangeOrderOfMagnitude))) * Math.pow(10, rangeOrderOfMagnitude);
      graphMax = Math.ceil(maxValue / (1 * Math.pow(10, rangeOrderOfMagnitude))) * Math.pow(10, rangeOrderOfMagnitude);
      graphRange = graphMax - graphMin;
      stepValue = Math.pow(10, rangeOrderOfMagnitude);
      numberOfSteps = Math.round(graphRange / stepValue);
      //Compare number of steps to the max and min for that size graph, and add in half steps if need be.	        
      while(numberOfSteps < minSteps || numberOfSteps > maxSteps) {
      	if (numberOfSteps < minSteps){
	        stepValue /= 2;
	        numberOfSteps = Math.round(graphRange/stepValue);
        }
        else{
	        stepValue *=2;
	        numberOfSteps = Math.round(graphRange/stepValue);
        }
      }
      var labels = [];
      populateLabels(labelTemplateString, labels, numberOfSteps, graphMin, stepValue);
      return {
        steps: numberOfSteps,
				stepValue: stepValue,
				graphMin: graphMin,
				labels: labels
      }

			function calculateOrderOfMagnitude(val){
			  return Math.floor(Math.log(val) / Math.LN10);
			}		
	}

  //Populate an array of all the labels by interpolating the string.
  function populateLabels(labelTemplateString, labels, numberOfSteps, graphMin, stepValue) {
      if (labelTemplateString) {
          //Fix floating point errors by setting to fixed the on the same decimal as the stepValue.
          for (var i = 1; i < numberOfSteps + 1; i++) {
              labels.push(tmpl(labelTemplateString, {value: (graphMin + (stepValue * i)).toFixed(getDecimalPlaces(stepValue))}));
          }
      }
  }
	
	//Max value from array
	function Max( array ){
		return Math.max.apply( Math, array );
	}

	//Min value from array
	function Min( array ){
		return Math.min.apply( Math, array );
	}

	//Default if undefined
	function Default(userDeclared,valueIfFalse){
		if(!userDeclared){
			return valueIfFalse;
		} else {
			return userDeclared;
		}
	}

	//Is a number function
	function isNumber(n) {
		return !isNaN(parseFloat(n)) && isFinite(n);
	}

	//Apply cap a value at a high or low number
	function CapValue(valueToCap, maxValue, minValue){
		if(isNumber(maxValue)) {
			if( valueToCap > maxValue ) {
				return maxValue;
			}
		}
		if(isNumber(minValue)){
			if ( valueToCap < minValue ){
				return minValue;
			}
		}
		return valueToCap;
	}

	function getDecimalPlaces (num){
		var numberOfDecimalPlaces;
		if (num%1!=0){
			return num.toString().split(".")[1].length
		}
		else{
			return 0;
		}
		
	} 
	
	function mergeChartConfig(defaults,userDefined){
		var returnObj = {};
	    for (var attrname in defaults) { returnObj[attrname] = defaults[attrname]; }
	    for (var attrname in userDefined) { returnObj[attrname] = userDefined[attrname]; }
	    return returnObj;
	}

	function getPosition(e) {
		var xPosition = 0;
		var yPosition = 0;
		while(e) {
			xPosition += (e.offsetLeft + e.clientLeft);
			yPosition += (e.offsetTop + e.clientTop);
			e = e.offsetParent;
		}
		if(window.pageXOffset > 0 || window.pageYOffset > 0) {
			xPosition -= window.pageXOffset;
			yPosition -= window.pageYOffset;
		} else if(document.body.scrollLeft > 0 || document.body.scrollTop > 0) {
			xPosition -= document.body.scrollLeft;
			yPosition -= document.body.scrollTop;
		}
		return { x: xPosition, y: yPosition };
	}
	
	//Javascript micro templating by John Resig - source at http://ejohn.org/blog/javascript-micro-templating/
  var cache = {};
	 
  function tmpl(str, data){
    // Figure out if we're getting a template, or if we need to
    // load the template - and be sure to cache the result.
    var fn = !/\W/.test(str) ?
      cache[str] = cache[str] ||
      tmpl(document.getElementById(str).innerHTML) :
      // Generate a reusable function that will serve as a template
      // generator (and which will be cached).
      new Function("obj",
        "var p=[],print=function(){p.push.apply(p,arguments);};" +
        // Introduce the data as local variables using with(){}
        "with(obj){p.push('" + 
        // Convert the template into pure JavaScript
        str
          .replace(/[\r\t\n]/g, " ")
          .split("<%").join("\t")
          .replace(/((^|%>)[^\t]*)'/g, "$1\r")
          .replace(/\t=(.*?)%>/g, "',$1,'")
          .split("\t").join("');")
          .split("%>").join("p.push('")
          .split("\r").join("\\'")
      + "');}return p.join('');");
    // Provide some basic currying to the user
    return data ? fn( data ) : fn;
  }

	function is_touch_device() {
	  return !!('ontouchstart' in window) // works on most browsers 
	      || !!('onmsgesturechange' in window); // works on ie10
	}

  var PolarArea = function(data,config,ctx){
    var maxSize, scaleHop, calculatedScale, labelHeight, scaleHeight, valueBounds, labelTemplateString;
    var dataAreas = [], hoveredArea;    
    calculateDrawingSizes();
    valueBounds = getValueBounds();
    labelTemplateString = (config.scaleShowLabels)? config.scaleLabel : null;
    // Check and set the scale
    if (!config.scaleOverride){
      calculatedScale = calculateScale(scaleHeight,valueBounds.maxSteps,valueBounds.minSteps,valueBounds.maxValue,valueBounds.minValue,labelTemplateString);
    }
    else {
      calculatedScale = {
        steps : config.scaleSteps,
        stepValue : config.scaleStepWidth,
        graphMin : config.scaleStartValue,
        labels : []
      }
      populateLabels(labelTemplateString, calculatedScale.labels,calculatedScale.steps,config.scaleStartValue,config.scaleStepWidth);
    }
    scaleHop = maxSize/(calculatedScale.steps);
    // Wrap in an animation loop wrapper
    animationLoop(config,drawScale,drawAllSegments,ctx);
    // Set up mouse/touch events
    if (is_touch_device()) {
      context.canvas.ontouchstart = function(e) {
        e.offsetX = e.targetTouches[0].clientX - position.x;
        e.offsetY = e.targetTouches[0].clientY - position.y;
        activeAreaHandler(e);
      }
      context.canvas.ontouchmove = function(e) {
        e.offsetX = e.targetTouches[0].clientX - position.x;
        e.offsetY = e.targetTouches[0].clientY - position.y;
        activeAreaHandler(e);
      }
    } else {
      context.canvas.onmousemove = function(e) {
        activeAreaHandler(e);
      }
    }

    function activeAreaHandler(event) {
      var offsetX = event.hasOwnProperty('offsetX') ? event.offsetX : event.layerX;
      var offsetY = event.hasOwnProperty('offsetY') ? event.offsetY : event.layerY;
      var mouse_on_area = false;
      for (var i in data) {
        var dataArea = dataAreas[i];
        if (data[dataArea.areaIndex].mouseover && isPointInSector(offsetX, offsetY, dataArea)) {
          mouse_on_area = true;
          if (hoveredArea != dataArea) {
            if (hoveredArea) {
              // We jumped from one area to the next, so fire the mouseout first for that area
              if (data[hoveredArea.areaIndex].mouseout) {
                data[hoveredArea.areaIndex].mouseout({event: event, area: dataArea});
              }
            }
            hoveredArea = dataArea;
            data[dataArea.areaIndex].mouseover({event: event, area: dataArea});
          }
          break;
        }
      }
      if (!mouse_on_area && hoveredArea) {
        if (data[hoveredArea.areaIndex].mouseout) {
          data[hoveredArea.areaIndex].mouseout({event: event, area: dataArea});
        }
        hoveredArea = null;
      }
      if (mouse_on_area) {
        context.canvas.style.cursor = 'pointer';
      } else {
        context.canvas.style.cursor = 'default';
      }
    }

    function drawScale(){
      // If axis must be drawn
      if (config.scaleShowXYAxis) {
        // X Axis
        ctx.beginPath();
        ctx.moveTo(margin, centerY);
        ctx.lineTo(originalWidth-margin, centerY);
        ctx.strokeStyle = '#999999';
        ctx.lineWidth = 2;
        ctx.stroke();
        // Y Axis
        ctx.beginPath();
        ctx.moveTo(centerX, margin);
        ctx.lineTo(centerX, originalHeight-margin);
        ctx.strokeStyle = '#999999';
        ctx.lineWidth = 2;
        ctx.stroke();
      } else if (config.scaleShowQuintAxis) {
        var angleScale = function (i) {
          return (i*Math.PI/5)-(Math.PI/2);
        };
        for (var i=0; i<5; i++) {
          var x = (width/2+10)*Math.cos(angleScale(2*i)) + centerX,
              y = (height/2+10)*Math.sin(angleScale(2*i)) + centerY;
          ctx.beginPath();
          ctx.moveTo(centerX, centerY);
          ctx.lineTo(x, y);
          ctx.strokeStyle = '#999999';
          ctx.lineWidth = 2;
          ctx.stroke();
        }
      }
      for (var i=0; i<calculatedScale.steps; i++){
        //If the line object is there
        if (config.scaleShowLine){
          ctx.beginPath();
          ctx.arc(centerX, centerY, scaleHop * (i + 1), 0, (Math.PI * 2), true);
          ctx.strokeStyle = config.scaleLineColor;
          ctx.lineWidth = config.scaleLineWidth;
          ctx.stroke();
        }
      }
    }

    function drawAllSegments(animationDecimal){
      var startAngle = -Math.PI/2
      scaleAnimation = 1,
      rotateAnimation = 1;
      if (config.animation) {
        if (config.animateScale) {
          scaleAnimation = animationDecimal;
        }
        if (config.animateRotate){
          rotateAnimation = animationDecimal;
        }
      }
      for (var i=0; i<data.length; i++) {
        // cap value if out of bounds
        data[i].value = CapValue(data[i].value, data[i].max, data[i].min);
        var angleStep = data[i].angle*0.0174532925;
        var area = {
          centerPoint: {
            x: centerX,
            y: centerY
          },
          radius: scaleAnimation * (((data[i].value-data[i].min)/(data[i].max-data[i].min))*maxSize),
          startAngle: startAngle,
          endAngle: startAngle + rotateAnimation*angleStep,
          areaIndex: i
        };
        area.startPoint = {
          x: area.radius*Math.cos(area.startAngle) + area.centerPoint.x,
          y: area.radius*Math.sin(area.startAngle) + area.centerPoint.y
        };
        area.endPoint = {
          x: area.radius*Math.cos(area.endAngle) + area.centerPoint.x,
          y: area.radius*Math.sin(area.endAngle) + area.centerPoint.y
        };
        dataAreas[area.areaIndex] = area;
        ctx.beginPath();
        ctx.arc(area.centerPoint.x, area.centerPoint.y, area.radius, area.startAngle, area.endAngle, false);
        ctx.lineTo(area.centerPoint.x, area.centerPoint.y);
        ctx.closePath();
        ctx.fillStyle = data[i].color;
        ctx.fill();
        if(config.segmentShowStroke){
          ctx.strokeStyle = config.segmentStrokeColor;
          ctx.lineWidth = config.segmentStrokeWidth;
          ctx.stroke();
        }
        // draw label
        if (config.showLabels) {
          if (area.radius != 0) {
            var labelAngle = startAngle + (area.endAngle-startAngle)/2,
                txt1 = data[i].name+' ['+data[i].min+','+data[i].max+']',
                txt2 = data[i].value+' '+data[i].unit;
            var labelX = (width/2+20)*Math.cos(labelAngle) + area.centerPoint.x,
                labelY = (height/2+20)*Math.sin(labelAngle) + area.centerPoint.y;
            var overXC = (labelX > centerX),
                overYC = (labelY > centerY);
            var w = ctx.measureText(txt1).width,
                w2 = ctx.measureText(txt2).width,
                h = config.scaleFontSize,
                paddingY = 4;
            labelX -= (w/2);
            if (overYC) {
              labelY += h; 
            }
            ctx.fillStyle = '#000000';
            ctx.fillText(txt1, labelX, labelY);
            ctx.fillText(txt2, labelX+((w-w2)/2), labelY+h+paddingY);
            // underline txt1
            ctx.beginPath();
            ctx.moveTo(labelX, labelY+paddingY);
            ctx.lineTo(labelX+w, labelY+paddingY);
            ctx.strokeStyle = '#333333';
            ctx.lineWidth = 1;
            ctx.stroke();
          }
        }
        // draw section
        if (data[i].section && data[i].section !== '') {
          ctx.font ='bold 12px Arial';
          var angleTab = [];
          if (config.scaleShowXYAxis) {
            index = (data.length == 8? [0, 2, 4, 6] : [1, 7, 13, 19])
            angleTab[index[0]] = -Math.PI/4;
            angleTab[index[1]] = Math.PI/4;
            angleTab[index[2]] = (3*Math.PI)/4;
            angleTab[index[3]] = (5*Math.PI)/4;
          } else if (config.scaleShowQuintAxis) {
            angleTab[1] = (Math.PI/5)-(Math.PI/2);
            angleTab[7] = (3*Math.PI/5)-(Math.PI/2);
            angleTab[13] = (5*Math.PI/5)-(Math.PI/2);
            angleTab[19] = (7*Math.PI/5)-(Math.PI/2);
            angleTab[25] = (9*Math.PI/5)-(Math.PI/2);
          }
          var sectionX = (width/2+40)*Math.cos(angleTab[i]) + area.centerPoint.x,
              sectionY = (height/2+40)*Math.sin(angleTab[i]) + area.centerPoint.y,
              txt = data[i].section;
          var overXC = (sectionX > width/2),
              overYC = (sectionY > height/2);
          var w = ctx.measureText(txt).width,
              h = config.scaleFontSize;
          if (overXC) {
            if (overYC) {;
              sectionY += h; 
            }
          } else {
            if (overYC) {
              sectionX -= w;
              sectionY += h;
            } else {
              sectionX -= w;
            }
          }
          ctx.fillStyle = '#000000';
          ctx.fillText(data[i].section, sectionX, sectionY);
          ctx.beginPath();
          ctx.rect(sectionX-4, sectionY-h, w+8, h+4);
          ctx.lineWidth = 1;
          ctx.strokeStyle = '#000000';
          ctx.stroke();
          ctx.font ='12px Arial';
        }
        startAngle = area.endAngle;
      }
    }

    function isPointInSector(x, y, areaData) {
      var topV = {
            x: areaData.startPoint.x - areaData.centerPoint.x,
            y: areaData.centerPoint.y - areaData.startPoint.y,
          },
          botV = {
            x: areaData.endPoint.x - areaData.centerPoint.x,
            y: areaData.centerPoint.y - areaData.endPoint.y,
          },
          relV = {
            x: x - areaData.centerPoint.x,
            y: areaData.centerPoint.y - y
          };
      return !areClockwise(botV, relV) &&
         areClockwise(topV, relV) &&
         isWithinRadius(relV, Math.pow(areaData.radius, 2));

      function areClockwise(v1, v2) {
        return -v1.x*v2.y + v1.y*v2.x > 0;
      }

      function isWithinRadius(v, radiusSquared) {
        return v.x*v.x + v.y*v.y <= radiusSquared;
      }
    }

    function calculateDrawingSizes(){
      maxSize = (Min([width,height])/2);
      //Remove whatever is larger - the font size or line width.
      maxSize -= Max([config.scaleFontSize*0.5,config.scaleLineWidth*0.5]);
      labelHeight = config.scaleFontSize*2;
      //If we're drawing the backdrop - add the Y padding to the label height and remove from drawing region.
      if (config.scaleShowLabelBackdrop){
        labelHeight += (2 * config.scaleBackdropPaddingY);
        maxSize -= config.scaleBackdropPaddingY*1.5;
      }
      scaleHeight = maxSize;
      //If the label height is less than 5, set it to 5 so we don't have lines on top of each other.
      labelHeight = Default(labelHeight,5);
    }

    function getValueBounds() {
      var upperValue = Number.MIN_VALUE;
      var lowerValue = Number.MAX_VALUE;
      for (var i=0; i<data.length; i++){
        if (data[i].value > upperValue) {upperValue = data[i].value;}
        if (data[i].value < lowerValue) {lowerValue = data[i].value;}
      };
      var maxSteps = Math.floor((scaleHeight / (labelHeight*0.66)));
      var minSteps = Math.floor((scaleHeight / labelHeight*0.5));
      return {
        maxValue : upperValue,
        minValue : lowerValue,
        maxSteps : maxSteps,
        minSteps : minSteps
      };
    }
  }
}
