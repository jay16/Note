#encoding: utf-8
require 'yaml/store'
require 'yaml'
require 'gtk2'

note_load = YAML.load_file('note.yml')
note_save = YAML::Store.new('note.yml')
note_init = YAML.load_file('record.yml')
note_record = YAML::Store.new('record.yml')

def add_theme(treeview,note_save)
  # Create a dialog that will be used to create a new product.

  dialog = Gtk::Dialog.new(
      "Add a Theme",
      nil,
      Gtk::Dialog::MODAL,
      [ Gtk::Stock::ADD,    Gtk::Dialog::RESPONSE_OK ],
      [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
  )
  entry = Gtk::Entry.new

  spin  = Gtk::SpinButton.new(0, 100, 1)
  # Set the precision to be displayed by spin button.
  spin.digits = 0

  table = Gtk::Table.new(4, 2, false)
  table.row_spacings = 5
  table.column_spacings = 5
  table.border_width = 5

  # Pack the table that will hold the dialog widgets.
  fll_shr = Gtk::SHRINK | Gtk::FILL
  fll_exp = Gtk::EXPAND | Gtk::FILL


  table.attach(Gtk::Label.new("Theme:"),  0, 1, 1, 2, fll_shr, fll_shr,  0, 0)
  table.attach(entry,                       1, 2, 1, 2, fll_exp, fll_shr,  0, 0)

  dialog.vbox.pack_start_defaults(table)
  dialog.show_all

  dialog.run do |response|
    if response == Gtk::Dialog::RESPONSE_OK
      theme = entry.text

      if theme == ""
        puts "All of the fields were not correctly filled out!"
        puts "DEBUG:  prod=(#{theme})"
        dialog.destroy
        return
      end

      model = treeview.model

      parent = model.append(nil)
      parent[0]  = theme
      note_save.transaction do 
        note_save[theme] = nil
      end
    end
    dialog.destroy
  end
end

def add_segment(treeview,treestore,note_save)
  # Create a dialog that will be used to create a new product.

  dialog = Gtk::Dialog.new(
      "Add a Segment",
      nil,
      Gtk::Dialog::MODAL,
      [ Gtk::Stock::ADD,    Gtk::Dialog::RESPONSE_OK ],
      [ Gtk::Stock::CANCEL, Gtk::Dialog::RESPONSE_CANCEL ]
  )
  # Create widgets that will be packed into the dialog.

  entry = Gtk::Entry.new

  table = Gtk::Table.new(4, 2, false)
  table.row_spacings = 5
  table.column_spacings = 5
  table.border_width = 5

    model = treeview.model
    selection = treeview.selection.selected
    parent = selection.parent 
    parent = selection unless parent
    
    row_ref = Gtk::TreeRowReference.new(treestore, Gtk::TreePath.new(parent.to_s)) if parent
    row_ref = Gtk::TreeRowReference.new(treestore, Gtk::TreePath.new(selection.to_s)) unless parent
    theme = row_ref.model.get_iter(row_ref.path)[0]
    
  # Pack the table that will hold the dialog widgets.
  fll_shr = Gtk::SHRINK | Gtk::FILL
  fll_exp = Gtk::EXPAND | Gtk::FILL
  table.attach(Gtk::Label.new("Root:#{theme}"), 0, 1, 0, 1, fll_shr, fll_shr,  0, 0)
  table.attach(Gtk::Label.new("Segment:"),  0, 1, 1, 2, fll_shr, fll_shr,  0, 0)
  table.attach(entry,                       1, 2, 1, 2, fll_exp, fll_shr,  0, 0)


    
  dialog.vbox.pack_start_defaults(table)
  #dialog.set_title(theme)
  dialog.show_all

  dialog.run do |response|
    # If the user presses OK, verify the entries and add the product.
    if response == Gtk::Dialog::RESPONSE_OK
      segment = entry.text
      if segment == ""
        puts "DEBUG:  segment = nil"
        dialog.destroy
        return
      end

   
      iter = model.get_iter(parent.to_s)

      child = model.append(iter)
      child[0]   = segment
      note_save.transaction do 
        puts theme
        puts segment
        note_save[theme] = { segment => "no data"}
      end
    end
    dialog.destroy
  end
end

def row_activated(treeview,treestore,textview,window)
 note_load = YAML.load_file('note.yml')
 selection = treeview.selection
 if iter = selection.selected        
   segment = iter[0]
   #记录当前被选择行的路径
   selection.selected_each do |model, path, iter|
     puts path
   end
   if iter.parent
    row_ref = Gtk::TreeRowReference.new(treestore, Gtk::TreePath.new(iter.parent.to_s))
    parent = row_ref.model.get_iter(row_ref.path)
    theme = parent[0]
    puts "#{theme}##{segment}"
    textview.buffer.text = note_load[theme][segment] if note_load[theme][segment]
    textview.buffer.text = "no data" unless note_load[theme][segment]
    window.set_title("SoLife #{theme}/#{segment} [open]")
    window.show_all
   else
    textview.buffer.text = note_load[segment].to_s if note_load[segment]
    textview.buffer.text = "no children!" unless note_load[segment]
   end
 else
   puts "no row selected"
 end
end

def save_file(treeview,treestore,textview,note_save,window) 
 selection = treeview.selection
 if iter = selection.selected        
   segment = iter[0]
   if iter.parent
    row_ref = Gtk::TreeRowReference.new(treestore, Gtk::TreePath.new(iter.parent.to_s))
    parent = row_ref.model.get_iter(row_ref.path)
    theme = parent[0]
    puts "#{theme}##{segment}"
    note_save.transaction do
    note_save[theme][segment] = textview.buffer.text
    end
    window.set_title("SoLife #{theme}/#{segment} [saved]")
    window.show_all
   end
 else
   puts "no row selected"
 end
end

def write_statu(treeview,treestore,textview,window) 
 selection = treeview.selection
 if iter = selection.selected        
   segment = iter[0]
   if iter.parent
    row_ref = Gtk::TreeRowReference.new(treestore, Gtk::TreePath.new(iter.parent.to_s))
    parent = row_ref.model.get_iter(row_ref.path)
    theme = parent[0]
    window.set_title("SoLife #{theme}/#{segment} [writing]")
    window.show_all
   end
 else
   puts "no row selected"
 end
end

def window_exit(treeview,treestore,note_record)
 selection = treeview.selection
 if iter = selection.selected        
   segment = iter[0]
   #记录当前被选择行的路径
   selection.selected_each do |model, path, iter|
     note_record.transaction do
       note_record["row"]["selected"]["path"] = path.to_str
     end
   end
   if iter.parent
    row_ref = Gtk::TreeRowReference.new(treestore, Gtk::TreePath.new(iter.parent.to_s))
    parent = row_ref.model.get_iter(row_ref.path)
    theme = parent[0]
    note_record.transaction do
     note_record["row"]["selected"]["yaml"] = "#{theme}:#{segment}"
    end
   end
 end
 Gtk.main_quit
end

treestore = Gtk::TreeStore.new(String, String, Integer)

note_load.each do |theme|
  # Append a second toplevel row and fill in some data
  parent = treestore.append(nil)
  parent[0] = theme[0]
    next unless note_load[theme[0]]
    note_load[theme[0]].each_with_index do |segment,index|
      child = treestore.append(parent)
      child[0]  = segment[0]
    end
end

view = Gtk::TreeView.new(treestore)
view.selection.mode = Gtk::SELECTION_SINGLE
view.expand_all
#SELECTION_NONE
#SELECTION_BROWSE


# Create a renderer
renderer = Gtk::CellRendererText.new
# Add column using our renderer
col = Gtk::TreeViewColumn.new("Theme", renderer, :text => 0)
view.append_column(col)


# Create a cell data function to calculate age

vbox = Gtk::VBox.new(homogeneous=false, spacing=nil) 
btn_save = Gtk::Button.new("save")
add_theme = Gtk::Button.new("add_theme")
add_segment = Gtk::Button.new("add_segment")


vbox.pack_start(view,true,true,0)
vbox.pack_start(btn_save,false,false,0)
vbox.pack_start(add_theme,false,false,0)
vbox.pack_start(add_segment,false,false,0)

textview = Gtk::TextView.new
textview.buffer.text = "Your 1st Gtk::TextView widget!"

scrolled_win = Gtk::ScrolledWindow.new
scrolled_win.border_width = 5
scrolled_win.add(textview)
scrolled_win.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_ALWAYS)

