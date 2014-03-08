class DatapointsController < ApplicationController

  def index
    unless params[:watch_id].blank?
      @watch = Watch.find(params[:watch_id])
      @datapoints = @watch.datapoints
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

end
