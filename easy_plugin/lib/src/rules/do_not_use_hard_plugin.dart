import 'dart:io';

import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class DoNotUseHardPlugin extends DartLintRule {
  DoNotUseHardPlugin() : super(code: _code);

  static const _code = LintCode(
    name: 'do_not_use_hard_plugin',
    problemMessage: 'Hard Plugin was a PoC',
    errorSeverity: ErrorSeverity.WARNING,
  );

  static const _hardPluginName = 'hard_plugin:';

  @override
  List<String> get filesToAnalyze => const ['pubspec.yaml'];

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    final file = File(resolver.path);
    final content = file.readAsStringSync();
    final hardString = content.lastIndexOf(' $_hardPluginName');
    if (hardString != -1) {
      reporter.reportErrorForOffset(
          code, hardString + 1, _hardPluginName.length);
    }
  }
}
