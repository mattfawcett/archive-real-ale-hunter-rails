class PubsController < ResourceController::Base
  before_filter :require_login, :only => [:new, :create, :edit, :update]
  layout :which_layout?
  caches_page :index, :unless => Proc.new { |c| c.request.format.js? }
  
  
  index.before {@page_title = "Pubs"}
  index.wants.json { render :json => collection.to_json }
  index.wants.js {}  
  
  new_action.before { object.beers.build }
  
  show.before {@page_title = "#{@pub.name} - #{@pub.town}"}
  show.wants.html { redirect_to @pub, :status => 301 if @pub.has_better_id? }
  show.wants.json { render :json => object.to_json(:methods => :slug) }
  

  create.flash "Thanks, The pub has been added"
  create.before { @pub.user = @current_user }
  
  
  
  private
  def which_layout?
    params[:action] == 'index' ? 'two_column' : 'one_column'
  end
  
  def collection      
    if params[:format] == 'json'
      #get all pubs with minimal details
      end_of_association_chain.all_optimised_for_cluster_for_map
    elsif params[:format] == 'js'
      #get details for a limited amount of pubs. but full details
      end_of_association_chain.within_boundreys(params[:min_lat], params[:max_lat], params[:min_lng], params[:max_lng])
    else
      if(params[:town_id])
        #limit to a town
        end_of_association_chain.in_town(params[:town_id]).beginning_with_letter(params[:letter]).paginate(:page => params[:page])
      else  
        end_of_association_chain.beginning_with_letter(params[:letter]).paginate(:page => params[:page])
      end
    end
  end
  
end
