require "./spec_helper"

module Environment
  describe Loader do
    it "raises error for non existent environment settings" do
      expect_raises Error do
        Loader.new("unknown", "./spec/config/")
      end
    end

    it "load settings from YAML file" do
      environment = Loader.new(:fake_env, "./spec/config/")
      environment.settings.should be_a Environment::Settings
    end

    it "loads encrypted YAML settings" do
      environment = Loader.new(:production, "./spec/config/")
      environment.settings.should be_a Environment::Settings
    end
  end
end
