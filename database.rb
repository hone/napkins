require 'activerecord'

# connect to the database
ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :dbfile => 'database.sqlite'
})

# model
class Note < ActiveRecord::Base
end
