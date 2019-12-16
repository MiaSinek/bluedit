class CommunityCreator
  def initialize(community, user)
    @community = community
    @user = user
  end

  def save
    if @community.save
      Subscription.create(community: @community, user: @user)
    end
  end
end