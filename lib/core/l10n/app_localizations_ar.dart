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

  @override
  String get bookingTitle => 'احجز موعدك';

  @override
  String get selectDate => 'اختر التاريخ';

  @override
  String get selectTime => 'اختر الوقت';

  @override
  String get duration => 'المدة';

  @override
  String hoursCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ساعة',
      few: '$count ساعات',
      two: 'ساعتان',
      one: 'ساعة',
    );
    return '$_temp0';
  }

  @override
  String get legendAvailable => 'متاح';

  @override
  String get legendBooked => 'محجوز';

  @override
  String get legendSelected => 'محدد';

  @override
  String get total => 'الإجمالي';

  @override
  String get confirmBooking => 'تأكيد الحجز';

  @override
  String get selectTimeCta => 'اختر وقتاً';

  @override
  String get bookingConfirmed => 'تم تأكيد الحجز!';

  @override
  String bookingConfirmedMsg(String turf, String date, String time) {
    return '$turf\n$date · $time';
  }

  @override
  String get done => 'تم';

  @override
  String get bookingFailed => 'فشل الحجز. حاول مرة أخرى.';

  @override
  String get today => 'اليوم';

  @override
  String get matchesTitle => 'المباريات المفتوحة';

  @override
  String get allFilter => 'الكل';

  @override
  String get skillBeginner => 'مبتدئ';

  @override
  String get skillIntermediate => 'متوسط';

  @override
  String get skillAdvanced => 'محترف';

  @override
  String get join => 'انضم';

  @override
  String get joined => 'منضم';

  @override
  String get matchFull => 'مكتملة';

  @override
  String playersCount(int joined, int max) {
    return '$joined/$max لاعبين';
  }

  @override
  String perPlayer(int price) {
    return '$price د.إ / لاعب';
  }

  @override
  String hostedBy(String name) {
    return 'بتنظيم $name';
  }

  @override
  String spotsLeft(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مكاناً متبقياً',
      few: '$count أماكن متبقية',
      two: 'مكانان متبقيان',
      one: 'مكان واحد متبقٍ',
    );
    return '$_temp0';
  }

  @override
  String get joinSuccess => 'تم انضمامك! نراك في الملعب.';

  @override
  String get joinFailed => 'تعذر الانضمام إلى المباراة. حاول مرة أخرى.';

  @override
  String get noMatches => 'لا توجد مباريات مفتوحة حالياً';

  @override
  String get chatsTitle => 'المحادثات';

  @override
  String get noChats => 'لا توجد محادثات بعد. انضم إلى مباراة لتبدأ الدردشة.';

  @override
  String get typeMessage => 'اكتب رسالة';

  @override
  String membersCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count لاعباً',
      few: '$count لاعبين',
      two: 'لاعبان',
      one: 'لاعب واحد',
    );
    return '$_temp0';
  }

  @override
  String get messageSendFailed => 'لم يتم إرسال الرسالة. حاول مرة أخرى.';

  @override
  String get noMessagesYet => 'ألقِ التحية على زملائك 👋';

  @override
  String get chatNotFound => 'هذه المحادثة لم تعد متاحة';
}
