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

public class URMSourceView : Gtk.SourceView {
    
    public URMSourceView () {
        this.show_line_numbers = true;

        var manager = Gtk.SourceLanguageManager.get_default ();
        var tmp_paths = manager.search_path;
        tmp_paths +=  "/usr/share/com.github.aleksandar-stefanovic.urmsimulator";
        manager.search_path = tmp_paths;
  
        var buffer = new Gtk.SourceBuffer.with_language (manager.get_language ("urm"));
        buffer.highlight_syntax = true;
        
        var style = Gtk.SourceStyleSchemeManager.get_default ().get_scheme ("kate");
        
        buffer.style_scheme = style;
        this.buffer = buffer;
    }   
}
