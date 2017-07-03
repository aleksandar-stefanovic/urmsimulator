/*
* Copyright (c) 2011-2017 Aleksandar Stefanović (https://github.com/aleksandar-stefanovic)
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

public enum Type {
    NULL, Z, S, T, J
}

public class Instruction {

    public Type type;
    private int[] values;

    public Instruction (Type type = Type.NULL, int[] values = {}) {
        this.type = type;
        this.values = values;
    }
    
    public void add_value (int val) {
        values += val;
    }
    
    public int get_value (int index) {
        return values[int];
    }
    
}
