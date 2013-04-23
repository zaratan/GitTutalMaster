#!/usr/bin/ruby

require 'cinch'
require 'active_support/inflector'
require "cinch/plugins/identify"
require_relative "../lib/module.rb"

modules = []

Dir.foreach('./lib/modules') do |mod| 
  if (mod =~ /.rb$/)
    load "./lib/modules/#{mod}" 
    p mod.gsub('.rb','')
    modules << mod.gsub('.rb','').camelize.constantize
  end
end

bot = Cinch::Bot.new do
  configure do |c|

    c.server = "irc.iiens.net"
    c.channels = ["#git-tutal"]
    c.nick   = "GitMaster"
    c.plugins.plugins = modules << Cinch::Plugins::Identify
    c.plugins.options[Cinch::Plugins::Identify] = {
      :password => "gitcestbien",
      :type     => :nickserv,
    }

  end

end


bot.start
