module GosuExtras
  # Sets up Gosu::KbA through KbZ to easily map letters to button ids
  def self.setup_keyboard_constants(window)
    unless defined?(Gosu::KbA)
      ('a'..'z').each do |letter|
        eval "::Gosu::Kb#{letter.upcase} = #{window.char_to_button_id(letter)}"
      end
    end
  end
end