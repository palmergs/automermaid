require 'spec_helper'

RSpec.describe Automermaid::VERSION do 
  it 'is semantically versioned' do
    expect(Automermaid::VERSION).to match(/\d+\.\d+\.\d+/)
  end
end
