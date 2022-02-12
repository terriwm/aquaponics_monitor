// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Setting {
  const Setting(
      {this.min = 0, this.max = 10, this.onMinChanged, this.onMaxChanged});
  final double min;
  final double max;
  final ValueChanged<double>? onMinChanged;
  final ValueChanged<double>? onMaxChanged;
}

class Login {
  const Login(
      {required this.username,
      required this.password,
      this.onUserChanged,
      this.onPassChanged});
  final String username;
  final String password;
  final ValueChanged<String>? onUserChanged;
  final ValueChanged<String>? onPassChanged;
}

class RefreshFeild {
  const RefreshFeild({required this.period, this.onPeriodChanged});
  final int period;
  final ValueChanged<String>? onPeriodChanged;
}

class Settings extends StatelessWidget {
  const Settings(
      {Key? key,
      required this.waterTemp,
      required this.ph,
      required this.nh3,
      required this.nh4,
      required this.o2,
      required this.seneyeInfo,
      required this.openweatherInfo,
      required this.refreshPeriod})
      : super(key: key);
  final Setting waterTemp;
  final Setting ph;
  final Setting nh3;
  final Setting nh4;
  final Setting o2;
  final Login seneyeInfo;
  final Login openweatherInfo;
  final RefreshFeild refreshPeriod;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        LimitModifer(
          label: "Water Temperature",
          min: waterTemp.min,
          max: waterTemp.max,
          onMinChanged: waterTemp.onMinChanged,
          onMaxChanged: waterTemp.onMaxChanged,
        ),
        const Divider(
          thickness: 3,
          height: 3,
          color: Colors.black38,
        ),
        LimitModifer(
          label: "pH",
          min: ph.min,
          max: ph.max,
          onMinChanged: ph.onMinChanged,
          onMaxChanged: ph.onMaxChanged,
        ),
        const Divider(
          thickness: 3,
          height: 3,
          color: Colors.black38,
        ),
        LimitModifer(
          label: "Ammonia",
          min: nh3.min,
          max: nh3.max,
          onMinChanged: nh3.onMinChanged,
          onMaxChanged: nh3.onMaxChanged,
        ),
        const Divider(
          thickness: 3,
          height: 3,
          color: Colors.black38,
        ),
        LimitModifer(
          label: "Ammonium",
          min: nh4.min,
          max: nh4.max,
          onMinChanged: nh4.onMinChanged,
          onMaxChanged: nh4.onMaxChanged,
        ),
        const Divider(
          thickness: 3,
          height: 3,
          color: Colors.black38,
        ),
        LimitModifer(
          label: "Oxygen",
          min: o2.min,
          max: o2.max,
          onMinChanged: o2.onMinChanged,
          onMaxChanged: o2.onMaxChanged,
        ),
        const Divider(
          thickness: 3,
          height: 3,
          color: Colors.black38,
        ),
        RefreshPeriod(
          label: "Refresh Period (sec)",
          value: refreshPeriod.period,
          onChanged: refreshPeriod.onPeriodChanged,
        ),
        const Divider(
          thickness: 3,
          height: 3,
          color: Colors.black38,
        ),
        ApiKeys(
          label: "Seneye Login",
          username: seneyeInfo.username,
          password: seneyeInfo.password,
          label1: "Username:",
          label2: "Password",
          passwordChanged: seneyeInfo.onPassChanged,
          usernameChanged: seneyeInfo.onUserChanged,
        ),
        const Divider(
          thickness: 3,
          height: 3,
          color: Colors.black38,
        ),
        ApiKeys(
          label: "OpenWeather Login",
          username: openweatherInfo.username,
          password: openweatherInfo.password,
          label1: "Location:",
          label2: "API ID:",
          passwordChanged: openweatherInfo.onPassChanged,
          usernameChanged: openweatherInfo.onUserChanged,
        ),
        
      ],
    );
  }
}

class LimitModifer extends StatelessWidget {
  const LimitModifer(
      {Key? key,
      this.label = "",
      this.min = 0,
      this.onMinChanged,
      this.max = 10,
      this.onMaxChanged})
      : super(key: key);

