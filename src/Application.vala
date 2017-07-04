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

    private SourceView source_view;
    private SourceView output_view;
    
    public Application () {
        Object (application_id: "com.github.aleksandar-stefanovic.urmsimulator",
        flags: ApplicationFlags.FLAGS_NONE);
    }
    
    protected override void activate () {
        var app_window = new ApplicationWindow (this);
        var header_bar = new HeaderBar ();
        header_bar.show_close_button = true;
        header_bar.title = _("URM Simulator");
        app_window.set_titlebar (header_bar);
        
        var run_button = new Button ();
        run_button.image = new Gtk.Image.from_icon_name ("media-playback-start", Gtk.IconSize.LARGE_TOOLBAR);
        run_button.tooltip_text = _("Run");
        run_button.clicked.connect (() => {
            var instructions = Parser.parse (source_view.buffer.text);
            //Placeholder
            output_view.buffer.text = instructions.length.to_string();
        });
        header_bar.add (run_button);
        
        var root = new HBox (true, 10);
        app_window.add (root);
        
        var v_box = new VBox(false, 10);
        root.add (v_box);
        
        source_view = new SourceView ();
        v_box.add (source_view);
        
        output_view = new SourceView ();
        output_view.editable = false;
        v_box.add (output_view);
        
        var controls = new VBox (false, 10);
        root.add (controls);
        
        var debug_checkbox = new CheckButton.with_label (_("Debug mode"));
        controls.add (debug_checkbox);
        
        app_window.show_all ();
    }    
}

int main (string[] args) {    
    var app = new URMSimulator.Application ();
    return app.run (args);
}
