import 'package:analyzer/dart/analysis/analysis_context.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:analyzer_plugin/plugin/plugin.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';
import 'package:hard_plugin/src/rules/amend_model_suffix.dart';

class HardPlugin extends ServerPlugin {
  HardPlugin() : super(resourceProvider: PhysicalResourceProvider.INSTANCE);

  @override
  Future<void> analyzeFile(
      {required AnalysisContext analysisContext, required String path}) async {
    final unit = await analysisContext.currentSession.getResolvedUnit(path);
    final errors = [
      if (unit is ResolvedUnitResult)
        ...validateAmendModelSuffix(path, unit).map((e) => e.error)
    ];
    channel
        .sendNotification(AnalysisErrorsParams(path, errors).toNotification());
  }

  @override
  List<String> get fileGlobsToAnalyze => ['*.dart'];

  @override
  String get name => 'Hard Plugin';

  @override
  String get version => '1.0.0';
}
