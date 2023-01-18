class Automermaid::SystemBoundary
  attr_reader :scanline,
              :boundaries,
              :systems

  attr_accessor :enterprise_boundary

  def initialize scanline
    @scanline = scanline
    @boundaries = []
    @systems = []
  end

  def id
    arr = []
    arr << enterprise_boundary.scanline.id if enterprise_boundary
    arr << @scanline.id
    arr.join('.')
  end

  def append item
    case item.scanline.element
    when 'boundary'
      boundaries << item
      item.system_boundary = self
    when 'system'
      systems << item
      item.system_boundary = self
    when 'system queue'
      systems << item
      item.system_boundary = self
    when 'system db'
      systems << item
      item.system_boundary = self
    when 'rel'
      item.system_boundary = self
    when 'birel'
      item.system_boundary = self
    end
  end

  def render used: Set.new, depth: 0
    used << id

    arr = []
    arr << "#{ "  "* depth }#{ render_command } {"
    boundaries.each do |boundary|
      arr << boundary.render(used:, depth: depth + 1) unless used.member?(boundary.id)
    end

    systems.each do |system|
      arr << system.render(used:, depth: depth + 1) unless used.member?(system.id)
    end
    arr << "#{ "  "* depth }}"

    return arr.compact.join("\n") if arr.compact.length > 2 

    nil
  end

  def render_command
    if @scanline.label
      "System_Boundary(#{ id }, \"#{ @scanline.name }\", \"#{ @scanline.label }\")"
    else
      "System_Boundary(#{ id }, \"#{ @scanline.name }\")"
    end
  end
end
