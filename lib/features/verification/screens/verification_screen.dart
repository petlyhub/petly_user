import 'dart:async';
import 'package:sixam_mart/common/models/response_model.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/features/auth/domain/enum/centralize_login_enum.dart';
import 'package:sixam_mart/features/auth/screens/new_user_setup_screen.dart';
import 'package:sixam_mart/features/auth/widgets/sign_in/existing_user_bottom_sheet.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/profile/domain/models/update_user_model.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/verification/controllers/verification_controller.dart';
import 'package:sixam_mart/features/verification/domein/enum/verification_type_enum.dart';
import 'package:sixam_mart/features/verification/domein/models/verification_data_model.dart';
import 'package:sixam_mart/features/verification/screens/new_pass_screen.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class VerificationScreen extends StatefulWidget {
  final String? number;
  final String? email;
  final bool fromSignUp;
  final String? token;
  final String? password;
  final String loginType;
  final String? firebaseSession;
  final bool fromForgetPassword;
  final UpdateUserModel? userModel;

  const VerificationScreen({
    super.key,
    required this.number,
    required this.password,
    required this.fromSignUp,
    required this.token,
    this.email,
    required this.loginType,
    this.firebaseSession,
    required this.fromForgetPassword,
    this.userModel,
  });

  @override
  VerificationScreenState createState() => VerificationScreenState();
}

class VerificationScreenState extends State<VerificationScreen> {
  String? _number;
  String? _email;
  Timer? _timer;
  int _seconds = 0;
  final ScrollController _scrollController = ScrollController();
  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    Get.find<VerificationController>().updateVerificationCode('', canUpdate: false);

    if (widget.number != null && widget.number!.isNotEmpty) {
      // نحافظ على الشكل الدولي لكن العرض سيكون LTR دائماً
      _number = widget.number!.startsWith('+')
          ? widget.number
          : '+${widget.number!.substring(1, widget.number!.length)}';
    }
    _email = widget.email;

