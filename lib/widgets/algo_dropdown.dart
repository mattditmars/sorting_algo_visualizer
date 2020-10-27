import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sorting_algo_visualizer/sorting_provider.dart';

class AlgoDropdown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SortingProvider>(
      builder: (context, sorter, child) {
        return Theme(
          data: ThemeData(canvasColor: Colors.deepPurple),
          child: Center(
            child: DropdownButton(
              iconEnabledColor: Colors.white,
              iconSize: 24,
              underline: Container(),
              items: sorter.availableAlgos.map((String algoName) {
                return DropdownMenuItem<String>(
                  value: algoName,
                  child:
                      Text(algoName, style: Theme.of(context).textTheme.button),
                );
              }).toList(),
              onChanged: (newValue) {
                sorter.setSelectedAlgo(newValue);
              },
              hint: Text(
                sorter.selectedAlgo,
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ),
        );
      },
    );
  }
}
