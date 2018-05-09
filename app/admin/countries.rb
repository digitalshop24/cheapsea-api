ActiveAdmin.register Country do
  menu label: "Страны", priority: 2

  actions :index, :new, :create, :edit, :update, :destroy

  permit_params :iata, :name, :name_en, :continent_id, square_images_attributes: [:file, :id, :_destroy], rectangular_images_attributes: [:file, :id, :_destroy]

  index do
    selectable_column
    id_column

    column "IATA", :art
    column "Название", :name
    column "Описание анг.", :name_en
    column "Континент", :continent

    actions
  end

  form do |f|
    f.inputs do
      f.has_many :square_images, heading: "Квадратные изображения", new_record: "Добавить квадратное изображение" do |p|
        p.input :_destroy, as: :boolean, label: "Удалить?" unless p.object.new_record?
        p.input :file, as: :file, hint: p.object.new_record? ? "Нет фото" : f.template.image_tag(p.object.file_url)
      end

      f.has_many :rectangular_images, heading: "Прямоугольные изображения", new_record: "Добавить прямоугольное изображение" do |p|
        p.input :_destroy, as: :boolean, label: "Удалить?" unless p.object.new_record?
        p.input :file, as: :file, hint: p.object.new_record? ? "Нет фото" : f.template.image_tag(p.object.file_url)
      end

      f.input :continent, label: 'Континент'
      f.input :iata, label: 'IATA'
      f.input :name, label: 'Название'
      f.input :name_en, label: 'Название анг.'
      f.input :desc, label: 'Описание'
    end

    actions
  end
end
