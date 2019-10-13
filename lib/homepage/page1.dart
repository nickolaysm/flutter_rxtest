import 'package:flutter/material.dart';
import 'package:making_flutter_more_reactive/homepage/Data.dart';
import 'package:making_flutter_more_reactive/managers/app_manager.dart';
import 'package:making_flutter_more_reactive/service_locator.dart';

class Page1 extends StatefulWidget {
  @override
  Page1State createState() {
    return Page1State();
  }
}

class Page1State extends State<Page1> {

  List<Data> dataList = [
    Data(1,"name1", "note1"),
    Data(2,"name2", "note2"),
    Data(3,"name3", "note3"),
    Data(4,"name4", "note4")
  ];

  void handleClick(){
    sl.get<AppManager>().switchToPage2();
    //sl.get<AppManager>().sendDataToPage2(dataList[1]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:[
        IconButton(
          icon: Icon(Icons.volume_up),
          tooltip: 'Go to information page',
          onPressed: this.handleClick
        ),
        Expanded(
          child:
            ListView.builder(
              itemBuilder: (BuildContext context, int index) => DataItem(dataList[index]),
              itemCount: dataList.length,
            )
        )
      ]
    );  
  }

}

class DataItem extends StatelessWidget {
  const DataItem(this.data);
  final Data data;
  
  Widget _buildTiles(Data root) {
    return //Text(root.name);
    GestureDetector(
      child: ListTile(title: Text(root.name)),
      onTap: () => sl.get<AppManager>().sendDataToPage2(root)
    );
    
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(data);
  }

}