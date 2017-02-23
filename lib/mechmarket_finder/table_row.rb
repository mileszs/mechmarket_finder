class TableRow
  DATE_FORMAT = "%d-%m-%y".freeze

  def initialize(date, title, url)
    @date = date
    @title = title
    @url = url
  end

  def to_a
    [@date, @title[0,50], @url ]
  end

  private

  def formatted_date
    @date = Time.at(@date).strftime(DATE_FORMAT)
  end
end
