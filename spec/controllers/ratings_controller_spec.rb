require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RatingsController do
  pending

  describe "responding to GET new" do
    describe "if I have not already added a review for this pub" do
      it "should give success"
      
      it "should expose a new rating as @rating"
    end
    
    describe "if I have already added a review for this page" do
      it "should redirect to the edit rating path" 
    end  
  end
  
  describe "responding to GET edit" do
    it "should give success"
    
    it "should expose my rating as @rating"
  end

  describe "responding to POST create" do
    it "should save my rating"
    
    it "should set a flash success message"
    
    it "should redirect me to the pubs show page"
  end
  
  describe "responding to PUT update" do
    it "should save my rating"
    
    it "should set a flash success message"
    
    it "should redirect me to the pubs show page"
  end
end
