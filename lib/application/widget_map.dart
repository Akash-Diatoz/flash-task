import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MapDataToWidget {
  List<Widget> serverWidget = [];

  mapWidgets(serverUI) {
    for (var element in jsonDecode(serverUI)) {
      String type = element["type"];
      serverWidget.add(toWidget(element, type));
    }
    return serverWidget;
  }

  toWidget(element, type) {
    switch (type) {
      case 'logout_message':
        return Text(
          (element["size"]),
        );
      case "Container":
        return Container(
          width: (element['width']).toDouble(),
          height: (element['height']).toDouble(),
          color: HexColor(element['color']),
          child:
              toWidget(element['attributes'], element['attributes']['types']),
        );
      case "Text":
        return Text(element["txtData"]);
      default:
        return const Text('Error');
    }
  }
}
