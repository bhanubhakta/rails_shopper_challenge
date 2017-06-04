class FunnelsController < ApplicationController
  def index
    start_date = params[:start_date] || Date.today.to_s
    end_date = params[:end_date] || Date.today.to_s

    if Date.parse(start_date) > Date.parse(end_date)
      render json: {code: 422, message: "start_date cannot be greater than end_date"}, :status => 422 and return
    end
    
    @funnel = Funnel.analytics(start_date, end_date)
    
    respond_to do |format|
      format.html { @chart_funnel = formatted_funnel }
      format.json { render json: @funnel }
    end
  end

  private

  # generates a formatted version of the funnel for display in d3
  def formatted_funnel
    formatted = Hash.new { |h, k| h[k] = [] }

    @funnel.each do |date, state_counts|
      state_counts.each do |state, count|
        formatted[state] << {label: date, value: count}
      end
    end

    formatted.map do |k, v|
      {
        key: k.humanize,
        values: v
      }
    end
  end
end
