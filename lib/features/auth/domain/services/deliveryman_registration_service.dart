import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/location/domain/models/zone_data_model.dart';
import 'package:sixam_mart/features/auth/domain/models/delivery_man_body.dart';
import 'package:sixam_mart/features/auth/domain/models/delivery_man_vehicles_model.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/auth_repository_interface.dart';
import 'package:sixam_mart/features/auth/domain/reposotories/deliveryman_registration_repository_interface.dart';
import 'package:sixam_mart/features/auth/domain/services/deliveryman_registration_service_interface.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';

class DeliverymanRegistrationService implements DeliverymanRegistrationServiceInterface{
  final DeliverymanRegistrationRepositoryInterface deliverymanRegistrationRepoInterface;
  final AuthRepositoryInterface authRepositoryInterface;
  DeliverymanRegistrationService({required this.deliverymanRegistrationRepoInterface, required this.authRepositoryInterface});

  @override
  Future<List<ZoneDataModel>?> getZoneList() async {
    return await deliverymanRegistrationRepoInterface.getList();
  }

  @override
  Future<List<ModuleModel>?> getModules(int? zoneId) async {
    return await deliverymanRegistrationRepoInterface.getList(isZone: false, zoneId: zoneId);
  }

  @override
  Future<List<DeliveryManVehicleModel>?> getVehicleList() async {
    return await deliverymanRegistrationRepoInterface.getList(isZone: false, isVehicle: true);
  }

  @override
  int? prepareSelectedZoneIndex(List<int>? zoneIds, List<ZoneDataModel>? zoneList) {
    int? selectedZoneIndex = 0;
    for(int index=0; index<zoneList!.length; index++) {
      if(zoneIds!.contains(zoneList[index].id)) {
        selectedZoneIndex = index;
        break;
      }
    }
    return selectedZoneIndex;
  }

  @override
  List<int?>? prepareVehicleIds(List<DeliveryManVehicleModel>? vehicleList) {
    List<int?>? vehicleIds = [];
    vehicleIds.add(0);
    for (var vehicle in vehicleList!) {
      vehicleIds.add(vehicle.id);
    }
    return vehicleIds;
  }

  @override
  Future<void> registerDeliveryMan(DeliveryManBody deliveryManBody, List<MultipartBody> multiParts) async {
    bool success = await deliverymanRegistrationRepoInterface.registerDeliveryMan(deliveryManBody, multiParts);
    if(success) {
      Get.offAllNamed(RouteHelper.getInitialRoute());
      showCustomSnackBar('delivery_man_registration_successful'.tr, isError: false);
    }
  }

  // @override
  // List<MultipartBody> prepareMultipart(XFile? pickedImage, List<XFile> pickedIdentities,List<XFile> pickedLicenses) {
  //   List<MultipartBody> multiParts = [];
  //   multiParts.add(MultipartBody('image', pickedImage));
  //   for(XFile file in pickedIdentities) {
  //     multiParts.add(MultipartBody('identity_image[]', file));
          
  //   }
  //   return multiParts;
  // }

  // @override
  // List<MultipartBody> prepareMultipartLicense(XFile? pickedLicenseimage, List<XFile> pickedLicenses) {
  //   List<MultipartBody> multiParts = [];
  //   multiParts.add(MultipartBody('image', pickedLicenseimage));
  //   for(XFile file in pickedLicenses) {
  //     multiParts.add(MultipartBody('license[]', file));
  //   }
  //   return multiParts;
  // }
  
  @override
List<MultipartBody> buildMultipart({
  XFile? profileImage,
  List<XFile> identityImages = const [],
  List<XFile> licenseImages = const [],
  List<XFile> criminalImages = const [],
  List<XFile> cardDriverImages = const [],
  List<XFile> vehicleImages = const [],
  List<XFile> typeImages = const [],

}) {

  List<MultipartBody> parts = [];

  // 🔹 profile image (single)
  if (profileImage != null) {
    parts.add(MultipartBody('image', profileImage));
  
  }

  // 🔹 identity images (array)
  for (var file in identityImages) {
    parts.add(MultipartBody('identity_image[]', file));
  }

  // 🔹 license images (array)
  for (var file in licenseImages) {
    parts.add(MultipartBody('license[]', file));
  }

  for (var file in cardDriverImages) {
    parts.add(MultipartBody('driver_card[]', file));
  }

  for (var file in criminalImages) {
    parts.add(MultipartBody('criminal_record[]', file));
  }

  for (var file in vehicleImages) {
    parts.add(MultipartBody('vehicle_images[]', file));
  }

  for (var file in typeImages) {
    parts.add(MultipartBody('type_image[]', file));
  }

  return parts;
}


}