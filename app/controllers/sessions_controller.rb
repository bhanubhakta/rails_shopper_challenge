class SessionsController < ApplicationController

  def create
    applicant = Applicant.find_by(email: email)
    if applicant && applicant.phone == phone
      flash[:notice] = "Login successful."
      log_in applicant
      redirect_to applicant_path(applicant)
    else
      flash[:alert] = "Incorrect email or phone."
      redirect_to root_path
    end
  end

  def logout
    log_out
    redirect_to root_path
  end

  private

  def email
    @email ||= params[:email]
  end

  def phone
    @phone ||= params[:phone]
  end
end