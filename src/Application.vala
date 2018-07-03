/*
* Copyright (c) 2017 Aleksandar Stefanović (https://github.com/aleksandar-stefanovic)
*
* This program is free software; you can redistribute it and/or
* modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation; either
* version 2 of the License, or (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
* General Public License for more details.
*
* You should have received a copy of the GNU General Public
* License along with this program; if not, write to the
* Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
* Boston, MA 02110-1301 USA
*
* Authored by: Aleksandar Stefanović <theonewithideas@gmail.com>
*/
using Gtk;

public class URMSimulator.Application : Gtk.Application {

    private URMSourceView source_view;
    private SourceView output_view;
    private Processor processor;
    
    public Application () {
        Object (application_id: "com.github.aleksandar_stefanovic.urmsimulator",
        flags: ApplicationFlags.FLAGS_NONE);
    }
    
    protected override void activate () {
        var app_window = new ApplicationWindow (this);
        app_window.set_default_size (800, 600);
        var header_bar = new HeaderBar ();
        header_bar.show_close_button = true;
        header_bar.title = _("URM Simulator");
        app_window.set_titlebar (header_bar);
        
        var open_button = new Button ();
        open_button.image = new Gtk.Image.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR);
        open_button.tooltip_text = _("Open");
        header_bar.add (open_button);
        
        var run_button = new Button ();
        run_button.image = new Gtk.Image.from_icon_name ("media-playback-start", Gtk.IconSize.LARGE_TOOLBAR);
        run_button.tooltip_text = _("Run");
        header_bar.add (run_button);
        
        var root = new Box (Orientation.HORIZONTAL, 10);
        root.margin = 10;
        root.homogeneous = true;
        app_window.add (root);
        
        var text_fields = new Box (Orientation.VERTICAL, 10);
        text_fields.homogeneous = true;
        root.add (text_fields);
        
        source_view = new URMSourceView ();
        var source_frame = new Frame (null);
        var source_scrolled = new ScrolledWindow (null, null);
        source_scrolled.add (source_view);
        source_frame.add (source_scrolled);
        text_fields.add (source_frame);
        
        output_view = new SourceView ();
        output_view.editable = false;
        var output_scrolled = new ScrolledWindow (null, null);
        output_scrolled.add (output_view);
        var output_frame = new Frame (null);
        output_frame.add (output_scrolled);
        text_fields.add (output_frame);
        
        var controls = new Box (Orientation.VERTICAL, 12);
        root.add (controls);
        
        var debug_switch = new LabeledSwitchBox (_("Debug mode"));
        controls.add (debug_switch);
        
        var help_icon = new Gtk.Image.from_icon_name ("help-info-symbolic", Gtk.IconSize.BUTTON);
        help_icon.tooltip_text = _("Values can by separated by anything.");
        
        var initial_values_text_box = new Box (Orientation.HORIZONTAL, 12);
        initial_values_text_box.hexpand = true;
        initial_values_text_box.add (new Label (_("Initial values")));
        initial_values_text_box.add (help_icon);
        controls.add (initial_values_text_box);
        
        var initial_values_entry = new Entry ();
        controls.add (initial_values_entry);
        
        var instruction_cap_text_box = new Box (Orientation.HORIZONTAL, 12);
        instruction_cap_text_box.hexpand = true;
        instruction_cap_text_box.add (new Label (_("Instruction execution limit:")));
        controls.add (instruction_cap_text_box);
        var instruction_cap_entry = new Entry ();
        instruction_cap_entry.text = "1024";
        controls.add (instruction_cap_entry);

        //end of creating layout, start of actual logic
        
        processor = new Processor (output_view.buffer);
        
        run_button.clicked.connect (() => {

            try {
                output_view.buffer.text = "";
                processor.reset ();
                var initial_values = Parser.parse_initial_values (initial_values_entry.text);
                var instructions = Parser.parse (source_view.buffer.text);
                int cap;
                var scan_matches = instruction_cap_entry.text.scanf("%i", out cap);
                if (scan_matches < 1) {
                    output_view.buffer.text += "Invalid instruction cap!\n";
                } else {
                    processor.run (instructions, debug_switch.is_active (), initial_values, cap);
                }
            } catch (InvalidInstructionException exception) {
                output_view.buffer.text = exception.message;
            }
        });
        
        open_button.clicked.connect (() => {
            var chooser = new FileChooserDialog (
                null, app_window, FileChooserAction.OPEN,
                _("Cancel"), ResponseType.CANCEL,
                _("Open"), ResponseType.ACCEPT);
                
            var filter = new FileFilter ();
		    chooser.set_filter (filter);
		    filter.add_mime_type ("text/plain");
            
            if (chooser.run () == ResponseType.ACCEPT) {
                var filename = chooser.get_filename ();
                try {
                    string text;
                    FileUtils.get_contents (filename, out text);
                    source_view.buffer.text = text;
                } catch (Error e) {
                    stderr.printf ("Error: %s\n", e.message);
                }
            }
            
            chooser.close ();
        });
        
        app_window.show_all ();
    }    
}

int main (string[] args) {    
    var app = new URMSimulator.Application ();
    return app.run (args);
}
