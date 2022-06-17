namespace Equinox {

    public class MainWindow : Gtk.Window {

        public EquinoxApp app;
        private Gtk.Box view;

        public MainWindow (EquinoxApp app) {
            this.app = app;
            this.set_application (app);
            this.set_size_request (950, 650);
            var setting = new Settings ("com.github.matthewmong.equinox");
            window_position = Gtk.WindowPosition.CENTER;

            //create main view
            var overlay = new Gtk.Overlay ();
            view = new Gtk.Box (Gtk.Orientation.VERTICAL, 0);
            view.expand = true;
            view.halign = Gtk.Align.FILL;
            view.valign = Gtk.Align.FILL;
            //  view.attach (new Gtk.Label(("Loading") +  "..."), 0, 0, 1, 1);
            overlay.add_overlay (view);
            Equinox.Utils.locate ();
            var currWeather = Equinox.Utils.get_OWAPI ();
            view.pack_start(new Gtk.Label(setting.get_string("location")), true, true, 2);
            view.pack_start(new Gtk.Label(currWeather.main), true, true, 2);
            var image = new Gtk.Image.from_file ("03d.png");
            view.pack_start(image, true, true, 2);
            view.pack_start(new Gtk.Label(Equinox.Utils.toCelcius(currWeather.temp)), true, true, 2);
            add(overlay);
        }
    }
}
