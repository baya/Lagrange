require 'rubygems'
require 'rest_client'
require 'json'
require 'spec_helper'

Lagrange.load_sandboxs

module EdgeCaste
  extend self

  TOKEN = '416522fb-1a9b-4920-9eba-8b152bd6b001'
  AUTH_TOKEN = "TOK:#{TOKEN}"
  ACCOUNT_NUMBER = '56F6'
  MCC_BASE_URL = "http://api.edgecast.com/v2/mcc/customers/#{ACCOUNT_NUMBER}"
  REPORT_BASE_URL = "http://api.edgecast.com/v2/reporting/customers/#{ACCOUNT_NUMBER}"
  HOST = "api.edgecast.com"
  M_TYPES = {
    'flash_media_streaming'  =>        2,
    'http_large_object'      =>        3,
    'http_small_object'      =>        8,
    'adn'                    =>        14,
    'adn_ssl'                =>        15
  }

  def purge(rp = { })
    url = MCC_BASE_URL + '/edge' + '/purge'
    body = { 'MediaPath' => rp[:media_path], 'MediaType' => rp[:media_type]}
    case rp[:format]
    when 'json'
      body = body.to_json
      accept = content_type = 'application/json'
    when 'xml'
      body = make_purge_xml_body(body)
      accept = content_type = 'application/xml'
    end
    headers = { :content_type => content_type, :accept => accept, :authorization => AUTH_TOKEN, :host => HOST}
    result = RestClient.put url, body, headers
  end

  #
  #    result = get_cname_hits(:begindate => "2011-10-20",
  #                            :enddate   => "2011-11-20",
  #                            :plat_form =>  8,
  #                            :foramt    => "xml")
  #    result.code #  =>200
  #    result.body #  => [{
  #        "Bytes" : 26182770916,
  #        "Hits" : 228445,
  #        "Name" : "CNAME1"
  #      }, {
  #        "Bytes" : 6958089484,
  #        "Hits" : 16646983,
  #        "Name" : "CNAME2"
  #     }, {
  #        "Bytes" : 36890,
  #        "Hits" : 97,
  #        "Name" : "CNAME3"
  #   } ]
  #
  def get_cname_hits(options = { :format => 'json'})
    url = REPORT_BASE_URL + "/media/#{options[:plat_form]}/cnames?begindate=#{options[:begindate]}&enddate=#{options[:enddate]}"
    result = RestClient.get(url, :accept => "application/#{options[:format]}", :authorization => AUTH_TOKEN, :host => HOST)
  end

  private

  def make_purge_xml_body(body = { })
    xml_body = "<MediaContentPurge xmlns=\"http://www.whitecdn.com/schemas/apiservices/\">"+
      "<MediaPath>#{body['MediaPath']}/MediaPath>" +
      "<MediaType>#{body['MediaType']}</MediaType>" +
      "</MediaContentPurge>"
  end

end

describe EdgeCaste do

  describe '.purge' do

    before :each do
      @http_small_object_path = "http://wac.56F6.edgecastcdn.com/0056F6888888"
      @media_path = "#{@http_small_object_path}/*.css"
      @media_type = EdgeCaste::M_TYPES['http_small_object']
    end

    it 'purge asset with json format and response ok' do
      Lagrange('purge', 'api.edgecast.com') do
        result = EdgeCaste.purge(:media_path => @media_path, :media_type => @media_type, :format => 'json')
        result.code.should == 200
      end
    end

    it 'purge asset with xml format and response ok' do
      pending
      result = EdgeCaste.purge(:media_path => @media_path, :media_type => @media_type, :format => 'xml')
      result.code.should == 200
    end

  end

  describe '.get_cname_hits' do

    it 'get cname hits with json format and response ok' do
      pending
      result = EdgeCaste.get_cname_hits(:begindate => "2011-11-01",
                                        :enddate   => "2011-11-03",
                                        :plat_form => EdgeCaste::M_TYPES['http_small_object'],
                                        :format    => "json")
      result.code.should == 200
    end

    it 'get cname hits with xml format and response ok' do
      pending
      result = EdgeCaste.get_cname_hits(:begindate => "2011-11-01",
                                        :enddate   => "2011-11-02",
                                        :plat_form => EdgeCaste::M_TYPES['http_small_object'],
                                        :format    => "xml")
      result.code.should == 200
    end

  end

end
