# -*- encoding : utf-8 -*-
class Test < SuperModule
  include Cinch::Plugin

    match /test/

    add_test :test1

    def test1(m)
      m.user.send("tell me \"test\"")
    end
      
    match(/^test/,:use_prefix => false,:method => "win_test1".to_sym)
    timer(1,:method => :everything_good?)
    timer(1,:method => :check_timeout)

    def execute(m)
      @tests =[:test1]
      super
    end

end
