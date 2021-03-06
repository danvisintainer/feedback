class InstrumentNeedsController < ApplicationController

  def update
    @project = Project.find(params[:id])
    @project.instrument_need.update(instrument_need_params)
    redirect_to project_path
  end

  private
 def instrument_need_params
    params.require(:instrument_need).permit(:guitar, :bass, :drums, :keyboards, :saxophone, :vocals, :project_id)
  end
end