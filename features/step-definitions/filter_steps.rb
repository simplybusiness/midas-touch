Given(/^I wish to create a new filter$/) do
  @expected_class = Midas::Filter
end

Given(/^I have a Filter$/) do
  @filter = Midas::Filter.new(:test)
end

When(/^I register it with Midas$/) do
  Midas.register_filter(@filter)
end

Then(/^I can retrieve it by name$/) do
  assert_equal(@filter, Midas.find_filter(:test))
end
