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

public class URMSimulator.Application : Gtk.Application {
    private MainWindow app_window;

    public Application () {
        Object (application_id: "com.github.aleksandar-stefanovic.urmsimulator",
        flags: ApplicationFlags.HANDLES_OPEN);
    }

    protected override void open (File[] urm_files, string hint) {
        if (urm_files.length == 0) {
            return;
        }

        foreach (var urm_file in urm_files) {
            try {
                string text;
                FileUtils.get_contents (urm_file.get_path (), out text);

                app_window = new MainWindow (this);
                app_window.source_view.buffer.text = text;
                app_window.show_all ();
            } catch (Error e) {
                error (e.message);
            }
        }
    }

    protected override void activate () {
        if (app_window != null) {
            app_window.present ();
        }

        app_window = new MainWindow (this);
        app_window.show_all ();
    }    
}

int main (string[] args) {    
    var app = new URMSimulator.Application ();
    return app.run (args);
}
