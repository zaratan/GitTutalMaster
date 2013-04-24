# -*- encoding : utf-8 -*-
class Miaou < SuperModule
  include Cinch::Plugin

  match /miaou/

  add_test :test_miaou
  add_test :test_ouaf

  def test_miaou
    m.user.send("miaou")
  end

  def test_ouaf
    m.user.send("ouaf")
  end

  match(/miaou/,:use_prefix => false,:method => :win_test_miaou)
  match(/ouaf/,:use_prefix => false,:method => :win_test_ouaf)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_miaou,:test_ouaf]
  end
end
