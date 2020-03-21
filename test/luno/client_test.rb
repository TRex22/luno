require "test_helper"

class LunoTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Luno::VERSION
  end

  def test_that_the_client_has_compatible_api_version
    assert_equal 'V1', Luno::Client.compatible_api_version
  end

  def test_that_the_client_has_api_version
    assert_equal 'v1 2020-02-24', Luno::Client.api_version
  end
end
