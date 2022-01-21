import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blitter_flutter_app/data/blocs.dart';

class ColorPickerSheet extends StatelessWidget {
  static const colorList = Colors.primaries;
  static const colorNameList = [
    'red',
    'pink',
    'purple',
    'deepPurple',
    'indigo',
    'blue',
    'lightBlue',
    'cyan',
    'teal',
    'green',
    'lightGreen',
    'lime',
    'yellow',
    'amber',
    'orange',
    'deepOrange',
    'brown',
    'blueGrey',
  ];

  const ColorPickerSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configBloc = context.read<ConfigBloc>();

    return Column(
      children: [
        const SizedBox(
          height: 50,
          child: Center(
            child: Text(
              'Tap on a color to set as primary',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  configBloc.add(
                    SetPrimaryColor(colorList[index]),
                  );
                  Navigator.pop(context);
                },
                child: Container(
                  height: 80,
                  color: colorList[index],
                  child: Center(
                    child: Text(
                      colorNameList[index].toUpperCase(),
                    ),
                  ),
                ),
              );
            },
            itemCount: Colors.primaries.length,
          ),
        ),
      ],
    );
  }
}
