require 'activerecord'

# connect to the database
ActiveRecord::Base.establish_connection({
  :adapter => 'sqlite3',
  :dbfile => 'database.sqlite'
})

# models

# This model keeps track of the version the migrations are on.  There should 
# only be one record in the table for this model.
class SchemaVersion < ActiveRecord::Base
  # sets the version number of the schema.  It checks if there already exists 
  # a record in schema version and sets that one if it exists.  If it doesn't
  # exist then it creates a new one and sets the version number.
  # Inputs:
  # [number]  +Fixnum+ of the new version number
  def self.set_version( number )
    if self.count > 0
      schema_version = self.find( :first )
      schema_version[:version] = number
      schema_version.save!
    else
      schema_version = self.new
      schema_version[:version] = number
      schema_version.save!
    end
  end
end

# This model stores the information of each note.
class Note < ActiveRecord::Base
end
