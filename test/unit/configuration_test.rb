require "test_helper.rb"

class ConfigurationTest < Minitest::Test
  def test_initialize_without_error
    config = ViteRb::Configuration.new

    assert_instance_of ViteRb::Configuration, config
  end
end