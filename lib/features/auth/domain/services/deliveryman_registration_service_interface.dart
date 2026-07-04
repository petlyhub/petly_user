import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/location/domain/models/zone_data_model.dart';
import 'package:sixam_mart/features/auth/domain/models/delivery_man_body.dart';
import 'package:sixam_mart/features/auth/domain/models/delivery_man_vehicles_model.dart';

abstract class DeliverymanRegistrationServiceInterface{
  Future<List<ZoneDataModel>?> getZoneList();
  Future<List<ModuleModel>?> getModules(int? zoneId);
  int? prepareSelectedZoneIndex(List<int>? zoneIds, List<ZoneDataModel>? zoneList);
  Future<List<DeliveryManVehicleModel>?> getVehicleList();
  List<int?>? prepareVehicleIds(List<DeliveryManVehicleModel>? vehicleList);
  Future<void> registerDeliveryMan(DeliveryManBody deliveryManBody, List<MultipartBody> multiParts);
 // List<MultipartBody> prepareMultipart(XFile? pickedImage, List<XFile> pickedIdentities);
  List<MultipartBody> buildMultipart({
  XFile? profileImage,
  List<XFile> identityImages = const [],
  List<XFile> cardDriverImages = const [],
  List<XFile> criminalImages = const [],
  List<XFile> licenseImages = const [],
  List<XFile> vehicleImages = const [],
  List<XFile> typeImages = const [],
  
}) {
  List<MultipartBody> parts = [];

  // profile
  if (profileImage != null) {
    parts.add(MultipartBody('image', profileImage));
  }

  // identity
  for (var file in identityImages) {
    parts.add(MultipartBody('identity_image[]', file));
  }

  // license
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