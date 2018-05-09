ActiveAdmin.register City do
  menu label: 'Города', priority: 5

  actions :index, :new, :show, :create, :edit, :update

  permit_params %i[iata name active country_id name_en latitude longitude]
end
