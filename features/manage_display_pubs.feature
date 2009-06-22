Feature: Manage display_pubs
  In order to display pubs
  Any person browsing the site
  wants to be able to view pubs
  
  Scenario: Displaying a list of pubs
    Given a pub is called "Rose and Crown"
		When I go to list all pubs page
    Then I should see "Rose and Crown"

	Scenario: Viewing one pubs details
		Given a pub is called "Rose and Crown"
		And I am on the list all pubs page
		When I follow "Rose and Crown"
		Then I should be on rose_and_crown_show_page
		And I should see "Rose and Crown"
		
	Scenario: "Adding a new pub"
		Given I have no pubs
		And I am on the list all pubs page
		When I follow "Add a new pub"
		And I fill in "name" with "Mr Foleys"
		And I fill in "description" with "A fine ale house"
		

		
		