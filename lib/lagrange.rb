require 'lagrange/scaffold'
require 'lagrange/net_http'
require 'lagrange/point'

module Lagrange
  extend Scaffold

  class << self

    attr_accessor :point

    def interpolate(point_name, sandbox_name, &block)
      point = Point.new(point_name, sandbox_name)
      create_sandbox_scaffold(point) unless sandbox_scaffold_exist?(point)
      self.point = point
      block.call
      point.save
      point
    end

    def scaffold_dir
      'lagrange_sandboxes'
    end

    def load_sandboxs
      app_files.each { |file|
        require file if File.exist?(file)
      }
    end

    def app_files
      Dir[File.join(scaffold_dir, "**", "app.rb")]
    end

  end

end

def Lagrange(point_name, sandbox_name, &block)
  Lagrange.interpolate(point_name, sandbox_name, &block)
end
