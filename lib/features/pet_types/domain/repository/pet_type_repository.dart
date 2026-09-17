import 'package:get/get.dart';
import 'package:sixam_mart/util/app_constants.dart';
import '../models/pet_type_model.dart';

class PetTypeRepository extends GetxService {
  final GetConnect _connect = GetConnect();

  Future<List<PetTypeModel>> fetchPetTypes() async {
    final response = await _connect.get('${AppConstants.baseUrl}${AppConstants.getPetTypes}');
    
    if (response.status.hasError) {
      throw Exception('Failed to fetch data: ${response.statusText}');
    }

    final List data = response.body['data'];
    return data.map((e) => PetTypeModel.fromJson(e)).toList();
  }
}