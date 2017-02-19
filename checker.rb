require "yaml"
require "pp"
require "pry"
require "redd"

config = YAML.load(File.read("./config.yml"))

r = Redd.it(:script, config["client_id"], config["secret"], config["username"], config["password"])
r.authorize!

keebs = %w(Planck JD40 JD45 MiniVan Minorca Preonic MobiK Quark)
posts = r.subreddit_from_name("mechmarket").search("[US- AND (" + keebs.join(" OR ") + ")", sort: :new)

puts "+#{'-'*170}+"
posts.each do |post|
  date = Time.at(post[:created]).strftime("%d-%m-%y")
  printf("| %8s | %-40s | %-114s |\n", date, post[:title][0,40], post[:url])
  puts "-"*172
end
