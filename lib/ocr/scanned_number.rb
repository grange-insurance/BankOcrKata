require 'ocr/scanned_characters'
require 'ocr/errors'

module OCR
  class ScannedNumber
    include ScannedCharacters

    attr_reader :scanned_lines
    attr_reader :value

    def initialize(lines)
      @scanned_lines = lines
      normalize_line_lengths
      check_proper_number_of_lines
      check_for_illegal_characters
      check_line_lengths
      @value = calculate_value
    end
  end

end
