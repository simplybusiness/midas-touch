Feature: Input Representation

  In order to provide an Object Orientated approach to
  input cleansing and validation, inputs must be
  representable as objects within Midas.

  Scenario: Creating a new Input
    Given I wish to create an input
    Then I can create one by calling "MidasTouch::Input.new(:name)"
    And it will be named "name"

  Scenario: Setting an inputs value
    Given I have an Input
    Then I can set the value

  Scenario: Adding filters to an input
    Given I have an Input
    When I add a filter
    Then the input can be filtered

  Scenario: Adding validation rules to an input
    Given I have an Input
    When I add a validation rule
    Then the input can be validated

  Scenario: Manually invalidating an input
    Given I have an Input
    Then I can manually mark it as invalid
