class Automermaid::ExternalDB
  attr_reader :scanline

  def initialize scanline
    @scanline = scanline
  end

  def render
    if @scanline.label
      "SystemDb_Ext(#{ @scanline.subject.last }, \"#{ @scanline.name }\", \"#{ @scanline.label }\")"
    else
      "SystemDb_Ext(#{ @scanline.subject.last }, \"#{ @scanline.name }\")"
    end
  end

  def self.append_from hsh, scanline
    return hsh unless scanline.valid
    return hsh unless scanline.element.downcase == "external db"

    hsh[scanline.subject] = Automermaid::ExternalDB.new(scanline)
    hsh
  end
end