  final String label;
  final double min;
  final double max;
  final ValueChanged<double>? onMinChanged;
  final ValueChanged<double>? onMaxChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          color: Colors.black,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "$label:",
              style: GoogleFonts.nunito(fontSize: 22, color: Colors.white),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 40, right: 15),
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SpinBoxTheme(
                data: SpinBoxThemeData(
                    iconColor: MaterialStateProperty.all<Color>(Colors.white)),
                child: SpinBox(
                  value: min,
                  step: 0.05,
                  decimals: 2,
                  decoration: InputDecoration(
                    labelText: "Min",
                    border: InputBorder.none,
                    labelStyle:
                        GoogleFonts.nunito(fontSize: 20, color: Colors.white),
                  ),
                  onChanged: onMinChanged,
                  textStyle:
                      GoogleFonts.nunito(fontSize: 20, color: Colors.white),
                  showCursor: false,
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 40, right: 15),
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: SpinBoxTheme(
                data: SpinBoxThemeData(
                    iconColor: MaterialStateProperty.all<Color>(Colors.white)),
                child: SpinBox(
                  step: 0.05,
                  decimals: 2,
                  decoration: InputDecoration(
                    labelText: "Max",
                    border: InputBorder.none,
                    labelStyle:
                        GoogleFonts.nunito(fontSize: 20, color: Colors.white),
                  ),
                  onChanged: onMaxChanged,
                  textStyle:
                      GoogleFonts.nunito(fontSize: 20, color: Colors.white),
                  showCursor: false,
                  value: max,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ApiKeys extends StatelessWidget {
  const ApiKeys(
      {Key? key,
      required this.label,
      required this.username,
      required this.password,
      required this.label1,
      required this.label2,
      this.usernameChanged,
      this.passwordChanged})
      : super(key: key);
  final String label;
  final String username;
  final String password;
  final String label1;
  final String label2;
  final ValueChanged<String>? usernameChanged;
  final ValueChanged<String>? passwordChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          color: Colors.black,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "$label:",
              style: GoogleFonts.nunito(fontSize: 22, color: Colors.white),
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.only(left: 40, right: 15),
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            color: Colors.black,
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      label1,
                      style:
                          GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                    )),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 1000,
                                child: TextFormField(
                                  initialValue: username,
                                  textAlign: TextAlign.left,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  style: GoogleFonts.nunito(
                                      color: Colors.white, fontSize: 18),
                                  onChanged: usernameChanged,
                                ),
                              ),
                            ])),
                  ),
                )
              ],
            )),
        Container(
            padding: const EdgeInsets.only(left: 40, right: 15),
            width: MediaQuery.of(context).size.width,
            height: 50,
            alignment: Alignment.center,
            color: Colors.black,
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      label2,
                      style:
                          GoogleFonts.nunito(fontSize: 18, color: Colors.white),
                    )),
                Expanded(
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                height: 50,
                                width: 1000,
                                child: TextFormField(
                                  initialValue: password,
                                  obscureText: true,
                                  textAlign: TextAlign.left,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                  ),
                                  style: GoogleFonts.nunito(
                                      color: Colors.white, fontSize: 18),
                                  onChanged: passwordChanged,
                                ),
                              ),
                            ])),
                  ),
                )
              ],
            )),
      ],
    );
  }
}

class RefreshPeriod extends StatelessWidget {
  const RefreshPeriod(
      {Key? key, required this.label, required this.value, this.onChanged})
      : super(key: key);

  final String label;
  final int value;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 15),
          width: MediaQuery.of(context).size.width,
          height: 50,
          alignment: Alignment.center,
          color: Colors.black,
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "$label:",
              style: GoogleFonts.nunito(fontSize: 22, color: Colors.white),
            ),
          ),
        ),
        Container(
          height: 50,
          padding: const EdgeInsets.only(left: 40),
          child: Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextFormField(
                    initialValue: value.toString(),
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    style: GoogleFonts.nunito(
                        color: Colors.white, fontSize: 18),
                    onChanged: onChanged,
                  )),
            ),
          ),
        ),
      ],
    );
  }
}
