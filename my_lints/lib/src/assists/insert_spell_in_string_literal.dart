import 'dart:math';

import 'package:analyzer/source/source_range.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

class InsertSpellInStringLiteral extends DartAssist {
  @override
  void run(
    CustomLintResolver resolver,
    ChangeReporter reporter,
    CustomLintContext context,
    SourceRange target,
  ) {
    final rand = Random();
    final spells = [
      "Accio",
      "Alohomora",
      "Lumos",
      "Wingardium Leviosa",
      "Expecto Patronum"
    ];

    context.registry.addSimpleStringLiteral((node) {
      if (!target.intersects(node.sourceRange)) return;

      final changeBuilder = reporter.createChangeBuilder(
        priority: 1,
        message: 'Insert a random spell in the string literal',
      );
      changeBuilder.addDartFileEdit((builder) {
        builder.addSimpleInsertion(
          node.offset + 1,
          '${spells.elementAt(rand.nextInt(spells.length - 1))}! ',
        );
      });
    });
  }
}
