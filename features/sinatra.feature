Feature: Extending Sinatra applications

  The Midas gem provides a DSL for Sinatra based applications
  allowing them to define inputs and rules with more ease.

  Background:
    Given there is a filter called "strip"
    And there is a validation called "duck_only"
    And the following application:
      """
      helpers Sinatra::MidasTouch
      get('/form') do
        form do
          filters :strip
          field :first_name
          field :last_name
        end
        form.inputs.map { |input|
          input.name.to_s + ' : ' + (input.value or 'nil')
        }.join(',')
      end

      get('/validate') do
        form do
          field :example, :duck_only
        end
        form.valid?.inspect
      end
      """

  Scenario: Using the sinatra DSL for inputs (without params)
    When we make a request to "form"
    Then the inputs have no value

  Scenario: Using the sinatra DSL for inputs (with params)
    When we make a request to "form" with the following params:
      | first_name | foo |
      | last_name  | bar |
    Then the inputs have values

  Scenario: Using the sinatra DSL for validation (without params)
    When we make a request to "validate"
    Then the response body is "false"

  Scenario Outline: Using the sinatra DSL for validation (with params)
    When we make a request to "validate" with the following params:
      | example | <param value> |
    Then the response body is "<result>"

    Examples:
      | param value | result |
      | foo         | false  |
      | fooduck     | false  |
      | duck        | true   |
