require_relative "../lib/app/annuaire_mairie"

url_source = "https://www.annuaire-des-mairies.com/val-d-oise.html"
my_annuaire = Anuaire.new(url_source)

describe "scrap should return a Nokogiri::HTML4::Document" do
  page = my_annuaire.scrap('https://www.annuaire-des-mairies.com/val-d-oise.html')
  it "scrap should not return an empty object" do
  expect(page.nil?).to eq(false)
  end
  it "scrap class should be Nokogiri::HTML4::Document" do
    expect(page.class).to eq(Nokogiri::HTML4::Document)
  end
end

describe "get_townhall_email should return list of mails" do
  xpath_email = '/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]'
  
  it "the returne element should contain an @ symbol" do
    expect(my_annuaire.get_townhall_email("https://www.annuaire-des-mairies.com/95/wy-dit-joli-village.html",xpath_email).include?("@")).to  eq(true)
    end
end

describe "get_townhall_urls should return list of cities urls" do
  xpath_cities_url = "//a[@class='lientxt']/@href"

  it "method should return list that has at least 15 elements" do
    expect(my_annuaire.get_townhall_urls('https://www.annuaire-des-mairies.com/val-d-oise.html',xpath_cities_url).size > 15).to eq(true)
  end
end

describe "get_townhall_names should return list of cities" do
  xpath_cities_name = "//a[@class='lientxt']"

  it "method should return list that has at least 15 elements" do
    expect(my_annuaire.get_townhall_names('https://www.annuaire-des-mairies.com/val-d-oise.html',xpath_cities_name).size > 15).to eq(true)
  end
end

