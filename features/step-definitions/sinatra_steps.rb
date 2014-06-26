Given(/^the following application:$/) do |string|
  mock_app do
    class_eval(string)
  end
end

Then(/^we have an InputGroup$/) do
  assert_instance_of(Midas::InputGroup, @result)
end

Given(/^there is a filter called "(.*?)"$/) do |name|
  filter = ::Midas::Filter.new(name)
  ::Midas.register_filter(filter)
end

Given(/^there is a validation called "(.*?)"$/) do |name|
  validation = Class.new(::Midas::Validation) do
    def call(value)
      value == "duck"
    end
  end.new(name)
  ::Midas.register_validation(validation)
end

Then(/^the group has the following inputs:$/) do |table|
  names = table.raw.flatten
  @result.inputs.each do |input|
    assert_includes(names, input.name.to_s)
  end
end

When(/^we make a request to "(.*?)"$/) do |path|
  get(path)
end

When(/^we make a request to "(.*?)" with the following params:$/) do |path, params|
  get(path, @params = params.rows_hash)
end

Then(/^the inputs have no value$/) do
  last_response.body.split(',').each do |line|
    assert_match("_name : nil", line)
  end
end

Then(/^the inputs have values$/) do
  vals = last_response.body.split(",").map { |line| line.split(' : ') }
  assert_equal(@params, Hash[vals])
end

Then(/^the response body is "(.*?)"$/) do |body|
  assert_equal(body, last_response.body)
end
