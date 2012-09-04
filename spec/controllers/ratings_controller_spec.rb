require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RatingsController do
  before(:each) do
    @rating = Rating.make
    @pub = @rating.pub
    @user_who_has_rated = @rating.user
    @user_who_has_not_rated = User.make
  end

  describe "responding to GET new" do
    before(:each){login_as(@user_who_has_not_rated)}
    describe "if I have not already added a review for this pub" do
      it "should give success" do
        get :new, :pub_id => @pub.id
        response.should be_success
      end

      it "should expose a new rating as @rating" do
        get :new, :pub_id => @pub.id
        assigns(:rating).should be_a(Rating)
        assigns(:rating).should be_new_record
      end
    end

    describe "if I have already added a review for this page" do
      it "should redirect to the edit rating path" do
        login_as(@user_who_has_rated)
        get :new, :pub_id => @pub.id
        response.should redirect_to(edit_rating_path(@rating))
      end
    end
  end

  describe "responding to GET edit" do
    before(:each){login_as(@user_who_has_rated)}
    it "should give success" do
      get :edit, :id => @rating.id
      response.should be_success
    end

    it "should expose my rating as @rating" do
      get :edit, :id => @rating.id
      assigns(:rating).should be_a(Rating)
      assigns(:rating).id.should eql(@rating.id)
    end
  end

  describe "responding to POST create" do
    before(:each){login_as(@user_who_has_not_rated)}

    describe "when everything is valid" do
      it "should save my rating" do
        mock_rating = mock_model(Rating, :pub => @pub)
        Rating.should_receive(:new).with('these' => 'params').and_return(mock_rating)
        mock_rating.should_receive(:pub=).with(@pub)
        mock_rating.should_receive(:user_id=).with(@user_who_has_not_rated.id)
        mock_rating.should_receive(:save).and_return(true)
        post :create, :pub_id => @pub.id, :rating => {'these' => 'params'}
      end

      it "should set a flash success message" do
        mock_rating = mock_model(Rating, :pub => @pub, :pub= => true, :user_id= => true, :save => true)
        Rating.stub!(:new).with('these' => 'params').and_return(mock_rating)
        post :create, :pub_id => @pub.id, :rating => {'these' => 'params'}
        flash[:notice].should eql("Thanks, your rating has been added")
      end

      it "should redirect me to the pubs show page" do
        mock_rating = mock_model(Rating, :pub => @pub, :pub= => true, :user_id= => true, :save => true)
        Rating.stub!(:new).with('these' => 'params').and_return(mock_rating)
        post :create, :pub_id => @pub.id, :rating => {'these' => 'params'}
        response.should redirect_to(pub_path(@pub))
      end
    end

    describe "when validation fails" do
      it "should rerender the form if the rating is invalid" do
        mock_rating = mock_model(Rating, :pub => @pub, :pub= => true, :user_id= => true, :save => false)
        Rating.stub!(:new).with('these' => 'params').and_return(mock_rating)
        post :create, :pub_id => @pub.id, :rating => {'these' => 'params'}
        response.should be_success
      end

      it "should expose the rating as @rating" do
        mock_rating = mock_model(Rating, :pub => @pub, :pub= => true, :user_id= => true, :save => false)
        Rating.stub!(:new).with('these' => 'params').and_return(mock_rating)
        post :create, :pub_id => @pub.id, :rating => {'these' => 'params'}
        assigns(:rating).should be_a(Rating)
      end
    end
  end

  describe "responding to PUT update" do
    before(:each){login_as(@user_who_has_rated)}

    describe "when everything is valid" do
      it "should save my rating" do
        @user_who_has_rated.stub_chain(:ratings, :find).and_return(@rating)
        @rating.should_receive(:update_attributes).with('these' => 'params').and_return(true)
        put :update, :id => @rating.id, :rating => {'these' => 'params'}
      end

      it "should set a flash success message" do
        @user_who_has_rated.stub_chain(:ratings, :find).and_return(@rating)
        @rating.should_receive(:update_attributes).with('these' => 'params').and_return(true)
        put :update, :id => @rating.id, :rating => {'these' => 'params'}
        flash[:notice].should eql("Thanks, your rating has been updated")
      end

      it "should redirect me to the pubs show page" do
        @user_who_has_rated.stub_chain(:ratings, :find).and_return(@rating)
        @rating.should_receive(:update_attributes).with('these' => 'params').and_return(true)
        put :update, :id => @rating.id, :rating => {'these' => 'params'}
        response.should redirect_to(pub_path(@pub))
      end
    end

    describe "when validation fails" do
      it "should rerender the form if the rating is invalid" do
        @user_who_has_rated.stub_chain(:ratings, :find).and_return(@rating)
        @rating.should_receive(:update_attributes).with('these' => 'params').and_return(false)
        put :update, :id => @rating.id, :rating => {'these' => 'params'}
        response.should be_success
      end

      it "should expose the rating as @rating" do
        @user_who_has_rated.stub_chain(:ratings, :find).and_return(@rating)
        @rating.should_receive(:update_attributes).with('these' => 'params').and_return(false)
        put :update, :id => @rating.id, :rating => {'these' => 'params'}
        assigns(:rating).should == @rating
      end
    end
  end

end
