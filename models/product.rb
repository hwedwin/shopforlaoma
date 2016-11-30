class Product
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  @@new_product = 0

  belongs_to :category, validate: false, dependent: :nullify, optional: true
  has_many :pictures
  has_one :car
  accepts_nested_attributes_for :car


  # field <name>, :type => <type>, :default => <value>
  field :title, :type => String
  field :cover, :type => String
  field :description, :type => String
  field :price_big, :type => Integer
  field :price_small, :type => Integer
  field :price, :type => String
  field :lowest_price, :type => String
  field :highest_price, :type => String
  field :lowest_price_big, :type => String
  field :lowest_price_small, :type => String
  field :highest_price_small, :type => Integer
  field :highest_price_big, :type => Integer
  field :product_model_type, :type => String
  field :brand, :type => String
  field :company, :type => String

  def self.set_new_product(product)
    @@new_product = product
  end

  def self.get_new_product
    @@new_product

  end



  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
