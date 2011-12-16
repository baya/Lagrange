require 'spec_helper'

describe Lagrange::Point do
  describe ".initialize" do

    it 'get a new point with name and sandbox name' do
      point = Lagrange::Point.new('purge', 'edgecast_cdn')
      point.scaffold_dir.should == 'lagrange_sandboxes/edgecast_cdn'
      point.views_dir.should == 'lagrange_sandboxes/edgecast_cdn/views'
      point.app_path.should == 'lagrange_sandboxes/edgecast_cdn/app.rb'
      point.view_path.should == 'lagrange_sandboxes/edgecast_cdn/views/purge'
    end

  end

end
