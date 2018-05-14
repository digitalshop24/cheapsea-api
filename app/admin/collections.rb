ActiveAdmin.register Collection do
  menu label: 'Коллекции', priority: 3

  actions :index, :new, :show, :create, :edit, :update, :destroy

  permit_params API::V1::CollectionsController.new.send(:params_array) << :user_id

  index do
    selectable_column
    id_column

    column 'Название', :name
    column 'Название анг.', :name_en
    column 'Описание', :desc

    actions
  end

  form do |f|
    f.inputs 'Детали' do
      f.input :name, label: 'Название'
      f.input :name_en, label: 'Название анг.'
      f.input :desc, label: 'Описание'
      f.input :user, label: 'Пользователь'
    end

    f.inputs 'Связи с предложениями' do
      f.has_many :offer_collections, heading: 'Связи', new_record: 'Добавить связь' do |p|
        p.input :_destroy, as: :boolean, label: "Удалить?" unless p.object.new_record?
        p.input :offer, label: 'Предложение'
      end
    end

    actions
  end

  show do
    attributes_table do
      row :name
      row :name_en
      row :desc
    end

    panel 'Связи с предложениями' do
      table_for collection.offer_collections do
        column :offer
      end
    end
  end
end
