module CurrentUser
  def self.set(user)
    @current_user = user
  end

  def self.get
    @current_user || nil
  end
end