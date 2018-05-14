ActiveAdmin.register Tag do
  menu label: 'Теги', priority: 4

  actions :index, :new, :show, :create, :edit, :update, :destroy

  permit_params API::V1::TagsController.new.send(:params_array) << :user_id

  index do
    selectable_column
    id_column

    column 'Название', :name
    column 'Пользователь', :user

    actions
  end

  form do |f|
    f.inputs 'Детали' do
      f.input :name, label: 'Название'
      f.input :user, label: 'Пользователь'
    end

    actions
  end

  show do
    attributes_table do
      row :name
      row :user
    end
  end
end
