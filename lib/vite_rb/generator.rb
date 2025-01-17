require "thor"
require "snowpacker/utils"

module ViteRb
  class Generator < Thor::Group
    include Thor::Actions
    extend Utils

    TEMPLATES = File.join(File.expand_path(__dir__), "templates")
    CONFIG_FILES = %w[
      vite.config.js
      postcss.config.js
    ]

    def self.source_root
      TEMPLATES
    end

    def create_initializer_file
      target = "vite_rb.rb"
      source = "#{target}.tt"

      destination = File.join("config", "initializers", target)

      if Utils.rails?
        destination = Rails.root.join("config", "initializers", target)
      end

      # Creates a config/initializers/snowpacker.rb file
      say "\n\nCreating initializer file at #{destination}...\n\n", :magenta
      template source, destination
    end

    def create_config_files
      destination = File.join("config", "snowpacker")

      if Utils.rails?
        destination = Rails.root.join("config", "snowpacker")
      end

      Rake.mkdir_p destination

      say "\n\nCreating config files @ #{destination}...\n\n", :magenta
      CONFIG_FILES.each do |filename|
        template filename, File.join(destination, filename)
      end
    end

    def create_snowpacker_files
      destination = File.join("app", "snowpacker")

      if Utils.rails?
        destination = Rails.root.join("app", "snowpacker")
      end
      say "\n\nCreating snowpacker files...\n\n", :magenta

      directory "snowpacker", destination
    end

    def init
      create_initializer_file
      create_config_files
      create_snowpacker_files
      add_snowpacker

      say "Finished initializing snowpacker", :green
    end

    def add_snowpacker
      if ENV["SNOWPACKER_TEST"] == "true"
        return system("yarn add rails-snowpacker file:../../")
      end

      system("yarn add rails-snowpacker")
    end

    def self.init
      new.init
    end
  end
end
