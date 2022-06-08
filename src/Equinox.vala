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
            window = new MainWindow (this);
            window.show_all ();
        }

        public static int main (string[] args) {
            return new Equinox.EquinoxApp ().run (args);
        }
    }
}