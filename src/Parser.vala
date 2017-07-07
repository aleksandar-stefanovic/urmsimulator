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

public class Parser {
    
    public static Instruction[] parse (string input) {
        Instruction[] instructions = {};
        
        var strings = input.split ("\n");
        
        foreach (string entry in strings) {
            if (entry.replace (" ", "").size() == 0) {
                continue;
            }
            
            var instruction = new Instruction ();
            
            entry.up ();
            
            if (entry.contains ("Z")) {
                instruction.type = Type.Z;
                var arg0 = 0;
                //this pattern is used to ignore everything until the integer is found
                entry.scanf("%*[^0123456789]%i", out arg0);
                instruction.add_value (arg0);
            } else if (entry.contains ("S")) {
                instruction.type = Type.S;
                var arg0 = 0;
                entry.scanf("%*[^0123456789]%i", out arg0);
                instruction.add_value (arg0);
            } else if (entry.contains ("T")) {
                instruction.type = Type.T;
                var arg0 = 0, arg1 = 0;
                entry.scanf("%*[^0123456789]%i%*[^0123456789]%i", out arg0, out arg1);
                instruction.add_value (arg0);
                instruction.add_value (arg1);
            } else if (entry.contains ("J")) {
                instruction.type = Type.J;
                int arg0, arg1, arg2;
                entry.scanf("%*[^0123456789]%i%*[^0123456789]%i%*[^0123456789]%i", out arg0, out arg1, out arg2);
                instruction.add_value (arg0);
                instruction.add_value (arg1);
                instruction.add_value (arg2);
            } else continue;
            
            instructions += instruction;
            
        }
        
        return instructions;
    }
    
}
