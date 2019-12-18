class VoteSubjectFinder
  def self.find(type, id)
    model_class(type).find(id)
  end

  def self.model_class(type)
    type.capitalize.constantize
  end
end