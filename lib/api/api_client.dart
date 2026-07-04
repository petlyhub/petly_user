import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:sixam_mart/api/api_checker.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/common/models/error_response.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static final String noInternetMessage = 'connection_to_api_server_failed'.tr;
  final int timeoutInSeconds = 40;

  String? token;
  late Map<String, String> _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.token);
    if (kDebugMode) {
      print('Token: $token');
    }
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
    } catch (_) {}
    int? moduleID;
    if (GetPlatform.isWeb &&
        sharedPreferences.containsKey(AppConstants.moduleId)) {
      try {
        moduleID = ModuleModel.fromJson(
                jsonDecode(sharedPreferences.getString(AppConstants.moduleId)!))
            .id;
      } catch (_) {}
    }
    updateHeader(
        token,
        addressModel?.zoneIds ?? [17],
        addressModel?.areaIds,
        sharedPreferences.getString(AppConstants.languageCode),
        moduleID,
        addressModel?.latitude,
        addressModel?.longitude);
  }

  Map<String, String> updateHeader(
    String? token,
    List<int>? zoneIDs,
    List<int>? operationIds,
    String? languageCode,
    int? moduleID,
    String? latitude,
    String? longitude, {
    bool setHeader = true,
  }) {
    Map<String, String> header = {};

    // Module ID
    if (moduleID != null ||
        sharedPreferences.getString(AppConstants.cacheModuleId) != null) {
      header[AppConstants.moduleId] =
          '${moduleID ?? ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.cacheModuleId)!)).id}';
    }

    // Static headers
    header['Content-Type'] = 'application/json; charset=UTF-8';

    // Zone IDs (SAFE)
    if (zoneIDs != null && zoneIDs.isNotEmpty) {
      header[AppConstants.zoneId] = jsonEncode(zoneIDs);
    }

    // Language
    header[AppConstants.localizationKey] =
        languageCode ?? AppConstants.languages[0].languageCode!;

    // Latitude (SAFE)
    if (latitude != null && latitude.isNotEmpty && latitude != 'null') {
      header[AppConstants.latitude] = latitude;
    }

    // Longitude (SAFE)
    if (longitude != null && longitude.isNotEmpty && longitude != 'null') {
      header[AppConstants.longitude] = longitude;
    }

    // Authorization
    if (token != null && token.isNotEmpty) {
      header['Authorization'] = 'Bearer $token';
    }

    if (setHeader) {
      _mainHeaders = header;
    }

    return header;
  }
  // web code 
//   Map<String, String> getCurrentHeaders() {
//   AddressModel? address;

//   try {
//     address = AddressModel.fromJson(
//       jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!),
//     );
//   } catch (_) {}

//   int? moduleId;

//   try {
//     moduleId = Get.find<SplashController>().module?.id;
//   } catch (_) {}

