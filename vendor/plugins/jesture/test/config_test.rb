require "test_helper"
require "test/unit"

class TestJestureConfig < Test::Unit::TestCase
  def test_config
    conf = Jesture::Config.new(File.join(File.dirname(__FILE__), "fixtures", "jestures.rb"))
    assert_not_nil(conf.jestures[:fight])
    assert_not_nil(conf.combos[:foo])
  end
end

class TestJestureConfigJestureConfig < Test::Unit::TestCase
  def test_presses
    jc = Jesture::Config::JestureDefinition.new do
      presses :foo, "bar"
    end
    assert_equal([:foo, "bar"], jc.triggers.select { |p| p.first == :foo }.first)
  end
end