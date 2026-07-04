import 'dart:convert';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/common/models/pet_model.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/util/app_constants.dart';

class PetController extends GetxController {
  List<Pet> pets = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<XFile> _pickedImageDogList = [];

  List<XFile> get pickedImageDogList => _pickedImageDogList;

  List<MultipartBody> buildMultipart({
    List<XFile> dogImage = const [],
  }) {
    List<MultipartBody> parts = [];

    // identity
    for (var file in dogImage) {
      parts.add(MultipartBody('dog_image[]', file));
    }
    return parts;
  }

  void pickDogImage() async {
    final XFile? file =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (file != null) {
      _pickedImageDogList.add(file);
      update();
    }
  }

  // ================= ADD PET =================

  Future<void> addPet(Pet pet, List<MultipartBody> images) async {
    _isLoading = true;
    update();
    print("IMAGES COUNT = ${images.length}");
    print("IMAGES LENGTH = ${images.length}");
    print("FIRST IMAGE PATH = ${images.first.file}");
    print("FIRST IMAGE PATH = ${images.first.key}");
    String? token = Get.find<AuthController>().getUserToken();

    var uri = Uri.parse('${AppConstants.baseUrl}/api/v1/pets/store');

    try {
      var request = http.MultipartRequest('POST', uri);

      // headers
      request.headers.addAll({
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      });

      // body (pet data)
      pet.toJson().forEach((key, value) {
        request.fields[key] = value.toString();
      });

      // images
      for (MultipartBody multipart in images) {
        if (multipart.file != null) {
          Uint8List bytes = await multipart.file!.readAsBytes();

          request.files.add(
            http.MultipartFile.fromBytes(
              multipart.key,
              bytes,
              filename: multipart.file!.name,
            ),
          );
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print(response.body);

      if (response.statusCode == 200) {
        showCustomSnackBar('تم اضافه الحيوان بنجاح');
      } else {
        showCustomSnackBar('حصل خطا');
      }
    } catch (e) {
      print(e);
      showCustomSnackBar('Error: $e');
    }

    _isLoading = false;
    update();
  }

  List<Pet>? _petList; // أو أياً كان اسم القائمة عندك
  List<Pet>? get petList => _petList;

  void clearPetList() {
    _petList = []; // تصفير القائمة
    update(); // تحديث الواجهات التي تستمع للـ Controller (GetBuilder)
  }
  // ================= GET PETS =================

  Future<void> getPets(int userId) async {
    _isLoading = true;

    update();

    try {
      final response = await http.get(
        Uri.parse(
          '${AppConstants.baseUrl}/api/v1/pets/apiIndex/$userId',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        pets = (data['data'] as List).map((e) => Pet.fromJson(e)).toList();

        print(pets);
      } else {
        print("ERROR: ${response.body}");
      }
    } catch (e) {
      print("EXCEPTION: $e");
    }

    _isLoading = false;

    update();
  }
}
