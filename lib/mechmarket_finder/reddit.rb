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
    subreddit_from_name("mechmarket").search("[US- AND (" + keebs.join(" OR ") + ")", sort: :new)
  end
end
