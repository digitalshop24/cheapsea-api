ActiveAdmin.register Offer do
  menu label: 'Предложения', priority: 1

  actions :index, :new, :show, :create, :edit, :update, :destroy

  permit_params API::V1::OffersController.new.send(:params_array) << %i[user_id main]

  index do
    selectable_column
    id_column

    column 'Название', :name
    tag_column 'Статус', :status, interactive: true
    tag_column 'Тип', :offer_type, interactive: true
    tag_column 'Тип скидки', :discount_type, interactive: true
    tag_column 'Качество', :quality, interactive: true
    toggle_bool_column 'На главной', :main
    column 'Авиакомпания', :airline

    actions
  end

  form do |f|
    f.inputs 'Детали' do
      f.input :offer_type, label: 'Тип'
      f.input :discount_type, label: 'Тип скидки'
      f.input :name, label: 'Название'
      f.input :airline, label: 'Авиакомпания'
      f.input :is_direct, label: 'Прямой?'
      f.input :date_from, as: :date_time_picker, label: 'От'
      f.input :date_to, as: :date_time_picker, label: 'По'
      f.input :date_end, as: :date_time_picker, label: 'Конец предложения'
      f.input :price, label: 'Цена'
      f.input :discount_rate, label: 'Скидка %'
      f.input :description, label: 'Описание'
      f.input :status, label: 'Статус'
      f.input :price_currency, label: 'Валюта'
      f.input :two_sides, label: 'В две стороны?'
      f.input :from_airport, label: 'Из аэропорта'
      f.input :to_airport, label: 'В аэропорт'
      f.input :origin, label: 'Из города'
      f.input :destination, label: 'В город'
      f.input :user, label: 'Пользователь'
      f.input :quality, label: 'Качество'
      f.input :main, label: 'На главной'
      f.input :faq, label: 'Инструкция'
    end

    f.inputs 'Пересадки' do
      f.has_many :transfers, heading: 'Пересадки', new_record: 'Добавить пересадку', allow_destroy: true do |p|
        p.input :_destroy, as: :boolean, label: "Удалить?" unless p.object.new_record?
        p.input :city, label: 'Город'
        p.input :to_city, label: 'Город назначения'
        p.input :airline, label: 'Авиакомпания'
        p.input :to_airline, label: 'Авиакомпания назначения'
        p.input :airport, label: 'Аэропорт'
        p.input :to_airport, label: 'Аэропорт назначения'
        p.input :user, label: 'Пользователь'
        p.input :type, label: 'В какую сторону'
        p.input :number, label: 'Номер'
      end
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
      row :offer_type
      row :discount_type
      row :name
      row :airline_id
      row :is_direct
      row :date_from
      row :date_to
      row :date_end
      row :price
      row :discount_rate
      row :description
      row :status
      row :price_currency
      row :two_sides
      row :from_airport_id
      row :to_airport_id
      row :origin_id
      row :destination_id
      row :quality
      row :main
      row :faq
    end

    panel 'Пересадки' do
      panel 'Туда' do
        table_for offer.transfers.from_origin, sortable: true do
          column :city
          column :airline
          column :airport
          column :to_airport
          column :to_city
          column :to_airline
          column :type
          column :number
        end
      end

      panel 'Обратно' do
        table_for offer.transfers.to_origin, sortable: true do
          column :city
          column :airline
          column :airport
          column :to_airport
          column :to_city
          column :to_airline
          column :type
          column :number
        end
      end
    end

    panel 'Теги' do
      table_for offer.tags do
        column :name
      end
    end
  end
end
