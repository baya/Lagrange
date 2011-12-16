# -*- coding: utf-8 -*-
# require 'spec_helper'
require 'rest_client'
# require 'rack'
require 'vcr'
# Lagrange.load_sandboxs

module Api
  class DouBan
    @base_url = 'http://api.douban.com'
    @api_config = { 'api_key' => '041d54466d9280f60c57fcd348b782e2', 'api_secret' => '085db26bde17ec8e'}

    class << self

      def get(path, params = { })
        path = path.gsub(/^\/|\/$/, '')
        params = params.merge('apikey' => @api_config['api_key']).map{ |k, v| "#{k}=#{v}"}.join("&")
        url = URI.encode("#{@base_url}/#{path}?#{params}")
        response = RestClient.get url
        response.body
      end

    end

  end
end


VCR.config do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.stub_with :fakeweb
end
describe '豆瓣API' do

  describe '搜索书籍' do

    it '搜索javascript' do
      # Lagrange('book_subjects', 'api.douban.com') do
      #   # q_word_step('/book/subjects', 'javascript')
      # end
      VCR.use_cassette('book_subjects') do
        q_word_step('/book/subjects', 'javascript')
      end
      # q_word_step('book/subjects', 'javascript')
      # q_word_step('book/subjects/', 'javascript')
      # q_word_step('/book/subjects/', 'javascript')
    end

    it '搜索ruby编程' do
      # q_word_step('/book/subjects', 'ruby编程')
      # q_word_step('book/subjects', 'ruby编程')
      # q_word_step('book/subjects/', 'ruby编程')
      # q_word_step('/book/subjects/', 'ruby编程')
    end

    it '搜索王小波' do
      # q_word_step('/book/subjects', '王小波')
      # q_word_step('book/subjects', '王小波')
      # q_word_step('book/subjects/', '王小波')
      # q_word_step('/book/subjects/', '王小波')
    end

    def q_word_step(path, q)
      @books_xml = Api::DouBan.get(path, :q => q)
      @books_xml.should be_instance_of(String)
      @books_xml.should include("<title>搜索 #{q} 的结果</title>")
      sleep(2) # 防止豆瓣封禁访问
    end

  end
end
