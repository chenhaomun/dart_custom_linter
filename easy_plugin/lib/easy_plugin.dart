import 'package:custom_lint_builder/custom_lint_builder.dart';
import 'package:easy_plugin/src/rules/amend_model_suffix.dart';
import 'package:easy_plugin/src/rules/do_not_use_hard_plugin.dart';

PluginBase createPlugin() => _EasyPlugin();

class _EasyPlugin extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs _) => [
        AmendModelSuffix(),
        DoNotUseHardPlugin(),
      ];
}
