class ListResultBuilder < ResultBuilderBase
  def autocomplete_hint
    "#{record.name}"
  end
end
