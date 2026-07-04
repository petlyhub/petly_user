import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/enums/user_type_form.dart';
import 'package:sixam_mart/features/auth/controllers/deliveryman_registration_controller.dart';

Widget userTypeDropdown(DeliverymanRegistrationController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      // 🔹 Label فوق
       Text(
        'select_user_type'.tr,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      const SizedBox(height: 6),

      // 🔹 Dropdown
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<UserTypeForm>(
            value: controller.selectedType,
            isExpanded: true,
            hint: const Text("اختر نوع المستخدم"),
            items: UserTypeForm.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                   type.name
                ),
              );
            }).toList(),
            onChanged: (val) {
              controller.setUserType(val!);
            },
          ),
        ),
      ),
    ],
  );
}