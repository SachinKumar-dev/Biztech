import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../UserModel/user_model.dart';

class ApiService extends GetxController {
  final dio = Dio();
  final userNameCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  Uri? urlValue;

  Future<bool> checkUser(String user, String password) async {
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.purple)),
    );

    try {
      final response = await dio.get('https://ssfbhl.com/adr/urljson.php');
      final List<dynamic> data = jsonDecode(response.data);

      List<Usermodel> users = data.map((e) => Usermodel.fromJson(e)).toList();

      for (var userModel in users) {
        if (userModel.name == user && userModel.password == password) {
          String urlString = userModel.url;
          if (!urlString.startsWith('http://') && !urlString.startsWith('https://')) {
            urlString = 'https://$urlString';
          }

          urlValue = Uri.parse(urlString);
          return true;
        }
      }
      return false;
    } catch (e) {
      print("Error: $e");
      return false;
    } finally {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    }
  }
}
