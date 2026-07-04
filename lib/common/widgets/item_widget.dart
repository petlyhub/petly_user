import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/cart_count_view.dart';
import 'package:sixam_mart/common/widgets/custom_favourite_widget.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/organic_tag.dart';
import 'package:sixam_mart/common/widgets/not_available_widget.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class ItemWidget extends StatelessWidget {
  final Item? item;
  final Store? store;
  final bool isStore;
  final int index;
  final int? length;
  final bool inStore;
  final bool isCampaign;
  final bool isFeatured;
  final bool fromCartSuggestion;
  final double? imageHeight;
  final double? imageWidth;
  final bool? isCornerTag;

  const ItemWidget({
    super.key,
    required this.item,
    required this.isStore,
    required this.store,
    required this.index,
    required this.length,
    this.inStore = false,
    this.isCampaign = false,
    this.isFeatured = false,
    this.fromCartSuggestion = false,
    this.imageHeight,
    this.imageWidth,
    this.isCornerTag = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool ltr = Get.find<LocalizationController>().isLtr;
    bool desktop = ResponsiveHelper.isDesktop(context);
    double? discount;
    String? discountType;
    bool isAvailable;
    String genericName = '';

    if (!isStore && item!.genericName != null && item!.genericName!.isNotEmpty) {
      for (String name in item!.genericName!) {
        genericName += name;
      }
    }
    if (isStore) {
      discount = store!.discount != null ? store!.discount!.discount : 0;
      discountType = store!.discount != null ? store!.discount!.discountType : 'percent';
      isAvailable = store!.open == 1 && store!.active!;
    } else {
      discount = (item!.storeDiscount == 0 || isCampaign) ? item!.discount : item!.storeDiscount;
      discountType = (item!.storeDiscount == 0 || isCampaign) ? item!.discountType : 'percent';
      isAvailable = DateConverter.isAvailable(item!.availableTimeStarts, item!.availableTimeEnds);
    }

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {
        if (isStore) {
          if (store != null) {
            if (isFeatured && Get.find<SplashController>().moduleList != null) {
              for (var module in Get.find<SplashController>().moduleList!) {
                if (module.id == store!.moduleId) {
                  Get.find<SplashController>().setModule(module);
                  break;
                }
              }
            }
            Get.toNamed(
              RouteHelper.getStoreRoute(id: store!.id, page: isFeatured ? 'module' : 'item'),
              arguments: store,
            );
          }
        } else {
          if (isFeatured && Get.find<SplashController>().moduleList != null) {
            for (var module in Get.find<SplashController>().moduleList!) {
              if (module.id == item!.moduleId) {
                Get.find<SplashController>().setModule(module);
                break;
              }
            }
          }
          Get.find<ItemController>().navigateToItemPage(item, context,
              inStore: inStore, isCampaign: isCampaign);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.08),
              blurRadius: 18,
              spreadRadius: 0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // الصورة والوسوم
            Stack(
              children: [
                // صورة العنصر
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomImage(
                    image: isStore
                        ? store?.logoFullUrl ?? ''
                        : item?.imageFullUrl ?? '',
                    height: imageHeight ?? 90,
                    width: imageWidth ?? 90,
                    fit: BoxFit.cover,
                  ),
                ),

                // وسم الخصم
                if (discount! > 0)
                  Positioned(
                    top: 8,
                    left: ltr ? 8 : null,
                    right: ltr ? null : 8,
                    child: DiscountTag(
                      discount: discount,
                      discountType: discountType,
                      freeDelivery: isStore ? store!.freeDelivery : false,
                    ),
                  ),

                // وسم "حلال" أو "منتج عضوي"
                if (!isStore && item!.isStoreHalalActive! && item!.isHalalItem!)
                  Positioned(
                    bottom: 8,
                    right: ltr ? 8 : null,
                    left: ltr ? null : 8,
                    child: const CustomAssetImageWidget(
                      Images.halalTag,
                      height: 19,
                      width: 19,
                    ),
                  ),

                if (!isStore && item!.organic == 1)
                  Positioned(
                    bottom: 8,
                    left: ltr ? 8 : null,
                    right: ltr ? null : 8,
                    child: OrganicTag(item: item!, placeInImage: true),
                  ),

                // زر المفضلة
                Positioned(
                  top: 8,
                  right: ltr ? 8 : null,
                  left: ltr ? null : 8,
                  child: GetBuilder<FavouriteController>(builder: (favouriteController) {
                    bool isWished = isStore
                        ? favouriteController.wishStoreIdList.contains(store!.id)
                        : favouriteController.wishItemIdList.contains(item!.id);
                    return CustomFavouriteWidget(
                      isWished: isWished,
                      isStore: isStore,
                      store: store,
                      item: item,
                    );
                  }),
                ),

                // "غير متاح"
                if (!isAvailable)
                  Positioned.fill(
                    child: NotAvailableWidget(isStore: isStore),
                  ),
              ],
            ),

            // بيانات المنتج/المتجر
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // الاسم والسعر
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            isStore ? store!.name! : item!.name!,
                            style: robotoBold.copyWith(fontSize: 17),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        // السعر/الخصم
                        !isStore
                            ? Row(
                          children: [
                            Text(
                              PriceConverter.convertPrice(item!.price,
                                  discount: discount, discountType: discountType),
                              style: robotoBold.copyWith(
                                  fontSize: 16, color: Theme.of(context).primaryColor),
                            ),
                            if (discount > 0)
                              Padding(
                                padding: const EdgeInsets.only(left: 5.0),
                                child: Text(
                                  PriceConverter.convertPrice(item!.price),
                                  style: robotoRegular.copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 13,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                              ),
                          ],
                        )
                            : SizedBox(),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // اسم المتجر أو العنوان
                    if (isStore && store?.address != null)
                      Text(
                        store!.address!,
                        style: robotoRegular.copyWith(
                            fontSize: 13, color: Theme.of(context).hintColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    if (!isStore && item!.storeName != null)
                      Text(
                        item!.storeName!,
                        style: robotoRegular.copyWith(
                            fontSize: 13, color: Theme.of(context).hintColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    // الاسم الجنريك إذا وُجد
                    if (genericName.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          genericName,
                          style: robotoRegular.copyWith(
                            fontSize: 13,
                            color: Theme.of(context).disabledColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    // التقييم
                    Row(
                      children: [
                        Icon(Icons.star_rounded,
                            color: Colors.amber[700], size: 17),
                        const SizedBox(width: 2),
                        Text(
                          isStore
                              ? (store!.avgRating ?? 0).toStringAsFixed(1)
                              : (item!.avgRating ?? 0).toStringAsFixed(1),
                          style: robotoMedium.copyWith(fontSize: 13),
                        ),
                        Text(
                          " (${isStore ? store!.ratingCount : item!.ratingCount})",
                          style: robotoRegular.copyWith(
                              color: Theme.of(context).hintColor, fontSize: 12),
                        ),
                        const Spacer(),
                        // زر السلة (CartCount)
                        if (!isStore)
                          CartCountView(item: item!, index: index),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
