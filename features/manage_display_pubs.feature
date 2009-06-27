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
		And I fill in "pub_name" with "Mr Foleys"
		And I fill in "pub_description" with "A fine ale house"
		And I fill in "pub_address_1" with "Headrow"
		And I fill in "pub_town" with "Leeds"
		And I fill in "pub_post_code" with "LS1 5RG"
		And I fill in "pub_telephone" with "0113500735"
		And I check "pub_gbg"		
		And I select "3" from "pub_number_of_pumps"
		And I press "Save"
		Then I should be on mr_foleys_show_page
		And I should see "Thanks, Mr Foleys has been added"
		

		
		