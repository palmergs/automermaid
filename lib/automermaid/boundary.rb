class Automermaid::Boundary
  attr_reader :scanline,
              :systems

  attr_accessor :enterprise_boundary,
                :system_boundary

  def initialize scanline
    @scanline = scanline
    @systems = []
  end

  def id
    arr = []
    arr << enterprise_boundary.scanline.id if enterprise_boundary
    arr << system_boundary.scanline.id if system_boundary
    arr << @scanline.id
    arr.join('.')
  end

  def append item
    case item.scanline.element
    when 'system'
      systems << item
      item.boundary = self
    when 'system queue'
      systems << item
      item.boundary = self
    when 'system db'
      systems << item
      item.boundary = self
    when 'rel'
      item.boundary = self
    when 'birel'
      item.boundary = self
    end
  end

  def render used: Set.new, depth: 0
    used << id

    arr = []
    arr << "#{ "  "* depth }#{ render_command } {"
    systems.each do |system|
      arr << system.render(used:, depth: depth + 1) unless used.member?(system.id)
    end
    arr << "#{ "  "* depth }}"
    
    return arr.compact.join("\n") if arr.compact.length > 2

    nil
  end

  def render_command
    if @scanline.label
      "Boundary(#{ id }, \"#{ @scanline.name }\", \"#{ @scanline.label }\")"
    else
      "Boundary(#{ id }, \"#{ @scanline.name }\")"
    end
  end
end
