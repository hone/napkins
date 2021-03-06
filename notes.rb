require 'lib/setup'
require 'lib/database'
require 'lib/scanner'
require 'lib/parser'
require 'lib/walk_tree_shoes'

# the main note window
class Notes < Shoes
  WIDTH = 450
  HEIGHT = 600
  BUTTON_HEIGHT = 30

  url '/', :index
  url '/show/(\d+)', :show
  url '/edit/(\d+)', :edit
  url '/update/(\d+)', :update

  # first note to be displayed.  Setup interface then display the first note.
  def index
    self.clear
    background white

    id = Note.find( :first ).id

    # setup the interface
    @buttons_flow = flow :width => 1.0, :height => BUTTON_HEIGHT
    @text_stack = stack :width => 1.0
    show id
  end
  
  #--
  # TODO should change id to title since links will be handled by title not id
  #++

  # displays a new note
  # Inputs:
  # [id]  +Fixnum+ of the id of the note
  def show( id )
    note = Note.find id

    @text_stack.clear do
      tokens = Scanner.scan( note.body )
      root_node = Parser.parse( tokens )
      eval_string = WalkTreeShoes.walk_root( root_node )
      puts eval_string
      eval( eval_string )
    end
    @buttons_flow.clear do
      background gray
      button( "edit" ) {edit id }
    end

    edit_key_event( id )
  end

  # changes display window into an edit box for note editing
  # Inputs:
  # [id]  +Fixnum+ of the id of the note
  def edit( id )
    note = Note.find id
    @text_stack.clear do
      @edit_box = edit_box :width => 1.0, :height => HEIGHT - BUTTON_HEIGHT , :text => note.body
    end
    @buttons_flow.clear do
      background gray
      button( "save" ) {update id }
    end

    save_key_event id
  end

  # performs the save operation when updating a note
  # Inputs:
  # [id]  +Fixnum+ of the id of the note
  def update( id )
    note = Note.find id
    note.body = @edit_box.text
    note.save!

    show id
  end

  # key handling events
  # Inputs:
  # [id]  +Fixnum+ of the id of the note
  def edit_key_event( id )
    keypress do |k|
      case k
      when :alt_e
        edit id
      end
    end
  end

  # Inputs:
  # [id]  +Fixnum+ of the id of the note
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
