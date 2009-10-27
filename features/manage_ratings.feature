Feature: Manage ratings
  In order to rate a pub
  a user
  wants to be able to create or update his rating for a particular pub
  
  Background:
    Given a pub is called "Rose and Crown"
    And I am logged in

  Scenario: Rating a pub for the first time   
    When I am logged in
	When I go to the rose_and_crown_show_page    
    And I follow "This pub hasn't been rated yet. be the first to rate it"
    Then I should see "Add a rating for Rose and Crown"
    When I select "3" from "rating_atmosphere"
    And I press "Save"
    Then I should be on the Rose and Crown image listing page
    And I should see "Atmosphere 3/10" 

  Scenario: Changing my rating of a pub
    When I am logged in
    And I have already rated the "Rose and Crown"
	When I go to the rose_and_crown_show_page
    Then I should not see "There are no ratings yet for the the Rose and Crown"
    When I follow "Rate the Rose and Crown"
    Then I should see "Edit your rating for the rose and crown"
    When I select "4" from "rating_atmosphere"
    And I press "Save"
    Then I should be on the Rose and Crown image listing page
    And I should see "Atmosphere 4/10" 
 
