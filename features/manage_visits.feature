Feature: Manage Pub Visits
  In order to use the pub visits facility
  A member browsing the site
  wants to be able to be able to view and add visits for a pub

  Scenario: Adding a visit
    Given I am logged in
    And a pub is called "Rose and Crown"
    When I go to the rose_and_crown_show_page
    And I follow "There are currently no visits for Rose and Crown, click here to add one"
    Then I should be on the Rose and Crown new visit page    
    When I fill in "visit_comments" with "It was very good"
    And I press "Add Visit"
    Then I should be on the rose_and_crown_show_page
    And I should see "Thanks, your visit has been added"    
    And I should see "It was very good"   
    And I should not see "There are currently no visits for Rose and Crown, click here to add one"
    When I follow "View All Visits"
    Then I should be on the Rose and Crown visits index
    And I should see "It was very good"
