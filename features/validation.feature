Feature: Validation rule representation

  Validation rules need to be represented as standard objects
  that can easily be added to inputs.

  Scenario: Creating a validation rule
    Given I wish to create a validation rule
    When I create a sub-class of "MidasTouch::Validation"
    Then the class can be initialized with a name
    And responds to the call method

  Scenario: Registering validation rules
    Given I have a validation rule
    When I register the with MidasTouch
    Then it can be retrieved with its name
