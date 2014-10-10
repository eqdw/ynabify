require 'rspec/expectations' 

RSpec::Matchers.define :match_stdout do |check|

  supports_block_expectations

  @capture = nil

  match do |block|
    begin
      stdout_saved = $stdout
      $stdout      = StringIO.new
      block.call
    ensure
      @capture     = $stdout
      $stdout      = stdout_saved
    end

    @capture.string.match check
  end

  failure_message do
    "expected to #{description}"
  end

  failure_message_when_negated do
    "expected not to #{description}"
  end

  description do
    "match\n\n#{"-"*20}\n#{check}\n#{"-"*20}\n\non output\n\n#{"-"*20}\n#{@capture.string}\n#{"-"*20}\n"
  end

end
