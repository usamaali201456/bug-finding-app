# frozen_string_literal: true

class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update assign_bug resolve_bug]
  before_action :set_project, only: %i[index show new create edit update]
  before_action :validate_bug, only: %i[edit update]

  def index
    @bugs = @project.bugs.includes(image_attachment: :blob)
  end

  def show; end

  def new
    @bug = @project.bugs.build
    authorize @bug
  end

  def create
    @bug = @project.bugs.build(bug_params)
    @bug.user = current_user

    if @bug.save!

      redirect_to project_bug_path(@project, @bug), notice: I18n.t('bug.created')
    else
      render :new
    end
  end

  def edit; end

  def assign_bug
    flash[:notice] = if @bug.update!(dev_id: current_user.id, status: :started)
                       I18n.t('bug.assign_bug')
                     else
                       I18n.t('bug.assign_bug_failed')
                     end
    redirect_to :projects
  end

  def resolve_bug
    flash[:notice] = if @bug.resolved!
                       I18n.t('bug.resolve_bug')
                     else
                       I18n.t('bug.resolve_bug_failed')
                     end
    redirect_to :projects
  end

  def update
    if @bug.update(bug_params)
      redirect_to project_bug_path(@project, @bug)
    else
      render :edit
    end
  end

  private

  def validate_bug
    authorize @bug
  end

  def set_bug
    @bug = Bug.find(params[:id])
  end

  def bug_params
    params.require(:bug).permit(:title, :deadline, :bug_type, :image, :status)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
