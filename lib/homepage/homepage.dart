import 'package:flutter/material.dart';
import 'package:making_flutter_more_reactive/homepage/page1.dart';
import 'package:making_flutter_more_reactive/homepage/page2.dart';
import 'package:making_flutter_more_reactive/keys.dart';
import 'package:making_flutter_more_reactive/managers/app_manager.dart';
import 'package:making_flutter_more_reactive/service_locator.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {

  HomePageState(){
    sl.get<AppManager>().switchToPage2.listen((data) { 
      setState(()=> pageIndex = 1);
    });
    sl.get<AppManager>().switchToPage1.listen((data) => setState(()=> pageIndex = 0));
  }

  int pageIndex = 0;
  List<Widget> pages = [Page1(), Page2()];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WeatherDemo")),
      //resizeToAvoidBottomPadding: false,
      body: pages[pageIndex]
    );
  }
}

/// As the normal switch does not even remember and display its current state
/// we us this one
class StateFullSwitch extends StatefulWidget {
  final bool state;
  final ValueChanged<bool> onChanged;

  StateFullSwitch({this.state, this.onChanged});

  @override
  StateFullSwitchState createState() {
    return StateFullSwitchState(state, onChanged);
  }
}

class StateFullSwitchState extends State<StateFullSwitch> {
  bool state;
  ValueChanged<bool> handler;

  StateFullSwitchState(this.state, this.handler);

  @override
  Widget build(BuildContext context) {
    return Switch(
      key: AppKeys.updateSwitch,
      value: state,
      onChanged: (b) {
        setState(() => state = b);
        handler(b);
      },
    );
  }
}
