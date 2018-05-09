ActiveAdmin.register Airport do
  menu label: 'Аэропорты', priority: 6

  actions :index, :new, :show, :create, :edit, :update, :destroy

  permit_params %i[name name_en city_id iata flightable latitude longitude]
end
