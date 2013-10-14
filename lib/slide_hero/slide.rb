module SlideHero
  class Slide
    attr_reader :headline, :headline_size
    def initialize(headline, headline_size: :large, &point_block)
      @headline = headline
      @headline_size = headline_size
      instance_eval(&point_block) if block_given?
    end

    def compile
      "<section>" +
        "<#{size_to_markup}>#{headline}</#{size_to_markup}>" +
        "#{collected_points}" +
      "</section>"
    end

    def point(text)
      points << Point.new(text).compile
    end

    def list(&block)
      points << List.new(&block).compile
    end

    def collected_points
      points.inject(:+)
    end

    def points
      @points ||= []
    end

    private
    def size_to_markup
      { 
        large: :h1,
        medium: :h2,
        small: :h3
      }[headline_size]

    end
  end
end