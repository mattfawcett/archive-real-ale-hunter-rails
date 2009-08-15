Feature: Manage ratings
  In order to rate a pub
  a user
  wants to be able to create or update his rating for a particular pub
  
  Scenario: Rating a pub for the first time
    Given a pub is called "Rose and Crown"
		When I go to the Rose and Crown image listing page
    Then I should see "There are no ratings yet for the the Rose and Crown"
    And I follow "Rate the Rose and Crown"
    Then I should see "Add a rating for the rose and crown"
    When I select "3" from "rating_atmosphere"
    And I press "Save"
    Then I should be on the Rose and Crown image listing page
    And I should see "Atmosphere 30/100" 

  Scenario: Changing my rating of a pub
    Given a pub is called "Rose and Crown"
    And I have already rated the "Rose and Crown"
		When I go to the Rose and Crown image listing page
    Then I should not see "There are no ratings yet for the the Rose and Crown"
    When I follow "Rate the Rose and Crown"
    Then I should see "Edit your rating for the rose and crown"
    When I select "4" from "rating_atmosphere"
    And I press "Save"
    Then I should be on the Rose and Crown image listing page
    And I should see "Atmosphere 40/100" 
 
