json.array!(@admin_merges) do |merge|
  json.extract! merge, :name, :title, :term
  json.url merge_url(merge, format: :json)
end
