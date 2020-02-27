import 'package:flutter/material.dart';
import 'detail_page.dart';
import 'package:flutter_weather_demo/app_model.dart';
import 'package:flutter_weather_demo/service_locator.dart';

class WeatherListView extends StatelessWidget {
  WeatherListView();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<WeatherEntry>>(
        stream: sl
            .get<AppModel>()
            .WeatherStream, //We access our ViewModel through the inherited Widget
        builder:
            (BuildContext context, AsyncSnapshot<List<WeatherEntry>> snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildRow(context, index, snapshot.data));
          } else {
            return Text("No items");
          }
        });
  }

  Widget buildRow(
      BuildContext context, int index, List<WeatherEntry> listData) {
    return GestureDetector(
        child: Wrap(
          spacing: 40.0,
          children: <Widget>[
            Image(image: NetworkImage(listData[index].iconURL)),
            Text(listData[index].cityName,
                style: TextStyle(fontSize: 20.0))
          ],
        ),
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetailPage(listData[index]))));
  }
}
