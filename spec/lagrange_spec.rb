require 'spec_helper'

describe Lagrange do

  let(:default_dir) { File.dirname(__FILE__) + '/../lagrange_sandboxes'}
  let(:point_name)   { "search"}
  let(:sandbox_name) { 'cn.bing.com'}
  # after(:each) { FileUtils.rm_rf default_dir}

  describe ".interpolate" do

    it "should create a new sandbox scaffold to the dir lagrange/sandboxes if the sandbox scaffold is not existed" do
      point = Lagrange.interpolate(point_name, sandbox_name) do
        uri = URI("http://cn.bing.com/search?q=lagrange")
        result = Net::HTTP.get(uri)
      end
      sandbox_dir = "#{default_dir}/#{sandbox_name}"
      File.directory?(point.views_dir).should be_true
      File.exist?(point.view_path).should be_true
      File.exist?(point.app_path).should be_true
    end

    it "should write sham rack code to app file" do
      point = Lagrange.interpolate(point_name, sandbox_name) do
        uri = URI("http://cn.bing.com/search?q=lagrange")
        result = Net::HTTP.get(uri)
      end
      # p point.http_request.to_hash
      # p point.http_request.to_hash['host']
      # p point.http_request.methods.sort
      # p point.http_request.path
      File.read(point.view_path).should include('lagrange')
      File.read(point.app_path).should include("/search?q=lagrange")
      # p point.http_response.to_hash
    end

  end

  describe '.app_files' do
    it 'should get all app files' do
      point = Lagrange.interpolate(point_name, sandbox_name) do
        uri = URI("http://cn.bing.com/search?q=lagrange")
        result = Net::HTTP.get(uri)
      end
      point_name = "lookup"
      sandbox_name = "bing.com"
      point = Lagrange.interpolate(point_name, sandbox_name) do
        uri = URI("http://cn.bing.com/search?q=lagrange")
        result = Net::HTTP.get(uri)
      end
      Lagrange.app_files.size.should == 2
    end
  end

  describe 'Lagrange is a method act as Lagrange.interpolate' do

    it "should create a new sandbox scaffold to the dir lagrange/sandboxes if the sandbox scaffold is not existed" do
      point = Lagrange(point_name, sandbox_name) do
        uri = URI("http://cn.bing.com/search?q=lagrange")
        result = Net::HTTP.get(uri)
      end
      sandbox_dir = "#{default_dir}/#{sandbox_name}"
      File.directory?(point.views_dir).should be_true
      File.exist?(point.view_path).should be_true
      File.exist?(point.app_path).should be_true
    end

  end

end
