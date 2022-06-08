namespace Equinox.Utils {
    struct Location {
        double lat;
        double lon;
        string country;
        string city;
        string region;
    }

    public void locate () {
        var setting = new Settings ("com.github.matthewmong.equinox");
        //  var uri1 = Constants.OWM_API_ADDR + "weather?lat=";
        //  var uri2 = "&APPID=" + setting.get_string ("apiid");

        Location current_coords = get_location ();
        //  string uri = uri1 + mycoords.lat.to_string () + "&lon=" + mycoords.lon.to_string () + uri2;
        //  setting.set_string ("idplace", update_id (uri).to_string());
        setting.set_string ("location", current_coords.city);
        setting.set_string ("region", current_coords.region);
        setting.set_string ("country", current_coords.country);
        setting.set_double ("latitude", current_coords.lat);
        setting.set_double ("longitude", current_coords.lon);
    }

    private static Location get_location () {
        var location = Location();
        var session = new Soup.Session ();
        var message = new Soup.Message ("GET", Constants.IP_URL);
        session.send_message (message);
        try {
            var parser = new Json.Parser ();
            parser.load_from_data ((string) message.response_body.flatten ().data, -1);
            var root_object = parser.get_root ().get_object ();
            location.lat = root_object.get_double_member ("latitude");
            location.lon = root_object.get_double_member ("longitude");
            location.country = root_object.get_string_member ("country");
            location.city = root_object.get_string_member ("city");
            location.region = root_object.get_string_member ("region");
        } catch (Error e) {
            debug(e.message);
        }
        return location;
    }
}