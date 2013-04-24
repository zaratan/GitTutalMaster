# -*- encoding : utf-8 -*-
class Coucou < SuperModule
  include Cinch::Plugin

  match /coucou/

  add_test :test_coucou

  def test_coucou(m)
    m.user.send("coucou")
  end

  match(/Tu veux voir mon bot\?/,:use_prefix => false, :method => :win_test_coucou)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_coucou]
    super
  end
end
