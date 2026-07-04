import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/features/home/controllers/advertisement_controller.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/home/widgets/all_store_filter_widget.dart';
import 'package:sixam_mart/features/home/widgets/cashback_logo_widget.dart';
import 'package:sixam_mart/features/home/widgets/cashback_dialog_widget.dart';
import 'package:sixam_mart/features/home/widgets/refer_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/item/controllers/campaign_controller.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/flash_sale/controllers/flash_sale_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/home/screens/modules/food_home_screen.dart';
import 'package:sixam_mart/features/home/screens/modules/grocery_home_screen.dart';
import 'package:sixam_mart/features/home/screens/modules/pharmacy_home_screen.dart';
import 'package:sixam_mart/features/home/screens/modules/shop_home_screen.dart';
import 'package:sixam_mart/features/parcel/controllers/parcel_controller.dart';
import 'package:sixam_mart/features/rental_module/home/controllers/taxi_home_controller.dart';
import 'package:sixam_mart/features/rental_module/home/screens/taxi_home_screen.dart';
import 'package:sixam_mart/features/rental_module/rental_cart_screen/controllers/taxi_cart_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/paginated_list_view.dart';
import 'package:sixam_mart/common/widgets/web_menu_bar.dart';
import 'package:sixam_mart/features/home/screens/web_new_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/home/widgets/module_view.dart';
import 'package:sixam_mart/features/parcel/screens/parcel_category_screen.dart';

