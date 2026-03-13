import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../generated/l10n/app_localizations.dart';
import '../../providers/language_provider.dart';

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageMode = ref.watch(languageProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.language),
      ),
      body: ListView(
        children: [
          _buildLanguageItem(
            context,
            ref,
            l10n.follow_system,
            LanguageMode.system,
            languageMode == LanguageMode.system,
          ),
          _buildLanguageItem(
            context,
            ref,
            l10n.chinese,
            LanguageMode.zh,
            languageMode == LanguageMode.zh,
          ),
          _buildLanguageItem(
            context,
            ref,
            l10n.english,
            LanguageMode.en,
            languageMode == LanguageMode.en,
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageItem(
    BuildContext context,
    WidgetRef ref,
    String title,
    LanguageMode mode,
    bool isSelected,
  ) {
    return ListTile(
      title: Text(title),
      trailing: isSelected
          ? Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            )
          : null,
      onTap: () {
        ref.read(languageProvider.notifier).setLanguage(mode);
      },
    );
  }
}
