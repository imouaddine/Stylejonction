require 'spec_helper'

describe PortfolioController do

  describe "GET 'home'" do
    it "should be successful" do
      get 'portfolio'
      response.should be_success
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end
end