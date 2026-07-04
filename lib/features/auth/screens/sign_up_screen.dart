import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/auth/widgets/sign_up_widget.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';

class SignUpScreen extends StatefulWidget {
  final bool exitFromApp;
  const SignUpScreen({super.key, this.exitFromApp = false});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      appBar: (ResponsiveHelper.isDesktop(context)
          ? null
          : !widget.exitFromApp
          ? AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios_rounded,
              color: Theme.of(context).textTheme.bodyLarge!.color),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: const [SizedBox()],
      )
          : null),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: context.width > 700 ? 500 : context.width * 0.9,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16),

                  /// Logo
                  Image.asset(
                    Images.logo,
                    width: 180,
                    height: 60,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 32),

                  /// Title
                  Text(
                    'إنشاء حساب جديد',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),
                  Text(
                    'أدخل بياناتك لإنشاء حساب جديد',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 36),

                  /// Sign Up Form
                  const SignUpWidget(),

                  const SizedBox(height: 24),

                  /// Already have account?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'هل لديك حساب؟',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey[700]),
                      ),
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            color: const Color(0xFFefa65a),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
