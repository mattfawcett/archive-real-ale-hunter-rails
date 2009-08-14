require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it { should have_many(:pubs) }
  it { should have_many(:images) }
  it { should have_many(:visits) }
  it { should have_many(:ratings) }
  
  def self.latest(n)
    #bug in rails is why this isn't in a named_scope https://rails.lighthouseapp.com/projects/8994/tickets/2346-named_scope-doesnt-override-default_scopes-order-key
    find(:all, :order => "created_at DESC", :limit => n)
  end
end
