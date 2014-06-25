When(/^I create a sub\-class of "(.*?)"$/) do |klass|
  @klass = Class.new(Object.const_get(klass))
end

Then(/^the class can be initialized with a name$/) do
  @instance = @klass.new(:name)
end

Then(/^responds to the call method$/) do
  assert_respond_to(@instance, :call)
end
