# frozen_string_literal: true

class ApplicationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_job
  before_action :set_job_application, only: %i[show update destroy]

  def index
    json_response(@job.applications)
  end

  def show
    if current_user.admin?
      if @application.seen == false
        params[:seen] = true
        @application.update(application_params)
        UserMailer.seen_application(@application.applicant).deliver_later
      end
    end
    json_response(@application)
  end

  def create
    params[:applicant] = current_user.email
    params[:seen] = false
    @job.applications.create!(application_params)
    json_response(@job, :created)
  end

  def update
    @application.update(application_params)
    head :no_content
  end

  def destroy
    @application.destroy
    head :no_content
  end

  private

  def application_params
    params.permit(:applicant, :seen)
  end

  def set_job
    @job = Job.find(params[:job_id])
  end

  def set_job_application
    @application = @job.applications.find_by!(id: params[:id]) if @job
  end
end
