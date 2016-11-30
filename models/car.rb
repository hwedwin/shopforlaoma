class Car
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  # field <name>, :type => <type>, :default => <value>

  @@new_car = 0

  belongs_to :product, validate: false, dependent: :nullify, optional: true
  field :manufacturer, :type => String
  field :level, :type => String
  field :engine, :type => String
  field :size, :type => String
  field :gearbox, :type => String
  field :structure, :type => String
  field :highest_speed, :type => String
  field :fuel_consumption_tested, :type => String
  field :fuel_consumption_official, :type => String
  field :assurance, :type => String
  field :other, :type => String
  field :model_type, :type => String
  field :price_about_didi_lowest, :type => BigDecimal
  field :price_about_didi_highest, :type => BigDecimal
  field :price_about_general_lowest, :type => BigDecimal
  field :price_about_general_highest, :type => BigDecimal

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  def self.set_new_car(car)
    @@new_car = car
  end

  def self.get_new_car
    @@new_car
  end



  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
