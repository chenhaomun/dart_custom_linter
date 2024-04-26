import 'package:analyzer/error/error.dart';
import 'package:analyzer/error/listener.dart';
import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

final _secretRegex = RegExp(
  r'\bsecret\b',
  caseSensitive: false,
);

class DoNotSay extends DartLintRule {
  DoNotSay() : super(code: _code);

  static const _code = LintCode(
    name: 'do_not_mention_secret',
    problemMessage: 'Secret shall not be mentioned',
  );

  // `run` is where you analyze a file and report lint errors
  // Invoked on a file automatically
  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    // A call back fn that runs on all variable declarations in a file
    context.registry.addVariableDeclaration((node) {
      final element = node.declaredElement;
      if (element == null || !_secretRegex.hasMatch(element.name)) return;

      // report a lint error with the `code` and the respective `element`
      reporter.reportErrorForElement(code, element);
    });
  }

  @override
  List<Fix> getFixes() => [_Replace()];
}

class _Replace extends DartFix {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    AnalysisError analysisError,
    List<AnalysisError> others,
  ) {
    context.registry.addVariableDeclaration((node) {
      final element = node.declaredElement;

      // `return` if the current variable declaration is not where the lint
      // error has appeared
      if (element == null ||
          !analysisError.sourceRange.intersects(node.sourceRange)) return;

      final changeBuilder = reporter.createChangeBuilder(
        message: 'Replace secret',
        priority: 1,
      );
      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(element.nameOffset, element.nameLength),
          element.name.replaceAll(
            _secretRegex,
            "xxxxxx",
          ),
        );
      });
    });
  }
}
