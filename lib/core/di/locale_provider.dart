import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// App-wide locale. Persistence (shared_preferences) comes with the Profile page.
class LocaleController extends Notifier<Locale> {
  @override
  Locale build() => const Locale('en');

  void toggle() =>
      state = state.languageCode == 'en' ? const Locale('ar') : const Locale('en');
}

final localeProvider =
    NotifierProvider<LocaleController, Locale>(LocaleController.new);
