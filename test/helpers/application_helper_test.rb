require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         t("static_pages.application.ruby")
    assert_equal full_title("Help"), "Help | Ruby on Rails Tutorial Sample App"
  end
end
