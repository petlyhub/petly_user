import 'package:flutter/cupertino.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/hover/text_hover.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/auth/widgets/auth_dialog_widget.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_dropdown.dart';

class WebMenuBar extends StatelessWidget implements PreferredSizeWidget {
  const WebMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          width: double.infinity,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
          child: Center(
            child: SizedBox(
              width: Dimensions.webMaxWidth,
              child: Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: AddressHelper.getUserAddressFromSharedPref() != null
                        ? InkWell(
                            onTap: () => Get.find<LocationController>()
                                .navigateToLocationScreen('home'),
                            child: Padding(
                              padding: const EdgeInsets.all(
                                  Dimensions.paddingSizeSmall),
                              child: GetBuilder<LocationController>(
                                builder: (locationController) {
                                  final userAddress = AddressHelper
                                      .getUserAddressFromSharedPref();

                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      AuthHelper.isLoggedIn()
                                          ? Icon(
                                              userAddress?.addressType == 'home'
                                                  ? Icons.home_filled
                                                  : userAddress?.addressType ==
                                                          'office'
                                                      ? Icons.work
                                                      : Icons.location_on,
                                              size: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )
                                          : Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                      const SizedBox(
                                        width: Dimensions.paddingSizeExtraSmall,
                                      ),
                                      Text(
                                        '${AuthHelper.isLoggedIn() ? (userAddress?.addressType?.tr ?? 'your_location'.tr) : 'your_location'.tr}: ',
                                        style: robotoMedium.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraSmall,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Flexible(
                                        child: Text(
                                          userAddress?.address ??
                                              'Select location',
                                          style: robotoRegular.copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color,
                                            fontSize: Dimensions.fontSizeSmall,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Icon(Icons.keyboard_arrow_down),
                                    ],
                                  );
                                },
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          child: Center(
              child: SizedBox(
                  width: Dimensions.webMaxWidth,
                  child: Row(children: [
                    InkWell(
                      onTap: () => Get.toNamed(RouteHelper.getInitialRoute()),
                      child: Image.asset(Images.logo, width: 100, height: 50),
                    ),
                    const SizedBox(width: 20),
                    Row(children: [
                      MenuButton(
                          title: 'home'.tr,
                          onTap: () {
                            if (AddressHelper.getUserAddressFromSharedPref() !=
                                null) {
                              Get.toNamed(RouteHelper.getInitialRoute());
                            } else {
                              showCustomSnackBar(
                                'please_select_address_first'.tr,
                              );
                            }
                          }),
                      const SizedBox(width: 20),
                      MenuButton(
                          title: 'categories'.tr,
                          onTap: () {
                            if (AddressHelper.getUserAddressFromSharedPref() !=
                                null) {
                              Get.toNamed(RouteHelper.getCategoryRoute());
                            } else {
                              showCustomSnackBar(
                                'please_select_address_first'.tr,
                              );
                            }
                          }),
                      const SizedBox(width: 20),
                      MenuButton(
                          title: 'favourite'.tr,
                          onTap: () {
                            if (AddressHelper.getUserAddressFromSharedPref() !=
                                null) {
                              Get.toNamed(RouteHelper.getFavouriteScreen());
                            } else {
                              showCustomSnackBar(
                                'please_select_address_first'.tr,
                              );
                            }
                          }),
                      const SizedBox(width: 20),
                      MenuButton(
                          title: 'stores'.tr,
                          onTap: () {
                            if (AddressHelper.getUserAddressFromSharedPref() !=
                                null) {
                              Get.toNamed(
                                  RouteHelper.getAllStoreRoute('popular'));
                            } else {
                              showCustomSnackBar(
                                'please_select_address_first'.tr,
                              );
                            }
                          }),
                      const SizedBox(width: 20),
                    ]),
                    const Expanded(child: SizedBox()),
                    MenuIconButton(
                        icon: CupertinoIcons.search,
                        onTap: () {
                          if (AddressHelper.getUserAddressFromSharedPref() !=
                              null) {
                            Get.toNamed(RouteHelper.getSearchRoute());
                          } else {
                            showCustomSnackBar(
                              'please_select_address_first'.tr,
                            );
                          }
                        }),
                    const SizedBox(width: 20),
                    MenuIconButton(
                        icon: CupertinoIcons.bell_fill,
                        onTap: () {
                          if (AddressHelper.getUserAddressFromSharedPref() !=
                              null) {
                            Get.toNamed(RouteHelper.getNotificationRoute());
                          } else {
                            showCustomSnackBar(
                              'please_select_address_first'.tr,
                            );
                          }
                        }),
                    const SizedBox(width: 20),
                    MenuIconButton(
                        icon: Icons.shopping_cart,
                        isCart: true,
                        onTap: () {
                          if (AddressHelper.getUserAddressFromSharedPref() !=
                              null) {
                            Get.toNamed(RouteHelper.getCartRoute());
                          } else {
                            showCustomSnackBar(
                              'please_select_address_first'.tr,
                            );
                          }
                        }),
                    const SizedBox(width: 20),
                    GetBuilder<AuthController>(builder: (authController) {
                      return InkWell(
                        onTap: () {
                          if (authController.isLoggedIn()) {
                            Get.toNamed(RouteHelper.getProfileRoute());
                          } else {
                            Get.dialog(
                              const Center(
                                  child: AuthDialogWidget(
                                      exitFromApp: false, backFromThis: false)),
                              barrierDismissible: false,
                            );
                          }
                        },
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeLarge),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radiusSmall),
                          ),
                          child: Row(children: [
                            Icon(
                                authController.isLoggedIn()
                                    ? Icons.person_pin_rounded
                                    : Icons.lock_outline,
                                size: 18,
                                color: Get.find<ThemeController>().darkTheme
                                    ? Colors.white
                                    : Colors.black),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                            Text(
                                authController.isLoggedIn()
                                    ? 'profile'.tr
                                    : 'sign_in'.tr,
                                style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    fontWeight: FontWeight.w100)),
                          ]),
                        ),
                      );
                    }),
                    MenuIconButton(
                        icon: Icons.menu,
                        onTap: () {
                          Scaffold.of(context).openEndDrawer();
                        }),
                  ]))),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(Dimensions.webMaxWidth, 100);
}

class MenuButton extends StatelessWidget {
  final String title;
  final Function onTap;
  const MenuButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return InkWell(
        onTap: onTap as void Function()?,
        child: Text(title,
            style: robotoRegular.copyWith(
                color: hovered ? Theme.of(context).primaryColor : null)),
      );
    });
  }
}

class MenuIconButton extends StatelessWidget {
  final IconData icon;
  final bool isCart;
  final Function onTap;
  const MenuIconButton(
      {super.key,
      required this.icon,
      this.isCart = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextHover(builder: (hovered) {
      return IconButton(
        onPressed: onTap as void Function()?,
        icon: GetBuilder<CartController>(builder: (cartController) {
          return Stack(clipBehavior: Clip.none, children: [
            Icon(
              icon,
              color: hovered
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.bodyLarge!.color,
            ),
            (isCart && cartController.cartList.isNotEmpty)
                ? Positioned(
                    top: -5,
                    right: -5,
                    child: Container(
                      height: 15,
                      width: 15,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor),
                      child: Text(
                        cartController.cartList.length.toString(),
                        style: robotoRegular.copyWith(
                            fontSize: 12, color: Theme.of(context).cardColor),
                      ),
                    ),
                  )
                : const SizedBox()
          ]);
        }),
      );
    });
  }
}
