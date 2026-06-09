class Admin::TeamMembersController < Admin::BaseController
  layout "admin"

  def index
    @team_members = TeamMember.ordered
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
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @team_member = TeamMember.find(params[:id])
    if @team_member.update(team_member_params)
      flash[:success] = t("team_member_updated")
      redirect_to edit_admin_team_member_path(@team_member)
    else
      flash[:error] = t("team_member_update_error")
      render :edit, status: :unprocessable_entity
    end
  end

  # TODO: DRY
  def update_position
    @team_members = TeamMember.all
    team_member = @team_members.find(params[:id])

    if params[:direction] == "up"
      other_team_member = @team_members.where("position < ?", team_member.position).ordered.last
    else
      other_team_member = @team_members.where("position > ?", team_member.position).ordered.first
    end

    if other_team_member
      saved_position = team_member.position
      team_member.update(position: other_team_member.position)
      other_team_member.update(position: saved_position)
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
