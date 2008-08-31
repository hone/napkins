require 'rubygems'
require 'activerecord'

require 'lib/database'

# migration file.  Creates the Note table, handling all the basic note data 
# storage.
# --
# TODO add column constraints
# ++
ActiveRecord::Schema.define do
  create_table :notes, :force => true do |t|
    t.column :id, :integer
    t.column :title, :string
    t.column :body, :text
  end
end

# creates the first note.
# --
# TODO need to  make a better first note with links and such
# ++
Note.create do |note|
  note[:title] = "Start Here!"
  note[:body] = "Testing"
end

SchemaVersion.set_version 2
