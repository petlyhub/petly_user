import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sixam_mart/features/home/screens/home_screen.dart';


class AuthControllerTest extends GetxController {

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  bool isLoading = false;
  bool isSuccess = false;

  Future<void> login() async {
    isLoading = true;
    update();

    try {
      final response = await http.post(
        Uri.parse('https://admin.petlyhub.online/api/v1/auth/simple-login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "phone": phoneController.text,
          "otp": otpController.text,
        }),
        
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        Get.snackbar("Success", "Login Done");
        print("TOKEN: ${data['token']}");
        print(response.body);
        print(response.statusCode);
      } else {
        Get.snackbar("Error", data['message'] ?? 'Failed');
        print("Error $data[message]");
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    isLoading = false;
    update();
  }
}


class UiPhoneTest extends StatelessWidget {
  UiPhoneTest({super.key});

  final AuthControllerTest controller =
      Get.put(AuthControllerTest()); // 👈 هنا كله في صفحة واحدة

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<AuthControllerTest>(
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextField(
                    controller: controller.phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 15),

                  TextField(
                    controller: controller.otpController,
                    decoration: const InputDecoration(
                      labelText: "OTP",
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      child: controller.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Login"),
                    ),
                  ),

                  const SizedBox(height: 15),

                  
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () async{
                        controller.phoneController.text = "01000000000";
                        controller.otpController.text = "123456";
                        await controller.login();
                       controller.isSuccess? Get.offAll(const HomeScreen()): Get.snackbar('error', 'error nav');
                        
                      },
                      child: const Text("Demo Login"),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