hbox = Gtk::HBox.new(homogeneous=false, spacing=nil) 
hbox.pack_start(vbox,false,false,0)
hbox.pack_start(scrolled_win,true,true,0)

window = Gtk::Window.new("")
window.set_title("SoLife")
window.border_width = 10
window.set_size_request(500, 500)
window.signal_connect("destroy") { window_exit(view,treestore,note_record) }
view.signal_connect("row-activated") { row_activated(view,treestore,textview,window)}
textview.buffer.signal_connect("changed"){ write_statu(view,treestore,textview,window) }
btn_save.signal_connect("clicked") { save_file(view,treestore,textview,note_save,window) }
add_theme.signal_connect("clicked") { add_theme(view,note_save) }
add_segment.signal_connect("clicked") { add_segment(view,treestore,note_save) }
view.selection.select_path(Gtk::TreePath.new(note_init["row"]["selected"]["path"]))
yaml_path = note_init["row"]["selected"]["yaml"].split(":")
textview.buffer.text = note_load[yaml_path[0]][yaml_path[1]]

ag = Gtk::AccelGroup.new
#ctrl+s save
ag.connect(Gdk::Keyval::GDK_S, Gdk::Window::CONTROL_MASK, Gtk::ACCEL_VISIBLE) {
  save_file(view,treestore,textview,note_save,window)
}
window.add_accel_group(ag)


window.add(hbox)
window.show_all
Gtk.main
