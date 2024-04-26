import 'dart:isolate';

import 'package:analyzer_plugin/starter.dart';
import 'package:hard_plugin/src/plugin.dart';

void start(Iterable<String> _, SendPort sendPort) {
  ServerPluginStarter(HardPlugin()).start(sendPort);
}
