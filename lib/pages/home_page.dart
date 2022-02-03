// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:aquaponics_monitor/fragments/home_screen.dart';
import 'package:aquaponics_monitor/fragments/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Map settings = {
  'ph': {'max': 0.0, 'min': 0.0},
  'waterTemp': {'max': 0.0, 'min': 0.0},
  'nh3': {'max': 0.0, 'min': 0.0},
  'o2': {'max': 0.0, 'min': 0.0},
  'nh4': {'max': 0.0, 'min': 0.0},
  'seneye': {'username': "default", 'password': 'default'},
  'openWeather': {'id': "default", 'location': 'default'}
};

Map data = {
  'ph': 0.0,
  'waterTemp': 0.0,
  'nh3': 0.0,
  'o2': 0.0,
  'nh4': 0.0,
  'light': 0.0,
  'outsideTemp': 0.0,
  'humidity': 0.0,
  'wind': 0.0,
  'airPressure': 0.0
};


class SettingsStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/settings.json');
  }

  void readSettings() async {
    final file = await _localFile;

    // Read the file
    final contents = await file.readAsString();
    settings = jsonDecode(contents);
  }

  Future<File> writeSettings(Map setting) async {
    final file = await _localFile;

    // Write the file
    var newSetting = jsonEncode(setting);
    return file.writeAsString(newSetting);
  }
}

double kelvinToCelcius(double kelvin) {
  return (kelvin - 273.15);
}

class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}

class HomePage extends StatefulWidget {
  final drawerItems = [
    DrawerItem("Home", Icons.home),
    DrawerItem("Settings", Icons.settings)
  ];

  HomePage({Key? key, required this.a}) : super(key: key);

  SettingsStorage a;
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    refresh();
    super.initState();
  }

  Future<void> refresh() async {
    String seneyeUsername, seneyePassword, openWeatherLocation, openWeatherID;
    seneyeUsername = settings['seneye']['username'];
    seneyePassword = settings['seneye']['password'];
    openWeatherID = settings['openWeather']['id'];
    openWeatherLocation = settings['openWeather']['location'];
    var seneyeResp = await http.get(Uri.parse(
        "https://api.seneye.com/v1/devices/53614/exps?user=$seneyeUsername&pwd=$seneyePassword"));
    var weatherResp = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$openWeatherLocation&appid=$openWeatherID"));

    Map aquaponicsData = jsonDecode(seneyeResp.body);
    Map weatherData = jsonDecode(weatherResp.body);
    print(seneyeUsername +
          " " +
          seneyePassword +
          "\n" +
          openWeatherID +
          " " +
          openWeatherLocation);
      print(aquaponicsData);
      print(weatherData);
    if (!(aquaponicsData.containsKey("message") || weatherData["cod"] != 200)) {
      setState(() {
        data['ph'] = double.parse(aquaponicsData['ph']['curr']);
        data['waterTemp'] = double.parse(aquaponicsData['temperature']['curr']);
        data['nh3'] = double.parse(aquaponicsData['nh3']['curr']);
        data['nh4'] = double.parse(aquaponicsData['nh4']['curr']);
        data['o2'] = double.parse(aquaponicsData['o2']['curr']);
        data['light'] = double.parse(aquaponicsData['lux']['curr']);
        data['outsideTemp'] = kelvinToCelcius(weatherData['main']['temp']);
        data['humidity'] = weatherData['main']['humidity'].toDouble();
        data['wind'] = weatherData['wind']['speed'];
        data['airPressure'] = weatherData['main']['pressure'].toDouble();
      });
    }
  }

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        widget.a.readSettings();
        return Home(
          refreshData: refresh,
          waterTemp: Data(
              current: data['waterTemp']!,
              min: settings['waterTemp']['min'],
              max: settings['waterTemp']['max']),
          ph: Data(
              current: data['ph']!,
              min: settings['ph']['min'],
              max: settings['ph']['max']),
          nh3: Data(
              current: data['nh3']!,
              min: settings['nh3']['min'],
              max: settings['nh3']['max']),
          nh4: Data(
              current: data['nh4']!,
              min: settings['nh4']['min'],
              max: settings['nh4']['max']),
          o2: Data(
              current: data['o2']!,
              min: settings['o2']['min'],
              max: settings['o2']['max']),
          light: data['light'],
          outsideTemp: data['outsideTemp'],
          humidity: data['humidity'],
          airPressure: data['airPressure'],
          wind: data['wind'],
        );
      case 1:
        return Settings(
          waterTemp: Setting(
              max: settings['waterTemp']['max'],
              min: settings['waterTemp']['min'],
              onMaxChanged: (value) => setState(() {
                    settings['waterTemp']['max'] = value;
                    widget.a.writeSettings(settings);
                  }),
              onMinChanged: (value) => setState(() {
                    settings['waterTemp']['min'] = value;
                    widget.a.writeSettings(settings);
                  })),
          ph: Setting(
              max: settings['ph']['max'],
              min: settings['ph']['min'],
              onMaxChanged: (value) => setState(() {
                    settings['ph']['max'] = value;
                    widget.a.writeSettings(settings);
                  }),
              onMinChanged: (value) => setState(() {
                    settings['ph']['min'] = value;
                    widget.a.writeSettings(settings);
                  })),
          nh3: Setting(
              max: settings['nh3']['max'],
              min: settings['nh3']['min'],
              onMaxChanged: (value) => setState(() {
                    settings['nh3']['max'] = value;
                    widget.a.writeSettings(settings);
                  }),
              onMinChanged: (value) => setState(() {
                    settings['nh3']['min'] = value;
                    widget.a.writeSettings(settings);
                  })),
          nh4: Setting(
              max: settings['nh4']['max'],
              min: settings['nh4']['min'],
              onMaxChanged: (value) => setState(() {
                    settings['nh4']['max'] = value;
                    widget.a.writeSettings(settings);
                  }),
              onMinChanged: (value) => setState(() {
                    settings['nh4']['min'] = value;
                    widget.a.writeSettings(settings);
                  })),
          o2: Setting(
              max: settings['o2']['max'],
              min: settings['o2']['min'],
              onMaxChanged: (value) => setState(() {
                    settings['o2']['max'] = value;
                    widget.a.writeSettings(settings);
                  }),
              onMinChanged: (value) => setState(() {
                    settings['o2']['min'] = value;
                    widget.a.writeSettings(settings);
                  })),
          seneyeInfo: Login(
            username: settings['seneye']['username'],
            password: settings['seneye']['password'],
            onPassChanged: (value) => setState(() {
              settings['seneye']['password'] = value;
              widget.a.writeSettings(settings);
            }),
            onUserChanged: (value) => setState(() {
              settings['seneye']['username'] = value;
              widget.a.writeSettings(settings);
            }),
          ),
          openweatherInfo: Login(
            username: settings['openWeather']['location'],
            password: settings['openWeather']['id'],
            onPassChanged: (value) => setState(() {
              settings['openWeather']['id'] = value;
              widget.a.writeSettings(settings);
            }),
            onUserChanged: (value) => setState(() {
              settings['openWeather']['location'] = value;
              widget.a.writeSettings(settings);
            }),
          ),
        );

      default:
        return const Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(ListTile(
        iconColor: Colors.white,
        textColor: Colors.white,
        leading: Icon(d.icon),
        title: Text(d.title),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // here we display the title corresponding to the fragment
        // you can instead choose to have a static title
        title: Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  "Aquaponics Monitor",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.nunito(fontSize: 28),
                )),
            Column(children: drawerOptions),
          ],
        ),
      ),
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
