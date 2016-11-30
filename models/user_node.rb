class UserNode
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  @@root = 0

  belongs_to :user, optional: true
  has_one :product
  has_many :user_nodes, validate: false
  belongs_to :user_node, validate: false, dependent: :nullify, optional: true

  # field <name>, :type => <type>, :default => <value>
  field :is_root, :type => Boolean
  field :seller, :type => String
  field :parent_node, :type => String

  def self.set_root(user_node)
    @@root = user_node
  end

  def self.get_root(user_node)
    @@root
  end


  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
