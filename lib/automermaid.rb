# frozen_string_literal: true

require_relative "automermaid/version"
require_relative "automermaid/scanner"
require_relative "automermaid/scanline"
require_relative "automermaid/runner"

require_relative "automermaid/external_system"
require_relative "automermaid/external_db"
require_relative "automermaid/external_queue"

require_relative "automermaid/enterprise_boundary"
require_relative "automermaid/system_boundary"
require_relative "automermaid/boundary"
require_relative "automermaid/system"
require_relative "automermaid/system_db"
require_relative "automermaid/system_queue"
require_relative "automermaid/relation"

module Automermaid
  class Error < StandardError; end
  # Your code goes here...
end
