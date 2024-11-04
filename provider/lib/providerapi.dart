// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'gender.dart';

// class GenderProvider with ChangeNotifier {
//   GenderTeller? _genderData;
//   bool _isLoading = false;
//   String? _error;

//   GenderTeller? get genderData => _genderData;
//   bool get isLoading => _isLoading;
//   String? get error => _error;

//   Future<void> fetchGenderData(String name) async {
//     if (name.isEmpty) {
//       _error = "Please enter a name";
//       notifyListeners();
//       return;
//     }

//     try {
//       _isLoading = true;
//       _error = null;
//       notifyListeners();

//       final response = await http.get(
//         Uri.parse("https://api.genderize.io?name=${name.trim().toLowerCase()}"),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _genderData = GenderTeller.fromJson(data);
//         _error = null;
//       } else {
//         _error = "Failed to fetch data";
//         _genderData = null;
//       }
//     } catch (e) {
//       _error = "An error occurred: $e";
//       _genderData = null;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void clearData() {
//     _genderData = null;
//     _error = null;
//     notifyListeners();
//   }
// }
