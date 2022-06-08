namespace Equinox.Utils {
    struct CurrentWeather {
        double temp;
        string main;
    }

    public void getWeather () {
        var setting = new Settings ("com.github.matthewmong.equinox");
        CurrentWeather current_weather = get_OWAPI ();
        setting.set_string ("weather-main", current_weather.main);
        setting.set_double ("weather-temp", current_weather.temp);
    }

    private static CurrentWeather get_OWAPI () {
        var setting = new Settings ("com.github.matthewmong.equinox");
        var latitude = setting.get_double ("latitude");
        var longitude = setting.get_double ("longitude");        
        var currWeather = CurrentWeather();
        var session = new Soup.Session ();
        string uri = Constants.OWM_URL + "weather?lat=" + latitude.to_string () + "&lon=" + longitude.to_string () + "&appid=" + Constants.OWM_API_ID;
        var message = new Soup.Message ("GET", uri);
        session.send_message (message);
        try {
            var parser = new Json.Parser ();
            parser.load_from_data ((string) message.response_body.flatten ().data, -1);
            var root_object = parser.get_root ().get_object ();
            double temperature = root_object.get_object_member ("main").get_double_member ("temp");
            string main = root_object.get_array_member("weather").get_object_element (0).get_string_member("main");
            currWeather.temp = temperature;
            currWeather.main = main;
        } catch (Error e) {
            debug(e.message);
        }
        return currWeather;
    }
}