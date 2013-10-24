class Variables
  require 'json'

  def self.get(name)
    JSON.parse(
      File.read(
        Rails.root + "app/models/variables/" + (name + ".json")
      )
    )
  end

  def self.get_structured(name)
    str = JSON.parse(File.read(Rails.root + "app/models/variables/" + (name + ".json")))
    ret = ""
    str.each do |lv1|
      ret += "== LEVEL 1 ==\n"
      ret += "Name: #{lv1['name']}\n"
      ret += "Contains: \n"
      ret += "\t== LEVEL 2 ==\n"
      lv1['values'].each do |lv2|
        ret += "\tName: #{lv2['name']}\n"
        ret += "\tType: #{lv2['type']}\n"
        ret += "\tContains: \n"
        ret += "\t\t== LEVEL 3 ==\n"
        lv2['values'].each do |lv3|
          ret += "\t\tName: #{lv3['name']}\n"
          ret += "\t\tValue: #{lv3['value']}\n" if lv3['value']
          ret += "\t\tIcon: #{lv3['icon']}\n"
        end  
        ret += "\t\t== END LEVEL 3 ==\n\n"
      end      
      ret += "\t== END LEVEL 2 ==\n\n"  
    end    
    ret += "== END LEVEL 1 ==\n\n"
    ret
  end
end
