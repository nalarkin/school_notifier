import 'package:flutter/material.dart';


/// dumps a very large widget tree to console, helpful for seeing the scope
/// I recommend waiting for the debug to finish printing. Then right click
/// on the text and select `copy all`, then save it in a text file. 
/// if you make the textfile in different VSCode .txt document, then it 
/// preserves the tab indentation. I then use CTRL+F to search the widget tree


Widget debugButton() {
  return TextButton(
    onPressed: () {
      debugDumpApp();
    },
    child: Text('Dump App'),
  );
}
