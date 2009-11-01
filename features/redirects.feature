Feature: Site redirects
  In order to get to the correct page
  A user
  wants to be able to request a page from the old app and be redirected to the new equivalent

  Scenario: Main Static Pages
    When I request page "/what-is-real-ale"
    Then I should be redirected to path "/what_is_real_ale"
    
    When I request page "/styles-of-real-ale"
    Then I should be redirected to path "/styles_of_real_ale"
    
    When I request page "/brewing-real-ale"
    Then I should be redirected to path "/brewing_real_ale"
    
    When I request page "/camra-campaign-for-real-ale"
    Then I should be redirected to path "/camra_campaign_for_real_ale"
    
    When I request page "/links.html"
    Then I should be redirected to path "/links"
    
  Scenario: Pub and town listing pages
    When I request page "/pubs/ALL.html" 
    Then I should be redirected to path "/pubs"
    
    When I request page "/pubs/X.html"
    Then I should be redirected to path "/pubs#X"
    
    When I request page "/towns/ALL.html" 
    Then I should be redirected to path "/towns"
    
    When I request page "/towns/X.html"
    Then I should be redirected to path "/towns#X"
    
    When I request page "/towns/Abberley Village/index.html"
    Then I should be redirected to path "/towns/Abberley%20Village/pubs"  
    
  Scenario: individual pubs show pages
    When I request page "/pubs/view_pub/1/101.html"
    Then I should be redirected to path "/pubs/grove-leeds" 
    
    When I request page "/pubs/view_pub/2/101.html"
    Then I should be redirected to path "/pubs/grove-leeds"

    When I request page "/pubs/view_images/101/1.html"
    Then I should be redirected to path "/pubs/grove-leeds/images"
    
    When I request page "/pubs/view_images/101/2.html"
    Then I should be redirected to path "/pubs/grove-leeds/images"
    
  Scenario: Map Pages
    When I request page "/map/index.html"
    Then I should be redirected to path "/map"
    
    
    