class CommunitiesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  def index
    load_communities
  end

  def show
    load_community
  end

  def new
    build_community
  end

  def create
    build_community
    save_community('Community was successfully created.') or render :new
  end

  def edit
    load_community
    build_community
  end


  def update
    load_community
    build_community
    save_community('Community was successfully updated.') or render :edit
  end

  def destroy
    load_community
    @community.destroy

    redirect_to communities_path, notice: 'Community was successfully destroyed.'
  end

  private
    def load_communities
      @communities ||= community_scope.to_a
    end

    def load_community
      @community ||=  community_scope.find(params[:id])
    end

    def build_community
      @community ||= community_scope.build
      @community.attributes = community_params
    end

    def save_community(notice)
      if CommunityCreator.new(@community, current_user).save
        redirect_to @community, notice: notice
      end
    end

    def community_scope
      if creating_community?
        current_user.communities_authored
      else
        Community.all
      end
    end

    def community_params
      community_params = params[:community]
      community_params ? community_params.permit(:name, :title, :description, :sidebar) : {}
    end

    def creating_community?
      user_signed_in? && params[:action] == 'create'
    end
 end
