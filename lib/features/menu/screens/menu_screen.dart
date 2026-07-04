import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/features/auth/widgets/auth_dialog_widget.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/language/widgets/language_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/controllers/taxi_cart_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/confirmation_dialog.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/features/menu/widgets/portion_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF181A20) : const Color(0xFFF6F7FB),
      body: GetBuilder<ProfileController>(builder: (profileController) {
        final bool isLoggedIn = AuthHelper.isLoggedIn();

        return Stack(
          children: [
            Column(
              children: [
                // Header
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.95),
                        Theme.of(context).primaryColor.withOpacity(0.65)
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32),
                      bottomRight: Radius.circular(32),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // صورة البروفايل
                      Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 18,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor: isDark ? const Color(0xFF23242A) : Colors.grey.shade100,
                          backgroundImage: (profileController.userInfoModel != null &&
                              isLoggedIn &&
                              (profileController.userInfoModel!.imageFullUrl?.isNotEmpty ?? false))
                              ? NetworkImage(profileController.userInfoModel!.imageFullUrl!)
                              : null,
                          child: (profileController.userInfoModel != null &&
                              isLoggedIn &&
                              (profileController.userInfoModel!.imageFullUrl?.isNotEmpty ?? false))
                              ? null
                              : Image.asset(Images.guestIconLight, width: 36, height: 36),
                        ),

                      ),
                      const SizedBox(width: 22),
                      // الاسم والتاريخ أو تسجيل الدخول
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 30), // ← هذه الجديدة، غيّر الرقم لما يناسبك

                            isLoggedIn && profileController.userInfoModel == null
                                ? Shimmer(
                              child: Container(
                                height: 15,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                                : Text(
                              isLoggedIn
                                  ? '${profileController.userInfoModel?.fName ?? ''} ${profileController.userInfoModel?.lName ?? ''}'
                                  : 'guest_user'.tr,
                              style: robotoBold.copyWith(
                                fontSize: 21,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 7),
                            isLoggedIn && profileController.userInfoModel == null
                                ? Shimmer(
                              child: Container(
                                height: 13,
                                width: 90,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                            )
                                : isLoggedIn
                                ? Text(
                              profileController.userInfoModel != null
                                  ? DateConverter.containTAndZToUTCFormat(profileController.userInfoModel!.createdAt!)
                                  : '',
                              style: robotoMedium.copyWith(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.82),
                              ),
                            )
                                : GestureDetector(
                              onTap: () async {
                                if (!ResponsiveHelper.isDesktop(context)) {
                                  await Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                                  if (AuthHelper.isLoggedIn()) {
                                    profileController.getUserInfo();
                                  }
                                } else {
                                  Get.dialog(const Center(child: AuthDialogWidget(exitFromApp: true, backFromThis: true)));
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.22),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  'login_to_view_all_feature'.tr,
                                  style: robotoMedium.copyWith(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // ---- محتوى القائمة ----
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Column(
                      children: [
                        // مجموعة عام
                        _SectionCard(
                          title: 'general'.tr,
                          children: [
                            PortionWidget(
                                icon: Images.profileIcon,
                                title: 'profile'.tr,
                                route: RouteHelper.getProfileRoute()),
                            PortionWidget(
                                icon: Images.addressIcon,
                                title: 'my_address'.tr,
                                route: RouteHelper.getAddressRoute()),
                            PortionWidget(
                                icon: Images.dog, 
                                title: 'petly'.tr,
                                route: RouteHelper.getPetlyAnimals()),
                            PortionWidget(
                                icon: Images.languageIcon,
                                title: 'language'.tr,
                                hideDivider: true,
                                onTap: () => _manageLanguageFunctionality(),
                                route: ''),
                          ],
                        ),
                        // مجموعة العروض
                        _SectionCard(
                          title: 'promotional_activity'.tr,
                          children: [
                            PortionWidget(
                                icon: Images.couponIcon,
                                title: 'coupon'.tr,
                                route: RouteHelper.getCouponRoute(),
                                hideDivider: Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 ||
                                    Get.find<SplashController>().configModel!.customerWalletStatus == 1
                                    ? false
                                    : true),
                            (Get.find<SplashController>().configModel!.loyaltyPointStatus == 1)
                                ? PortionWidget(
                              icon: Images.pointIcon,
                              title: 'loyalty_points'.tr,
                              route: RouteHelper.getLoyaltyRoute(),
                              hideDivider: Get.find<SplashController>().configModel!.customerWalletStatus == 1 ? false : true,
                              suffix: !isLoggedIn
                                  ? null
                                  : '${profileController.userInfoModel?.loyaltyPoint != null ? profileController.userInfoModel!.loyaltyPoint.toString() : '0'} ${'points'.tr}',
                            )
                                : const SizedBox(),
                            (Get.find<SplashController>().configModel!.customerWalletStatus == 1)
                                ? PortionWidget(
                              icon: Images.walletIcon,
                              title: 'my_wallet'.tr,
                              hideDivider: true,
                              route: RouteHelper.getWalletRoute(),
                              suffix: !isLoggedIn
                                  ? null
                                  : PriceConverter.convertPrice(profileController.userInfoModel != null
                                  ? profileController.userInfoModel!.walletBalance
                                  : 0),
                            )
                                : const SizedBox(),
                          ],
                        ),
                        // مجموعة الأرباح
                        (Get.find<SplashController>().configModel!.refEarningStatus == 1) ||
                            (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context)) ||
                            (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context))
                            ? _SectionCard(
                          title: 'earnings'.tr,
                          children: [
                            (Get.find<SplashController>().configModel!.refEarningStatus == 1)
                                ? PortionWidget(
                              icon: Images.referIcon,
                              title: 'refer_and_earn'.tr,
                              route: RouteHelper.getReferAndEarnRoute(),
                              hideDivider: (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context)) ||
                                  (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context))
                                  ? false
                                  : true,
                            )
                                : const SizedBox(),
                            (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context))
                                ? PortionWidget(
                              icon: Images.dmIcon,
                              title: 'join_as_a_delivery_man'.tr,
                              route: RouteHelper.getDeliverymanRegistrationRoute(),
                              hideDivider: (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context))
                                  ? false
                                  : true,
                            )
                                : const SizedBox(),
                            (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context))
                                ? PortionWidget(
                              icon: Images.storeIcon,
                              title: 'open_vendor'.tr,
                              hideDivider: true,
                              route: RouteHelper.getRestaurantRegistrationRoute(),
                            )
                                : const SizedBox(),
                          ],
                        )
                            : const SizedBox(),
                        // مجموعة الدعم
                        _SectionCard(
                          title: 'help_and_support'.tr,
                          children: [
                            PortionWidget(
                                icon: Images.chatIcon,
                                title: 'live_chat'.tr,
                                route: RouteHelper.getConversationRoute()),
                            PortionWidget(
                                icon: Images.helpIcon,
                                title: 'help_and_support'.tr,
                                route: RouteHelper.getSupportRoute()),
                            PortionWidget(
                                icon: Images.aboutIcon,
                                title: 'about_us'.tr,
                                route: RouteHelper.getHtmlRoute('about-us')),
                            PortionWidget(
                                icon: Images.termsIcon,
                                title: 'terms_conditions'.tr,
                                route: RouteHelper.getHtmlRoute('terms-and-condition')),
                            PortionWidget(
                                icon: Images.privacyIcon,
                                title: 'privacy_policy'.tr,
                                route: RouteHelper.getHtmlRoute('privacy-policy')),
                            (Get.find<SplashController>().configModel!.refundPolicyStatus == 1)
                                ? PortionWidget(
                              icon: Images.refundIcon,
                              title: 'refund_policy'.tr,
                              route: RouteHelper.getHtmlRoute('refund-policy'),
                              hideDivider: (Get.find<SplashController>().configModel!.cancellationPolicyStatus == 1) ||
                                  (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1)
                                  ? false
                                  : true,
                            )
                                : const SizedBox(),
                            (Get.find<SplashController>().configModel!.cancellationPolicyStatus == 1)
                                ? PortionWidget(
                              icon: Images.cancelationIcon,
                              title: 'cancellation_policy'.tr,
                              route: RouteHelper.getHtmlRoute('cancellation-policy'),
                              hideDivider: (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1) ? false : true,
                            )
                                : const SizedBox(),
                            (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1)
                                ? PortionWidget(
                              icon: Images.shippingIcon,
                              title: 'shipping_policy'.tr,
                              hideDivider: true,
                              route: RouteHelper.getHtmlRoute('shipping-policy'),
                            )
                                : const SizedBox(),
                          ],
                        ),
                        const SizedBox(height: 110),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // زر تسجيل الدخول/تسجيل الخروج عائم أسفل الشاشة
            Positioned(
              left: 16,
              right: 16,
              bottom: 60,
              child: SafeArea(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AuthHelper.isLoggedIn() ? Colors.red : Theme.of(context).primaryColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
                  ),
                  icon: Icon(
                    AuthHelper.isLoggedIn() ? Icons.logout : Icons.login,
                    color: Colors.white,
                  ),
                  label: Text(
                    AuthHelper.isLoggedIn() ? 'logout'.tr : 'sign_in'.tr,
                    style: robotoMedium.copyWith(fontSize: 17, color: Colors.white, letterSpacing: 1),
                  ),
                  onPressed: () async {
                    if (AuthHelper.isLoggedIn()) {
                      Get.dialog(
                        ConfirmationDialog(
                          icon: Images.support,
                          description: 'are_you_sure_to_logout'.tr,
                          isLogOut: true,
                          onYesPressed: () async {
                            Get.find<ProfileController>().clearUserInfo();
                            Get.find<AuthController>().socialLogout();
                            Get.find<CartController>().clearCartList(canRemoveOnline: false);
                            Get.find<FavouriteController>().removeFavourite();
                            await Get.find<AuthController>().clearSharedData();
                            Get.find<HomeController>().forcefullyNullCashBackOffers();
                            Get.find<TaxiCartController>().getCarCartList();
                            Get.offAllNamed(RouteHelper.getInitialRoute());
                          },
                        ),
                        useSafeArea: false,
                      );
                    } else {
                      Get.find<FavouriteController>().removeFavourite();
                      await Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                      if (AuthHelper.isLoggedIn()) {
                        await Get.find<FavouriteController>().getFavouriteList();
                        profileController.getUserInfo();
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  _manageLanguageFunctionality() {
    Get.find<LocalizationController>().saveCacheLanguage(null);
    Get.find<LocalizationController>().searchSelectedLanguage();

    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      context: Get.context!,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radiusExtraLarge),
          topRight: Radius.circular(Dimensions.radiusExtraLarge),
        ),
      ),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: const LanguageBottomSheetWidget(),
        );
      },
    ).then((value) => Get.find<LocalizationController>().setLanguage(Get.find<LocalizationController>().getCacheLocaleFromSharedPref()));
  }
}

// ويدجت كارت لكل قسم
class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 19, top: 2),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF22242A) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.grey.withOpacity(0.10),
            blurRadius: 24,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: robotoMedium.copyWith(
              fontSize: 16,
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 7),
          ...children,
        ],
      ),
    );
  }
}
