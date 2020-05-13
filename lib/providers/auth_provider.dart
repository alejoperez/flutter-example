import 'package:flutter/widgets.dart';
import 'package:flutterexample/domain/http_exception.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static const String API_KEY = "AIzaSyBMnzfH_LbjlNlOp7irGlCmvbWErxPxZPw";
  static const String AUTH_KEY = "auth";
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;

  bool get isAuthenticated {
    return token != null;
  }

  String get token {
    if(_token != null && _expiryDate != null && _expiryDate.isAfter(DateTime.now())) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }

  Future<void> _authenticate(String email, String password, String url) async {
    try {
      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      
      final responseData = json.decode(response.body);
      if(responseData["error"] != null) {
        throw HttpException("${responseData["error"]["message"]}");
      } else {
        _token = responseData["idToken"];
        _userId = responseData["localId"];
        _expiryDate = DateTime.now().add(Duration(seconds: int.tryParse(responseData["expiresIn"])));
        _autoLogout();
        notifyListeners();

        final prefs = await SharedPreferences.getInstance();
        prefs.setString(AUTH_KEY, json.encode({
          "token": _token,
          "userId": _userId,
          "expiryDate": _expiryDate.toIso8601String(),

        }));

      }
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {

    final prefs = await SharedPreferences.getInstance();
    if(!prefs.containsKey(AUTH_KEY)) {
      return false;
    }

    final Map<String, Object> authData = json.decode(prefs.get(AUTH_KEY));
    final expiryDate = DateTime.parse(authData["expiryDate"]);
    if(expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = authData["token"];
    _userId = authData["userId"];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> signUp(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY";
    return _authenticate(email, password, url);
  }

  Future<void> logIn(String email, String password) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$API_KEY";
    return _authenticate(email, password, url);
  }

  Future<void> logOut() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if(_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if(_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiryInSeconds = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiryInSeconds), logOut);
  }

}
