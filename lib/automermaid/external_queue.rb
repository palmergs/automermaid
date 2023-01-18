class Automermaid::ExternalQueue
  attr_reader :scanline

  def initialize scanline
    @scanline = scanline
  end

  def id
    @scanline.id
  end

  def render
    if @scanline.label
      "SystemQueue_Ext(#{ @scanline.subject.last }, \"#{ @scanline.name }\", \"#{ @scanline.label }\")"
    else
      "SystemQueue_Ext(#{ @scanline.subject.last }, \"#{ @scanline.name }\")"
    end
  end

  def self.append_from hsh, scanline
    return hsh unless scanline.valid
    return hsh unless scanline.element.downcase == "external system"

    hsh[scanline.subject] = Automermaid::ExternalSystem.new(scanline)
    hsh
  end
end

