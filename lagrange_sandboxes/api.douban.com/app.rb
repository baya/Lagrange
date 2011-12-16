ShamRack.at('api.douban.com').sinatra do 
  get "/book/subjects?q=javascript&apikey=041d54466d9280f60c57fcd348b782e2" do 
    erb :book_subjects
  end
end