
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:sixam_mart/common/enums/user_type_form.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/location/domain/models/zone_data_model.dart';
import 'package:sixam_mart/features/location/domain/models/zone_response_model.dart';
import 'package:sixam_mart/features/auth/domain/models/delivery_man_body.dart';
import 'package:sixam_mart/features/auth/domain/models/delivery_man_vehicles_model.dart';
import 'package:sixam_mart/features/auth/domain/services/deliveryman_registration_service_interface.dart';

class DeliverymanRegistrationController extends GetxController
    implements GetxService {
  final DeliverymanRegistrationServiceInterface
      deliverymanRegistrationServiceInterface;

  DeliverymanRegistrationController(
      {required this.deliverymanRegistrationServiceInterface});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _showPassView = false;
  bool get showPassView => _showPassView;

  XFile? _pickedImage;
  XFile? get pickedImage => _pickedImage;

  XFile? _pickLicenseimage;
  XFile? get pickedLicenseimage => _pickLicenseimage;

  XFile? _pickCardDriverimage;
  XFile? get pickCardDriverimage => _pickCardDriverimage;

  XFile? _pickCriminalmimage;
  XFile? get pickCriminalmimage => _pickCriminalmimage;

 
  List<XFile> _pickedIdentities = [];
  List<XFile> get pickedIdentities => _pickedIdentities;

  List<XFile> _pickedLicenses = [];
  List<XFile> get pickedLicenses => _pickedLicenses;

  List<XFile> _pickedCardDriverlist= [];
  List<XFile> get pickedCardDriverlist => _pickedCardDriverlist;


  List<XFile> _pickedCriminalImagelist= [];
  List<XFile> get pickedCriminalImagelist => _pickedCriminalImagelist;


  XFile? _pickVehiclelmimage;
  XFile? get pickVehiclelmimage => _pickVehiclelmimage;


  XFile? _picktypeimagelmimage;
  XFile? get picktypeimagelmimage => _picktypeimagelmimage;


  List<XFile> _pickedVehicleImagelist= [];
  List<XFile> get pickedVehicleImagelist => _pickedVehicleImagelist;


  List<XFile> _pickedtypeImagelist= [];
  List<XFile> get pickedtypeImagelist => _pickedtypeImagelist;

  double _dmStatus = 0.4;
  double get dmStatus => _dmStatus;

  bool _lengthCheck = false;
  bool get lengthCheck => _lengthCheck;

  bool _numberCheck = false;
  bool get numberCheck => _numberCheck;

  bool _uppercaseCheck = false;
  bool get uppercaseCheck => _uppercaseCheck;

  bool _lowercaseCheck = false;
  bool get lowercaseCheck => _lowercaseCheck;

  bool _spatialCheck = false;
  bool get spatialCheck => _spatialCheck;

  final List<String> _identityTypeList = ['passport', 'driving_license', 'nid'];
  List<String> get identityTypeList => _identityTypeList;
// add code

  int _identityTypeIndex = 0;
  int get identityTypeIndex => _identityTypeIndex;

  int _dmTypeIndex = 0;
  int get dmTypeIndex => _dmTypeIndex;

  List<ZoneDataModel>? _zoneList;
  List<ZoneDataModel>? get zoneList => _zoneList;
  int? _selectedZoneIndex = 0;
  int? get selectedZoneIndex => _selectedZoneIndex;

  List<int>? _zoneIds;
  List<int>? get zoneIds => _zoneIds;

  UserTypeForm selectedType = UserTypeForm.saudi;
  UserTypeForm get getSelectedType => selectedType;


String getIdentityLabel() {
  if (selectedType == UserTypeForm.saudi) {
    return widgetsaudia.toString();
  } else {
    return widgetresident.toString();
  }
  
  
}

get widgetsaudia {
  return 'identity_saudi'.tr;
}

get widgetresident {
  return 'identity_resident'.tr;
}

void setUserType(UserTypeForm type) {
  selectedType = type;
  update();
}
  List<ModuleModel>? _moduleList;
  List<ModuleModel>? get moduleList => _moduleList;

  List<DeliveryManVehicleModel>? _vehicles;
  List<DeliveryManVehicleModel>? get vehicles => _vehicles;

  List<int?>? _vehicleIds;
  List<int?>? get vehicleIds => _vehicleIds;

  final List<String?> _dmTypeList = [
    'select_delivery_type',
    'freelancer',
    'salary_based'
  ];
  List<String?> get dmTypeList => _dmTypeList;

  int? _vehicleIndex = 0;
  int? get vehicleIndex => _vehicleIndex;

  bool _acceptTerms = true;
  bool get acceptTerms => _acceptTerms;

  void showHidePass({bool isUpdate = true}) {
    _showPassView = !_showPassView;
    if (isUpdate) {
      update();
    }
  }

  Future<void> setZoneIndex(int? index, {bool canUpdate = true}) async {
    _selectedZoneIndex = index;
    if (canUpdate) {
      await getModules(zoneList![selectedZoneIndex!].id);
      update();
    }
  }

  void setVehicleIndex(int? index, bool notify) {
    _vehicleIndex = index;
    if (notify) {
      update();
    }
  }

  void removeIdentityImage(int index) {
    _pickedIdentities.removeAt(index);
    update();
  }
  void removeCardDrvierImage(int index) {
    _pickedCardDriverlist.removeAt(index);
    update();
  }

  void removeLicenseImage(int index) {
    _pickedLicenses.removeAt(index);
    update();
  }
  void removeTypeImage(int index) {
    _pickedtypeImagelist.removeAt(index);
    update();
  }

  void removeCriminalImage(int index) {
    _pickedCriminalImagelist.removeAt(index);
    update();
  }
  void removeDriverlImages(int index) {
    _pickedVehicleImagelist.removeAt(index);
    update();
  }

  void pickDmImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickedImage = null;
      _pickedIdentities = [];
    } else {
      if (isLogo) {
        _pickedImage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        XFile? xFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (xFile != null) {
          _pickedIdentities.add(xFile);
        }
      }
      update();
    }
  }

  void pickLiImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickLicenseimage = null;
      _pickedLicenses = [];
    } else {
      if (isLogo) {
        _pickLicenseimage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        XFile? xFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (xFile != null) {
          _pickedLicenses.add(xFile);
        }
      }
      update();
    }
  }

  void pickDrvicerCardImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickCardDriverimage = null;
      _pickedCardDriverlist = [];
    } else {
      if (isLogo) {
        _pickCardDriverimage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        XFile? xFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (xFile != null) {
          _pickedCardDriverlist.add(xFile);
        }
      }
      update();
    }
  }

  void pickCriminalImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickCriminalmimage = null;
      _pickedCriminalImagelist = [];
    } else {
      if (isLogo) {
        _pickCriminalmimage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        XFile? xFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (xFile != null) {
          _pickedCriminalImagelist.add(xFile);
        }
      }
      update();
    }
  }

  void pickvehiclesImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _pickVehiclelmimage = null;
      _pickedVehicleImagelist = [];
    } else {
      if (isLogo) {
        _pickVehiclelmimage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        XFile? xFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (xFile != null) {
          _pickedVehicleImagelist.add(xFile);
        }
      }
      update();
    }
  }

  void picktypeImage(bool isLogo, bool isRemove) async {
    if (isRemove) {
      _picktypeimagelmimage = null;
      _pickedtypeImagelist = [];
    } else {
      if (isLogo) {
        _picktypeimagelmimage =
            await ImagePicker().pickImage(source: ImageSource.gallery);
      } else {
        XFile? xFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        if (xFile != null) {
          _pickedtypeImagelist.add(xFile);
        }
      }
      update();
    }
  }

  
