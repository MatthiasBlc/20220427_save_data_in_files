class Anuaire

  attr_accessor :url_source

  def initialize(url_source) 
    @url_source = url_source # = departement_url
    @xpath_email = '/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]'
    @xpath_cities_url = "//a[@class='lientxt']/@href"
    @xpath_cities_name = "//a[@class='lientxt']"
    @liste_mayor_stalker = []
    @liste_email = []
  end

  # Intit and run
  def fetching_cities_urls
    puts "Start fetching cities urls"
    @liste_urls = get_townhall_urls(@url_source,@xpath_cities_url)
    puts "Fetched all cities urls"
  end
  
  def fetching_mayors_email
    total_bar = @liste_urls.size
    puts "Start fetching mayors emails"
    @liste_urls.each.with_index {|url,i| @liste_email << get_townhall_email(url,@xpath_email); loading_bar(total_bar,i) }
    puts "Fetched all mayors emails"
  end
  
  def data_merging
    puts "Merging all data"
    @liste_cities = get_townhall_names(url_source, @xpath_cities_name)
    @liste_cities.each.with_index {|city,i| @liste_mayor_stalker << {city => @liste_email[i]}}
    puts "All data printed"
  end

  def display
    puts @liste_mayor_stalker
  end
  

  #Elements
  def scrap(url)
    return Nokogiri::HTML(URI.open(url))
  end

  def get_townhall_email(townhall_url,xpath_email)
    page = scrap(townhall_url)
    townhall_email = page.xpath(xpath_email).text
    townhall_email.size == 0 ? townhall_email = "No m@il address" : townhall_email
    puts "Working on #{townhall_email}"
    return townhall_email
  end

  def get_townhall_urls(departement_url,xpath_cities_url)
    page = scrap(departement_url)
    liste_cities_url = []
    page.xpath(xpath_cities_url).each do |city_url|
      liste_cities_url << 'https://www.annuaire-des-mairies.com' + city_url.text[1..-1]
    end
    return liste_cities_url
  end
  
  def get_townhall_names(departement_url,xpath_cities_name)
    page = scrap(departement_url)
    liste_city_names = []
    page.xpath(xpath_cities_name).each do |city_name|
      liste_city_names << city_name.text
    end
    return liste_city_names
  end
  
  def loading_bar(total_size, current_size)
    current_size = 100 * current_size / total_size
    puts ("#" * current_size.to_i).ljust(100,"-")
  end
  
  #Extract
  def save_as_json_file
    File.open("db/emails.JSON","w") do |f|
      f.write(@liste_mayor_stalker.to_json) ########## FAIRE un ZIP ? pour un full hasj -> json ? 
    end
  end

  def save_as_spreadsheet
    
  end
  
  def save_as_csv_file
    CSV.open("db/emails.csv", "w") do |csv|
      csv << @liste_mayor_stalker ########################## Ajouter lignes à lignes 


    end
  end
  

end










