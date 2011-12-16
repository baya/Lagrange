
module Lagrange
  class Point

    attr_accessor :http_request
    attr_accessor :http_response

    attr_reader :sandbox_name
    attr_reader :name
    attr_reader :scaffold_dir
    attr_reader :views_dir
    attr_reader :view_path
    attr_reader :app_path

    def initialize(name, sandbox_name )
      @sandbox_name  =   sandbox_name
      @name          =   name
      @scaffold_dir  =   File.join(Lagrange.scaffold_dir, @sandbox_name)
      @views_dir     =   File.join(@scaffold_dir, 'views')
      @app_path      =   File.join(@scaffold_dir, 'app.rb')
      @view_path     =   File.join(@views_dir, @name)
    end

    def save
      File.open(view_path, 'w') { |f| f.write http_response.body}
      File.open(app_path, 'w') { |f| f.write build_app_string}
    end

    def http_request_header
      @http_request_header ||= self.http_request.to_hash
    end

    def http_request_host
      @http_request_host ||= http_request_header['host'][0]
    end

    private

    def build_app_string
      "ShamRack.at(\'#{self.http_request_host}\').sinatra do " + "\n" +
      "  get \"#{self.http_request.path}\" do " + "\n" +
      "    erb :#{self.name}"   + "\n" +
      "  end" + "\n" +
      "end"
    end

  end
end
