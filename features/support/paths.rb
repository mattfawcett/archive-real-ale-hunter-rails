module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
    when /the new rating page/
      new_rating_path

    when /the new display_pubs page/
      new_display_pubs_path

    when /the new pub page/
      new_pub_path
    when /list all pubs page/
      pubs_path  
    when /rose_and_crown_show_page/
      "/pubs/rose-and-crown-leeds"
    when "mr_foleys_show_page"
      "/pubs/mr-foleys-leeds"
    when /the Rose and Crown image listing page/
      "/pubs/rose-and-crown-leeds/images"
    when /the Rose and Crown new image page/
      "/pubs/rose-and-crown-leeds/images/new"
    when /the Rose and Crown new visit page/
      "/pubs/rose-and-crown-leeds/visits/new" 
    when /Rose and Crown visits index/
      "/pubs/rose-and-crown-leeds/visits"     
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
