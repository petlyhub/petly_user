import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/common/models/pet_model.dart';
import 'package:sixam_mart/features/petly_animals/controllers/pet_controller.dart';
import 'package:sixam_mart/features/petly_animals/widgets/custom_text_field.dart';
import 'package:sixam_mart/util/dimensions.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key}); 

  @override
  State<AddPetScreen> createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController breed = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController image = TextEditingController();
  String selectedType = "cat";
  final formKey = GlobalKey<FormState>();
  List<Map<String, String>> petTypes = [
    {"value": "cat", "label": "قط"},
    {"value": "dog", "label": "كلب"},
    {"value": "bird", "label": "طائر"},
    {"value": "fish", "label": "سمك"},
    {"value": "rodent", "label": "قارض"},
    {"value": "reptile", "label": "زاحف"},
    {"value": "other", "label": "اخر"},
  ];
  // ... باقي الـ Controllers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("إضافة حيوان جديد")),
      body: GetBuilder<PetController>(builder: (petcontroller) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () => petcontroller.pickDogImage(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusDefault),
                                  child: petcontroller
                                          .pickedImageDogList.isNotEmpty
                                      ? GetPlatform.isWeb
                                          ? Image.network(
                                              petcontroller.pickedImageDogList
                                                  .first.path,
                                              width: 150,
                                              height: 120,
                                              fit: BoxFit.cover,
                                            )
                                          : Image.file(
                                              File(petcontroller
                                                  .pickedImageDogList
                                                  .first
                                                  .path),
                                              width: 220,
                                              height: 220,
                                              fit: BoxFit.cover,
                                            )
                                      : SizedBox(
                                          width: double.infinity,
                                          height: 250,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                'assets/image/cover_upload_dog.jpg',
                                                color: Colors.white
                                                    .withOpacity(0.5),
                                                fit: BoxFit.cover,
                                                colorBlendMode:
                                                    BlendMode.modulate,
                                              ),
                                              const SizedBox(
                                                height:
                                                    Dimensions.paddingSizeSmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                ),

                                // 📸 Add button overlay
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  top: 0,
                                  left: 0,
                                  child: Visibility(
                                    visible: true,
                                    child: Center(
                                      child: Container(
                                        margin: const EdgeInsets.all(25),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2, color: Colors.white),
                                          shape: BoxShape.circle,
                                        ),
                                        padding: const EdgeInsets.all(
                                            Dimensions.paddingSizeLarge),
                                        child: const Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                // ❌ Remove button
                                petcontroller.pickedImageDogList.isNotEmpty
                                    ? Positioned(
                                        bottom: -10,
                                        right: -10,
                                        child: InkWell(
                                          onTap: () {
                                            petcontroller.pickedImageDogList
                                                .clear();
                                            petcontroller.update();
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    Theme.of(context).cardColor,
                                                width: 2,
                                              ),
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                            ),
                                            padding: const EdgeInsets.all(
                                                Dimensions
                                                    .paddingSizeExtraSmall),
                                            child: Icon(
                                              Icons.remove,
                                              size: 18,
                                              color:
                                                  Theme.of(context).cardColor,
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text('upload image'),
                    ],
                  ),
                  CustomTextField(
                    controller: name,
                    label: 'pet_name'.tr,
                  ), // استخدام الـ Widget الخاص بك
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: age,
                    isNumber: true,
                    label: "pet_age".tr,
                  ), //
                  const SizedBox(
                    height: 10,
                  ),

                  CustomTextField(
                    controller: breed,
                    label: "pet_breed".tr,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  CustomTextField(
                    controller: description,
                    label: "pet_description".tr,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  DropdownButtonFormField(
                    initialValue: selectedType,
                    items: petTypes.map((type) {
                      return DropdownMenuItem(
                        value: type["value"],
                        child: Text(type["label"]!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                        print("Type Animal $selectedType");
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 2),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      labelText: "pet_type".tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  // ... Dropdown للنوع (cat, dog...)
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                        maximumSize: const Size(double.infinity, 60),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final prefs = await SharedPreferences.getInstance();
                          final userId = prefs.getInt('user_id');
                          print("USER ID = $userId");

                          final pet = Pet(
                            userId: userId,
                            name: name.text,
                            age: int.parse(age.text),
                            type: selectedType,
                            breed: breed.text,
                            description: description.text,
                          );

                          print("PET CREATED FOR USER: $userId");
                          final images = petcontroller.buildMultipart(
                              dogImage: petcontroller.pickedImageDogList);
                          final controller = Get.find<PetController>();
                          await controller.addPet(
                            pet,
                            images,
                          );
                        } else {
                          'من فضلك ادخل باقي الحقول';
                        }
                      },
                      child: const Text("حفظ"),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
