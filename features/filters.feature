Feature: Filter logic

  In order to easily filter inputs (strip whitespace, upcase, etc)
  then we require the ability to define filters that can be executed
  on values.

  Scenario: Use of the base filter class
    Given I wish to create a new filter
    When I create a sub-class of "MidasTouch::Filter"
    Then the class can be initialized with a name
    And responds to the call method

  Scenario: Registering filters for easy access
    Given I have a Filter
    When I register it with MidasTouch
    Then I can retrieve it by name
