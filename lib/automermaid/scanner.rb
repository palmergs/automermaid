class Automermaid::Scanner

  attr_reader :path

  def initialize path
    @path = path
  end

  def scan
    output = `pushd #{ path } && rg -n \@\@ && popd`
    arr = output.split("\n")
    arr[1..-2]
  end
end
