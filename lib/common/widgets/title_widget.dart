import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  final String? subtitle;       // ✅ اختياري
  final Function? onTap;        // ✅ اختياري
  final String? image;          // ✅ اختياري (للتوافق القديم)
  final IconData? icon;         // ✅ اختياري (بديل أكثر عصرية)

  const TitleWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.onTap,
    this.image,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool ltr = Get.find<LocalizationController>().isLtr;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Row: Title + Optional Icon/Image + "See All"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// Title and optional icon/image
              Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Theme.of(context).primaryColor, size: 20),
                    const SizedBox(width: 6),
                  ] else if (image != null) ...[
                    Image.asset(image!, height: 20, width: 20),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    title,
                    style: robotoBold.copyWith(
                      fontSize: ResponsiveHelper.isDesktop(context)
                          ? Dimensions.fontSizeExtraLarge
                          : Dimensions.fontSizeLarge,
                    ),
                  ),
                ],
              ),

              /// Optional: See All button
              if (onTap != null)
                InkWell(
                  onTap: onTap as void Function()?,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'see_all'.tr,
                          style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeSmall,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          ltr ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                          size: 12,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          /// Optional Subtitle
          if (subtitle != null)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                subtitle!,
                style: robotoRegular.copyWith(
                  fontSize: Dimensions.fontSizeExtraSmall,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
