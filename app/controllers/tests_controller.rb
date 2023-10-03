class TestsController < ApplicationController
  def index
    render inline: "<%= Test.all.inspect %>"
  end
end
