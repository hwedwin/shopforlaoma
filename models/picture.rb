class Picture
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  attr_accessor :image


  # field <name>, :type => <type>, :default => <value>
  field :name, :type => String
  mount_uploader :image, PictureUploader
  belongs_to :product , validate: false, dependent: :nullify, optional: true
  belongs_to :category, validate: false, dependent: :nullify, optional: true

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
