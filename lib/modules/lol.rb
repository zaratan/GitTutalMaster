# -*- encoding : utf-8 -*-
class Lol < SuperModule
  include Cinch::Plugin

  match /lol/

  add_test :test_lol
  add_test :test_oki

  def test_lol(m)
    m.user.send("lol")
  end

  def test_oki(m)
    m.user.send("oki")
  end

  match(/LOL/,:use_prefix => false,:method => :win_test_oki)
  match(/OKI/,:use_prefix => false,:method => :win_test_lol)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_lol,:test_oki]
    super
  end
end
