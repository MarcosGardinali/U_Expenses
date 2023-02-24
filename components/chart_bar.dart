// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String? label;
  final double? value;
  final double? percentage;

  ChartBar({this.label, this.value, this.percentage,});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints){
        return Column(
        children: [
          Container(
          height: constraints.maxHeight * 0.1,
          child: 
          FittedBox(child: Text('${value?.toStringAsFixed(2)}'))),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(height: constraints.maxHeight * 0.7,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 200, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(5),
                  ),
                )
              ),
            ],
          ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05,),
          Container(
            height: constraints.maxHeight * 0.1,
            child: FittedBox(child: Text(label!))),
    
        ],
      );
      },
 
    );
    
  }
}