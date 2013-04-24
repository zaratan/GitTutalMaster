# -*- encoding : utf-8 -*-
class Pan < SuperModule
  include Cinch::Plugin

  match /pan/

  add_test :test_pan

  def test_pan(m)
    m.user.send("coin")
  end

  match(/\*\*PAN\*\*/,:use_prefix => false, :method => :win_test_pan)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_pan]
    super
  end
end
