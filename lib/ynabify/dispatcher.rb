# Class responsible for parsing command line arguments
# and dispatching to the relevant classes

module Ynabify
  class Dispatcher
    attr_reader :subcommand, :opts

    def self.dispatch(argv)
      new(argv).dispatch
    end

    def initialize(argv)
      @subcommand = argv.shift
      @opts       = argv
    end

  end
end
