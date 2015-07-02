
module Ubr

  Coordinate = Struct.new(:latitude, :longitude)

  class << Coordinate
    def parse(text)
      if text =~ /\A(\-?[\d\.]+),(\-?[\d\.]+)\Z/
        Coordinate.new($1.to_f, $2.to_f)
      else
        raise "Coordinate must be in format 'latitude,longitude'; #{text.inspect} given"
      end
    end
  end

end
