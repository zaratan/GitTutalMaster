# -*- encoding : utf-8 -*-
class Youtube < SuperModule
  include Cinch::Plugin
  
  match /youtube/

  add_test :test_youtube

  def test_youtube(m)
    m.user.send("http://www.youtube.com/watch?v=jUM0iTxT6GQ")
  end

  match(/PoPiPo - Version Original\./,:use_prefix => false,:method => :win_test_youtube)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_youtube]
    super
  end


end
