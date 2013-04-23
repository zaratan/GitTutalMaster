class Test < SuperModule
  include Cinch::Plugin

    match /test/

    def test1(m)
      p "at least"
      m.user.send("tell me something")
      Cinch::Plugin.match(/./,:use_prefix => false,:method => "win_test1_#{m.user.user}".to_sym)
      timer(10,:shots => 1,:method => "fail_test1_#{m.user.user}".to_sym)
    end

    def execute(m)
      @tests =[:test1]
      super
    end

end
