module VariablesHelper
  def collapse_id(lv1)
    "collapse_" + lv1['name'].downcase
  end

  def generate_lv3(name, type, values)
    html = ""

    case type
    when "radio"
      html = generate_radio_lv3(name, values)
    when "sliders"
    when "sliders100"
    end

    html
  end

  def generate_radio_lv3(name, values) 
    html = 
    '<div class="row">'

    values.each do |v|
      name.downcase!
      vname = v['name'].downcase

      html +=
      '<div class="col-md-4">' +
      '  <div class="radio">' +
      '    <label>' + 
      '      <img href="#" alt="' + vname + '">' +  
      '      <input type="radio" name="radio-' + name + '" id="radio-' + name + '-' + vname + '" value="' + vname + '">' + 
      '    </label>' + 
      '  </div>' +
      '</div>'
    end
    
    html += 
    '</div>'
  end
end
