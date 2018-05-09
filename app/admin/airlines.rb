ActiveAdmin.register Airline do
  menu label: 'Авиакомпании', priority: 7

  actions :index, :new, :show, :create, :edit, :update

  permit_params %i[id name iata]
end
