class User
  def assign_role(role)
    @role = role
  end
  
  def in_role?(role)
    role == @role
  end
end
