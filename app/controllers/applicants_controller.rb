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
    @applicant = current_applicant
    if @applicant.nil?
      flash[:alert] = "Please login to view your information."
      redirect_to root_path
    end
  end

  def authorize
    applicant = current_applicant
    applicant.update_state
    @full_name = "#{applicant.first_name} #{applicant.last_name}"
    redirect_to confirm_applicants_path
  end

  def confirm
  end

  private

  def permitted_params
    [:email, :first_name, :last_name, :phone, :phone_type, :region]
  end
end
