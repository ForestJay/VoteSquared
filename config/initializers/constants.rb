# When this is internationalized the country will need to be dynamically set
COUNTRY = "United States of America"
OFFICES = YAML.load(File.read(File.expand_path("config/initializers/offices.yml")))
ADMINS = YAML.load(File.read(File.expand_path("config/initializers/admins.yml")))