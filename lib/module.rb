class SuperModule
  include Cinch::Plugin

  def voice_if_all_true (m)
    host = m.user.host
    m.channel.users.each {|u| p u}
    m.channel.users.each do |u|
      user = u[0]
      if !user.kind_of? Cinch::Bot
        m.channel.voice(user) if user.host == host
      end
    end
  end

  def kick_if_false (m)
    m.channel.kick(m.user,"Problems?")
  end

  def execute(m)
    @users ||=Hash.new
    @users[m.user.user] = m
    @tests ||= [] 
    @toTest ||= Hash.new
    @result ||= Hash.new
    @toTest[m.user.user] = []
    @result[m.user.user] = []
    @tests.each do |test|       
      self.send(test,m)
      @toTest[m.user.user] << test
    end
  end
  
  timer(10,:method => :everything_good?)



  def everything_good?
    @result.keys.each do |k|
      unless @toTest[k].empty?
        if @result[k].all? {|r| r}
          m.reply("#{k}: GREAT!")
          voice_if_all_true(@users[k])
        else
          kick_if_false @users[k]
        end
      end
    end
  end
  
    def method_missing(name, *args,&block)
      if name =~ /fail_([A-z0-9]*)_(\S*)/
        p "YOU FAIL!"
        @result[$2] << false
        @toTest[$2].delete($1.to_sym)
        return
      end
      if name =~ /win_([A-z0-9]*)_(\S*)/
        p "YOU WIN" 
        @result[$2].delete($1.to_sym)
        return
      end
      super
    end

end

