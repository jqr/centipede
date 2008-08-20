class Level

  attr_accessor :grid, :rows, :columns, :tile_size

  def initialize(window, columns, rows, tile_size)
    @window = window
    self.rows = rows
    self.columns = columns
    self.tile_size = tile_size
    self.grid = Array.new(columns).collect { |a| Array.new(rows) }
  end
end
