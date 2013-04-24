# -*- encoding : utf-8 -*-
class Cla < SuperModule
  include Cinch::Plugin

  match /cla/

  add_test :test_cla

  def test_cla(m)
    m.user.send("CLA")
  end

  match(/(RINETTE|FOUTI|non|SSIQUE|MARD|VICULE|PET|BOTER|MANT|MÉ|BAUD|BAUDAGE|MSER|POTAGE|QUE|QUETTE|KEKETTE|RIFIER|SH|VECIN|VIER|YON|YETTE|QUÉ|PIR)/,:use_prefix => false,:method => :win_test_cla)
  timer(1,:method => :everything_good?)
  timer(1,:method => :check_timeout)

  def execute(m)
    @tests = [:test_cla]
  end
end
