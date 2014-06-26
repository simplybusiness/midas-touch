Feature: Handling collections of input

  We can handle collections of inputs easily via the use
  of an InputGroup which allows us to filter and validate
  numerous inputs.

  Scenario: Adding inputs to a group
    Given I have an InputGroup
    Then I can add inputs

  Scenario: Adding group filters
    Given I have an InputGroup
    And it has a Filter
    When it is filtered
    Then all inputs are filtered

  Scenario: Adding group validations
    Given I have an InputGroup
    And it has a validation rule
    When it is validated
    Then all inputs are validated

  Scenario: Enumerate over values
    Given I have an InputGroup
    And it has inputs
    Then I can iterate over the names and values
