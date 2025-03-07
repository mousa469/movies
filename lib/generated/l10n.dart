// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Find your next favorite movie here.`
  String get find_next_favorite_movie {
    return Intl.message(
      'Find your next favorite movie here.',
      name: 'find_next_favorite_movie',
      desc: '',
      args: [],
    );
  }

  /// `Get access to a huge library of movies to suit all tastes. You will surely like it.`
  String get huge_library_of_movies {
    return Intl.message(
      'Get access to a huge library of movies to suit all tastes. You will surely like it.',
      name: 'huge_library_of_movies',
      desc: '',
      args: [],
    );
  }

  /// `Discover Movies`
  String get discover_movies {
    return Intl.message(
      'Discover Movies',
      name: 'discover_movies',
      desc: '',
      args: [],
    );
  }

  /// `Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.`
  String get explore_vast_collection {
    return Intl.message(
      'Explore a vast collection of movies in all qualities and genres. Find your next favorite film with ease.',
      name: 'explore_vast_collection',
      desc: '',
      args: [],
    );
  }

  /// `Explore Now`
  String get explore_now {
    return Intl.message('Explore Now', name: 'explore_now', desc: '', args: []);
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Explore All Genres`
  String get explore_all_genres {
    return Intl.message(
      'Explore All Genres',
      name: 'explore_all_genres',
      desc: '',
      args: [],
    );
  }

  /// `Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.`
  String get discover_movies_every_genre {
    return Intl.message(
      'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
      name: 'discover_movies_every_genre',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Create Watchlists`
  String get create_watchlists {
    return Intl.message(
      'Create Watchlists',
      name: 'create_watchlists',
      desc: '',
      args: [],
    );
  }

  /// `Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.`
  String get save_movies_watchlist {
    return Intl.message(
      'Save movies to your watchlist to keep track of what you want to watch next. Enjoy films in various qualities and genres.',
      name: 'save_movies_watchlist',
      desc: '',
      args: [],
    );
  }

  /// `Rate, Review, and Learn`
  String get rate_review_learn {
    return Intl.message(
      'Rate, Review, and Learn',
      name: 'rate_review_learn',
      desc: '',
      args: [],
    );
  }

  /// `Share your thoughts on the movies you've watched. Dive deep into film details and help others discover great movies with your reviews.`
  String get share_thoughts_movies {
    return Intl.message(
      'Share your thoughts on the movies you\'ve watched. Dive deep into film details and help others discover great movies with your reviews.',
      name: 'share_thoughts_movies',
      desc: '',
      args: [],
    );
  }

  /// `Start Watching Now`
  String get start_watching_now {
    return Intl.message(
      'Start Watching Now',
      name: 'start_watching_now',
      desc: '',
      args: [],
    );
  }

  /// `Watch`
  String get watch {
    return Intl.message('Watch', name: 'watch', desc: '', args: []);
  }

  /// `Screen Shots`
  String get screen_shots {
    return Intl.message(
      'Screen Shots',
      name: 'screen_shots',
      desc: '',
      args: [],
    );
  }

  /// `Similar`
  String get similar {
    return Intl.message('Similar', name: 'similar', desc: '', args: []);
  }

  /// `Summary`
  String get summary {
    return Intl.message('Summary', name: 'summary', desc: '', args: []);
  }

  /// `Cast`
  String get cast {
    return Intl.message('Cast', name: 'cast', desc: '', args: []);
  }

  /// `Genres`
  String get genres {
    return Intl.message('Genres', name: 'genres', desc: '', args: []);
  }

  /// `Action`
  String get action {
    return Intl.message('Action', name: 'action', desc: '', args: []);
  }

  /// `Sci-Fi`
  String get sci_fi {
    return Intl.message('Sci-Fi', name: 'sci_fi', desc: '', args: []);
  }

  /// `Adventure`
  String get adventure {
    return Intl.message('Adventure', name: 'adventure', desc: '', args: []);
  }

  /// `Fantasy`
  String get fantasy {
    return Intl.message('Fantasy', name: 'fantasy', desc: '', args: []);
  }

  /// `Horror`
  String get horror {
    return Intl.message('Horror', name: 'horror', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get forget_password_question {
    return Intl.message(
      'Forgot your password?',
      name: 'forget_password_question',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Login With Google`
  String get login_with_google {
    return Intl.message(
      'Login With Google',
      name: 'login_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get dont_have_account_question {
    return Intl.message(
      'Don’t have an account?',
      name: 'dont_have_account_question',
      desc: '',
      args: [],
    );
  }

  /// `Create One`
  String get create_one {
    return Intl.message('Create One', name: 'create_one', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Phone Number`
  String get phone_number {
    return Intl.message(
      'Phone Number',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get create_account {
    return Intl.message(
      'Create Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account_question {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account_question',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verify_email {
    return Intl.message(
      'Verify Email',
      name: 'verify_email',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Forget Password`
  String get forget_password {
    return Intl.message(
      'Forget Password',
      name: 'forget_password',
      desc: '',
      args: [],
    );
  }

  /// `See More`
  String get see_more {
    return Intl.message('See More', name: 'see_more', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Wish List`
  String get wish_list {
    return Intl.message('Wish List', name: 'wish_list', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `Edit Profile`
  String get edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message('Exit', name: 'exit', desc: '', args: []);
  }

  /// `Pick Avatar`
  String get pick_avatar {
    return Intl.message('Pick Avatar', name: 'pick_avatar', desc: '', args: []);
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Update Data`
  String get update_data {
    return Intl.message('Update Data', name: 'update_data', desc: '', args: []);
  }

  /// `OR`
  String get or {
    return Intl.message('OR', name: 'or', desc: '', args: []);
  }

  /// `email address is required `
  String get email_address_is_required {
    return Intl.message(
      'email address is required ',
      name: 'email_address_is_required',
      desc: '',
      args: [],
    );
  }

  /// `password is required `
  String get password_is_required {
    return Intl.message(
      'password is required ',
      name: 'password_is_required',
      desc: '',
      args: [],
    );
  }

  /// `name is required`
  String get name_is_required {
    return Intl.message(
      'name is required',
      name: 'name_is_required',
      desc: '',
      args: [],
    );
  }

  /// `phone number is required`
  String get phone_number_is_required {
    return Intl.message(
      'phone number is required',
      name: 'phone_number_is_required',
      desc: '',
      args: [],
    );
  }

  /// `congratualtions`
  String get congratualtions {
    return Intl.message(
      'congratualtions',
      name: 'congratualtions',
      desc: '',
      args: [],
    );
  }

  /// `Opps`
  String get Opps {
    return Intl.message('Opps', name: 'Opps', desc: '', args: []);
  }

  /// `Registered successfully`
  String get registered_successfully {
    return Intl.message(
      'Registered successfully',
      name: 'registered_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Sign in successfully`
  String get sign_in_successfully {
    return Intl.message(
      'Sign in successfully',
      name: 'sign_in_successfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
