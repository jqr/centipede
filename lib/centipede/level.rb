class Level

  attr_accessor :grid, :rows, :columns, :tile_size, :name

  def initialize(window, columns, rows, tile_size, name)
    @window = window
    @name = name
    self.rows = rows
    self.columns = columns
    self.tile_size = tile_size
    self.grid = Array.new(columns).collect { |a| Array.new(rows) }
    @mushroom = Gosu::Image.load_tiles(window, File.join(GAME_DIR, 'images', 'mushroom.png'), 8, 8, false)
    
    add_initial_mushrooms
  end
  
  def add_initial_mushrooms
    25.times do
      grid[[1, rand(columns)].max][rand(rows)] = 4
    end
    
    # add_solid_column(0)
  end

  def add_solid_column(x)
    columns.times do |column|
      grid[column][x] = 4
    end
  end
  
  def draw
    grid.each_with_index do |rows, y|
      rows.each_with_index do |value, x|
        @mushroom[4 - value].draw(x * tile_size, y * tile_size, 0, 2, 2) if value
      end
    end
  end
  
  def open?(x, y)
    x >= 0 && x < columns && grid[y] && grid[y][x] == nil
  end
  
end
