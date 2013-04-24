# -*- encoding : utf-8 -*-
class Wave < SuperModule
  include Cinch::Plugin

  match /wave/

  add_test :test_wave

  def text_wave(m)
    m.user.send('\o/')
  end

  match(/(\/\\_<).(\/\\_>)/,:use_prefix => false,:method => :win_test_wave)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_wave]
    super
  end


end
