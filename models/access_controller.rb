class AccessController
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  embedded_in :role

  # field <name>, :type => <type>, :default => <value>
  field :access_name, :type => String
  field :creatable, :type => Boolean
  field :updatable, :type => Boolean
  field :readable, :type => Boolean
  field :deletable, :type => Boolean

  # You can define indexes on documents using the index macro:
  # index :field <, :unique => true>

  # You can create a composite key in mongoid to replace the default id using the key macro:
  # key :field <, :another_field, :one_more ....>
end
