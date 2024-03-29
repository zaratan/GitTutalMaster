# -*- encoding : utf-8 -*-
class SuperModule
  include Cinch::Plugin

  def voice_if_all_true (m)
    m.channel.voice(m.user) 
    username = m.user.user
    m.channel.users.each {|u| p u}
    m.channel.users.each do |u|
      user = u[0]
      if !user.kind_of? Cinch::Bot
        m.channel.voice(user) if user.user == username
      end
    end
  end

  KickMessages=[
    "Problems?",
    "I guess you failed.",
    "One kick to rule them all.",
    "TRY! MOAR!",
    "TRY! AGAIN!",
    "Please... don't make me do that again.",
    "Kyaaaaa~~~ ♥",
    "I secretly hope that somebody will succed... one day...",
    "Oops... I did it again!",
    "Missclic... I wanted to voice you",
    "With all Zaratan's love",
    "Say hello to Skelz0r for me",
    "42",
    "If Skelz0r was a punk he would love you... wait... he is a punk!",
    "Zaratan likes to lose time on stupid features"
  ]

  def kick_if_false (m)
    Channel('#git-tutal').kick(m.user,KickMessages[Random.rand(KickMessages.size)])
  end

  def execute(m)
    @users ||=Hash.new
    @timer ||=Hash.new
    @users[m.user.user] = m
    @tests ||= [] 
    @toTest ||= Hash.new
    @result ||= Hash.new
    @toTest[m.user.user] = []
    @result[m.user.user] = []
    @timer[m.user.user] = Hash.new
    @tests.each do |test|       
      self.send(test,m)
      @toTest[m.user.user] << test
      @timer[m.user.user][test] = 10
    end
  end
  
  def everything_good?
    @result.keys.each do |k|
      if @toTest[k].empty?
        if @result[k].all? {|r| r}
          voice_if_all_true(@users[k])
        else
          kick_if_false @users[k]
        end
        @result.delete(k)
        @toTest.delete(k)
        @timer.delete(k)
      end
    end
  end

  def check_timeout
    @timer.each do |k,user_timer|
      user_timer.each do |key,timer|
        if timer == 0
          send("fail_#{key}",k) 
        else 
          @timer[k][key] = timer - 1
        end
      end
    end
  end
  
  def self.add_test(name)
    define_method("fail_#{name}") do |user|
        p "#{user}: YOU FAIL!"
        @result[user] << false
        @toTest[user].delete(name)
      end
      define_method("win_#{name}") do |m|
        p "#{m.user.user}: YOU WIN" 
        @toTest[m.user.user].delete(name)
        @timer[m.user.user].delete(name)
      end
    end

  def fake_join
    User("Linael").send("!j #git-tutal")
  end

  def fake_part
    User("Linael").send("!part #git-tutal")
  end

  def initialize blu
    @result=Hash.new
    @toTest=Hash.new
    @timer=Hash.new
    super
  end

end