    _startTimer();
    errorController = StreamController<ErrorAnimationType>();
  }

  void _startTimer() {
    _seconds = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _seconds--;
        if (_seconds <= 0) {
          _seconds = 0;
          timer.cancel();
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    errorController.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveHelper.isDesktop(context);
    const double borderWidth = 0.7;

    final String targetText = (_email != null && _email!.isNotEmpty)
        ? _email!
        : (_number ?? '');

    return Scaffold(
      appBar: isDesktop
          ? null
          : CustomAppBar(
        title: (_email != null && _email!.isNotEmpty)
            ? 'email_verification'.tr
            : 'phone_verification'.tr,
      ),
      backgroundColor: isDesktop
          ? Theme.of(context).scaffoldBackgroundColor
          : Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            child: Center(
              child: Container(
                width: context.width > 700 ? 480 : context.width,
                padding: context.width > 700
                    ? const EdgeInsets.all(Dimensions.paddingSizeLarge)
                    : const EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeLarge,
                  vertical: Dimensions.paddingSizeLarge,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: GetBuilder<VerificationController>(
                  builder: (verificationController) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        if (isDesktop)
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () => Get.back(),
                              icon: const Icon(Icons.close),
                            ),
                          ),

                        // Icon
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor.withOpacity(0.06),
                          ),
                          padding: const EdgeInsets.all(18),
                          child: CustomAssetImageWidget(
                            (_email != null && _email!.isNotEmpty)
                                ? Images.emailVerifiedIcon
                                : Images.otpVerification,
                            height: 60,
                            width: 60,
                          ),
                        ),

                        const SizedBox(height: Dimensions.paddingSizeLarge),

                        // Title
                        Text(
                          'otp_verification'.tr,
                          style: robotoBold.copyWith(
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 6),

                        // Underline accent
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),

                        const SizedBox(height: Dimensions.paddingSizeLarge),

                        // Description + target text
                        if (!Get.find<SplashController>().configModel!.demo!)
                          Column(
                            children: [
                              Text(
                                'we_have_a_verification_code'.tr,
                                style: robotoRegular.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: Dimensions.paddingSizeSmall),
                              if (targetText.isNotEmpty)
                                Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(0.04),
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radiusLarge,
                                      ),
                                      border: Border.all(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.35),
                                      ),
                                    ),
                                    child: Text(
                                      targetText,
                                      style: robotoMedium.copyWith(
                                        fontSize: 14,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          )
                        else
                          Text(
                            'for_demo_purpose'.tr,
                            style: robotoMedium.copyWith(
                              color: Theme.of(context).hintColor,
                            ),
                          ),

                        const SizedBox(height: Dimensions.paddingSizeExtraLarge),

                        // OTP label
                        Text(
                          'ادخل رمز التحقق الذي وصلك على الهاتف'.tr,
                          style: robotoRegular.copyWith(
                            color: Theme.of(context).hintColor,
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: Dimensions.paddingSizeDefault),
                      
                      //  OTP Fields (Always LTR)

                        // Pinput(
                        //   length: 6,
                        //   contr: context,
                        //   keyboardType: TextInputType.number,
                        //   animationType: AnimationType.fade,
                          
                        //   textStyle: robotoMedium.copyWith(fontSize: 18),
                        //   cursorColor: Theme.of(context).primaryColor,
                        //   pinTheme: PinTheme(
                        //     shape: PinCodeFieldShape.box,
                        //     fieldHeight: 54,
                        //     fieldWidth: 44,
                        //     borderWidth: borderWidth,
                        //     borderRadius: BorderRadius.circular(
                        //       Dimensions.radiusDefault,
                        //     ),
                        //     selectedColor: Theme.of(context).primaryColor,
                        //     selectedFillColor: Colors.white,
                        //     inactiveFillColor: Theme.of(context).cardColor,
                        //     inactiveColor: Theme.of(context)
                        //         .disabledColor
                        //         .withOpacity(0.4),
                        //     activeColor: hasError
                        //         ? Colors.redAccent
                        //         : Theme.of(context).primaryColor,
                        //     activeFillColor: Theme.of(context).cardColor,
                        //     inactiveBorderWidth: borderWidth,
                        //     selectedBorderWidth: borderWidth,
                        //     disabledBorderWidth: borderWidth,
                        //     errorBorderWidth: borderWidth,
                        //     activeBorderWidth: borderWidth,
                        //   ),
                        //   animationDuration:
                        //   const Duration(milliseconds: 220),
                        //   backgroundColor: Colors.transparent,
                        //   enableActiveFill: true,
                        //   onChanged: (value) {
                        //     if (hasError) {
                        //       setState(() {
                        //         hasError = false;
                        //         errorMessage = '';
                        //       });
                        //     }
                        //     verificationController.updateVerificationCode(value);
                        //   },
                        //   beforeTextPaste: (text) => true,
                        //   errorAnimationController: errorController,
                        //   errorTextSpace: 0,
                        // ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: context.width > 850
                                ? 50
                                : Dimensions.paddingSizeDefault,
                            vertical: Dimensions.paddingSizeSmall,
                          ),
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: PinCodeTextField(
                              length: 6,
                              appContext: context,
                              keyboardType: TextInputType.number,
                              animationType: AnimationType.fade,
                              textStyle: robotoMedium.copyWith(fontSize: 18),
                              cursorColor: Theme.of(context).primaryColor,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                fieldHeight: 54,
                                fieldWidth: 44,
                                borderWidth: borderWidth,
                                borderRadius: BorderRadius.circular(
                                  Dimensions.radiusDefault,
                                ),
                                selectedColor: Theme.of(context).primaryColor,
                                selectedFillColor: Colors.white,
                                inactiveFillColor: Theme.of(context).cardColor,
                                inactiveColor: Theme.of(context)
                                    .disabledColor
                                    .withOpacity(0.4),
                                activeColor: hasError
                                    ? Colors.redAccent
                                    : Theme.of(context).primaryColor,
                                activeFillColor: Theme.of(context).cardColor,
                                inactiveBorderWidth: borderWidth,
                                selectedBorderWidth: borderWidth,
                                disabledBorderWidth: borderWidth,
                                errorBorderWidth: borderWidth,
                                activeBorderWidth: borderWidth,
                              ),
                              animationDuration:
                              const Duration(milliseconds: 220),
                              backgroundColor: Colors.transparent,
                              enableActiveFill: true,
                              onChanged: (value) {
                                if (hasError) {
                                  setState(() {
                                    hasError = false;
                                    errorMessage = '';
                                  });
                                }
                                verificationController.updateVerificationCode(value);
                              },
                              beforeTextPaste: (text) => true,
                              errorAnimationController: errorController,
                              errorTextSpace: 0,
                            ),
                          ),
                        ),

                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                        // Error text
                        if (hasError && errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                            ),
                            child: Text(
                              errorMessage,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                        const SizedBox(height: Dimensions.paddingSizeLarge),

                        // Verify button
                        GetBuilder<ProfileController>(
                          builder: (profileController) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: isDesktop
                                    ? 32
                                    : Dimensions.paddingSizeSmall,
                              ),
                              child: CustomButton(
                                radius: Dimensions.radiusDefault,
                                buttonText: 'verify'.tr,
                                isLoading: verificationController.isLoading ||
                                    profileController.isLoading,
                                onPressed: verificationController
                                    .verificationCode.length <
                                    6
                                    ? null
                                    : () {
                                  _onVerifyPressed(verificationController);
                                },
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: Dimensions.paddingSizeDefault),

                        // Resend row
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: isDesktop
                                ? 20
                                : Dimensions.paddingSizeDefault,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'did_not_receive_the_code'.tr,
                                style: robotoRegular.copyWith(
                                  color: Theme.of(context).hintColor,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 4),
                              TextButton(
                                onPressed: _seconds < 1
                                    ? () async {
                                  if (widget.firebaseSession != null) {
                                    await Get.find<AuthController>()
                                        .firebaseVerifyPhoneNumber(
                                      _number!,
                                      widget.token,
                                      widget.loginType,
                                      fromSignUp: widget.fromSignUp,
                                      canRoute: false,
                                    );
                                    _startTimer();
                                  } else {
                                    _resendOtp();
                                  }
                                }
                                    : null,
                                child: Text(
                                  '${'resent_it'.tr}${_seconds > 0 ? ' (${_seconds}s)' : ''}',
                                  style: TextStyle(
                                    color: _seconds > 0
                                        ? Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.7)
                                        : Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: Dimensions.paddingSizeLarge),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onVerifyPressed(VerificationController verificationController) {
    if (widget.firebaseSession != null && widget.userModel == null) {
      verificationController
          .verifyFirebaseOtp(
        phoneNumber: _number!,
        session: widget.firebaseSession!,
        loginType: widget.loginType,
        otp: verificationController.verificationCode,
        token: widget.token,
        isForgetPassPage: widget.fromForgetPassword,
        isSignUpPage:
        widget.loginType == CentralizeLoginType.otp.name ? false : true,
      )
          .then((value) {
        if (value.isSuccess) {
          _handleVerifyResponse(value, _number, _email);
        } else {
          errorController.add(ErrorAnimationType.shake);
          setState(() {
            hasError = true;
            errorMessage = value.message ?? '';
          });
          showCustomSnackBar(value.message);
        }
      });
    } else if (widget.userModel != null) {
      widget.userModel!.otp = verificationController.verificationCode;
      Get.find<ProfileController>().updateUserInfo(
        widget.userModel!,
        Get.find<AuthController>().getUserToken(),
        fromButton: true,
      );
    } else if (widget.fromSignUp) {
      verificationController
          .verifyPhone(
        data: VerificationDataModel(
          phone: _number,
          email: _email,
          verificationType: _number != null
              ? VerificationTypeEnum.phone.name
              : VerificationTypeEnum.email.name,
          otp: verificationController.verificationCode,
          loginType: widget.loginType,
          guestId: AuthHelper.getGuestId(),
        ),
      )
          .then((value) {
        if (value.isSuccess) {
          _handleVerifyResponse(value, _number, _email);
        } else {
          errorController.add(ErrorAnimationType.shake);
          setState(() {
            hasError = true;
            errorMessage = value.message ?? '';
          });
          showCustomSnackBar(value.message);
        }
      });
    } else {
      Get.find<VerificationController>()
          .verifyToken(phone: _number, email: _email)
          .then((value) {
        if (value.isSuccess) {
          if (ResponsiveHelper.isDesktop(Get.context!)) {
            Get.back();
            Get.dialog(
              Center(
                child: NewPassScreen(
                  resetToken: verificationController.verificationCode,
                  number: _number,
                  email: _email,
                  fromPasswordChange: false,
                  fromDialog: true,
                ),
              ),
            );
          } else {
            Get.toNamed(
              RouteHelper.getResetPasswordRoute(
                phone: _number,
                email: _email,
                token: verificationController.verificationCode,
                page: 'reset-password',
              ),
            );
          }
        } else {
          errorController.add(ErrorAnimationType.shake);
          setState(() {
            hasError = true;
            errorMessage = value.message ?? '';
          });
          showCustomSnackBar(value.message);
        }
      });
    }
  }

  void _handleVerifyResponse(
      ResponseModel response, String? number, String? email) {
    if (response.authResponseModel != null &&
        response.authResponseModel!.isExistUser != null) {
      if (ResponsiveHelper.isDesktop(context)) {
        Get.back();
        Get.dialog(
          Center(
            child: ExistingUserBottomSheet(
              userModel: response.authResponseModel!.isExistUser!,
              number: _number,
              email: _email,
              loginType: widget.loginType,
              otp: Get.find<VerificationController>().verificationCode,
            ),
          ),
        );
      } else {
        Get.bottomSheet(
          ExistingUserBottomSheet(
            userModel: response.authResponseModel!.isExistUser!,
            number: _number,
            email: _email,
            loginType: widget.loginType,
            otp: Get.find<VerificationController>().verificationCode,
          ),
        );
      }
    } else if (response.authResponseModel != null &&
        !response.authResponseModel!.isPersonalInfo!) {
      if (ResponsiveHelper.isDesktop(context)) {
        Get.back();
        Get.dialog(
          NewUserSetupScreen(
            name: '',
            loginType: widget.loginType,
            phone: number,
            email: email,
          ),
        );
      } else {
        Get.toNamed(
          RouteHelper.getNewUserSetupScreen(
            name: '',
            loginType: widget.loginType,
            phone: number,
            email: email,
          ),
        );
      }
    } else {
      if (widget.fromForgetPassword) {
        Get.toNamed(
          RouteHelper.getResetPasswordRoute(
            phone: _number,
            email: _email,
            token: Get.find<VerificationController>().verificationCode,
            page: 'reset-password',
          ),
        ); 
      } else {
        Get.find<LocationController>()
            .navigateToLocationScreen('verification', offNamed: true);
      }
    }
  }

  void _resendOtp() {
    if (widget.userModel != null) {
      Get.find<ProfileController>().updateUserInfo(
        widget.userModel!,
        Get.find<AuthController>().getUserToken(),
        fromVerification: true,
      );
    } else if (widget.fromSignUp) {
      if (widget.loginType == CentralizeLoginType.otp.name) {
        Get.find<AuthController>()
            .otpLogin(
          phone: _number!,
          otp: '',  
          loginType: widget.loginType,
          verified: '',
        )
            .then((response) {
          if (response.isSuccess) {
            _startTimer();
            showCustomSnackBar('resend_code_successful'.tr, isError: false);
          } else {
            showCustomSnackBar(response.message);
          }
        });
      } else {
        Get.find<AuthController>()
            .login(
          emailOrPhone: _number != null ? _number! : _email ?? '',
          password: widget.password!,
          loginType: widget.loginType,
          fieldType: _number != null
              ? VerificationTypeEnum.phone.name
              : VerificationTypeEnum.email.name,
        )
            .then((value) {
          if (value.isSuccess) {
            _startTimer();
            showCustomSnackBar('resend_code_successful'.tr, isError: false);
          } else {
            showCustomSnackBar(value.message);
          }
        });
      }
    } else {
      Get.find<VerificationController>()
          .forgetPassword(phone: _number, email: _email)
          .then((value) {
        if (value.isSuccess) {
          _startTimer();
          showCustomSnackBar('resend_code_successful'.tr, isError: false);
        } else {
          showCustomSnackBar(value.message);
        }
      });
    }
  }
}
