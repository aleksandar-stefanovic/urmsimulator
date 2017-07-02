int main (string[] args) {
    Gtk.init (ref args);
    var window = new Gtk.Window ();
    window.title = "Hello World!";
    window.set_border_width (12);
    window.set_position (Gtk.WindowPosition.CENTER);
    window.set_default_size (350, 70);
    window.destroy.connect (Gtk.main_quit);
    
    var button = new Gtk.Button.with_label ("Glupi početak");
    button.clicked.connect (() => {
        stdout.printf("Nešto se desilo");
    });
    
    window.add (button);
    window.show_all ();

    Gtk.main ();
    return 0;
}
