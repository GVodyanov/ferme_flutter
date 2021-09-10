import 'package:shared_preferences/shared_preferences.dart';

void setId (int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('id', id);
}

void deleteId () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('id');
}

Future<int?> getId () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? id = prefs.getInt('id');
  return id;
}

void setPassword (String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('password', password);
}

void deletePassword () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('password');
}

Future<String?> getPassword () async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? password = prefs.getString('password');
  return password;
}

void logout () async {
  deleteId();
  deletePassword();
}