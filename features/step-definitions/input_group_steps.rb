Given(/^I have an InputGroup$/) do
  @group = MidasTouch::InputGroup.new
end

Then(/^I can add inputs$/) do
  @group.inputs << MidasTouch::Input.new(:foo)
  @group.inputs << MidasTouch::Input.new(:bar)
  assert_includes(@group.fields, :foo)
  assert_includes(@group.fields, :bar)
end

And(/^it has a Filter$/) do
  filter = Class.new(MidasTouch::Filter) do
    def call(value)
      value.to_s.upcase
    end
  end.new(:upcase)
  @group.filters << filter
end

When(/^it is filtered$/) do
  @group.inputs << MidasTouch::Input.new(:foo)
  @group.inputs << MidasTouch::Input.new(:bar)
  @group.input(:foo).value = "foo"
  @group.input(:bar).value = "bar"
  @group.filter!
end

Then(/^all inputs are filtered$/) do
  values = @group.inputs.map(&:value)
  assert_includes(values, "FOO")
  assert_includes(values, "BAR")
end

And(/^it has a validation rule$/) do
  validation = Class.new(MidasTouch::Validation) do
    def call(value)
      value == "duck"
    end
  end.new(:is_duck)
  @group.validations << validation
end

And(/^it has inputs$/) do
  @group.inputs << MidasTouch::Input.new(:foo)
  @group.inputs << MidasTouch::Input.new(:bar)
  @group.input(:foo).value = "foo"
  @group.input(:bar).value = "bar"
end

When(/^it is validated$/) do
  @group.inputs << MidasTouch::Input.new(:bar)
  @group.inputs << MidasTouch::Input.new(:baz)
  @group.input(:bar).value = "duck"
  @group.input(:baz).value = "bar"
  @result = @group.valid?
end

Then(/^all inputs are validated$/) do
  refute(@result)
  assert(@group.error_on?(:baz))
end

Then(/^I can iterate over the names and values$/) do
  act = Hash[@group.map { |k, v| [k, v] }]
  exp = { :foo => "foo", :bar => "bar" }
  assert_equal(exp, act)
end
