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

public class LabeledSwitchBox: Box {

    private Switch switch_widget;

    public LabeledSwitchBox (string tooltip, bool active = false) {
        this.orientation = Orientation.HORIZONTAL;
        this.spacing = 10;
        this.hexpand = true;
        
        var label = new Label (tooltip);
        label.halign = Align.START;
        this.pack_start (label, true, true, 0);
        
        switch_widget = new Switch();
        switch_widget.active = active;
        this.pack_end (switch_widget, false, false, 0);
    }   
    
    public bool is_active () {
        return switch_widget.active;
    }
    
    
    
}
