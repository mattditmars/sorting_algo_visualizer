import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorting_algo_visualizer/sorting_provider.dart';

class ActionButton extends StatefulWidget {
  final bool isSort;

  ActionButton({
    @required this.isSort,
  });

  @override
  _ActionButtonState createState() => _ActionButtonState();
}

class _ActionButtonState extends State<ActionButton> {
  final Random rng = Random();
  Color randomColor;

  @override
  void initState() {
    super.initState();
    randomColor = newRandomColor;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
            this.widget.isSort ? 10 : 20, 20, this.widget.isSort ? 20 : 10, 20),
        child: MaterialButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(15.0)),
          height: double.infinity,
          onPressed: () {
            SortingProvider provider =
                Provider.of<SortingProvider>(context, listen: false);
            this.widget.isSort
                ? provider.runCorrectAlgo()
                : provider.generateRandomList();
            randomColor = Color.fromARGB(
                255, rng.nextInt(255), rng.nextInt(255), rng.nextInt(255));
            setState(() {});
          },
          color: this.widget.isSort ? Colors.green : randomColor,
          child: Stack(
            children: <Widget>[
              Text(
                this.widget.isSort ? "SORT" : "RANDOMIZE",
                style: Theme.of(context).textTheme.headline6.copyWith(
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3
                      ..color = Colors.black),
              ),
              Text(
                this.widget.isSort ? "SORT" : "RANDOMIZE",
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
        ),
      ),
    );
  }

  Color get newRandomColor =>
      Color.fromARGB(255, rng.nextInt(255), rng.nextInt(255), rng.nextInt(255));
}
