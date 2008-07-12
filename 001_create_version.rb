require 'rubygems'
require 'activerecord'

require 'database'

# migration file.  Creates the SchemaVersion table, keeping track of which 
# version of the migration we're on.

# defines the table
# --
# TODO add column constraints
# ++
ActiveRecord::Schema.define do
  create_table :schema_versions, :force => true do |t|
    t.column :version, :integer
  end
end

SchemaVersion.set_version 1
