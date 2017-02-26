require "singleton"
class Reddit < SimpleDelegator
  include Singleton

  def initialize
    config = YAML.load(File.read("config.yml"))
    client = Redd.it(:script, config["client_id"], config["secret"], config["username"], config["password"])
    client.authorize!
    super(client)
  end

  def find_new_usa_keebs(keebs)
    search_string = "[US- AND (" + keebs.join(" OR ") + ")"
    subreddit_from_name("mechmarket").search(search_string, sort: :new)
  end
end
