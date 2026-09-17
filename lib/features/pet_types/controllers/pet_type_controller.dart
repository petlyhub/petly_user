import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sixam_mart/features/pet_types/domain/models/pet_type_model.dart';
import 'package:sixam_mart/features/pet_types/domain/repository/pet_type_repository.dart';


class PetTypeController extends GetxController implements GetxService {
  final PetTypeRepository petTypeRepository;
  PetTypeController({required this.petTypeRepository});

  List<PetTypeModel>? _petTypeList;
  List<PetTypeModel>? get petTypeList => _petTypeList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    getPetTypeList();
  }

  Future<void> getPetTypeList() async {
    _isLoading = true;
    update();

    try {
      _petTypeList = await petTypeRepository.fetchPetTypes();
    } catch (e) {
      print("Error fetching pet types: $e");
    }

    _isLoading = false;
    update();
  }
}