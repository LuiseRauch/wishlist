class UserResultBuilder < ResultBuilderBase
  def autocomplete_hint
    "Username: #{record.username}, Full name: #{record.full_name}, City: #{record.city}"
  end
end
