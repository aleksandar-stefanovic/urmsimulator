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

public class Processor {
    
    private int[] registers = new int[256];
    private Gtk.TextBuffer output;
    public int instruction_counter = 0;
    
    public Processor (Gtk.TextBuffer output) {
        this.output = output;
    }
    
    public void run (Instruction[] instructions, bool debug = false, int from = 0) {
        var next_instruction = from;
        var highest_register = 0;
        
        while (next_instruction < instructions.length) {
            instruction_counter++;
            
            var instruction = instructions[next_instruction];
            
            next_instruction++;
            
            for (int i =  0; i < instruction.get_value_count (); i++) {
                if (instruction.get_value (i) > highest_register && i < 2) {
                    highest_register = instruction.get_value (i);
                }
            }
            
            
            switch (instruction.type) {
                case Type.Z: {
                    registers[instruction.get_value(0)] = 0;
                }
                break;
                
                case Type.S: {
                    registers[instruction.get_value(0)] += 1;
                }
                break;
                
                case Type.T: {
                    registers[instruction.get_value(1)] = registers[instruction.get_value(0)];
                }
                break;
                
                case Type.J: {
                    if (registers[instruction.get_value(0)] == registers[instruction.get_value(1)]) {
                            next_instruction = instruction.get_value (2);
                    }
                }
                break;
            }
            
            
            if (debug) {
                output.text += @"$next_instruction: ";
                print_registers (highest_register + 1);   
                
            }
            
            
        }
        output.text += _("End result:");
        output.text += "\n";
        print_registers (highest_register + 1);
    }
    
    public void reset () {
        registers = new int[256];
        instruction_counter = 0;
    }
    
    
    private void print_registers (int to, int from = 0) {
        
        for (int i = from; i < to; i++) {
            int val = registers[i];
            output.text += @"[$val]";
        }
        output.text += "\n";
    }
    
    
}
