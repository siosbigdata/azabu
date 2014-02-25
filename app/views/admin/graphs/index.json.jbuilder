json.array!(@admin_graphs) do |admin_graph|
  json.extract! admin_graph, :name, :title, :analysis_type,:graph_type, :term, :y,:y_min,:template,:useval,:usetip,:linewidth,:y_unit
  json.url admin_graph_url(admin_graph, format: :json)
end
