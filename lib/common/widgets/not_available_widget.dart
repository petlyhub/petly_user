import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotAvailableWidget extends StatelessWidget {
  final double fontSize;
  final bool isStore;
  final bool isAllSideRound;
  final double? radius;
  final Store? store;
  const NotAvailableWidget({
    super.key,
    this.fontSize = 15,
    this.isStore = false,
    this.isAllSideRound = true,
    this.radius = Dimensions.radiusSmall,
    this.store,
  });

  @override
  Widget build(BuildContext context) {
    final bool isClosed = store?.storeOpeningTime == 'closed';
    final String statusText = isStore
        ? (store != null
        ? (isClosed
        ? 'closed_now'.tr
        : '${'closed_now'.tr} ${!store!.active! ? '' : '(${'open_at'.tr} ${DateConverter.convertRestaurantOpenTime(store!.storeOpeningTime!)})'}')
        : 'closed_now'.tr)
        : 'not_available_now_break'.tr;

    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Align(
      alignment: isRtl ? Alignment.topLeft : Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
        decoration: BoxDecoration(
          color: const Color(0xffFF3A30),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.red.withOpacity(0.10),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.white,
              size: fontSize + 5,
            ),
            const SizedBox(width: 3),
            Flexible(
              child: Text(
                statusText,
                style: robotoMedium.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
