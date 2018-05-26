ActiveAdmin.register Country do
  menu label: "Страны", priority: 2

  actions :index, :new, :create, :edit, :update

  permit_params :iata,
    :name,
    :name_en,
    :continent_id,
    :desc,
    :police_phone_number,
    :ambulance_phone_number,
    :inoculations,
    :snakes,
    :thieves,
    :queer_money,
    square_images_attributes: [:file, :id, :_destroy], rectangular_images_attributes: [:file, :id, :_destroy]

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
      f.input :police_phone_number, label: 'Телефон полиции'
      f.input :ambulance_phone_number, label: 'Телефон скорой помощи'
      f.input :inoculations, label: 'Прививки'
      f.input :snakes, label: 'Змеи'
      f.input :thieves, label: 'Щипачи'
      f.input :queer_money, label: 'Фальшивые деньги'
    end

    actions
  end
end
