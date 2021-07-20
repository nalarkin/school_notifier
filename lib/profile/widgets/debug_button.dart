import 'package:flutter/material.dart';

/// dumps a very large widget tree to console, helpful for seeing the scope
///

Widget debugButton() {
  return TextButton(
    onPressed: () {
      debugDumpApp();
    },
    child: Text('Dump App'),
  );
}
