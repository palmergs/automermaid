class Automermaid::System
  attr_reader :scanline

  attr_accessor :enterprise_boundary,
                :system_boundary,
                :boundary

  def initialize scanline
    @scanline = scanline
  end

  def id
    arr = []
    arr << enterprise_boundary.id if enterprise_boundary
    arr << system_boundary.scanline.id if system_boundary
    arr << boundary.scanline.id if boundary
    arr << @scanline.id
    arr.join('.')
  end

  def render used: Set.new, depth: 0
    used << id

    if @scanline.label
      "#{ "  "* depth }System(#{ id }, \"#{ @scanline.name }\", \"#{ @scanline.label }\")"
    else
      "#{ "  "* depth }System(#{ id }, \"#{ @scanline.name }\")"
    end
  end
end