import '../../notification/domain/models/notification_body_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  static Future<void> loadData(bool reload, {bool fromModule = false}) async {
    Get.find<LocationController>().syncZoneData();
    Get.find<FlashSaleController>().setEmptyFlashSale(fromModule: fromModule);
    // print('------------call from home');
    // await Get.find<CartController>().getCartDataOnline();
    if(AuthHelper.isLoggedIn()) {
      Get.find<StoreController>().getVisitAgainStoreList(fromModule: fromModule);
    }
    if(Get.find<SplashController>().module != null && !Get.find<SplashController>().configModel!.moduleConfig!.module!.isParcel! && !Get.find<SplashController>().configModel!.moduleConfig!.module!.isTaxi!) {
      Get.find<BannerController>().getBannerList(reload);
      Get.find<StoreController>().getRecommendedStoreList();
      if(Get.find<SplashController>().module!.moduleType.toString() == AppConstants.grocery) {
        Get.find<FlashSaleController>().getFlashSale(reload, false);
      }
      if(Get.find<SplashController>().module!.moduleType.toString() == AppConstants.ecommerce) {
        Get.find<ItemController>().getFeaturedCategoriesItemList(false, false);
        Get.find<FlashSaleController>().getFlashSale(reload, false);
        Get.find<BrandsController>().getBrandList();
      }
      Get.find<BannerController>().getPromotionalBannerList(reload);
      Get.find<ItemController>().getDiscountedItemList(reload, false, 'all');
      Get.find<CategoryController>().getCategoryList(reload);
      Get.find<StoreController>().getPopularStoreList(reload, 'all', false);
      Get.find<CampaignController>().getBasicCampaignList(reload);
      Get.find<CampaignController>().getItemCampaignList(reload);
      Get.find<ItemController>().getPopularItemList(reload, 'all', false);
      Get.find<StoreController>().getLatestStoreList(reload, 'all', false);
      Get.find<StoreController>().getTopOfferStoreList(reload, false);
      Get.find<ItemController>().getReviewedItemList(reload, 'all', false);
      Get.find<ItemController>().getRecommendedItemList(reload, 'all', false);
      Get.find<StoreController>().getStoreList(1, reload);
      Get.find<AdvertisementController>().getAdvertisementList();
    }
    if(AuthHelper.isLoggedIn()) {
      // Get.find<StoreController>().getVisitAgainStoreList(fromModule: fromModule);
      await Get.find<ProfileController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
      Get.find<CouponController>().getCouponList();
    }
    Get.find<SplashController>().getModules();
    if(Get.find<SplashController>().module == null && Get.find<SplashController>().configModel!.module == null) {
      Get.find<BannerController>().getFeaturedBanner();
      Get.find<StoreController>().getFeaturedStoreList();
      if(AuthHelper.isLoggedIn()) {
        Get.find<AddressController>().getAddressList();
      }
    }
    if(Get.find<SplashController>().module != null && Get.find<SplashController>().configModel!.moduleConfig!.module!.isParcel!) {
      Get.find<ParcelController>().getParcelCategoryList();
    }
    if(Get.find<SplashController>().module != null && Get.find<SplashController>().module!.moduleType.toString() == AppConstants.pharmacy) {
      Get.find<ItemController>().getBasicMedicine(reload, false);
      Get.find<StoreController>().getFeaturedStoreList();
      await Get.find<ItemController>().getCommonConditions(false);
      if(Get.find<ItemController>().commonConditions!.isNotEmpty) {
        Get.find<ItemController>().getConditionsWiseItem(Get.find<ItemController>().commonConditions![0].id!, false);
      }
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool searchBgShow = false;
  final GlobalKey _headerKey = GlobalKey();
  final profileController = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    HomeScreen.loadData(false).then((value) {
      Get.find<SplashController>().getReferBottomSheetStatus();

      if((Get.find<ProfileController>().userInfoModel?.isValidForDiscount??false) && Get.find<SplashController>().showReferBottomSheet) {
        _showReferBottomSheet();
      }
    });

    // if(!ResponsiveHelper.isWeb()) {
    //   Get.find<LocationController>().getZone(
    //       AddressHelper.getUserAddressFromSharedPref()!.latitude,
    //       AddressHelper.getUserAddressFromSharedPref()!.longitude, false, updateInAddress: true
    //   );
    // }

    _scrollController.addListener(() {
      if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(Get.find<HomeController>().showFavButton){
          Get.find<HomeController>().changeFavVisibility();
          Future.delayed(const Duration(milliseconds: 800), () => Get.find<HomeController>().changeFavVisibility());
        }
      }else {
        if(Get.find<HomeController>().showFavButton){
          Get.find<HomeController>().changeFavVisibility();
          Future.delayed(const Duration(milliseconds: 800), () => Get.find<HomeController>().changeFavVisibility());
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _showReferBottomSheet() {
    ResponsiveHelper.isDesktop(context) ? Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
        insetPadding: const EdgeInsets.all(22),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const ReferBottomSheetWidget(),
      ),
      useSafeArea: false,
    ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false))
        : showModalBottomSheet(
      isScrollControlled: true, useRootNavigator: true, context: Get.context!,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusExtraLarge), topRight: Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: const ReferBottomSheetWidget(),
        );
      },
    ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false));
  }

  Future<void> loadTaxiApis() async{
   await Get.find<TaxiHomeController>().getTaxiBannerList(true);
   await Get.find<TaxiHomeController>().getTopRatedCarList(1, true);
    if (AuthHelper.isLoggedIn()) {
      await Get.find<AddressController>().getAddressList();
      await Get.find<TaxiHomeController>().getTaxiCouponList(true);
      await Get.find<TaxiCartController>().getCarCartList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      if(splashController.moduleList != null && splashController.moduleList!.length == 1) {
        splashController.switchModule(0, true);
      }
      bool showMobileModule = !ResponsiveHelper.isDesktop(context) && splashController.module == null && splashController.configModel!.module == null;
      // bool isParcel = splashController.module != null && splashController.configModel!.moduleConfig!.module!.isParcel!;
      bool isParcel = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.parcel;
      bool isPharmacy = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.pharmacy;
      bool isFood = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.food;
      bool isShop = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.ecommerce;
      bool isGrocery = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.grocery;
      bool isTaxi = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.taxi;

      return GetBuilder<HomeController>(builder: (homeController) {
        return Scaffold(
          appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
          endDrawer: const MenuDrawer(),
          endDrawerEnableOpenDragGesture: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: isParcel ? const ParcelCategoryScreen() : SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                splashController.setRefreshing(true);
                if (Get.find<SplashController>().module != null && !isTaxi) {
                  await Get.find<LocationController>().syncZoneData();
                  await Get.find<BannerController>().getBannerList(true);
                  if (isGrocery) {
                    await Get.find<FlashSaleController>().getFlashSale(true, true);
                  }
                  await Get.find<BannerController>().getPromotionalBannerList(true);
                  await Get.find<ItemController>().getDiscountedItemList(true, false, 'all');
                  await Get.find<CategoryController>().getCategoryList(true);
                  await Get.find<StoreController>().getPopularStoreList(true, 'all', false);
                  await Get.find<CampaignController>().getItemCampaignList(true);
                  Get.find<CampaignController>().getBasicCampaignList(true);
                  await Get.find<ItemController>().getPopularItemList(true, 'all', false);
                  await Get.find<StoreController>().getLatestStoreList(true, 'all', false);
                  await Get.find<StoreController>().getTopOfferStoreList(true, false);
                  await Get.find<ItemController>().getReviewedItemList(true, 'all', false);
                  await Get.find<StoreController>().getStoreList(1, true);
                  Get.find<AdvertisementController>().getAdvertisementList();
                  if (AuthHelper.isLoggedIn()) {
                    await Get.find<ProfileController>().getUserInfo();
                    await Get.find<NotificationController>().getNotificationList(true);
                    Get.find<CouponController>().getCouponList();
                  }
                  if (isPharmacy) {
                    Get.find<ItemController>().getBasicMedicine(true, true);
                    Get.find<ItemController>().getCommonConditions(true);
                  }
                  if (isShop) {
                    await Get.find<FlashSaleController>().getFlashSale(true, true);
                    Get.find<ItemController>().getFeaturedCategoriesItemList(true, true);
                    Get.find<BrandsController>().getBrandList();
                  }
                } else if(isTaxi) {
                  await loadTaxiApis();
                } else {
                  await Get.find<BannerController>().getFeaturedBanner();
                  await Get.find<SplashController>().getModules();
                  if (AuthHelper.isLoggedIn()) {
                    await Get.find<AddressController>().getAddressList();
                  }
                  await Get.find<StoreController>().getFeaturedStoreList();
                }
                splashController.setRefreshing(false);
              },
              child: ResponsiveHelper.isDesktop(context) ? WebNewHomeScreen(
                scrollController: _scrollController,
              ) : CustomScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [





                SliverAppBar(
                floating: true,
                pinned: true,
                elevation: 0,
                backgroundColor: Theme.of(context).colorScheme.surface,
                surfaceTintColor: Theme.of(context).colorScheme.surface,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(
                    children: [

                      // === زر التبديل بين الموديولات ===
                      if (splashController.module != null &&
                          splashController.configModel!.module == null &&
                          splashController.moduleList != null &&
                          splashController.moduleList!.length != 1)
                        InkWell(
                          onTap: () {
                            splashController.removeModule();
                            Get.find<StoreController>().resetStoreData();
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(Icons.grid_view_rounded, color: Theme.of(context).primaryColor),
                          ),
                        ),

                      if (splashController.module != null &&
                          splashController.configModel!.module == null &&
                          splashController.moduleList != null &&
                          splashController.moduleList!.length != 1)
                        const SizedBox(width: Dimensions.paddingSizeSmall),

                      // === الموقع الحالي (عنوان + نص فرعي) ===
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => Get.find<LocationController>().navigateToLocationScreen('home'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: GetBuilder<LocationController>(builder: (locationController) {
                              final address = AddressHelper.getUserAddressFromSharedPref();
                              return Row(
                                children: [
                                  Icon(Icons.location_on, size: 18, color: Theme.of(context).primaryColor),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          AuthHelper.isLoggedIn()
                                              ? address?.addressType?.tr ?? 'your_location'.tr
                                              : 'your_location'.tr,
                                          style: robotoMedium.copyWith(
                                            fontSize: 13,
                                            color: Theme.of(context).textTheme.bodyLarge!.color,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          address?.address ?? '',
                                          style: robotoRegular.copyWith(
                                            fontSize: 11,
                                            color: Theme.of(context).disabledColor,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Theme.of(context).disabledColor),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),

                      const SizedBox(width: Dimensions.paddingSizeSmall),

                      // === الإشعارات ===
                      InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
                        child: GetBuilder<NotificationController>(builder: (notificationController) {
                          return Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.black87.withOpacity(0.08),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(CupertinoIcons.bell, size: 20, color: Colors.black87),
                              ),
                              if (notificationController.hasNotification)
                                Positioned(
                                  top: 6,
                                  right: 6,
                                  child: Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 1),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }),
                      ),

                      const SizedBox(width: Dimensions.paddingSizeSmall),


                      // === زر الدعم الفني ===
                      InkWell(
                        borderRadius: BorderRadius.circular(40),
                        onTap: () => Get.toNamed(RouteHelper.getChatRoute(notificationBody: NotificationBodyModel(
                          notificationType: NotificationType.message, adminId: 0,
                        ))),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black87.withOpacity(0.08),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.headset_mic_rounded, size: 20, color: Colors.black87),
                        ),
                      ),


                      if (AuthHelper.isLoggedIn()) ...[
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: const Color(0xFFefa65a), width: 1),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFefa65a),
                                ),
                                child: const Icon(Icons.star_rounded, size: 14, color: Colors.white),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${profileController.userInfoModel?.loyaltyPoint ?? 0} نقطة',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  color: Color(0xFFefa65a),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]









                    ],
                  ),
                ),
                actions: const [SizedBox()],
              ),









                  /// Search Button
                  !showMobileModule && !isTaxi ? SliverPersistentHeader(
                    pinned: true,
                    delegate: SliverDelegate(
                      callback: (val) {},
                      child: Center(
                        child: Container(
                          height: 60,
                          width: Dimensions.webMaxWidth,
                          color: searchBgShow
                              ? Get.find<ThemeController>().darkTheme
                              ? Theme.of(context).colorScheme.surface
                              : Theme.of(context).cardColor
                              : null,
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: InkWell(
                            onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                border: Border.all(
                                  color: Theme.of(context).primaryColor.withOpacity(0.15),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.search,
                                    size: 24,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
                                          ? 'search_food_or_restaurant'.tr
                                          : 'search_item_or_store'.tr,
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Theme.of(context).hintColor.withOpacity(0.8),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ) : const SliverToBoxAdapter(),


                  SliverToBoxAdapter(
                    child: Center(child: SizedBox(
                      width: Dimensions.webMaxWidth,
                      child: !showMobileModule ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

                        isGrocery ? const GroceryHomeScreen()
                            : isPharmacy ? const PharmacyHomeScreen()
                            : isFood ? const FoodHomeScreen()
                            : isShop ? const ShopHomeScreen()
                            : isTaxi ? const TaxiHomeScreen()
                            : const SizedBox(),

                      ]) : ModuleView(splashController: splashController),
                    )),
                  ),

                  !showMobileModule && !isTaxi ? SliverPersistentHeader(
                    key: _headerKey,
                    pinned: true,
                    delegate: SliverDelegate(
                      height: 85,
                      callback: (val) {
                        searchBgShow = val;
                      },
                      child: const AllStoreFilterWidget(),
                    ),
                  ) : const SliverToBoxAdapter(),

                  SliverToBoxAdapter(child: !showMobileModule && !isTaxi ? Center(child: GetBuilder<StoreController>(builder: (storeController) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: ResponsiveHelper.isDesktop(context) ? 0 : 100),
                      child: PaginatedListView(
                        scrollController: _scrollController,
                        totalSize: storeController.storeModel?.totalSize,
                        offset: storeController.storeModel?.offset,
                        onPaginate: (int? offset) async => await storeController.getStoreList(offset!, false),
                        itemView: ItemsView(
                          isStore: true,
                          items: null,
                          isFoodOrGrocery: (isFood || isGrocery),
                          stores: storeController.storeModel?.stores,
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
                            vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
                          ),
                        ),
                      ),
                    );
                  }),) : const SizedBox()),

                ],
              ),
            ),
          ),

          floatingActionButton: AuthHelper.isLoggedIn() && homeController.cashBackOfferList != null && homeController.cashBackOfferList!.isNotEmpty ?
          homeController.showFavButton ? Padding(
            padding: EdgeInsets.only(bottom: 50.0, right: ResponsiveHelper.isDesktop(context) ? 50 : 0),
            child: InkWell(
              onTap: () => Get.dialog(const CashBackDialogWidget()),
              child: const CashBackLogoWidget(),
            ),
          ) : null : null,

        );
      });
    });
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  Function(bool isPinned)? callback;
  bool isPinned = false;

  SliverDelegate({required this.child, this.height = 50, this.callback});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    isPinned = shrinkOffset == maxExtent /*|| shrinkOffset < maxExtent*/;
    callback!(isPinned);
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}
