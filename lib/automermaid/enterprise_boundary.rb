class Automermaid::EnterpriseBoundary
  attr_reader :scanline,
              :system_boundaries,
              :boundaries,
              :systems

  def initialize scanline
    @scanline = scanline
    @system_boundaries = []
    @boundaries = []
    @systems = []
  end

  def id
    @scanline.id
  end

  def append item
    case item.scanline.element
    when 'system boundary'
      system_boundaries << item
      item.enterprise_boundary = self
    when 'boundary'
      boundaries << item
      item.enterprise_boundary = self
    when 'system'
      systems << item
      item.enterprise_boundary = self
    when 'system queue'
      systems << item
      item.enterprise_boundary = self
    when 'system db'
      systems << item
      item.enterprise_boundary = self
    when 'rel'
      item.enterprise_boundary = self
    when 'birel'
      item.enterprise_boundary = self
    end
  end

  def render used: Set.new, depth: 0
    used << id

    arr = []
    arr << "#{ render_command } {"
    system_boundaries.each do |boundary|
      arr << boundary.render(used:, depth: 1) unless used.member?(boundary.id)
    end

    boundaries.each do |boundary|
      arr << boundary.render(used:, depth: 1) unless used.member?(boundary.id)
    end

    systems.each do |system|
      arr << system.render(used:, depth: 1) unless used.member?(system.id)
    end
    arr << "}"
    
    return arr.compact.join("\n") if arr.compact.length > 2

    nil
  end

  def render_command
    if @scanline.label
      "Enterprise_Boundary(#{ id }, \"#{ @scanline.name }\", \"#{ @scanline.label }\")"
    else
      "Enterprise_Boundary(#{ id }, \"#{ @scanline.name }\")"
    end
  end
end
