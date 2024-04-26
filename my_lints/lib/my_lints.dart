import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:my_lints/src/assists/do_not_say_assist.dart';
import 'package:my_lints/src/assists/insert_spell_in_string_literal.dart';
import 'package:my_lints/src/rules/do_not_say.dart';
import 'package:my_lints/src/rules/util_methods_be_static.dart';

PluginBase createPlugin() => _EasyPlugin();

class _EasyPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs _) => [
        DoNotSay(),
        UtilMethodsBeStatic(),
      ];

  @override
  List<Assist> getAssists() => [
        InsertSpellInStringLiteral(),
        DoNotSayAssist(),
      ];
}
