Feature: Manage display_pubs
  In order to display pubs
  Any person browsing the site
  wants to be able to view pubs
  
  Scenario: Displaying a list of pubs
    Given a pub is called "Rose and Crown"
	When I go to list all pubs page
    Then I should see "Rose and Crown"
