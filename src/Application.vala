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

public class URMSimulator.Application : Granite.Application {

    private URMSourceView source_view;
    private SourceView output_view;
    private Processor processor;
    
    public Application () {
        Object (application_id: "com.github.aleksandar-stefanovic.urmsimulator",
        flags: ApplicationFlags.FLAGS_NONE);
    }
    
    protected override void activate () {
        var app_window = new ApplicationWindow (this);
        app_window.set_default_size (800, 600);
        var header_bar = new HeaderBar ();
        header_bar.show_close_button = true;
        header_bar.title = _("URM Simulator");
        app_window.set_titlebar (header_bar);
        
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
        text_fields.add (source_view);
        
        output_view = new SourceView ();
        output_view.editable = false;
        text_fields.add (output_view);
        
        var controls = new Grid ();
        controls.orientation = Orientation.VERTICAL;
        //controls.homogeneous = false;
        root.add (controls);
        
        var debug_switch = new LabeledSwitchBox (_("Debug mode"));
        controls.add (debug_switch);
        
        //end of creating layout, start of actual logic
        
        processor = new Processor (output_view.buffer);
        
        run_button.clicked.connect (() => {
            output_view.buffer.text = "";
            processor.reset ();
            var instructions = Parser.parse (source_view.buffer.text);
            processor.run (instructions, debug_switch.is_active ());
        });
        
        app_window.show_all ();
    }    
}

int main (string[] args) {    
    var app = new URMSimulator.Application ();
    return app.run (args);
}
