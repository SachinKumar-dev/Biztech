import 'package:browser_launcher_app/Service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Service/web_view_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final ctrl = Get.find<ApiService>();
  bool isVisible = true;

  void toggleVisibility() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            'Biztech',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("assets/logos/homeImage.png", scale: 7),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                TextField(
                  style: const TextStyle(color: Colors.black),
                  controller: ctrl.userNameCtrl,
                  decoration: InputDecoration(
                    labelText: "Enter Name",
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w500),
                    labelStyle: GoogleFonts.poppins(
                        color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: isVisible,
                  style: const TextStyle(color: Colors.black),
                  controller: ctrl.passwordCtrl,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: toggleVisibility,
                      icon: Icon(
                        isVisible ? Icons.visibility_off : Icons.visibility,
                        color: Colors.blue,
                      ),
                    ),
                    labelText: "Enter User Id",
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w500),
                    labelStyle: GoogleFonts.poppins(
                        color: Colors.blue, fontSize: 14, fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 52,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final bool isAuthenticated = await ctrl.checkUser(
                        ctrl.userNameCtrl.text.trim(),
                        ctrl.passwordCtrl.text.trim(),
                      );
                      if (isAuthenticated && ctrl.urlValue != null) {
                        Get.to(() => WebViewScreen(url: ctrl.urlValue!));
                        ctrl.userNameCtrl.clear();
                        ctrl.passwordCtrl.clear();
                      } else {
                        Get.snackbar(
                          'Oops!',
                          isAuthenticated ? 'URL is null' : 'Invalid username or password',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      }
                    },
                    child: Text(
                      'LogIn',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
