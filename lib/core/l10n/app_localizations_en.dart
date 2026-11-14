// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'TurfMate';

  @override
  String get tagline => 'Find. Book. Play.';

  @override
  String get welcomeBack => 'Welcome back';

  @override
  String get signInSubtitle => 'Sign in to book turfs and join matches';

  @override
  String get signIn => 'Sign In';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Enter a valid email address';

  @override
  String get passwordShort => 'Password must be at least 6 characters';

  @override
  String get continueAsGuest => 'Continue as guest';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get createAccount => 'Create account';

  @override
  String get signInFailed => 'Sign in failed. Please try again.';

  @override
  String get language => 'العربية';

  @override
  String get homePlaceholder => 'Home – coming in the next page';

  @override
  String get createAccountTitle => 'Join TurfMate';

  @override
  String get createAccountSubtitle => 'Create your player profile in a minute';

  @override
  String get fullName => 'Full name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get nameRequired => 'Your name is required';

  @override
  String get passwordsMismatch => 'Passwords do not match';

  @override
  String get addPhoto => 'Add profile photo';

  @override
  String get changePhoto => 'Change photo';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get chooseGallery => 'Choose from gallery';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get accountCreateFailed =>
      'Could not create your account. Please try again.';

  @override
  String get tabTurfs => 'Turfs';

  @override
  String get tabMatches => 'Matches';

  @override
  String get tabChat => 'Chat';

  @override
  String get tabProfile => 'Profile';

  @override
  String get searchTurfs => 'Search turfs or areas';

  @override
  String get turfsNearYou => 'Turfs near you';

  @override
  String get noTurfsFound => 'No turfs match your search';

  @override
  String get retry => 'Retry';

  @override
  String get loadFailed => 'Could not load data';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String get openNow => 'Open';

  @override
  String get closedNow => 'Closed';

  @override
  String perHour(int price) {
    return '$price AED / hour';
  }

  @override
  String get formats => 'Formats';

  @override
  String get openingHours => 'Opening hours';

  @override
  String get amenities => 'Amenities';

  @override
  String get bookNow => 'Book now';

  @override
  String get priceLabel => 'Price';

  @override
  String hoursRange(String from, String to) {
    return '$from – $to';
  }

  @override
  String get turfNotFound => 'This turf is no longer available';

  @override
  String get amenityParking => 'Parking';

  @override
  String get amenityFloodlights => 'Floodlights';

  @override
  String get amenityChangingRooms => 'Changing rooms';

  @override
  String get amenityShowers => 'Showers';

  @override
  String get amenityCafe => 'Cafe';

  @override
  String get amenityWifi => 'Wi-Fi';

  @override
  String get amenityWater => 'Drinking water';
}
