import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SecurityLocalDataSource {
  Future<bool> isPinEnabled();
  Future<void> savePin(String pin);
  Future<void> removePin();
  Future<bool> checkPin(String enteredPin);
}

class SecurityLocalDataSourceImpl implements SecurityLocalDataSource {
  final SharedPreferences preferences;

  static const _keyPinEnabled = 'storee_pin_enabled';
  static const _keyPinHash = 'storee_pin_hash';
  static const _salt = 'storee_boutique_secure_salt_2026';

  const SecurityLocalDataSourceImpl(this.preferences);

  String _hashPin(String pin) {
    final bytes = utf8.encode('$_salt:$pin');
    return sha256.convert(bytes).toString();
  }

  @override
  Future<bool> isPinEnabled() async {
    return preferences.getBool(_keyPinEnabled) ?? false;
  }

  @override
  Future<void> savePin(String pin) async {
    final hash = _hashPin(pin);
    await preferences.setString(_keyPinHash, hash);
    await preferences.setBool(_keyPinEnabled, true);
  }

  @override
  Future<void> removePin() async {
    await preferences.remove(_keyPinHash);
    await preferences.setBool(_keyPinEnabled, false);
  }

  @override
  Future<bool> checkPin(String enteredPin) async {
    final savedHash = preferences.getString(_keyPinHash);
    if (savedHash == null) return false;
    final enteredHash = _hashPin(enteredPin);
    return savedHash == enteredHash;
  }
}
