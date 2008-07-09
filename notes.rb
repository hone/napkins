require 'setup'
require 'database'

class Notes < Shoes
  WIDTH = 400
  HEIGHT = 300
  DISPLAY_WIDTH = 400
  DISPLAY_HEIGHT = 250
  BUTTON_HEIGHT = 30

  url '/', :index
  url '/show/(\d+)', :show
  url '/edit/(\d+)', :edit
  url '/update/(\d+)', :update

  def index
    id = Note.find( :first ).id

    # setup the interface
    @text_stack = stack :width => 1.0, :height => HEIGHT - BUTTON_HEIGHT do
    end
    @buttons_stack = stack :width => 1.0, :height => BUTTON_HEIGHT do
    end

    show id
  end

  def show( id )
    note = Note.find id
    @id = id

    @text_stack.clear do
      para note.body
    end
    @buttons_stack.clear do
      button( "edit" ) {edit id }
    end

    edit_key_event( id )
  end

  def edit( id )
    note = Note.find id
    @text_stack.clear do
      @edit_box = edit_box :width => 400, :height => HEIGHT - BUTTON_HEIGHT , :text => note.body
    end
    @buttons_stack.clear do
      button( "save" ) {update id }
    end

    save_key_event id
  end

  def update( id )
    note = Note.find id
    note.body = @edit_box.text
    note.save!

    show id
  end

  # key handling events
  def edit_key_event( id )
    keypress do |k|
      case k
      when :alt_e
        edit id
      end
    end
  end

  def save_key_event( id )
    keypress do |k|
      case k
      when :alt_s
        update id
      end
    end
  end
end

Shoes.app :width => Notes::WIDTH,
  :height => Notes::HEIGHT,
  :title => "Napkins"
