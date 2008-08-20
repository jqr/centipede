class Assets
  
  def self.asset_dirs
    @asset_directories
  end

  def self.add_asset_dir(dir)
    @asset_directories ||= []
    @asset_directories << dir
  end
  add_asset_dir(File.join(GAME_DIR, "images"))
  add_asset_dir(File.join(GAME_DIR, "images", "centipede"))
  

  def self.preload
    self.asset_dirs.each do |d|
      Dir.entries(d).each do |f|
        rpath = File.join(d, f)
        unless File.directory?(rpath)
          @assets ||= { }
          @assets[f] = File.read(rpath)
        end
      end
    end
  end

  def self.by_name(name)
    @assets[name]
  end
  
end
