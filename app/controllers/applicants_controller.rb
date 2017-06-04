class ApplicantsController < ApplicationController
  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(permitted_values)
    if @applicant.save
      log_in @applicant
      redirect_to background_applicants_path
    else
      @errors = parse_error(@applicant.errors)
      render "new"
    end
  end

  def update
    # your code here
  end

  def show
    # your code here
  end

  private

  def permitted_params
    [:email, :first_name, :last_name, :phone, :phone_type, :region]
  end
end
