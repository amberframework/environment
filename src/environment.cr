require "./environment/**"
require "./support/file_encryptor"

module Environment
  VERSION = "0.9.0"

  alias EnvType = String | Symbol

  class Error < Exception
    def initialize(path, environment)
      super("Environment file not found for #{path}#{environment}")
    end
  end

  macro included
    class_property path : String = "./config/environments/"
    @@settings : Settings?

    def self.settings
      @@settings ||= Loader.new(env.to_s, path).settings
    rescue Error
      @@settings = Settings.from_yaml("default: settings")
    end

    def self.logger
      settings.logger
    end

    def self.env=(env : EnvType)
      @@env = Env.new(env.to_s)
      @@settings = Loader.new(env, path).settings
    end

    def self.env
      @@env ||= Env.new
    end
  end
end