//   return updateHeader(
//     token,
//     address?.zoneIds ?? [17],
//     address?.areaIds,
//     sharedPreferences.getString(AppConstants.languageCode),
//     moduleId,
//     address?.latitude,
//     address?.longitude,
//     setHeader: false,
//   );
// }

  Map<String, String> getHeader() => _mainHeaders;
  // function mobile
  Future<Response> getData(String uri,
      {Map<String, dynamic>? query,
      Map<String, String>? headers,
      bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: ${headers ??  _mainHeaders}');
      }
      http.Response response = await http
          .get(
            Uri.parse(appBaseUrl + uri),
            headers: headers ??  _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
          print("APPBASE URL $appBaseUrl + uri");
      return handleResponse(response, uri, handleError);
    } catch (e) {
      if (kDebugMode) {
        print('------------${e.toString()}');
      }
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  // function web
//   Future<Response> getData(
//   String uri, {
//   Map<String, dynamic>? query,
//   Map<String, String>? headers,
//   bool handleError = true,
// }) async {
//   try {
//     final url = Uri.parse(appBaseUrl + uri).replace(
//       queryParameters: query?.map(
//         (key, value) => MapEntry(key, value.toString()),
//       ),
//     );

//     http.Response response = await http.get(
//       url,
//       headers: headers ?? _mainHeaders,
//     );

//     return handleResponse(response, uri, handleError);
//   } catch (e) {
//     return Response(statusCode: 1, statusText: noInternetMessage);
//   }
// }


  Future<Response> postData(String uri, dynamic body,
      {Map<String, String>? headers,
      int? timeout,
      bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
        print('====> API Body: $body');
      }

      Map<dynamic, dynamic> newBody = {};
      if (body != null) {
        body.forEach((key, value) {
          if (value != null && value.toString().isNotEmpty) {
            newBody.addAll({key: value});
          }
        });
      }

      http.Response response = await http
          .post(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(newBody),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeout ?? timeoutInSeconds));
      print('STATUS CODE => ${response.statusCode}');
      print('RESPONSE => ${response.body}');
      print('URL => ${appBaseUrl + uri}');
      print('HEADERS => $_mainHeaders');
      print('BODY => ${jsonEncode(body)}');
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(
      String uri, Map<String, String> body, List<MultipartBody> multipartBody,
      {Map<String, String>? headers, bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
        print('====> API Body: $body with ${multipartBody.length} picture');
      }
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      request.headers.addAll(headers ?? _mainHeaders);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          Uint8List list = await multipart.file!.readAsBytes();
          request.files.add(http.MultipartFile(
            multipart.key,
            multipart.file!.readAsBytes().asStream(),
            list.length,
            filename: '${DateTime.now().toString()}.png',
          ));
        }
      }
      Map<String, String> newBody = {};
      body.forEach((s, i) {
        if (i.isNotEmpty) {
          newBody.addAll({s: i});
        }
      });
      request.fields.addAll(newBody);
      http.Response response =
          await http.Response.fromStream(await request.send());
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body,
      {Map<String, String>? headers, bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
        print('====> API Body: $body');
      }
      http.Response response = await http
          .put(
            Uri.parse(appBaseUrl + uri),
            body: jsonEncode(body),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri,
      {Map<String, String>? headers, bool handleError = true}) async {
    try {
      if (kDebugMode) {
        print('====> API Call: $uri\nHeader: ${headers ?? _mainHeaders}');
      }
      http.Response response = await http
          .delete(
            Uri.parse(appBaseUrl + uri),
            headers: headers ?? _mainHeaders,
          )
          .timeout(Duration(seconds: timeoutInSeconds));
      return handleResponse(response, uri, handleError);
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(
      http.Response response, String uri, bool handleError) {
    dynamic body;
    try {
      body = jsonDecode(response.body);
    } catch (_) {}
    Response response0 = Response(
      body: body ?? response.body,
      bodyString: response.body.toString(),
      request: Request(
          headers: response.request!.headers,
          method: response.request!.method,
          url: response.request!.url),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (response0.statusCode != 200 &&
        response0.body != null &&
        response0.body is! String) {
      if (response0.body.toString().startsWith('{errors: [{code:')) {
        ErrorResponse errorResponse = ErrorResponse.fromJson(response0.body);
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: errorResponse.errors![0].message);
      } else if (response0.body.toString().startsWith('{message')) {
        response0 = Response(
            statusCode: response0.statusCode,
            body: response0.body,
            statusText: response0.body['message']);
      }
    } else if (response0.statusCode != 200 && response0.body == null) {
      response0 = Response(statusCode: 0, statusText: noInternetMessage);
    }
    if (kDebugMode) {
      print('====> API Response: [${response0.statusCode}] $uri');
      if (!ResponsiveHelper.isWeb() || response.statusCode != 500) {
        print('${response0.body}');
      }
    }
    if (handleError) {
      if (response0.statusCode == 200) {
        return response0;
      } else {
        ApiChecker.checkApi(response0);
        return const Response();
      }
    } else {
      return response0;
    }
  }
}

class MultipartBody {
  String key;
  XFile? file;

  MultipartBody(this.key, this.file);
}
