require 'rubygems'
require 'activerecord'
require 'database'

ActiveRecord::Schema.define do
  create_table :notes, :force => true do |t|
    t.column :id, :integer
    t.column :body, :text
  end
end

Note.create do |note|
  note['body'] = "Testing"
end
