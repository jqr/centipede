class Assets

  def initialize(window)
    @window = window
  end
  
  def self.asset_dirs
    @asset_directories
  end

  def self.add_asset_dir(dir)
    @asset_directories ||= []
    @asset_directories << dir
  end
  add_asset_dir(File.join(GAME_DIR, "images"))
  add_asset_dir(File.join(GAME_DIR, "images", "centipede"))
  

  def preload
    Assets.asset_dirs.each do |d|
      Dir.entries(d).each do |f|
        rpath = File.join(d, f)
        unless File.directory?(rpath)
          @assets ||= { }
          @assets[f] = Gosu::Image.new(@window, rpath)
          Centipede.logger.info("Loaded #{rpath}")
        end
      end
    end
  end

  def by_name(name)
    @assets[name]
  end

end
