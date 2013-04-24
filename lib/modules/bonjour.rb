# -*- encoding : utf-8 -*-
class Bonjour < SuperModule
  include Cinch::Plugin

  match /bonjour/

  add_test :test_bonjour

  def test_bonjour
    fake_part
    fake_join
  end

  match(/Bonjour Linael!/,:use_prefix => false,:method => :win_test_bonjour)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_bonjour]
    super
  end
end
