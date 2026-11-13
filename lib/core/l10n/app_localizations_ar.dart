// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'تيرف ميت';

  @override
  String get tagline => 'اعثر. احجز. العب.';

  @override
  String get welcomeBack => 'أهلاً بعودتك';

  @override
  String get signInSubtitle =>
      'سجّل الدخول لحجز الملاعب والانضمام إلى المباريات';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get emailInvalid => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get passwordShort => 'يجب ألا تقل كلمة المرور عن 6 أحرف';

  @override
  String get continueAsGuest => 'المتابعة كضيف';

  @override
  String get noAccount => 'ليس لديك حساب؟';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get signInFailed => 'فشل تسجيل الدخول. حاول مرة أخرى.';

  @override
  String get language => 'English';

  @override
  String get homePlaceholder => 'الرئيسية – في الصفحة القادمة';
}
