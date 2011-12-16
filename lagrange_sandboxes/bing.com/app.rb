ShamRack.at('cn.bing.com') do 
  get "/search?q=lagrange" do 
    erb :lookup
  end
end