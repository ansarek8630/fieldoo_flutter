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

  @override
  String get createAccountTitle => 'انضم إلى تيرف ميت';

  @override
  String get createAccountSubtitle => 'أنشئ ملفك كلاعب في دقيقة';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get nameRequired => 'الاسم مطلوب';

  @override
  String get passwordsMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get addPhoto => 'إضافة صورة الملف الشخصي';

  @override
  String get changePhoto => 'تغيير الصورة';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get chooseGallery => 'اختيار من المعرض';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get accountCreateFailed => 'تعذر إنشاء حسابك. حاول مرة أخرى.';

  @override
  String get tabTurfs => 'الملاعب';

  @override
  String get tabMatches => 'المباريات';

  @override
  String get tabChat => 'الدردشة';

  @override
  String get tabProfile => 'حسابي';

  @override
  String get searchTurfs => 'ابحث عن ملعب أو منطقة';

  @override
  String get turfsNearYou => 'ملاعب قريبة منك';

  @override
  String get noTurfsFound => 'لا توجد ملاعب مطابقة لبحثك';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get loadFailed => 'تعذر تحميل البيانات';

  @override
  String get comingSoon => 'قريباً';

  @override
  String get openNow => 'مفتوح';

  @override
  String get closedNow => 'مغلق';

  @override
  String perHour(int price) {
    return '$price د.إ / ساعة';
  }

  @override
  String get formats => 'أنواع المباريات';

  @override
  String get openingHours => 'ساعات العمل';

  @override
  String get amenities => 'المرافق';

  @override
  String get bookNow => 'احجز الآن';

  @override
  String get priceLabel => 'السعر';

  @override
  String hoursRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get turfNotFound => 'هذا الملعب لم يعد متاحاً';

  @override
  String get amenityParking => 'مواقف سيارات';

  @override
  String get amenityFloodlights => 'إضاءة كاشفة';

  @override
  String get amenityChangingRooms => 'غرف تبديل';

  @override
  String get amenityShowers => 'دشّات';

  @override
  String get amenityCafe => 'مقهى';

  @override
  String get amenityWifi => 'واي فاي';

  @override
  String get amenityWater => 'مياه شرب';
}
