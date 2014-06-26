Given(/^I wish to create an input$/) do
  @expected_class = MidasTouch::Input
end

Then(/^I can create one by calling "(.*?)"$/) do |code|
  @eval_result = eval(code)
  assert_instance_of(@expected_class, @eval_result)
end

Then(/^it will be named "(.*?)"$/) do |name|
  assert_equal(name, @eval_result.name.to_s)
end

Given(/^I have an Input$/) do
  @input = MidasTouch::Input.new(:example)
end

Then(/^I can set the value$/) do
  @input.value = "raw input value"
  assert_equal("raw input value", @input.value)
end

When(/^I add a filter$/) do
  filter = Class.new(MidasTouch::Filter) do
    def call(value)
      value.to_s.upcase
    end
  end.new(:example)

  @input.filters << filter
end

When(/^I add a validation rule$/) do
  rule = Class.new(MidasTouch::Validation) do
    def call(value)
      value == "duck"
    end
  end.new(:example)

  @input.validations << rule
end

Then(/^the input can be filtered$/) do
  @input.value = "example"
  @input.filter!
  assert_equal("EXAMPLE", @input.value)
end

Then(/^the input can be validated$/) do
  @input.value = "example"
  refute(@input.valid?)
  @input.value = "duck"
  assert(@input.valid?)
end

Then(/^I can manually mark it as invalid$/) do
  @input.invalidate!
  @input.value = "duck"
  refute(@input.valid?)
end
