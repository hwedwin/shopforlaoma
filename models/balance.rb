class Balance
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  belongs_to :user

  has_many :bills

  # field <name>, :type => <type>, :default => <value>
  field :amount, :type => String
  field :currency_big, :type => Integer
  field :currency_small, :type => Integer
  field :status, :type => String

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
