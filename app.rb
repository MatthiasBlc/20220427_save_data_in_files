
require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE__)
require 'app/annuaire_mairie'
# require 'views/fichier_2'


url_source = "https://www.annuaire-des-mairies.com/val-d-oise.html"
my_annuaire = Anuaire.new(url_source)

my_annuaire.fetching_cities_urls
my_annuaire.fetching_mayors_email
my_annuaire.data_merging
my_annuaire.display

my_annuaire.save_as_json_file

my_annuaire.save_as_csv_file
#reste ADD google sheet save
#reste ADD csv save