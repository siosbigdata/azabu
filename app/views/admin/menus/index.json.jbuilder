json.array!(@admin_menus) do |menu|
  json.extract! menu, :group_id, :parent_id, :name, :title, :vieworder, :icon, :menutype
  json.url menu_url(menu, format: :json)
end
