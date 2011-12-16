ShamRack.at('cn.bing.com') do 
  get "/search?q=lagrange" do 
    erb :search
  end
end