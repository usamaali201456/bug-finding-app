# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]
  before_action :set_users, only: %i[new edit]
  before_action :validate_project, only: %i[edit update destroy]

  def index
    @projects = policy_scope(Project)
  end

  def show; end

  def new
    @project = Project.new
    authorize @project
  end

  def create
    @project = current_user.owned_projects.new(project_params)

    if @project.save!
      flash[:notice] = I18n.t('project.created')
      redirect_to @project
    else
      render :new
    end
  end

  def edit; end

  def update
    if @project.update!(project_params)
      redirect_to @project
    else
      render :edit
    end
  end

  def destroy
    redirect_to projects_path if @project.destroy!
  end

  private

  def validate_project
    authorize @project
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, user_ids: [])
  end

  def set_users
    @developers = User.developers
    @testers = User.testers
  end
end
