require "yaml"
require "pp"
require "pry"
require "redd"
require "colorize"
require "terminal-table"

config = YAML.load(File.read("./config.yml"))
keebs = %w(Planck JD40 JD45 MiniVan Minorca Preonic MobiK Quark)

r = Redd.it(:script, config["client_id"], config["secret"], config["username"], config["password"])
r.authorize!
posts = r.subreddit_from_name("mechmarket").search("[US- AND (" + keebs.join(" OR ") + ")", sort: :new)

puts "+#{'-'*170}+"
rows = posts.map do |post|
  date = Time.at(post[:created]).strftime("%d-%m-%y")
  [date.light_green, post[:title][0,50].light_magenta, post[:url].blue]
end

table = Terminal::Table.new rows: rows
table.headings = ["Date", "Title", "URL"]
puts table
