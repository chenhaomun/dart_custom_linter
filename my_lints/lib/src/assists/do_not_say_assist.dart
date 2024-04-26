import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

final _secretRegex = RegExp(
  r'\bsecret\b',
  caseSensitive: false,
);

class DoNotSayAssist extends DartAssist {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    context.registry.addSimpleStringLiteral((node) {
      if (!target.intersects(node.sourceRange) ||
          !_secretRegex.hasMatch(node.value)) return;

      final changeBuilder = reporter.createChangeBuilder(
        priority: 1,
        message: 'Assist replace secret',
      );
      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleReplacement(
          SourceRange(node.offset, node.length),
          "'xxxxxx'",
        );
      });
    });
  }
}
