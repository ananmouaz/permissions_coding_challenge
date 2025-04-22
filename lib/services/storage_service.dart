import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/consent_model.dart';

class StorageService {
  static const String _consentKey = 'user_consent';

  // Save consent settings to local storage
  Future<bool> saveConsent(ConsentModel consent) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(consent.toJson());
      return await prefs.setString(_consentKey, jsonString);
    } catch (e) {
      print('Error saving consent settings: $e');
      return false;
    }
  }

  // Load consent settings from local storage
  Future<ConsentModel> loadConsent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_consentKey);

      if (jsonString == null) {
        return ConsentModel(); // Return default settings if none are saved
      }

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return ConsentModel.fromJson(json);
    } catch (e) {
      print('Error loading consent settings: $e');
      return ConsentModel(); // Return default settings on error
    }
  }

  // Clear consent settings (useful for testing)
  Future<bool> clearConsent() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.remove(_consentKey);
    } catch (e) {
      print('Error clearing consent settings: $e');
      return false;
    }
  }
}