class Automermaid::Scanline
  attr_reader :line,
              :valid,
              :path,
              :num,
              :element,
              :subject,
              :name,
              :object,
              :label

  def initialize line
    @valid = false
    @line = line
  end

  def id
    @subject.last
  end

  def process

    # colon separates path and labels from element type
    arr = @line.split(":")
    return nil if arr.length < 3
    return nil if arr[0].strip == ""

    @path = arr[0].strip.split("/")
    @num = Integer(arr[1], exception: false) or return nil

    # double ampersands are used to identify a mermaid line
    # only the text after ampersands is important
    tmp = arr[1].split("@@")
    return nil if tmp.length != 2
    return nil if tmp[1].strip == ""

    @element = tmp[1].strip.downcase

    # exclaimation point separates items from label
    sub = arr[2].split("!")
    return nil if sub[0].strip == ""
    
    @label = sub[1].strip if sub.length > 1
    obj = sub[0].split(">")
    if obj.length > 1
      return nil if obj[1].strip == ""

      @object = obj[1].strip.split("/")
    end

    return nil if sub[0].strip == ""

    @subject = obj[0].strip.split("/")
    @name = @subject.last.split("-").map(&:capitalize).join(' ')
    @valid = true
    return self
  end
end
