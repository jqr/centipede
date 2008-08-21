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
      grid[rand(columns)][rand(rows)] = 4
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
    grid[x] && grid[x][y] == 0
  end
  
end
