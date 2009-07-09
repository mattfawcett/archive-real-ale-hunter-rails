Feature: Manage Pub Images
  In order to use the pub images facility
  Any person browsing the site
  wants to be able to be able to view and add photos for a pub

  Scenario: Uploading a new photo
    Given a pub is called "Rose and Crown"
		When I go to the Rose and Crown image listing page
    And I follow "Upload a new photo of Rose and Crown"
    Then I should be on the Rose and Crown new image page
    When I attach the file at "features/support/picture.jpg" to "image_attachment"
    And I fill in "image_name" with "Matts image"
    And I press "Upload"
    Then I should be on the Rose and Crown image listing page
    And I should see "Thanks, your photo has been uploaded"    
    And I should see tag "img[@src*='picture.jpg']"   
