require 'ocr/scanned_number'

module OCR
  class AccountReader
    include Enumerable

    def initialize(in_stream)
      @in_stream = in_stream
      @line_number = 0
    end

    def read_account_number
      starting_line = next_line_number
      result = (0...3).map { read_line }
      read_line
      if result.any? { |ln| ln.nil? }
        nil
      else
        AccountNumber.new(result)
      end
    rescue OCR::StandardError => ex
      ex.line_number = starting_line
      raise ex
    end

    def each
      while line = read_account_number
        yield line
      end
    end
  end
end
