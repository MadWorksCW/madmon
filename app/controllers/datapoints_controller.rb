class DatapointsController < ApplicationController

  def index
    @datapoints = Datapoint.all

    respond_to do |format|
      format.html
      format.json
    end
  end

end
