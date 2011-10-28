module Assets
  module Helpers

    def javascript_assets
      %w[ libs/jquery.fancybox-1.3.4.pack.js main.js ]
    end

    def javascript_includes_names
      settings.production? ? %w[all.js] : javascript_assets
    end

    def javascript_includes
      javascript_includes_names.map {|a| %(<script src="/javascripts/#{a}"></script>) }.join("\n")
    end

    def javascript_files
      javascript_assets.map{|name| File.join(settings.public, "javascripts", name) }
    end

    def render_javascript(files)
      files.map { |name|
        content = File.read name
        Uglifier.new.compile(content)
      }.join(";")
    end

    def file_mtime(name)
      name = File.join(settings.views, name) unless name.include? '/'
      File.mtime name
    end
  end

  def self.registered(app)
    app.helpers Helpers

    # poor man's Sprockets
    app.get "/javascripts/all.js" do
      content_type "application/javascript"
      files = javascript_files

      expires 10.days
      last_modified files.map {|f| file_mtime(f) }.max

      render_javascript files
    end
  end
end