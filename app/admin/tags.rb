ActiveAdmin.register Tag do
  menu label: 'Теги', priority: 4

  actions :index, :new, :show, :create, :edit, :update, :destroy

  permit_params API::V1::TagsController.new.send(:params_array) << :user_id

  index do
    selectable_column
    id_column

    column 'Название', :name

    actions
  end

  form do |f|
    f.inputs 'Детали' do
      f.input :name, label: 'Название'
    end

    f.inputs 'Связи с тегами' do
      f.has_many :offer_tags, heading: 'Связи', new_record: 'Добавить связь' do |p|
        p.input :_destroy, as: :boolean, label: "Удалить?" unless p.object.new_record?
        p.input :tag, label: 'Тег'
      end
    end

    actions
  end

  show do
    attributes_table do
      row :name
    end

    panel 'Связи с предложениями' do
      table_for offer.offer_tags do
        column :tag
      end
    end
  end
end
