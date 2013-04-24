# -*- encoding : utf-8 -*-
class Karma < SuperModule
  include Cinch::Plugin

  match /karma/

  add_test :test_karma

  def test_karma(m)
    m.user.send("GitMaster ++")
    m.user.send("!karma")
  end

  match(/arma.*GitMaster.*(\d*)/,:use_prefix => false, :method => :karma_test)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def karma_test(m)
    win_test_karma if $1.to_i > 0
  end

  def execute(m)
    @tests = [:test_karma]
    super
  end
end

