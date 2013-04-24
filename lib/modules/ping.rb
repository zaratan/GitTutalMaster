# -*- encoding : utf-8 -*-
class Ping < SuperModule
  include Cinch::Plugin

  match /ping/

  add_test :test_pong

  def test_pong(m)
    m.user.send("ping")
  end

  match(/^pong/,:use_prefix => false,:method => :win_test_pong)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_pong]
    super
  end
end
