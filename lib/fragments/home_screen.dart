import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Data {
  const Data({this.min = 0, this.max = 0, this.current = 0});
  final double min;
  final double max;
  final double current;
}

class Home extends StatefulWidget {
  const Home(
      {required this.waterTemp,
      required this.ph,
      required this.nh3,
      required this.nh4,
      required this.o2,
      required this.light,
      required this.outsideTemp,
      required this.humidity,
      required this.wind,
      required this.airPressure,
      required this.refreshData,
      Key? key})
      : super(key: key);
  final Data waterTemp;
  final Data ph;
  final Data nh3;
  final Data nh4;
  final Data o2;
  final double light;
  final double outsideTemp;
  final double humidity;
  final double wind;
  final double airPressure;
  final Future<void> Function() refreshData;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: widget.refreshData,
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: DataWidget(
                  label: "pH",
                  suffix: "",
                  data: widget.ph.current,
                  min: widget.ph.min,
                  max: widget.ph.max,
                  cornerIcon: Icons.water,
                  decimalPlaces: false,
                ),
              ),
              Expanded(
                child: DataWidget(
                  label: "Water",
                  suffix: "°C",
                  data: widget.waterTemp.current,
                  min: widget.waterTemp.min,
                  max: widget.waterTemp.max,
                  cornerIcon: Icons.thermostat,
                  decimalPlaces: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DataWidget(
                  label: "Ammonia",
                  suffix: "ppm",
                  data: widget.nh3.current,
                  min: widget.nh3.min,
                  max: widget.nh3.max,
                  cornerIcon: Icons.trending_up,
                  decimalPlaces: false,
                ),
              ),
              Expanded(
                child: DataWidget(
                  label: "Ammonium",
                  suffix: "ppm",
                  data: widget.nh4.current,
                  min: widget.nh4.min,
                  max: widget.nh4.max,
                  cornerIcon: Icons.science,
                  decimalPlaces: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DataWidget(
                  label: "Oxygen",
                  suffix: "",
                  data: widget.o2.current,
                  min: widget.o2.min,
                  max: widget.o2.max,
                  cornerIcon: Icons.bubble_chart,
                  decimalPlaces: false,
                ),
              ),
              Expanded(
                child: DataWidget(
                  label: "Light",
                  suffix: "",
                  data: widget.light,
                  min: -100,
                  max: 200,
                  cornerIcon: Icons.lightbulb,
                  decimalPlaces: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DataWidget(
                  label: "Outside",
                  suffix: "°C",
                  data: widget.outsideTemp,
                  min: 0,
                  max: 40,
                  cornerIcon: Icons.thermostat,
                  decimalPlaces: true,
                ),
              ),
              Expanded(
                child: DataWidget(
                  label: "Humidity",
                  suffix: "%",
                  data: widget.humidity,
                  min: 0,
                  max: 100,
                  cornerIcon: Icons.opacity,
                  decimalPlaces: true,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: DataWidget(
                  label: "Wind",
                  suffix: "km/h",
                  data: widget.wind,
                  min: -10,
                  max: 80,
                  cornerIcon: Icons.air,
                  decimalPlaces: true,
                ),
              ),
              Expanded(
                child: DataWidget(
                  label: "Air",
                  suffix: "hPa",
                  data: widget.airPressure,
                  min: -100,
                  max: 3000,
                  cornerIcon: Icons.speed,
                  decimalPlaces: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataWidget extends StatelessWidget {
  DataWidget(
      {Key? key,
      required this.label,
      required this.suffix,
      required this.data,
      required this.cornerIcon,
      required this.min,
      required this.max,
      required this.decimalPlaces})
      : super(key: key);
  final String label;
  final String suffix;
  final IconData cornerIcon;
  final double min;
  final double max;
  double data;
  final bool decimalPlaces;

  @override
  Widget build(BuildContext context) {
    var newData;
    if (decimalPlaces) {
      newData = data.round();
    } else {
      newData = data;
    }

    double width = (MediaQuery.of(context).size.width / 2);
    return Container(
        width: width,
        height: 150,
        color: Colors.black,
        child: Stack(alignment: AlignmentDirectional.center, children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: width - 50,
                height: 25,
                padding: const EdgeInsets.only(left: 25),
                decoration: BoxDecoration(
                    color: Colors.blueGrey[800],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Text(
                  label,
                  style: GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                  width: width - 50,
                  height: 75,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        "$newData$suffix",
                        style: GoogleFonts.nunito(
                            fontSize: 32, color: Colors.white),
                      ),
                    ),
                  ))
            ],
          ),
          Positioned(
            right: width - 45,
            bottom: 105,
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blueGrey[700],
                ),
                child: Icon(
                  cornerIcon,
                  size: 28,
                  color: pickColor(min, max, data),
                )),
          )
        ]));
  }
}

Color pickColor(double min, double max, double current) {
  if (current > max || current < min) {
    return (Colors.red);
  } else if (current > max - (max * 0.1) || current < min + (min * 0.1)) {
    return (Colors.amber);
  } else {
    return (Colors.green);
  }
}

// Container(
              // height: 100,
              // width: (MediaQuery.of(context).size.width / 2) - 30,
              // padding: const EdgeInsets.only(left: 25),
              // color: Colors.amber,
              // child: Text(
                // label,
                // style: GoogleFonts.nunito(fontSize: 18, color: Colors.white),
              // ),
            // ),
