require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Beer do
  it { should belong_to(:parent) }
  it { should validate_presence_of(:name) }
end
