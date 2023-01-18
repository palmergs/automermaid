class Automermaid::Relation
  attr_reader :scanline

  attr_accessor :enterprise_boundary,
                :system_boundary,
                :boundary

  def initialize scanline
    @scanline = scanline
  end

  def id
    "#{ lhs }>#{ rhs }"
  end

  def lhs
    if @scanline.subject.length > 1
      @scanline.subject.join(".")
    else
      arr = []
      arr << enterprise_boundary.scanline.id if enterprise_boundary
      arr << system_boundary.scanline.id if system_boundary
      arr << boundary.scanline.id if boundary
      arr << @scanline.subject
      arr.join('.')
    end
  end

  def rhs
    if @scanline.object.length > 1
      @scanline.object.join(".")
    else
      arr = []
      arr << enterprise_boundary.scanline.id if enterprise_boundary
      arr << system_boundary.scanline.id if system_boundary
      arr << boundary.scanline.id if boundary
      arr << @scanline.object
      arr.join('.')
    end
  end

  def render used: Set.new, depth: 0
    used << id

    pp @scanline

    cmd = @scanline.element == "rel" ? "Rel" : "BiRel"
    if @scanline.label
      "#{ "  "* depth }#{ cmd }(#{ lhs }, #{ rhs }, \"#{ label }\")"
    else
      "#{ "  "* depth }#{ cmd }(#{ lhs }, #{ rhs }, \"Uses\")"
    end
  end
end
