namespace Equinox.Utils {
    public struct CurrentWeather {
        double temp;
        string main;
        string icon;
    }

    //  public void getWeather () {
    //      var setting = new Settings ("com.github.matthewmong.equinox");
    //      CurrentWeather current_weather = get_OWAPI ();
    //      setting.set_string ("weather-main", current_weather.main);
    //      setting.set_double ("weather-temp", current_weather.temp);
    //  }

    private int round_double_to_int(double dbl) {
        (dbl > 0) ? (dbl += 0.5) : (dbl += (-0.5));
        return (int)dbl;
    }

    public string toCelcius (double num) {
        double celcius = round_double_to_int(num - 273.15);
        return(celcius.to_string()+"C");
    }

    public static CurrentWeather get_OWAPI () {
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
            string icon = root_object.get_array_member("weather").get_object_element (0).get_string_member("icon");
            string main = root_object.get_array_member("weather").get_object_element (0).get_string_member("main");
            currWeather.temp = temperature;
            currWeather.main = main;
            currWeather.icon = icon;
        } catch (Error e) {
            debug(e.message);
        }
        return currWeather;
    }
}