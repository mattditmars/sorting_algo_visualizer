import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorting_algo_visualizer/sorting_provider.dart';
import 'package:sorting_algo_visualizer/widgets/action_button.dart';
import 'package:sorting_algo_visualizer/widgets/algo_dropdown.dart';
import 'package:sorting_algo_visualizer/widgets/array_painter.dart';

void main() => runApp(
      ChangeNotifierProvider(
        create: (context) => SortingProvider(),
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sorting Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      home: SortingVisualizer(),
    );
  }
}

class SortingVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sorting Visualizer"),
          elevation: 0,
          actions: <Widget>[
            AlgoDropdown(),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 8,
              child: SizedBox.expand(
                child: Consumer<SortingProvider>(
                  builder: (context, sorter, child) {
                    return CustomPaint(
                      painter: ArrayPainter(sorter.listToSort),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  ActionButton(isSort: false),
                  ActionButton(isSort: true)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
