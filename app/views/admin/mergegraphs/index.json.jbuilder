json.array!(@admin_mergegraphs) do |mergegraph|
  json.extract! mergegraph, :merge_id, :graph_id, :side, :y, :vieworder
  json.url mergegraph_url(mergegraph, format: :json)
end
