@omniauth_test @vcr
Feature: Authorizing (OAuth2) client applications
  In order to use Login as an OAuth2 provider for NYU Libraries' service applications
  As an admin
  I want to be able to add authorized client applications through a web interface in Login.

  Scenario: Viewing the list of client applications as an admin
    Given I am logged in as an admin
    And I am on my user page
    When I click on the applications link
    Then I should see the list of applications

  Scenario: Trying to view the list of client applications as a non-admin user
    Given I am logged in as a non-admin user
    When I go to the client applications page
    Then I should not see the list of applications

  Scenario: Adding a client application as an admin
    Given I am logged in as an admin
    When I go to the client applications page
    And I click add new application
    And I fill out the form with the following fields:
      | Name         | test                      |
      | Redirect URI | urn:ietf:wg:oauth:2.0:oob |
    Then I should see that the application is added

  Scenario: Trying to add a client application as a non-admin user
    Given I am logged in as a non-admin user
    When I go to the new client applications page
    Then I should not see the form to add a new application

  Scenario: Trying to add a client application without logging in.
    Given I am a logged out user
    When I go to the client applications page
    Then I should not see the list of applications

  Scenario: Trying to view the link to the list of client applications as a non-admin user
    Given I am logged in as a non-admin user
    When I go to my user page
    Then I should not see the link to the list of client applications
