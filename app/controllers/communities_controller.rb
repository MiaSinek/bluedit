class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:show, :index]

  def index
    @communities = Community.all
  end

  def show
  end

  def new
    @community = current_user.communities_authored.new
  end

  def edit
  end

  def create
    @community = current_user.communities_authored.new(community_params)

    if @community.save
      Subscription.create(community_id: @community.id, user_id: current_user.id)

      redirect_to @community, notice: 'Community was successfully created.'
    else
      render :new
    end
  end

  def update
    if @community.update(community_params)
      redirect_to @community, notice: 'Community was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @community.destroy

    redirect_to communities_url, notice: 'Community was successfully destroyed.'
  end

  private
    def set_community
      @community = Community.find(params[:id])
    end

    def community_params
      params.require(:community).permit(:name, :title, :description, :sidebar)
    end
end