// void pickVehicalsImage(String type) async {
//   final XFile? image =
//       await ImagePicker().pickImage(source: ImageSource.gallery);

//   if (image != null) {
//     if (type == 'front') {
//       frontImage = image;
//     } else if (type == 'side') {
//       sideImage = image;
//     } else if (type == 'back') {
//       backImage = image;
//       _pickedVehicalImagelist.add(image);
//       print('list vehicle $_pickedVehicalImagelist');
//     }
//     update();
//   }
// }

  void removeLiImage() {
    _pickLicenseimage = null;
    update();
  }


  void removeDRImage() {
    _pickCardDriverimage = null;
    update();
  }

  void removeDmImage() {
    _pickedImage = null;
    update();
  }

  void dmStatusChange(double value, {bool isUpdate = true}) {
    _dmStatus = value;
    if (isUpdate) {
      update();
    }
  }

  void validPassCheck(String pass, {bool isUpdate = true}) {
    _lengthCheck = false;
    _numberCheck = false;
    _uppercaseCheck = false;
    _lowercaseCheck = false;
    _spatialCheck = false;

    if (pass.length > 7) {
      _lengthCheck = true;
    }
    if (pass.contains(RegExp(r'[a-z]'))) {
      _lowercaseCheck = true;
    }
    if (pass.contains(RegExp(r'[A-Z]'))) {
      _uppercaseCheck = true;
    }
    if (pass.contains(RegExp(r'[ .!@#$&*~^%]'))) {
      _spatialCheck = true;
    }
    if (pass.contains(RegExp(r'[\d+]'))) {
      _numberCheck = true;
    }
    if (isUpdate) {
      update();
    }
  }

  void setIdentityTypeIndex(String? identityType, bool notify) {
    int index0 = 0;
    for (int index = 0; index < _identityTypeList.length; index++) {
      if (_identityTypeList[index] == identityType) {
        index0 = index;
        break;
      }
    }
    _identityTypeIndex = index0;
    if (notify) {
      update();
    }
  }

  void setDMTypeIndex(int dmType, bool notify) {
    _dmTypeIndex = dmType;
    if (notify) {
      update();
    }
  }

  Future<void> getZoneList() async {
    _selectedZoneIndex = -1;
    _zoneIds = null;
    List<ZoneDataModel>? zones =
        await deliverymanRegistrationServiceInterface.getZoneList();
    if (zones != null) {
      _zoneList = [];
      _zoneList!.addAll(zones);
      _setLocation(LatLng(
        double.parse(
            Get.find<SplashController>().configModel!.defaultLocation!.lat ??
                '0'),
        double.parse(
            Get.find<SplashController>().configModel!.defaultLocation!.lng ??
                '0'),
      ));
      await getModules(_zoneList![0].id);
    }
    update();
  }

  void _setLocation(LatLng location) async {
    ZoneResponseModel response = await Get.find<LocationController>().getZone(
      location.latitude.toString(),
      location.longitude.toString(),
      false,
    );
    if (response.isSuccess && response.zoneIds.isNotEmpty) {
      _zoneIds = response.zoneIds;
      _selectedZoneIndex = deliverymanRegistrationServiceInterface
          .prepareSelectedZoneIndex(_zoneIds, _zoneList);
    } else {
      _zoneIds = null;
    }
    update();
  }

  Future<void> getModules(int? zoneId) async {
    List<ModuleModel>? modules =
        await deliverymanRegistrationServiceInterface.getModules(zoneId);
    if (modules != null) {
      _moduleList = [];
      _moduleList!.addAll(modules);
    }
    update();
  }

  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }

  Future<void> getVehicleList() async {
    List<DeliveryManVehicleModel>? vehicleList =
        await deliverymanRegistrationServiceInterface.getVehicleList();
    if (vehicleList != null) {
      _vehicles = [];
      _vehicles!.addAll(vehicleList);
      _vehicleIds = deliverymanRegistrationServiceInterface
          .prepareVehicleIds(vehicleList);
    }
    update();
  }

  Future<void> registerDeliveryMan(DeliveryManBody deliveryManBody) async {
    _isLoading = true;
    update();

    List<MultipartBody> multiParts = [];

    // identity images
    multiParts.addAll(
      
      deliverymanRegistrationServiceInterface.buildMultipart(
          profileImage: _pickedImage,
          cardDriverImages: _pickedCardDriverlist,
          identityImages: _pickedIdentities,
          criminalImages: _pickedCriminalImagelist,
          licenseImages: _pickedLicenses,
          vehicleImages: _pickedVehicleImagelist,
          typeImages: _pickedtypeImagelist,
          
          ),
    );
  
    // license

    await deliverymanRegistrationServiceInterface.registerDeliveryMan(
        deliveryManBody, multiParts);

    _isLoading = false;
    update();
  }

  void resetDeliveryRegistration() {
    _identityTypeIndex = 0;
    _dmTypeIndex = 0;
    _selectedZoneIndex = -1;
    _pickedImage = null; 
    _pickLicenseimage = null;
    _pickVehiclelmimage= null;
    _pickCardDriverimage = null;
    _pickCriminalmimage = null;
    
    _pickedLicenses = [];
    _pickedCardDriverlist= [];
    _pickedCriminalImagelist = [];
    _pickedVehicleImagelist = [];
    _pickedIdentities = [];
    update();
  }
}

class TextResident extends StatelessWidget {
  const TextResident({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text('upload_identity'.tr);
  }
}
