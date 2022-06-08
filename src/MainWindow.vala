namespace Equinox {

    public class MainWindow : Gtk.Window {

        public EquinoxApp app;
        private Gtk.Grid view;

        public MainWindow (EquinoxApp app) {
            this.app = app;
            this.set_application (app);
            this.set_size_request (950, 650);
            var setting = new Settings ("com.github.matthewmong.equinox");
            window_position = Gtk.WindowPosition.CENTER;

            //create main view
            var overlay = new Gtk.Overlay ();
            view = new Gtk.Grid ();
            view.expand = true;
            view.halign = Gtk.Align.FILL;
            view.valign = Gtk.Align.FILL;
            //  view.attach (new Gtk.Label(("Loading") +  "..."), 0, 0, 1, 1);
            overlay.add_overlay (view);
            Equinox.Utils.locate();
            Equinox.Utils.getWeather();
            view.attach(new Gtk.Label(setting.get_string("location")), 1, 0, 1, 1);
            view.attach(new Gtk.Label(setting.get_string("weather-main")), 0, 1, 1, 1);
            view.attach(new Gtk.Label(setting.get_double("weather-temp").to_string()), 1, 1, 1, 1);

            add(overlay);
        }
    }
}
