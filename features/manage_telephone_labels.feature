Feature: Manage Telephone Labels
  In order to assign telephones labels to a patients 
  As a administrator
  I want to create and manage telephone labels

Background:
  Given I am logged in as thiago@medical_office.com with passsword thiago

  Scenario: Telephone Labels List
    Given a telephone_label exist with label: "Residencial"
    And a telephone_label exist with label: "Comercial"
    When I am on the telephone_labels list
    Then I should see "Residencial"
    And I should see "Comercial"

  Scenario: Create a Valid Telephone Label
    Given I am on the telephone_labels list
    And 0 telephone_labels exist
    When I follow "New Telephone Label"
    And I fill in "Label" with "Residencial"
    And I press "Create"
    Then I should see "Telephone Label was successfully created."
    And I should see "Residencial"
    And a telephone_label should exist

  Scenario: Try to Create an Invalid Telephone Label
    Given 0 telephone_labels exist
    And I am on the telephone_labels list
    And I follow "New Telephone Label"
    When I fill in "Label" with " "
    And I press "Create"
    Then I should see "error"
    And 0 telephone_labels should exist

  Scenario: Update a Telephone Label
    Given a telephone_label exist
    And I am on the telephone_labels list
    When I follow "Edit"
    And I fill in "Label" with "Comercial"
    And I press "Update"
    Then I should see "Telephone Label was successfully updated."
    And I should see "Comercial"
    And a telephone_label should exist

  Scenario: Destroy a Telephone Label
    Given a telephone_label exist
    And I am on the telephone_labels list
    When I follow "Destroy"
    Then 0 telephone_labels should exist

