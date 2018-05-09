ActiveAdmin.register Continent do
  menu label: 'Континенты', priority: 6

  actions :index, :new, :show, :create, :edit, :update

  permit_params %i[name name_en city_id iata flightable latitude longitude]
end
