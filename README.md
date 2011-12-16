Lagrange
========

Lagrange help ruby developer build sandbox app quickly and easily to simulate _external (Http) services_ for test and development.

Using it
---------

    require 'net/http'
    require 'lagrange'

    Lagrange.turn_on

    uri    = URI("http://cn.bing.com/search?q=lagrange")
    result = Net::HTTP.get(uri)

Then you will find a sandbox named cn.bing.com in lagrange/sandboxes/cn.bing.com

Once you have built the sandbox, you could remove the block of Lagrange.interpolate just like follow:

    uri    = URI("http://cn.bing.com/search?q=lagrange")
    result = Net::HTTP.get(uri)

The result will be returned form the sandbox lagrange_sandboxes/cn.bing.com

Open the file lagrange_sandboxes/cn.bing.com/app.rb, you will find following codes:

    ShamRack.at('cn.bing.com').sinatra do
      get "/search?q=lagrange" do
        erb :search
      end
    end


