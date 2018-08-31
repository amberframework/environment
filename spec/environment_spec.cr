require "./spec_helper"

module Test
  include Environment
end

describe Environment do
  it "works" do
    Test.responds_to?(:path).should eq true
    Test.responds_to?(:settings).should eq true
    Test.responds_to?(:env=).should eq true
    Test.responds_to?(:env).should eq true
  end
end
