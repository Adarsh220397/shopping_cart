import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'preference_constants.dart';

class PreferenceManager {
  //Singleton instance
  PreferenceManager._internal();

  static PreferenceManager instance = PreferenceManager._internal();
  static late SharedPreferences _prefs;

  factory PreferenceManager() {
    return instance;
  }

  Future<void> clearAll() async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
  }

  /// ------------------( MOBILE NUMBER )------------------
  Future<String> getMobileNumber() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.mobileNumber) ?? "";
  }

  Future<void> setMobileNumber(String mobileNumber) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.mobileNumber, mobileNumber);
  }

  /// ------------------( NAME )------------------
  Future<String> getName() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.name) ?? "";
  }

  Future<void> setName(String name) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.name, name);
  }

  /// ------------------( EMAIL )------------------
  Future<String> getEmail() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.email) ?? "";
  }

  Future<void> setEmail(String email) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.email, email);
  }

  /// ------------------( ADDRESS )------------------
  Future<String> getPassword() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.address) ?? "";
  }

  Future<void> setPassword(String address) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.address, address);
  }

  /// ------------------( IMAGE )------------------
  Future<String> getImageUrl() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(PreferenceConstants.image) ?? "";
  }

  Future<void> setImage(String image) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(PreferenceConstants.image, image);
  }
}
