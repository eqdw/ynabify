require 'rspec/expectations' 

RSpec::Matchers.define :match_stdout do |check|

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
    "expected to puts #{description}"
  end

  failure_message_when_negated do
    "expected not to puts #{description}"
  end

  description do
    "match [#{check}] on stdout [#{@capture.string}]"
  end

end
