namespace Equinox.Utils {
    struct Location {
        double lat;
        double lon;
    }

    public void locate () {
        get_location();
    }

    private static Location get_location () {
        var location = Location();
        var session = new Soup.Session ();
        var message = new Soup.Message ("GET", Constants.LOCATION_URL);
        session.send_message (message);
        try {
            var parser = new Json.Parser ();
            parser.load_from_data ((string) message.response_body.flatten ().data, -1);
            var root_object = parser.get_root ().get_object ();
            var response = root_object.get_object_member ("location");
            location.lat = response.get_double_member ("lat");
            location.lon = response.get_double_member ("lng");
        } catch (Error e) {
            debug(e.message);
        }
        return location;
    }
}