import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/pet_types/controllers/pet_type_controller.dart';
import 'package:sixam_mart/features/pet_types/screens/breeds_details_screen.dart';
import 'package:sixam_mart/features/pet_types/widgets/pet_type_card_widget.dart';

class PetTypeScreen extends StatelessWidget {
  const PetTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PetTypeController>(
      init: Get.find<PetTypeController>(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.petTypeList == null || controller.petTypeList!.isEmpty) {
          return const Center(child: Text('لا توجد بيانات'));
        }

      return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.petTypeList!.length,
          itemBuilder: (context, index) {
            final petType = controller.petTypeList![index];

            return InkWell(
              borderRadius: BorderRadius.circular(50),
              onTap: () {
                // التحقق من وجود breeds تفادياً للأخطاء في حال كانت القائمة فارغة
                if (petType.breeds.isNotEmpty) {
                  Get.to(() => BreedDetailsScreen(
                        breed: petType
                            .breeds.first, // يمرر الفصيلة الأولى افتراضياً
                        petType: petType, // يمرر النوع كاملاً
                      ));
                } else {
                  Get.snackbar(
                    'تنبيه',
                    'لا توجد فصائل مسجلة لهذا النوع حالياً',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: PetTypeCardWidget(petType: petType),
            );
          },
        );
      },
    );
  }
}
