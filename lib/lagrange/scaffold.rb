
module Lagrange

  module Scaffold

    def create_sandbox_scaffold(point)
      create_views_dir(point)
      create_point_file(point)
      create_app_file(point)
    end

    def create_views_dir(point)
      FileUtils.mkdir_p(point.views_dir) unless File.directory?(point.views_dir)
    end

    def create_app_file(point)
      FileUtils.touch(point.app_path) unless File.exist?(point.app_path)
    end

    def create_point_file(point)
      FileUtils.touch(point.view_path) unless File.exist?(point.view_path)
    end

    def sandbox_scaffold_exist?(point)
      File.exist?(point.view_path) and File.exist?(point.app_path)
    end

  end

end
