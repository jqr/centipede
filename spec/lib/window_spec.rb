require File.join('..', 'spec_helper')

describe Window do
  
  it "should load sounds" do
    @window = Window.new
    @window.sounds.should_not be_empty
  end
  
end
