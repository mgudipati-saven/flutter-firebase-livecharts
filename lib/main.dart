import 'package:flutter/material.dart';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class Sales {
  int year;
  int sales;
  charts.Color color;

  Sales(this.year, this.sales, this.color);
}

class _State extends State<MyApp> {
  List<Sales> _data;
  List<charts.Series<Sales, int>> _chartData;

  void _makeData() {
    _chartData = List<charts.Series<Sales, int>>();
    _data = <Sales>[
      new Sales(0, 100, charts.MaterialPalette.red.shadeDefault),
      new Sales(1, 75, charts.MaterialPalette.yellow.shadeDefault),
      new Sales(2, 50, charts.MaterialPalette.blue.shadeDefault),
      new Sales(3, 20, charts.MaterialPalette.green.shadeDefault),
    ];
    
    _chartData.add(new charts.Series(
      id: 'Sales',
      data: _data,
      domainFn: (Sales sales, _) => sales.year,
      measureFn: (Sales sales, _) => sales.sales,
      colorFn: (Sales sales, _) => sales.color,
    ));
  }

  @override
  void initState() {
    _makeData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Title'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
            new Text('Sales Data'),
            new Expanded(child: new charts.PieChart(
              _chartData,
              animate: true,
              animationDuration: new Duration(seconds: 1),
            )),
          ],
        ),
      ),
    );
  }

}