module Formatted
  DATE_FORMAT = "%d-%m-%y".freeze

  def self.included(base)
    existing_modifiers = base.class_variable_get(:@@modifiers)
    base.class_variable_set(:@@modifiers, (existing_modifiers << "format"))
  end

  private

  def format
    format_date
    truncate_title
  end

  def format_date
    @row[0] = Time.at(@row[0]).strftime(DATE_FORMAT)
  end

  def truncate_title
    @row[1] = @row[1][0,50]
  end
end

module Painted
  COLORS = [:white, :cyan, :blue].freeze

  def self.included(base)
    existing_modifiers = base.class_variable_get(:@@modifiers)
    base.class_variable_set(:@@modifiers, existing_modifiers << "paint")
  end

  private

  def paint
    @row = paint_row
  end

  def paint_row
    @row.map.with_index do |field, index|
      Paint[field, COLORS[index]]
    end
  end
end

class TableRow
  @@modifiers = []

  include Formatted
  include Painted

  def initialize(date, title, url)
    @row = [date, title, url]
  end

  def draw
    modify
    @row
  end

  def modify
    @@modifiers.each { |modifier| send(modifier) }
  end
end
