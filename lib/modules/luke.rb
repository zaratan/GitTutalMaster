class Luke < SuperModule
  include Cinch::Plugin

  match /luke/

  add_test :luke

  def luke
    m.user.send("luke")
  end

  match /father/,:use_prefix => false,:method => :win_luke)
    timer(1,:method => :everything_good?)
    timer(1,:method => :check_timeout)

    def execute(m)
      @tests = [:luke]
      super
    end
end
      

