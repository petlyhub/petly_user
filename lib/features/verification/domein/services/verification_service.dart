import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/common/models/response_model.dart';
import 'package:sixam_mart/features/auth/domain/models/auth_response_model.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/auth_repository_interface.dart';
import 'package:sixam_mart/features/verification/domein/models/verification_data_model.dart';
import 'package:sixam_mart/features/verification/domein/reposotories/verification_repository_interface.dart';
import 'package:sixam_mart/features/verification/domein/services/verification_service_interface.dart';

class VerificationService implements VerificationServiceInterface {
  final VerificationRepositoryInterface verificationRepoInterface;
  final AuthRepositoryInterface authRepoInterface;

  VerificationService({required this.verificationRepoInterface, required this.authRepoInterface});

  @override
  Future<ResponseModel> forgetPassword({String? phone, String? email}) async {
    return await verificationRepoInterface.forgetPassword(phone: phone, email: email);
  }

  @override
  Future<ResponseModel> resetPassword({String? resetToken, String? phone, String? email, required String password, required String confirmPassword}) async {
    return await verificationRepoInterface.resetPassword(resetToken: resetToken, phone: phone, email: email, password: password, confirmPassword: confirmPassword);
  }

  @override
  Future<ResponseModel> verifyPhone(VerificationDataModel data) async {
    Response response = await verificationRepoInterface.verifyPhone(data);
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      AuthResponseModel authResponse = AuthResponseModel.fromJson(response.body);
      print("LOGIN STARTED");
      print("RAW RESPONSE = ${response.body}");
      print("STATUS = ${response.statusCode}");
      print("TYPE = ${response.body.runtimeType}");
      print("BODY = ${response.body}");

      final data = response.body;

      final token = data['token'];

      print("TOKEN = $token");

      final decodedToken = JwtDecoder.decode(token);

      print("DECODED TOKEN = $decodedToken");

      final userId = decodedToken['sub'];

      print("USER ID = $userId");

      final prefs = await SharedPreferences.getInstance();

      await prefs.setInt(
        'user_id',
        int.parse(userId.toString()),
      );

      print("SAVED USER ID = ${prefs.getInt('user_id')}");
      if(authResponse.isExistUser == null && authResponse.isPersonalInfo!) {
        authRepoInterface.saveUserToken(authResponse.token ?? '');
        await authRepoInterface.updateToken();
        authRepoInterface.clearSharedPrefGuestId();
      }
      responseModel = ResponseModel(true, authResponse.token??'', authResponseModel: authResponse);
    } else {
      responseModel = ResponseModel(false, response.statusText);
    }
    return responseModel;
  }

  @override
  Future<ResponseModel> verifyToken({String? phone, String? email, required String token}) async {
    return await verificationRepoInterface.verifyToken(phone: phone, email: email, token: token);
  }

  @override
  Future<ResponseModel> verifyFirebaseOtp({required String phoneNumber, required String session, required String otp, required String loginType, required String? token, required bool isSignUpPage, required bool isForgetPassPage}) async {
    ResponseModel responseModel = ResponseModel(false, '');
    if(isForgetPassPage) {
      responseModel = await verificationRepoInterface.verifyForgetPassFirebaseOtp(phoneNumber: phoneNumber, session: session, otp: otp);
    } else {
      responseModel = await verificationRepoInterface.verifyFirebaseOtp(phoneNumber: phoneNumber, session: session, otp: otp, loginType: loginType);
      if(responseModel.isSuccess && responseModel.authResponseModel != null && responseModel.authResponseModel!.token != null) {
        authRepoInterface.saveUserToken(responseModel.authResponseModel!.token!);
        await authRepoInterface.updateToken();
        authRepoInterface.clearSharedPrefGuestId();
      }
    }
    return responseModel;
  }

}