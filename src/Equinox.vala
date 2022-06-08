namespace Equinox {

    public class EquinoxApp : Gtk.Application {

        public MainWindow window;


        public EquinoxApp () {
            Object (
                application_id: "com.github.matthewmong.equinox",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        protected override void activate () {
            var granite_settings = Granite.Settings.get_default ();
            var gtk_settings = Gtk.Settings.get_default ();
            gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
            granite_settings.notify["prefers-color-scheme"].connect (() => {
                gtk_settings.gtk_application_prefer_dark_theme = granite_settings.prefers_color_scheme == Granite.Settings.ColorScheme.DARK;
            });
            window = new MainWindow (this);
            window.set_title("Equinox");
            window.show_all ();
        }

        public static int main (string[] args) {
            return new Equinox.EquinoxApp ().run (args);
        }
    }
}