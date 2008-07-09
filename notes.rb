require 'setup'
require 'database'

class Notes < Shoes
  WIDTH = 400
  HEIGHT = 300

  url '/', :index
  url '/note/(\d+)', :note
  url '/update/(\d+)', :update

  def index
    @id = Note.find( :first ).id

    # setup the interface
    @text_stack = flow :width => 1.0, :height => 150 do
      para "testing"
    end
    @rest_stack = stack :width => 1.0 do
      @edit_box = edit_box :width => 400, :height => 110, :text => "blah"
      button( "save" ) {update @id }
    end

    note @id
  end

  def note( id )
    note = Note.find id
    @id = id

    @text_stack.clear do
      para note.body
    end
    @rest_stack.clear do
      @edit_box = edit_box :width => 400, :height => 110, :text => note.body
      button( "save" ) {update id }
    end

    # key handling
    keypress do |k|
      case k
      when :alt_s
        update id
      end
    end
  end

  def update( id )
    note = Note.find id
    note.body = @edit_box.text
    note.save!

    @text_stack.clear do
      para @edit_box.text
    end
  end
end

Shoes.app :width => 400, :height => 300
