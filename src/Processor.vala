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
    
    private Gee.ArrayList<int> registers = new Gee.ArrayList<int> ();
    private Gtk.TextBuffer output;
    public int instruction_counter = 0;
    
    public Processor (Gtk.TextBuffer output) {
        this.output = output;
    }
    
    public void run (Instruction[] instructions, bool debug = false, int[] initial_values = {}, int instruction_cap = 1024, int from = 0) {
        for (int i = 0; i < initial_values.length; i++) {
            registers[i] = initial_values[i];
        }
        
        var next_instruction = from;
        var highest_register = initial_values.length - 1;
        
        while (next_instruction < instructions.length) {
            instruction_counter++;
            
            if (instruction_counter >= instruction_cap) {
                output.text += @"Instruction limit ($instruction_cap) reached!\n";
                break;
            }

            var instruction = instructions[next_instruction];
            
            next_instruction++;
            
            for (int i =  0; i < instruction.get_value_count (); i++) {
                if (instruction.get_value (i) > highest_register && i < 2) {
                    highest_register = instruction.get_value (i);
                }
            }
            
            
            switch (instruction.type) {
                case Type.Z: {
                    var address = instruction.get_value (0);
                    ensure_list_capacity (address + 1);
                    registers[address] = 0;
                }
                break;
                
                case Type.S: {
                    var address = instruction.get_value (0);
                    ensure_list_capacity (address + 1);
                    // This has to be done without "+=" because accessing creates a copy
                    registers[address] = registers[address] + 1;
                }
                break;
                
                case Type.T: {
                    ensure_list_capacity (instruction.get_value (0) + 1);
                    ensure_list_capacity (instruction.get_value (1) + 1);
                    registers[instruction.get_value(1)] = registers[instruction.get_value(0)];
                }
                break;
                
                case Type.J: {
                    ensure_list_capacity (instruction.get_value (0) + 1);
                    ensure_list_capacity (instruction.get_value (1) + 1);
                    if (registers[instruction.get_value(0)] == registers[instruction.get_value(1)]) {
                            next_instruction = instruction.get_value (2) - 1;
                            if (next_instruction < 0) {
                                next_instruction = 0;
                            }
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

    // Stupid, but necessary in absence of a built-in method.
    private void ensure_list_capacity (int capacity) {
        while (registers.size < capacity) {
            registers.add(0);
        }
    }
    
    public void reset () {
        registers.clear ();
        instruction_counter = 0;
    }
    
    
    private void print_registers (int to, int from = 0) {
        
        foreach (int r in registers) {
            output.text += @"[$r]";
        }
        output.text += "\n";
    }
    
    
}
