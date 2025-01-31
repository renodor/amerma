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
      # TODO
    end
  end

  def update
    @team_member = TeamMember.find(params[:id])
    if @team_member.update(team_member_params)
      flash.now[:success] = t("team_member_updated")
    else
      # TODO
    end
  end

  def destroy
    TeamMember.find(params[:id]).destroy
    flash[:success] = t("team_member_deleted")
    redirect_to admin_team_members_path
  end

  private

  def team_member_params
    params.require(:team_member).permit(:name, :description, :linked_in_url, :photo)
  end
end
