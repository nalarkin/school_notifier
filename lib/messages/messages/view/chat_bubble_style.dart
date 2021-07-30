import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

const styleSomebody = BubbleStyle(
  nip: BubbleNip.leftBottom,
  color: Colors.white,
  borderColor: Colors.blue,
  borderWidth: 1,
  elevation: 1,
  margin: BubbleEdges.only(top: 8, right: 50),
  alignment: Alignment.topLeft,
);

const styleMe = BubbleStyle(
  nip: BubbleNip.rightBottom,
  color: Color.fromARGB(255, 190, 190, 190),
  borderColor: Colors.blue,
  borderWidth: 1,
  elevation: 1,
  margin: BubbleEdges.only(top: 8, left: 50),
  alignment: Alignment.topRight,
);
