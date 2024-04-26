import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:analyzer_plugin/protocol/protocol_generated.dart';

Iterable<AnalysisErrorFixes> validateAmendModelSuffix(
  String path,
  ResolvedUnitResult unit,
) sync* {
  final lib = unit.libraryElement;
  final topLevelClasses = lib.topLevelElements.whereType<ClassElement>();
  for (final c in topLevelClasses) {
    if (c.name.endsWith('Model')) {
      final location = Location(path, c.nameOffset, c.nameLength, 0, 0);
      yield AnalysisErrorFixes(
        AnalysisError(
          AnalysisErrorSeverity.INFO,
          AnalysisErrorType.LINT,
          location,
          'Amend model suffix in class names',
          'hard_amend_model_suffix',
          correction: 'Rename class',
          hasFix: false,
        ),
      );
    }
  }
}
