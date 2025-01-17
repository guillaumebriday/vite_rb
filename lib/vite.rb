# frozen_string_literal: true

require "vite_rb/configuration"
require "vite_rb/env"
require "vite_rb/generator"
require "vite_rb/helpers"
require "vite_rb/proxy"
require "vite_rb/utils"
require "vite_rb/manifest"

module ViteRb
  class << self
    attr_accessor :config

    def configure
      self.config ||= Configuration.new
      yield(config) if block_given?
    end
  end
end

require "vite_rb/version"
require "vite_rb/runner"
require "vite_rb/engine" if defined?(Rails)
