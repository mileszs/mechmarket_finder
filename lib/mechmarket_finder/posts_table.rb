class PostsTable
  HEADINGS = ["Date", "Title", "URL"].freeze

  def initialize(posts, row_class = TableRow)
    @posts = posts
    @row_class = row_class
  end

  def draw
    formatted_table
  end

  private

  def formatted_table
    table = Terminal::Table.new(rows: rows)
    table.headings = HEADINGS
    table
  end

  def rows
    @posts.map do |post|
      @row_class.new(post[:created], post[:title], post[:url]).to_a
    end
  end
end
