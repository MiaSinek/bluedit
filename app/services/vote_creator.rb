class VoteCreator
  def initialize(user, action, vote_subject)
    @user = user
    @action = action
    @vote_subject = vote_subject
  end

  def attempt_to_vote

    if subject_not_voted_on_yet?
      vote!(@action)
      "Successfully #{@action}d #{vote_subject_type}"
    else
      "You already voted for this #{vote_subject_type}"
    end
  end

  private

  def subject_not_voted_on_yet?
    !@user.voted_for?(@vote_subject)
  end

  def vote!(action)
    @vote_subject.send("#{action}_by", @user)
  end

  def vote_subject_type
    @vote_subject.class.to_s.downcase
  end

end