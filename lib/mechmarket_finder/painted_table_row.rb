class PaintedTableRow < TableRow
  COLORS = [:white, :cyan, :blue].freeze

  def to_a
    super.map.with_index do |field, index|
      Paint[field, COLORS[index]]
    end
  end
end
