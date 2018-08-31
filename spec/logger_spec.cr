require "./spec_helper"

describe Environment::Logger do
  describe "#log" do
    it "logs messages with progname" do
      IO.pipe do |r, w|
        logger = Environment::Logger.new(w)
        logger.progname = "Amber"
        logger.debug "debug:skip"
        logger.info "info:show"

        logger.level = Logger::DEBUG
        logger.debug "debug:show"

        logger.level = Logger::WARN
        logger.debug "debug:skip:again"
        logger.info "info:skip"
        logger.error "error:show"

        r.gets.should match(/Amber\t| info:show/)
        r.gets.should match(/Amber\t| debug:show/)
        r.gets.should match(/Amber\t| error:show/)
      end
    end
  end

  describe "#color" do
    it "logs messages with passed color attribute" do
      IO.pipe do |r, w|
        logger = Environment::Logger.new(w)
        Colorize.enabled = true
        logger.info "Test", "Amber", :blue
        r.gets.should match(/\[34mAmber/)
      end
    end
    it "logs messages with default color attribute" do
      IO.pipe do |r, w|
        logger = Environment::Logger.new(w)
        logger.progname = "Amber"
        Colorize.enabled = true
        logger.info "Test"
        r.gets.should match(/\[96mAmber/)
      end
    end
    it "logs messages when #color is used" do
      IO.pipe do |r, w|
        logger = Environment::Logger.new(w)
        logger.progname = "Amber"
        logger.color = :green
        Colorize.enabled = true
        logger.info "Test"
        r.gets.should match(/\[32mAmber/)
      end
    end
  end
end