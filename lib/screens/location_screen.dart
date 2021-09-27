import 'package:clima/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';

WeatherModel weatherModel = WeatherModel();

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherdata});
  final weatherdata;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String name;
  int id;
  String desc;
  int temp;
  var temperature;
  String weathericon;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uiUpdate(widget.weatherdata);
  }

  void uiUpdate(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        name = '';
        temp = 0;
        weathericon = 'Error';
        desc = 'try again';
        return;
      }
      name = weatherdata['name'];
      id = weatherdata['weather'][0]['id'];
      desc = weatherdata['weather'][0]['description'];
      temperature = weatherdata['main']['temp'];
      temp = temperature.toInt();
      weathericon = weatherModel.getWeatherIcon(id);

      print(temp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherdata = await weatherModel.getLocationWeather();
                      uiUpdate(weatherdata);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CityScreen();
                      }));
                      if (typedName != null) {
                        dynamic weatherData =
                            await weatherModel.getCityWeather(typedName);
                        uiUpdate(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weathericon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "${weatherModel.getMessage(temp)} in $name",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//
