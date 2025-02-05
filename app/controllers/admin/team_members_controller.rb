class Admin::TeamMembersController < Admin::BaseController
  layout "admin"

  def index
    @team_members = TeamMember.all
  end

  def new
    @team_member = TeamMember.new
  end

  def edit
    @team_member = TeamMember.find(params[:id])
  end

  def create
    @team_member = TeamMember.new(team_member_params)
    if @team_member.save
      flash[:success] = t("team_member_created")
      redirect_to edit_admin_team_member_path(@team_member)
    else
      flash[:error] = t("team_member_create_error")
      redirect_to new_admin_team_member_path(@project)
    end
  end

  def update
    @team_member = TeamMember.find(params[:id])
    if @team_member.update(team_member_params)
      flash.now[:success] = t("team_member_updated")
    else
      flash[:error] = t("team_member_update_error")
      redirect_to edit_admin_team_member_path(@team_member)
    end
  end

  def destroy
    TeamMember.find(params[:id]).destroy
    flash[:success] = t("team_member_deleted")
    redirect_to admin_team_members_path
  end

  private

  def team_member_params
    params.require(:team_member).permit(:name, :description, :description_en, :linked_in_url, :photo)
  end
end
