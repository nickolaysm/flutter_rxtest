import 'package:making_flutter_more_reactive/homepage/Data.dart';
import 'package:making_flutter_more_reactive/service_locator.dart';
import 'package:rxdart/src/subjects/behavior_subject.dart';
import 'package:rx_command/rx_command.dart';
import 'package:making_flutter_more_reactive/services/weather_service.dart';
import 'package:making_flutter_more_reactive/services/weather_entry.dart';
import 'package:rxdart/subjects.dart';

class AppManager {
  RxCommand<Data, void> sendDataToPage2; 
  RxCommand<void, void> switchToPage2;
  RxCommand<void, void> switchToPage1;
  RxCommand<Data, Data> dataForPage2;


  final collectDataForPage2 = new BehaviorSubject<Data>();

  RxCommand<String, List<WeatherEntry>> updateWeatherCommand;
  RxCommand<bool, bool> switchChangedCommand;
  RxCommand<String, String> textChangedCommand;

  AppManager() {

    sendDataToPage2 = RxCommand.createSync<Data, void>( (data) => collectDataForPage2.add(data) );

    dataForPage2 = RxCommand.createSync<Data, Data>((data)=>data);

    collectDataForPage2.listen((data) => dataForPage2(data));

    switchToPage2 = RxCommand.createSync<void, void>( 
      (res) { 
        return res ;
      } 
      );
    switchToPage1 = RxCommand.createSync<void, void>( (res) => res );

    // Command expects a bool value when executed and issues the value on it's
    // result Observable (stream)
    switchChangedCommand = RxCommand.createSync<bool, bool>((b) => b);

    // We pass the result of switchChangedCommand as canExecute Observable to
    // the updateWeatherCommand
    updateWeatherCommand = RxCommand.createAsync<String, List<WeatherEntry>>(
      sl.get<WeatherService>().getWeatherEntriesForCity,
      canExecute: switchChangedCommand,
    );

    // Will be called on every change of the search field
    textChangedCommand = RxCommand.createSync<String, String>((s) => s);

    // When the user starts typing
    textChangedCommand
        // Wait for the user to stop typing for 500ms
        .debounce(new Duration(milliseconds: 500))
        // Then call the updateWeatherCommand
        .listen(updateWeatherCommand);

    // Update data on startup
    updateWeatherCommand('');
  }
}
