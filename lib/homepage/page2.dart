import 'package:flutter/material.dart';
import 'package:making_flutter_more_reactive/homepage/Data.dart';

import 'package:making_flutter_more_reactive/managers/app_manager.dart';
import 'package:making_flutter_more_reactive/service_locator.dart';

class Page2 extends StatefulWidget {
  @override
  Page2State createState() {
    return Page2State();
  }
}

class Page2State extends State<Page2> {

  Page2State(){
    sl.get<AppManager>().collectDataForPage2.listen(
      (dataFrom){ 
        setState( () => data = dataFrom );
      }
    );
  }

  void handleClick(){
    sl.get<AppManager>().switchToPage1();
  }

  Data data = Data(111, "name111", "note111");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text(data.name),
      IconButton(
          icon: Icon(Icons.backspace),
          tooltip: 'Go to page 1',
          onPressed: this.handleClick
      ),
    ]);
      // RxLoader<Data>(
      //     spinnerKey: AppKeys.loadingSpinner,
      //     radius: 25.0,
      //     commandResults: sl.get<AppManager>().dataForPage2,
      //     dataBuilder: (context, localData) => Text(data.name),
      //     placeHolderBuilder: (context) => Center(
      //       key: AppKeys.loaderPlaceHolder, child: Text("No Data")),
      //     errorBuilder: (context, ex) => Center(
      //       key: AppKeys.loaderError,
      //       child: Text("Error: ${ex.toString()}"))
      //   ); 
        //Text(data.name)
  }

}

