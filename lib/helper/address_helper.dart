import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/util/app_constants.dart';

class AddressHelper {

 static Future<bool> saveUserAddressInSharedPref(AddressModel address) async {
  SharedPreferences sharedPreferences = Get.find<SharedPreferences>();

  final lat = address.latitude;
  final lng = address.longitude;

  if (lat == null || lng == null) {
    debugPrint("❌ Cannot save address with null coordinates");
    return false;
  }

  final safeAddress = address.toJson();
  safeAddress['latitude'] = lat;
  safeAddress['longitude'] = lng;

  print('ADDRESS BEFORE SAVE => $safeAddress');

  Get.find<ApiClient>().updateHeader(
    sharedPreferences.getString(AppConstants.token),
    address.zoneIds,
    [],
    sharedPreferences.getString(AppConstants.languageCode),
    Get.find<SplashController>().module?.id,
    lat,
    lng,
  );

  return await sharedPreferences.setString(
    AppConstants.userAddress,
    jsonEncode(safeAddress),
  );
}
 static AddressModel? getUserAddressFromSharedPref() {
  SharedPreferences sharedPreferences = Get.find<SharedPreferences>();

  try {
    final addressJson =
        sharedPreferences.getString(AppConstants.userAddress);

    if (addressJson == null || addressJson.isEmpty) {
      return null;
    }

    final data = jsonDecode(addressJson);

    if (data['latitude'] == null || data['longitude'] == null) {
      debugPrint("❌ Corrupted address data");
      return null;
    }

    return AddressModel.fromJson(data);
  } catch (e) {
    debugPrint('Address Catch exception : $e');
    return null;
  }
}

  static bool clearAddressFromSharedPref() {
    SharedPreferences sharedPreferences = Get.find<SharedPreferences>();
    sharedPreferences.remove(AppConstants.userAddress);
    return true;
  }

}