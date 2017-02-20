require "yaml"
require "pp"
require "pry"
require "redd"
require "colorize"

config = YAML.load(File.read("./config.yml"))
keebs = %w(Planck JD40 JD45 MiniVan Minorca Preonic MobiK Quark)

r = Redd.it(:script, config["client_id"], config["secret"], config["username"], config["password"])
r.authorize!
posts = r.subreddit_from_name("mechmarket").search("[US- AND (" + keebs.join(" OR ") + ")", sort: :new)

puts "+#{'-'*170}+"
posts.each do |post|
  date = Time.at(post[:created]).strftime("%d-%m-%y")
  printf("| %8s | %-50s | %-128s |\n", date.light_green, post[:title][0,50].light_magenta, post[:url].blue)
  puts "-"*172
end
