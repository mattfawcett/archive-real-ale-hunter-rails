require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PubsController do

  before(:each) do
    @pub = Pub.make(:town => "Leeds", :name => "Dog and Gun")
  end

  describe "responding to GET index" do
    describe "when requesting html" do

      it "should expose all the pubs as @pubs" do
        get :index
        assigns(:pubs).should == [@pub]
      end

      it "should limit the number of pubs to a town if there is a town_id in params" do
        get :index, :town_id => "Leeds"
        assigns(:pubs).should == [@pub]
        get :index, :town_id => "Wakefield"
        assigns(:pubs).should == []
      end

      describe "handing only displayig pubs beginning with a certain letter" do
        it "should be handle the passing in of a letter all pubs" do
          get :index, :letter => 'D'
          assigns(:pubs).should == [@pub]
          get :index, :letter => 'E'
          assigns(:pubs).should == []
        end

        it "should be handle the passing in of a letter limited to a town" do
          get :index, :town_id => "Leeds", :letter => 'D'
          assigns(:pubs).should == [@pub]
          get :index, :town_id => "Leeds", :letter => 'E'
          assigns(:pubs).should == []
        end
      end

      it "should give success" do
        get :index
        response.should be_success
      end

      it "should give html back" do
        get :index
        response.headers['Content-Type'].should =~ /text\/html/
      end
    end

    describe "when requesting json" do
      describe "when wanting all pubs" do
        describe "when request is from an iphone and includes lat and lon" do
          it "should find the nearest pubs" do
            pubs_array = [@pub]
            Pub.should_receive(:find).with(:all, :order => :distance, :within => 100, :origin => [53,-1], :limit => 5).at_least(:once).and_return(pubs_array)
            get :index, :format => 'json', :lat => 53, :lon => -1
          end
        end

        describe "when request is from cluster and all pubs are needed (no lat or lon)" do
          it "should call all_optimised_for_cluster_for_map on Pub" do
            pubs_array = [@pub]
            Pub.should_receive(:all_optimised_for_cluster_for_map).at_least(:once).and_return(pubs_array)
            pubs_array.should_receive(:to_json)
            get :index, :format => 'json'
          end

          it "should give success" do
            Pub.stub!(:all_optimised_for_cluster_for_map).and_return([])
            get :index, :format => 'json'
            response.should be_success
          end

          it "should not do a normal expensive find" do
            Pub.stub!(:all_optimised_for_cluster_for_map).and_return([])
            Pub.should_not_receive(:find).with(:all)
            get :index, :format => 'json'
          end

          it "should give json back" do
            Pub.stub!(:all_optimised_for_cluster_for_map).and_return([])
            get :index, :format => 'json'
            response.headers['Content-Type'].should =~ /json/
          end
        end
      end
      describe "when requesting javascript" do
        it "should call all_optimised_for_cluster_for_map on Pub" do
          pubs_array = [@pub]
          Pub.should_receive(:within_boundreys).at_least(:once).with("53.79190566459485", "53.80711346956182", "-1.567397117614746", "-1.5300607681274414").and_return(pubs_array)
          get :index, :format => 'js', :min_lat => "53.79190566459485", :max_lat => "53.80711346956182", :min_lng => "-1.567397117614746", :max_lng => "-1.5300607681274414"
        end

        it "should give success" do
          Pub.stub!(:within_boundreys).and_return([])
          get :index, :format => 'js', :min_lat => "53.79190566459485", :max_lat => "53.80711346956182", :min_lng => "-1.567397117614746", :max_lng => "-1.5300607681274414"
          response.should be_success
        end

        it "should give javascript back" do
          Pub.stub!(:within_boundreys).and_return([])
          get :index, :format => 'js', :min_lat => "53.79190566459485", :max_lat => "53.80711346956182", :min_lng => "-1.567397117614746", :max_lng => "-1.5300607681274414"
          response.headers['Content-Type'].should =~ /javascript/
        end
      end

    end
  end

  describe "rsponding to GET show" do
    describe "when requesting html" do
      it "should find the pub" do
        Pub.should_receive(:find).with(@pub.slug).and_return(@pub)
        get :show, :id => @pub.slug
      end

      it "should expose the pub as @pub" do
        Pub.stub(:find).with(@pub.slug).and_return(@pub)
        get :show, :id => @pub.slug
        assigns(:pub).should eql(@pub)
      end

      it "should give success" do
        Pub.stub(:find).with(@pub.slug).and_return(@pub)
        @pub.stub(:has_better_id?).and_return(false)
        get :show, :id => @pub.slug
        response.should be_success
      end

      it "should give html back" do
        Pub.stub(:find).with(@pub.slug).and_return(@pub)
        get :show, :id => @pub.slug
        response.headers['Content-Type'].should =~ /text\/html/
      end

      it "should redirect to the pubs better id if there is one" do
        Pub.stub(:find).with("12").and_return(@pub)
        @pub.stub(:has_better_id?).and_return(true)
        get :show, :id => "12"
        response.should redirect_to(pub_path(@pub))
      end
    end

    describe "when requesting json" do
      it "should find the pub" do
        Pub.should_receive(:find).with("12").and_return(@pub)
        get :show, :id => "12", :format => 'json'
      end

      it "should expose the pub as @pub" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12", :format => 'json'
        assigns(:pub).should eql(@pub)
      end

      it "should give success" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12", :format => 'json'
        response.should be_success
      end

      it "should give json back" do
        Pub.stub(:find).with("12").and_return(@pub)
        get :show, :id => "12", :format => 'json'
        response.headers['Content-Type'].should =~ /json/
      end
    end
  end

end
