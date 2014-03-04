class AdminController < ApplicationController
  layout 'static_pages'
  http_basic_authenticate_with :name => "iaste", :password => (ENV['ADMIN_PWD'] || 'dev')
  def admin
    array = [
      ['static', 'static_title', 'The Sustainability Checker'],
      ['static', 'static_subtitle', 'A didactic, interactive tool to understand and discuss sustainability issues'],
      ['static', 'static_footer', 'A didactic, interactive tool to understand and discuss sustainability issues proposed by the IASTE research group of the Universitat Autònoma de Barcelona.<br/>'],
      ['static', 'static_copyright', '<em>&copy; 2013 <abbr title="Integrated Assessment: Sociology, Technology and the Environment">IASTE</abbr></em>'],
      ['contact', 'contact_title', 'How to contact us?'],
      ['contact', 'contact_visit_title', 'Visit Us!'],
      ['contact', 'contact_visit_desc', 'Our research group is located on the Bellaterra Campus of the Universitat Autònoma de Barcelona, in the Facultat de Ciències (Building C). <br/><br/>The Bellaterra Campus is located about 20 km outside of Barcelona and can be conveniently reached from Barcelona\'s city centre by Ferrocarril (FGC, line Barcelona-Vallès, destination: Universitat Autònoma). At Plaça Catalunya, take line S-2 (green, towards Sabadell) or S-55 (blue, towards Universitat Autònoma) and get off at the stop Universitat Autònoma". The trip takes about 30 minutes and trains leave about every 10 minutes. <br/><br/>We look forward to welcome you!'],
      ['contact', 'contact_email_title', 'Via email'],
      ['contact', 'contact_address_title', 'Via postal address'],
      ['contact', 'contact_address_desc', 'You can write to us at the following address: <br><em>Integrated Assessment group - Pr. Mario Giampietro <br>Institute for Environmental Science and Technology (ICTA) <br>Universitat Autònoma de Barcelona (UAB) <br>Edifici C, Campus de la UAB <br>08193 Bellaterra (Cerdanyola del Vallès) – Barcelona <br>Spain </em>'],
      ['home', 'home_desc', 'All natural and technological processes proceed in such a way that the availability of the remaining energy decreases. In all energy exchanges, if no energy enters or leaves an isolated system, the entropy of that system increases. Energy continuously flows from being concentrated, to becoming dispersed, spread out, wasted and useless. New energy cannot be created and high grade energy is being destroyed. An economy based on endless growth is unsustainable. The fundamental laws of thermodynamics will place fixed limits on technological innovation and human advancement. In an isolated system the entropy can only increase. A species set on endless growth is unsustainable. All natural and technological processes proceed in such a way that the availability of the remaining energy decreases. In all energy exchanges, if no energy enters or leaves an isolated system, the entropy of that system increases.'],
      ['home', 'home_btn_start', 'Let\'s Start!'],
      ['home', 'home_btn_info', 'Wait, what does it mean?'],
      ['legal', 'legal_title', 'Legal Terms and Conditions'],
      ['presentation', 'pres_title', 'What is it?'],
      ['presentation', 'pres_desc', 'All natural and technological processes proceed in such a way that the availability of the remaining energy decreases. In all energy exchanges, if no energy enters or leaves an isolated system, the entropy of that system increases. Energy continuously flows from being concentrated, to becoming dispersed, spread out, wasted and useless. New energy cannot be created and high grade energy is being destroyed. An economy based on endless growth is unsustainable. The fundamental laws of thermodynamics will place fixed limits on technological innovation and human advancement. In an isolated system the entropy can only increase. A species set on endless growth is unsustainable. All natural and technological processes proceed in such a way that the availability of the remaining energy decreases. In all energy exchanges, if no energy enters or leaves an isolated system, the entropy of that system increases.'],
      ['presentation', 'pres_btn', 'I got it, let\'s start!'],
      ['checker', 'chkr_demand', 'Demand'],
      ['checker', 'chkr_supply', 'Supply'],
      ['checker', 'chkr_check', 'Check'],
      ['checker', 'chkr_check_title', 'Sustainability Check'],
      ['checker', 'chkr_summary_title', 'Summary of selected data:'],
      ['checker', 'chkr_summary_btn', 'Check now!'],
      ['checker', 'chkr_start_title', 'The Sustainability Checker <br>'],
      ['checker', 'chkr_start_subtitle', 'A didactic, interactive tool to understand and discuss sustainability issues'],
      ['checker', 'chkr_start_desc', 'How easy is it for a country to become self-sustained? 9 questions (and a <em>little</em> math) is all it takes to find out!'],
      ['checker', 'chkr_start_btn', 'Start the experience!'],
      ['checker', 'chkr_dem_title', 'Socio-demographics '],
      ['checker', 'chkr_dem_subtitle', 'Typology of society'],
      ['checker', 'chkr_dem_desc', '<p><strong>How would you define your population?</strong></p><p>A more developped country has more requirements.</p>'],
      ['checker', 'chkr_die_title', 'Diet '],
      ['checker', 'chkr_die_subtitle', 'Meat Consumption'],
      ['checker', 'chkr_die_desc', '<p><strong>How much animal products (meat, eggs, milk...) does your population consume?</strong></p><p>The more meat your people eat, the more food you will have to produce to feed your animals.</p>'],
      ['checker', 'chkr_hou_title', 'Households '],
      ['checker', 'chkr_hou_subtitle', 'Typology'],
      ['checker', 'chkr_hou_desc', '<p><strong>What is the proportion of urban population in your country?</strong></p><p>If all your people lived scattered across the land, ambulances would have a hard time reaching all of them in due time!</p>'],
      ['checker', 'chkr_hou_desc2', '<p><strong>Within the urban population, how are your cities laid out?</strong></p><p>The richer your population, the more resources you have to allocate to cater to their needs!</p>'],
      ['checker', 'chkr_hou_subtitle', 'Typology'],
      ['checker', 'chkr_ser_title', 'Services &amp; Government '],
      ['checker', 'chkr_ser_subtitle', 'Budget repartition'],
      ['checker', 'chkr_ser_desc', '<p><strong>How much money do you want to allocate to the different services?</strong></p><p>The higher resources you allocate, the smarter, the healthier, the happier your population becomes, but providing all these services has a cost.</p>'],
      ['checker', 'chkr_den_title', 'Population Density'],
      ['checker', 'chkr_den_subtitle', ' '],
      ['checker', 'chkr_den_desc', '<p><strong>How is your population density?</strong></p><p>Population density reflects how scattered or concentrated your population is. It would be easier to attend to the needs of everyone if they were all in the same place, but wouldn\'t they suffocate if it was too concentrated?</p>'],
      ['checker', 'chkr_lan_title', 'Land '],
      ['checker', 'chkr_lan_subtitle', 'Arable land'],
      ['checker', 'chkr_lan_desc', '<p><strong>What is the quantity of arable land in your country?</strong></p><p>Arable land....</p>'],
      ['checker', 'chkr_ind_title', 'Bulding &amp; Manufacturing '],
      ['checker', 'chkr_ind_subtitle', 'Industrialization'],
      ['checker', 'chkr_ind_desc', '<p><strong>What is the level of industrialization and infrastructure in your society?</strong></p><p>..........................</p>'],
      ['checker', 'chkr_agr_title', 'Agriculture '],
      ['checker', 'chkr_agr_subtitle', 'Typology'],
      ['checker', 'chkr_agr_desc', '<p><strong>You are currently consuming <em>XX food</em>, how does your population produce it?</strong></p><p>......</p>'],
      ['checker', 'chkr_ene_title', 'Energy &amp; Fuels '],
      ['checker', 'chkr_ene_subtitle', 'Local production'],
      ['checker', 'chkr_ene_desc', '<p><strong>You are currently consuming <em>XX energy</em>, how does your population produce it?</strong></p><p>......................</p>'],
    ]

    for item in array
      c = Content.new(page: item[0], slug: item[1], content: item[2])
      c.save
    end
  end
end

