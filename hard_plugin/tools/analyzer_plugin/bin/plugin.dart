import 'dart:isolate';

import 'package:hard_plugin/hard_plugin.dart';

void main(List<String> args, SendPort sendPort) {
  start(args, sendPort);
}
