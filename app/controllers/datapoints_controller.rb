class DatapointsController < ApplicationController

  def index
    @watch = Watch.find(params[:watch_id])
    @datapoints = @watch.datapoints

    respond_to do |format|
      format.html
      format.json
    end
  end

end
