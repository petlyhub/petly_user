// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
// import 'package:sixam_mart/common/controllers/theme_controller.dart';
// import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
// import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
// import 'package:sixam_mart/features/home/controllers/advertisement_controller.dart';
// import 'package:sixam_mart/features/home/controllers/home_controller.dart';
// import 'package:sixam_mart/features/home/widgets/all_store_filter_widget.dart';
// import 'package:sixam_mart/features/home/widgets/cashback_logo_widget.dart';
// import 'package:sixam_mart/features/home/widgets/cashback_dialog_widget.dart';
// import 'package:sixam_mart/features/home/widgets/refer_bottom_sheet_widget.dart';
// import 'package:sixam_mart/features/item/controllers/campaign_controller.dart';
// import 'package:sixam_mart/features/category/controllers/category_controller.dart';
// import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
// import 'package:sixam_mart/features/flash_sale/controllers/flash_sale_controller.dart';
// import 'package:sixam_mart/features/location/controllers/location_controller.dart';
// import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
// import 'package:sixam_mart/features/item/controllers/item_controller.dart';
// import 'package:sixam_mart/features/store/controllers/store_controller.dart';
// import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
// import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
// import 'package:sixam_mart/features/address/controllers/address_controller.dart';
// import 'package:sixam_mart/features/home/screens/modules/food_home_screen.dart';
// import 'package:sixam_mart/features/home/screens/modules/grocery_home_screen.dart';
// import 'package:sixam_mart/features/home/screens/modules/pharmacy_home_screen.dart';
// import 'package:sixam_mart/features/home/screens/modules/shop_home_screen.dart';
// import 'package:sixam_mart/features/parcel/controllers/parcel_controller.dart';
// import 'package:sixam_mart/features/rental_module/home/controllers/taxi_home_controller.dart';
// import 'package:sixam_mart/features/rental_module/home/screens/taxi_home_screen.dart';
// import 'package:sixam_mart/features/rental_module/rental_cart_screen/controllers/taxi_cart_controller.dart';
// import 'package:sixam_mart/helper/address_helper.dart';
// import 'package:sixam_mart/helper/auth_helper.dart';
// import 'package:sixam_mart/helper/responsive_helper.dart';
// import 'package:sixam_mart/helper/route_helper.dart';
// import 'package:sixam_mart/util/app_constants.dart';
// import 'package:sixam_mart/util/dimensions.dart';
// import 'package:sixam_mart/util/styles.dart';
// import 'package:sixam_mart/common/widgets/item_view.dart';
// import 'package:sixam_mart/common/widgets/menu_drawer.dart';
// import 'package:sixam_mart/common/widgets/paginated_list_view.dart';
// import 'package:sixam_mart/common/widgets/web_menu_bar.dart';
// import 'package:sixam_mart/features/home/screens/web_new_home_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sixam_mart/features/home/widgets/module_view.dart';
// import 'package:sixam_mart/features/parcel/screens/parcel_category_screen.dart';

// import '../../notification/domain/models/notification_body_model.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   static Future<void> loadData(bool reload, {bool fromModule = false}) async {
//     Get.find<LocationController>().syncZoneData();
//     Get.find<FlashSaleController>().setEmptyFlashSale(fromModule: fromModule);
//     // print('------------call from home');
//     // await Get.find<CartController>().getCartDataOnline();
//     if(AuthHelper.isLoggedIn()) {
//       Get.find<StoreController>().getVisitAgainStoreList(fromModule: fromModule);
//     }
//     if(Get.find<SplashController>().module != null && !Get.find<SplashController>().configModel!.moduleConfig!.module!.isParcel! && !Get.find<SplashController>().configModel!.moduleConfig!.module!.isTaxi!) {
//       Get.find<BannerController>().getBannerList(reload);
//       Get.find<StoreController>().getRecommendedStoreList();
//       if(Get.find<SplashController>().module!.moduleType.toString() == AppConstants.grocery) {
//         Get.find<FlashSaleController>().getFlashSale(reload, false);
//       }
//       if(Get.find<SplashController>().module!.moduleType.toString() == AppConstants.ecommerce) {
//         Get.find<ItemController>().getFeaturedCategoriesItemList(false, false);
//         Get.find<FlashSaleController>().getFlashSale(reload, false);
//         Get.find<BrandsController>().getBrandList();
//       }
//       Get.find<BannerController>().getPromotionalBannerList(reload);
//       Get.find<ItemController>().getDiscountedItemList(reload, false, 'all');
//       Get.find<CategoryController>().getCategoryList(reload);
//       Get.find<StoreController>().getPopularStoreList(reload, 'all', false);
//       Get.find<CampaignController>().getBasicCampaignList(reload);
//       Get.find<CampaignController>().getItemCampaignList(reload);
//       Get.find<ItemController>().getPopularItemList(reload, 'all', false);
//       Get.find<StoreController>().getLatestStoreList(reload, 'all', false);
//       Get.find<StoreController>().getTopOfferStoreList(reload, false);
//       Get.find<ItemController>().getReviewedItemList(reload, 'all', false);
//       Get.find<ItemController>().getRecommendedItemList(reload, 'all', false);
//       Get.find<StoreController>().getStoreList(1, reload);
//       Get.find<AdvertisementController>().getAdvertisementList();
//     }
//     if(AuthHelper.isLoggedIn()) {
//       // Get.find<StoreController>().getVisitAgainStoreList(fromModule: fromModule);
//       await Get.find<ProfileController>().getUserInfo();
//       Get.find<NotificationController>().getNotificationList(reload);
//       Get.find<CouponController>().getCouponList();
//     }
//     Get.find<SplashController>().getModules();
//     if(Get.find<SplashController>().module == null && Get.find<SplashController>().configModel!.module == null) {
//       Get.find<BannerController>().getFeaturedBanner();
//       Get.find<StoreController>().getFeaturedStoreList();
//       if(AuthHelper.isLoggedIn()) {
//         Get.find<AddressController>().getAddressList();
//       }
//     }
//     if(Get.find<SplashController>().module != null && Get.find<SplashController>().configModel!.moduleConfig!.module!.isParcel!) {
//       Get.find<ParcelController>().getParcelCategoryList();
//     }
//     if(Get.find<SplashController>().module != null && Get.find<SplashController>().module!.moduleType.toString() == AppConstants.pharmacy) {
//       Get.find<ItemController>().getBasicMedicine(reload, false);
//       Get.find<StoreController>().getFeaturedStoreList();
//       await Get.find<ItemController>().getCommonConditions(false);
//       if(Get.find<ItemController>().commonConditions!.isNotEmpty) {
//         Get.find<ItemController>().getConditionsWiseItem(Get.find<ItemController>().commonConditions![0].id!, false);
//       }
//     }
//   }

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final ScrollController _scrollController = ScrollController();
//   bool searchBgShow = false;
//   final GlobalKey _headerKey = GlobalKey();
//   final profileController = Get.find<ProfileController>();

//   @override
//   void initState() {
//     super.initState();
//     HomeScreen.loadData(false).then((value) {
//       Get.find<SplashController>().getReferBottomSheetStatus();

//       if((Get.find<ProfileController>().userInfoModel?.isValidForDiscount??false) && Get.find<SplashController>().showReferBottomSheet) {
//         _showReferBottomSheet();
//       }
//     });

//     // if(!ResponsiveHelper.isWeb()) {
//     //   Get.find<LocationController>().getZone(
//     //       AddressHelper.getUserAddressFromSharedPref()!.latitude,
//     //       AddressHelper.getUserAddressFromSharedPref()!.longitude, false, updateInAddress: true
//     //   );
//     // }

//     _scrollController.addListener(() {
//       if(_scrollController.position.userScrollDirection == ScrollDirection.reverse){
//         if(Get.find<HomeController>().showFavButton){
//           Get.find<HomeController>().changeFavVisibility();
//           Future.delayed(const Duration(milliseconds: 800), () => Get.find<HomeController>().changeFavVisibility());
//         }
//       }else {
//         if(Get.find<HomeController>().showFavButton){
//           Get.find<HomeController>().changeFavVisibility();
//           Future.delayed(const Duration(milliseconds: 800), () => Get.find<HomeController>().changeFavVisibility());
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _scrollController.dispose();
//   }

//   void _showReferBottomSheet() {
//     ResponsiveHelper.isDesktop(context) ? Get.dialog(
//       Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
//         insetPadding: const EdgeInsets.all(22),
//         clipBehavior: Clip.antiAliasWithSaveLayer,
//         child: const ReferBottomSheetWidget(),
//       ),
//       useSafeArea: false,
//     ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false))
//         : showModalBottomSheet(
//       isScrollControlled: true, useRootNavigator: true, context: Get.context!,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusExtraLarge), topRight: Radius.circular(Dimensions.radiusExtraLarge)),
//       ),
//       builder: (context) {
//         return ConstrainedBox(
//           constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
//           child: const ReferBottomSheetWidget(),
//         );
//       },
//     ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false));
//   }

//   Future<void> loadTaxiApis() async{
//    await Get.find<TaxiHomeController>().getTaxiBannerList(true);
//    await Get.find<TaxiHomeController>().getTopRatedCarList(1, true);
//     if (AuthHelper.isLoggedIn()) {
//       await Get.find<AddressController>().getAddressList();
//       await Get.find<TaxiHomeController>().getTaxiCouponList(true);
//       await Get.find<TaxiCartController>().getCarCartList();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<SplashController>(builder: (splashController) {
//       if(splashController.moduleList != null && splashController.moduleList!.length == 1) {
//         splashController.switchModule(0, true);
//       }
//       bool showMobileModule = !ResponsiveHelper.isDesktop(context) && splashController.module == null && splashController.configModel!.module == null;
//       // bool isParcel = splashController.module != null && splashController.configModel!.moduleConfig!.module!.isParcel!;
//       bool isParcel = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.parcel;
//       bool isPharmacy = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.pharmacy;
//       bool isFood = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.food;
//       bool isShop = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.ecommerce;
//       bool isGrocery = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.grocery;
//       bool isTaxi = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.taxi;

//       return GetBuilder<HomeController>(builder: (homeController) {
//         return Scaffold(
//           appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
//           endDrawer: const MenuDrawer(),
//           endDrawerEnableOpenDragGesture: false,
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           body: isParcel ? const ParcelCategoryScreen() : SafeArea(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 splashController.setRefreshing(true);
//                 if (Get.find<SplashController>().module != null && !isTaxi) {
//                   await Get.find<LocationController>().syncZoneData();
//                   await Get.find<BannerController>().getBannerList(true);
//                   if (isGrocery) {
//                     await Get.find<FlashSaleController>().getFlashSale(true, true);
//                   }
//                   await Get.find<BannerController>().getPromotionalBannerList(true);
//                   await Get.find<ItemController>().getDiscountedItemList(true, false, 'all');
//                   await Get.find<CategoryController>().getCategoryList(true);
//                   await Get.find<StoreController>().getPopularStoreList(true, 'all', false);
//                   await Get.find<CampaignController>().getItemCampaignList(true);
//                   Get.find<CampaignController>().getBasicCampaignList(true);
//                   await Get.find<ItemController>().getPopularItemList(true, 'all', false);
//                   await Get.find<StoreController>().getLatestStoreList(true, 'all', false);
//                   await Get.find<StoreController>().getTopOfferStoreList(true, false);
//                   await Get.find<ItemController>().getReviewedItemList(true, 'all', false);
//                   await Get.find<StoreController>().getStoreList(1, true);
//                   Get.find<AdvertisementController>().getAdvertisementList();
//                   if (AuthHelper.isLoggedIn()) {
//                     await Get.find<ProfileController>().getUserInfo();
//                     await Get.find<NotificationController>().getNotificationList(true);
//                     Get.find<CouponController>().getCouponList();
//                   }
//                   if (isPharmacy) {
//                     Get.find<ItemController>().getBasicMedicine(true, true);
//                     Get.find<ItemController>().getCommonConditions(true);
//                   }
//                   if (isShop) {
//                     await Get.find<FlashSaleController>().getFlashSale(true, true);
//                     Get.find<ItemController>().getFeaturedCategoriesItemList(true, true);
//                     Get.find<BrandsController>().getBrandList();
//                   }
//                 } else if(isTaxi) {
//                   await loadTaxiApis();
//                 } else {
//                   await Get.find<BannerController>().getFeaturedBanner();
//                   await Get.find<SplashController>().getModules();
//                   if (AuthHelper.isLoggedIn()) {
//                     await Get.find<AddressController>().getAddressList();
//                   }
//                   await Get.find<StoreController>().getFeaturedStoreList();
//                 }
//                 splashController.setRefreshing(false);
//               },
//               child: ResponsiveHelper.isDesktop(context) ? WebNewHomeScreen(
//                 scrollController: _scrollController,
//               ) : CustomScrollView(
//                 controller: _scrollController,
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 slivers: [

//                 SliverAppBar(
//                 floating: true,
//                 pinned: true,
//                 elevation: 0,
//                 backgroundColor: Theme.of(context).colorScheme.surface,
//                 surfaceTintColor: Theme.of(context).colorScheme.surface,
//                 automaticallyImplyLeading: false,
//                 title: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                   child: Row(
//                     children: [

//                       // === زر التبديل بين الموديولات ===
//                       if (splashController.module != null &&
//                           splashController.configModel!.module == null &&
//                           splashController.moduleList != null &&
//                           splashController.moduleList!.length != 1)
//                         InkWell(
//                           onTap: () {
//                             splashController.removeModule();
//                             Get.find<StoreController>().resetStoreData();
//                           },
//                           borderRadius: BorderRadius.circular(12),
//                           child: Container(
//                             height: 40,
//                             width: 40,
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor.withOpacity(0.08),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Icon(Icons.grid_view_rounded, color: Theme.of(context).primaryColor),
//                           ),
//                         ),

//                       if (splashController.module != null &&
//                           splashController.configModel!.module == null &&
//                           splashController.moduleList != null &&
//                           splashController.moduleList!.length != 1)
//                         const SizedBox(width: Dimensions.paddingSizeSmall),

//                       // === الموقع الحالي (عنوان + نص فرعي) ===
//                       Expanded(
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(12),
//                           onTap: () => Get.find<LocationController>().navigateToLocationScreen('home'),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor.withOpacity(0.05),
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: GetBuilder<LocationController>(builder: (locationController) {
//                               final address = AddressHelper.getUserAddressFromSharedPref();
//                               return Row(
//                                 children: [
//                                   Icon(Icons.location_on, size: 18, color: Theme.of(context).primaryColor),
//                                   const SizedBox(width: 6),
//                                   Expanded(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           AuthHelper.isLoggedIn()
//                                               ? address?.addressType?.tr ?? 'your_location'.tr
//                                               : 'your_location'.tr,
//                                           style: robotoMedium.copyWith(
//                                             fontSize: 13,
//                                             color: Theme.of(context).textTheme.bodyLarge!.color,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                         Text(
//                                           address?.address ?? '',
//                                           style: robotoRegular.copyWith(
//                                             fontSize: 11,
//                                             color: Theme.of(context).disabledColor,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(width: 4),
//                                   Icon(Icons.keyboard_arrow_down_rounded, size: 20, color: Theme.of(context).disabledColor),
//                                 ],
//                               );
//                             }),
//                           ),
//                         ),
//                       ),

//                       const SizedBox(width: Dimensions.paddingSizeSmall),

//                       // === الإشعارات ===
//                       InkWell(
//                         borderRadius: BorderRadius.circular(40),
//                         onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
//                         child: GetBuilder<NotificationController>(builder: (notificationController) {
//                           return Stack(
//                             clipBehavior: Clip.none,
//                             children: [
//                               Container(
//                                 height: 40,
//                                 width: 40,
//                                 decoration: BoxDecoration(
//                                   color: Colors.black87.withOpacity(0.08),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: const Icon(CupertinoIcons.bell, size: 20, color: Colors.black87),
//                               ),
//                               if (notificationController.hasNotification)
//                                 Positioned(
//                                   top: 6,
//                                   right: 6,
//                                   child: Container(
//                                     height: 8,
//                                     width: 8,
//                                     decoration: BoxDecoration(
//                                       color: Theme.of(context).primaryColor,
//                                       shape: BoxShape.circle,
//                                       border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 1),
//                                     ),
//                                   ),
//                                 ),
//                             ],
//                           );
//                         }),
//                       ),

//                       const SizedBox(width: Dimensions.paddingSizeSmall),

//                       // === زر الدعم الفني ===
//                       InkWell(
//                         borderRadius: BorderRadius.circular(40),
//                         onTap: () => Get.toNamed(RouteHelper.getChatRoute(notificationBody: NotificationBodyModel(
//                           notificationType: NotificationType.message, adminId: 0,
//                         ))),
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             color: Colors.black87.withOpacity(0.08),
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(Icons.headset_mic_rounded, size: 20, color: Colors.black87),
//                         ),
//                       ),

//                       if (AuthHelper.isLoggedIn()) ...[
//                         const SizedBox(width: Dimensions.paddingSizeSmall),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border.all(color: const Color(0xFFefa65a), width: 1),
//                           ),
//                           child: Row(
//                             children: [
//                               Container(
//                                 width: 22,
//                                 height: 22,
//                                 decoration: const BoxDecoration(
//                                   shape: BoxShape.circle,
//                                   color: Color(0xFFefa65a),
//                                 ),
//                                 child: const Icon(Icons.star_rounded, size: 14, color: Colors.white),
//                               ),
//                               const SizedBox(width: 6),
//                               Text(
//                                 '${profileController.userInfoModel?.loyaltyPoint ?? 0} نقطة',
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 13,
//                                   color: Color(0xFFefa65a),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ]

//                     ],
//                   ),
//                 ),
//                 actions: const [SizedBox()],
//               ),

//                   /// Search Button
//                   !showMobileModule && !isTaxi ? SliverPersistentHeader(
//                     pinned: true,
//                     delegate: SliverDelegate(
//                       callback: (val) {},
//                       child: Center(
//                         child: Container(
//                           height: 120,
//                           width: Dimensions.webMaxWidth,
//                           color: searchBgShow
//                               ? Get.find<ThemeController>().darkTheme
//                               ? Theme.of(context).colorScheme.surface
//                               : Theme.of(context).cardColor
//                               : null,
//                           padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                           child: InkWell(
//                             onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
//                             borderRadius: BorderRadius.circular(30),
//                             child: Container(
//                               height: 80,
//                               padding: const EdgeInsets.symmetric(horizontal: 16),
//                               margin: const EdgeInsets.symmetric(vertical: 8),
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).cardColor,
//                                 borderRadius: BorderRadius.circular(30),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.black12.withOpacity(0.05),
//                                     blurRadius: 8,
//                                     offset: const Offset(0, 3),
//                                   ),
//                                 ],
//                                 border: Border.all(
//                                   color: Theme.of(context).primaryColor.withOpacity(0.15),
//                                   width: 1,
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Icon(
//                                     CupertinoIcons.search,
//                                     size: 24,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   const SizedBox(width: 10),
//                                   Expanded(
//                                     child: Text(
//                                       Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
//                                           ? 'search_food_or_restaurant'.tr
//                                           : 'search_item_or_store'.tr,
//                                       style: robotoRegular.copyWith(
//                                         fontSize: Dimensions.fontSizeDefault,
//                                         color: Theme.of(context).hintColor.withOpacity(0.8),
//                                       ),
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ) : const SliverToBoxAdapter(),

//                   SliverToBoxAdapter(
//                     child: Center(child: SizedBox(
//                       width: Dimensions.webMaxWidth,
//                       child: !showMobileModule ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

//                         isGrocery ? const GroceryHomeScreen()
//                             : isPharmacy ? const PharmacyHomeScreen()
//                             : isFood ? const FoodHomeScreen()
//                             : isShop ? const ShopHomeScreen()
//                             : isTaxi ? const TaxiHomeScreen()
//                             : const SizedBox(),

//                       ]) : ModuleView(splashController: splashController),
//                     )),
//                   ),

//                   !showMobileModule && !isTaxi ? SliverPersistentHeader(
//                     key: _headerKey,
//                     pinned: true,
//                     delegate: SliverDelegate(
//                       height: 85,
//                       callback: (val) {
//                         searchBgShow = val;
//                       },
//                       child: const AllStoreFilterWidget(),
//                     ),
//                   ) : const SliverToBoxAdapter(),

//                   SliverToBoxAdapter(child: !showMobileModule && !isTaxi ? Center(child: GetBuilder<StoreController>(builder: (storeController) {
//                     return Padding(
//                       padding: EdgeInsets.only(bottom: ResponsiveHelper.isDesktop(context) ? 0 : 100),
//                       child: PaginatedListView(
//                         scrollController: _scrollController,
//                         totalSize: storeController.storeModel?.totalSize,
//                         offset: storeController.storeModel?.offset,
//                         onPaginate: (int? offset) async => await storeController.getStoreList(offset!, false),
//                         itemView: ItemsView(
//                           isStore: true,
//                           items: null,
//                           isFoodOrGrocery: (isFood || isGrocery),
//                           stores: storeController.storeModel?.stores,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall,
//                             vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
//                           ),
//                         ),
//                       ),
//                     );
//                   }),) : const SizedBox()),

//                 ],
//               ),
//             ),
//           ),

//           floatingActionButton: AuthHelper.isLoggedIn() && homeController.cashBackOfferList != null && homeController.cashBackOfferList!.isNotEmpty ?
//           homeController.showFavButton ? Padding(
//             padding: EdgeInsets.only(bottom: 50.0, right: ResponsiveHelper.isDesktop(context) ? 50 : 0),
//             child: InkWell(
//               onTap: () => Get.dialog(const CashBackDialogWidget()),
//               child: const CashBackLogoWidget(),
//             ),
//           ) : null : null,

//         );
//       });
//     });
//   }
// }

// class SliverDelegate extends SliverPersistentHeaderDelegate {
//   Widget child;
//   double height;
//   Function(bool isPinned)? callback;
//   bool isPinned = false;

//   SliverDelegate({required this.child, this.height = 50, this.callback});

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     isPinned = shrinkOffset == maxExtent /*|| shrinkOffset < maxExtent*/;
//     callback!(isPinned);
//     return child;
//   }

//   @override
//   double get maxExtent => height;

//   @override
//   double get minExtent => height;

//   @override
//   bool shouldRebuild(SliverDelegate oldDelegate) {
//     return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/fast_service.dart/care_and_beauty_screen.dart';
import 'package:sixam_mart/features/fast_service.dart/clinics_screen.dart';
import 'package:sixam_mart/features/fast_service.dart/consultation_screen.dart';
import 'package:sixam_mart/features/fast_service.dart/hotel_pets_screen.dart';
import 'package:sixam_mart/features/fast_service.dart/mobile_clinics_screen.dart';
import 'package:sixam_mart/features/fast_service.dart/pet_training_screen.dart';
import 'package:sixam_mart/features/fast_service.dart/pharmacy_screen.dart';
import 'package:sixam_mart/features/flash_sale/controllers/flash_sale_controller.dart';
import 'package:sixam_mart/features/home/controllers/advertisement_controller.dart';
import 'package:sixam_mart/features/home/medical_record/medical_record_screen.dart';
import 'package:sixam_mart/features/item/controllers/campaign_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/parcel/controllers/parcel_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/screens/all_store_screen.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/images.dart';

import '../../store/domain/models/store_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.store, this.slug});
  static Future<void> loadData(bool reload, {bool fromModule = false}) async {
    Get.find<LocationController>().syncZoneData();
    Get.find<FlashSaleController>().setEmptyFlashSale(fromModule: fromModule);
    // print('------------call from home');
    // await Get.find<CartController>().getCartDataOnline();
    if (AuthHelper.isLoggedIn()) {
      Get.find<StoreController>()
          .getVisitAgainStoreList(fromModule: fromModule);
    }
    if (Get.find<SplashController>().module != null &&
        !Get.find<SplashController>()
            .configModel!
            .moduleConfig!
            .module!
            .isParcel! &&
        !Get.find<SplashController>()
            .configModel!
            .moduleConfig!
            .module!
            .isTaxi!) {
      Get.find<BannerController>().getBannerList(reload);
      Get.find<StoreController>().getRecommendedStoreList();
      if (Get.find<SplashController>().module!.moduleType.toString() ==
          AppConstants.grocery) {
        Get.find<FlashSaleController>().getFlashSale(reload, false);
      }
      if (Get.find<SplashController>().module!.moduleType.toString() ==
          AppConstants.ecommerce) {
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
    if (AuthHelper.isLoggedIn()) {
      // Get.find<StoreController>().getVisitAgainStoreList(fromModule: fromModule);
      await Get.find<ProfileController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
      Get.find<CouponController>().getCouponList();
    }
    Get.find<SplashController>().getModules();
    if (Get.find<SplashController>().module == null &&
        Get.find<SplashController>().configModel!.module == null) {
      Get.find<BannerController>().getFeaturedBanner();
      Get.find<StoreController>().getFeaturedStoreList();
      if (AuthHelper.isLoggedIn()) {
        Get.find<AddressController>().getAddressList();
      }
    }
    if (Get.find<SplashController>().module != null &&
        Get.find<SplashController>()
            .configModel!
            .moduleConfig!
            .module!
            .isParcel!) {
      Get.find<ParcelController>().getParcelCategoryList();
    }
    if (Get.find<SplashController>().module != null &&
        Get.find<SplashController>().module!.moduleType.toString() ==
            AppConstants.pharmacy) {
      Get.find<ItemController>().getBasicMedicine(reload, false);
      Get.find<StoreController>().getFeaturedStoreList();
      await Get.find<ItemController>().getCommonConditions(false);
      if (Get.find<ItemController>().commonConditions!.isNotEmpty) {
        Get.find<ItemController>().getConditionsWiseItem(
            Get.find<ItemController>().commonConditions![0].id!, false);
      }
    }
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  final Store? store;
  final String ? slug;


}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // لضمان اتجاه الواجهة من اليمين لليسار
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FD),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header (Greeting & Notification)
                _buildHeader(),
                const SizedBox(height: 16),
                // 2. Pet Profile Card
                _buildPetProfileCard(),
                const SizedBox(height: 24),
                // 3. Quick Services Section
                _buildSectionHeader('الخدمات السريعة', onSeeAllTap: () {}),
                const SizedBox(height: 12),
                _buildQuickServicesGrid(),
                const SizedBox(height: 24),
                TodayOffersSection(
                  products: sampleOffers,
                  onViewAllPressed: () {
                    // Navigate to full offers screen
                  },
                  onAddToCart: (product) {
                    // Add product to cart logic
                  },
                ),
                const SizedBox(height: 24),
                HomeSectionsWidget(
                  stores: [
                    StoreItem(
                        name: 'Pet House',
                        logoUrl: 'https://via.placeholder.com/100',
                        rating: 4.8),
                    StoreItem(
                        name: 'Pet World',
                        logoUrl: 'https://via.placeholder.com/100',
                        rating: 4.7),
                    StoreItem(
                        name: 'Zoo Store',
                        logoUrl: 'https://via.placeholder.com/100',
                        rating: 4.6),
                  ],
                  clinic: ClinicItem(
                    name: 'مركز رعاية الحيوان',
                    tag: 'أليفنا',
                    imageUrl: 'https://via.placeholder.com/150',
                    rating: 4.9,
                    distance: '2.10 كم',
                    duration: '30-40 دقيقة',
                    isVerified: true,
                  ),
                  onViewAllStores: () {
                    // Navigate to Stores Page
                  },
                  onViewAllClinics: () {
                    // Navigate to Clinics Page
                  },
                ),
                // 4. Promo Banner Card
                const SizedBox(height: 24),
                _buildPromoBanner(),
                const SizedBox(height: 24),
                // 5. Upcoming Bookings Section
                _buildSectionHeader('الحجوزات القادمة', onSeeAllTap: () {}),
                const SizedBox(height: 12),
                _buildUpcomingBookingItem(
                  title: 'عيادة الأصدقاء البيطرية',
                  subtitle: 'كشف شامل',
                  dateText: '15 أغسطس 2025',
                  timeText: '04:00 م',
                  dayOfWeek: 'الأحد',
                  dayNum: '15',
                  month: 'أغسطس',
                  status: 'مؤكد',
                  statusColor: const Color(0xFF4CAF50),
                  statusBg: const Color(0xFFE8F5E9),
                  imageUrl: 'https://via.placeholder.com/150',
                ),
                const SizedBox(height: 12),
                _buildUpcomingBookingItem(
                  title: 'مركز العناية والجمال',
                  subtitle: 'استحمام وتقليم شعر',
                  dateText: '18 أغسطس 2025',
                  timeText: '11:00 ص',
                  dayOfWeek: 'الأربعاء',
                  dayNum: '18',
                  month: 'أغسطس',
                  status: 'بانتظار التأكيد',
                  statusColor: const Color(0xFFFF9800),
                  statusBg: const Color(0xFFFFF3E0),
                  imageUrl: 'https://via.placeholder.com/150',
                ),
                const SizedBox(height: 80), // Space for Bottom Navigation
              ],
            ),
          ),
        ),

        // Floating Action Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: const Color(0xFF6C5CE7),
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, size: 30, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        // Bottom Navigation Bar
      ),
    );
  }

  // Header Widget
  Widget _buildHeader() {
    return GetBuilder<ProfileController>(builder: (profileController) {
      String userName = profileController.userInfoModel?.fName ?? 'أحمد';

      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'مرحباً $userName',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E272E),
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text('👋', style: TextStyle(fontSize: 18)),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'كيف يمكننا مساعدتك اليوم؟',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ],
          ),
          InkWell(
            onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
            borderRadius: BorderRadius.circular(30),
            child: GetBuilder<NotificationController>(
                builder: (notificationController) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0EDFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(CupertinoIcons.bell,
                        size: 22, color: Color(0xFF6C5CE7)),
                  ),
                  if (notificationController.hasNotification)
                    Positioned(
                      top: 2,
                      right: 2,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.redAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ],
      );
    });
  }

  // Pet Profile Card Widget
  Widget _buildPetProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pet Picture & Edit Icon
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/image/dog_true.png'), // استبدلها بصورة الكلب
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0EDFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.edit,
                        size: 14, color: Color(0xFF6C5CE7)),
                  ),
                ],
              ),
              const SizedBox(width: 14),

              // Pet Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'لولو',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0EDFF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.pets,
                              size: 14, color: Color(0xFF6C5CE7)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('جولدن ريتريفر',
                        style: TextStyle(color: Colors.grey, fontSize: 13)),
                    const SizedBox(height: 2),
                    const Text('أنثى • سنتان',
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),

              // Calendar Action
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EDFF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.calendar_month,
                    color: Color(0xFF6C5CE7), size: 20),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFF0F0F0)),
          const SizedBox(height: 12),

          // Lower Info Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Medical Record Button
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MedicalRecordScreen()));
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FD),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.folder_outlined,
                          size: 16, color: Color(0xFF6C5CE7)),
                      SizedBox(width: 6),
                      Text(
                        'عرض الملف الطبي',
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF6C5CE7),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              // Next Vaccination Info
              const Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('التطعيم القادم',
                          style: TextStyle(fontSize: 11, color: Colors.grey)),
                      SizedBox(height: 2),
                      Text('بعد 12 يوم',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6C5CE7))),
                    ],
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.alarm, size: 20, color: Color(0xFF6C5CE7)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Section Header Template
  Widget _buildSectionHeader(String title,
      {required VoidCallback onSeeAllTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E272E)),
        ),
        InkWell(
          onTap: onSeeAllTap,
          child: const Row(
            children: [
              Text('عرض الكل',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(width: 2),
              Icon(Icons.arrow_back_ios_new, size: 10, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

// Quick Services Horizontal Scroll
  Widget _buildQuickServicesGrid() {
    final List<Map<String, dynamic>> services = [
      {
        'title': 'فنادق الحيوانات',
        'icon': Icons.other_houses_outlined,
        'bgColor': const Color(0xFFFFEFEB),
        'iconColor': const Color(0xFFFF7675),
        'screen': const HotelPetsScreen(),
      },
      {
        'title': 'الصيدليات',
        'icon': Icons.local_pharmacy_outlined,
        'bgColor': const Color(0xFFE8F8F5),
        'iconColor': const Color(0xFF1ABC9C),
        'screen': const PharmacyScreen(),
      },
      {
        'title': 'العيادات',
        'icon': Icons.medical_services_outlined,
        'bgColor': const Color(0xFFEBF5FB),
        'iconColor': const Color(0xFF3498DB),
        'screen': const ClinicsScreen(),
      },
      {
        'title': 'الاستشارات',
        'icon': Icons.forum_outlined,
        'bgColor': const Color(0xFFF4ECF7),
        'iconColor': const Color(0xFF9B59B6),
        'screen': const ConsultationsScreen(),
      },
      {
        'title': 'متاجر المنتجات',
        'icon': Icons.shopping_bag_outlined,
        'bgColor': const Color(0xFFF5EEF8),
        'iconColor': const Color(0xFF8E44AD),
        'screen':  const AllStoreScreen(isFeatured: false,isNearbyStore: false,isPopular: false,isTopOfferStore: false,),
        
      },
      {
        'title': 'العيادات المتنقلة',
        'icon': Icons.directions_car_outlined,
        'bgColor': const Color(0xFFEAF2F8),
        'iconColor': const Color(0xFF2980B9),
        'screen': const MobileClinicsScreen(),
      },
      {
        'title': 'العناية والتجميل',
        'icon': Icons.content_cut_outlined,
        'bgColor': const Color(0xFFFDEDEC),
        'iconColor': const Color(0xFFE74C3C),
        'screen': const CareAndBeautyScreen(),
      },
      {
        'title': 'التدريب',
        'icon': Icons.school_outlined,
        'bgColor': const Color(0xFFEAECEE),
        'iconColor': const Color(0xFF2C3E50),
        'screen': const PetTrainingScreen(),
      },
    ];

    return SizedBox(
      height: 100, // تحديد ارتفاع القائمة الأفقية
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: services.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final item = services[index];
          return Padding(
            padding: const EdgeInsets.only(left: 12),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item['screen'] as Widget),
                );
              },
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 80, // تحديد عرض العنصر
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: item['bgColor'],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        item['icon'],
                        color: item['iconColor'],
                        size: 22,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Promotional Banner Widget
  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFF6C5CE7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Banner Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'خصم 20% على أول حجز',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'استخدم الكود: PETLY20',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF6C5CE7),
                    elevation: 0,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    minimumSize: const Size(80, 32),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('احجز الآن',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          // Dog Image Overlay
          Positioned(
            left: 10,
            bottom: 0,
            top: 0,
            child: Container(
              width: 110,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/dog_true.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Upcoming Booking Card
  Widget _buildUpcomingBookingItem({
    required String title,
    required String subtitle,
    required String dateText,
    required String timeText,
    required String dayOfWeek,
    required String dayNum,
    required String month,
    required String status,
    required Color statusColor,
    required Color statusBg,
    required String imageUrl,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 70,
                height: 70,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436)),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),

                // تم استبدال الـ Row بـ Wrap لحل مشكلة الـ Overflow
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  runSpacing: 2,
                  children: [
                    const Icon(Icons.calendar_month_outlined,
                        size: 12, color: Colors.grey),
                    Text(dateText,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey)),
                    const SizedBox(width: 4),
                    const Icon(Icons.access_time, size: 12, color: Colors.grey),
                    Text(timeText,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),

                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                            color: statusColor, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          status,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: statusColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // Date Side Container
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dayOfWeek,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
                const SizedBox(height: 2),
                Text(
                  dayNum,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E272E)),
                ),
                Text(month,
                    style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Navigation Item Builder
  Widget _buildNavItem(
      {required IconData icon, required String label, required int index}) {
    final bool isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey,
            size: 22,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? const Color(0xFF6C5CE7) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// Product Model
class OfferProduct {
  final String title;
  final String weight;
  final double currentPrice;
  final double originalPrice;
  final int discountPercent;
  final String imageUrl;

  OfferProduct({
    required this.title,
    required this.weight,
    required this.currentPrice,
    required this.originalPrice,
    required this.discountPercent,
    required this.imageUrl,
  });
}

// Main Widget
class TodayOffersSection extends StatelessWidget {
  final List<OfferProduct> products;
  final VoidCallback? onViewAllPressed;
  final Function(OfferProduct)? onAddToCart;

  const TodayOffersSection({
    super.key,
    required this.products,
    this.onViewAllPressed,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // Set RTL layout direction
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Header
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      'عروض اليوم',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 4),
                    Text('🔥', style: TextStyle(fontSize: 18)),
                  ],
                ),
                TextButton(
                  onPressed: onViewAllPressed,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Row(
                    children: [
                      Text(
                        'عرض الكل',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                      Icon(
                        Icons.arrow_back_ios_new,
                        size: 12,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Horizontal Product List
          SizedBox(
            height: 230,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return ProductCard(
                  product: products[index],
                  onAddToCart: () {
                    if (onAddToCart != null) {
                      onAddToCart!(products[index]);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Individual Product Card Component
class ProductCard extends StatelessWidget {
  final OfferProduct product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FB),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section: Discount Badge & Image
          Stack(
            children: [
              // Product Image
              Container(
                height: 90,
                width: double.infinity,
                alignment: Alignment.center,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image, size: 40, color: Colors.grey),
                ),
              ),
              // Discount Tag
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '-${product.discountPercent}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Product Title
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),

          // Weight/Volume
          Text(
            product.weight,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[500],
            ),
          ),
          const Spacer(),

          // Price & Add to Cart Action Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Prices
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${product.originalPrice.toInt()} ر.س',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey[400],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${product.currentPrice.toInt()}',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE67E22),
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Text(
                        'ر.س',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFE67E22),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Add Button
              InkWell(
                onTap: onAddToCart,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6C5CE7),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final List<OfferProduct> sampleOffers = [
  OfferProduct(
    title: 'روبال كانين للقطط',
    weight: '2 كجم',
    currentPrice: 89,
    originalPrice: 110,
    discountPercent: 20,
    imageUrl: 'https://via.placeholder.com/150',
  ),
  OfferProduct(
    title: 'هيلز للكلاب الصغار',
    weight: '1.5 كجم',
    currentPrice: 75,
    originalPrice: 88,
    discountPercent: 15,
    imageUrl: 'https://via.placeholder.com/150',
  ),
  OfferProduct(
    title: 'فانسي فيست للقطط',
    weight: '85 جم',
    currentPrice: 5,
    originalPrice: 6,
    discountPercent: 10,
    imageUrl: 'https://via.placeholder.com/150',
  ),
  OfferProduct(
    title: 'رمل قطط',
    weight: '10 لتر',
    currentPrice: 37,
    originalPrice: 49,
    discountPercent: 25,
    imageUrl: 'https://via.placeholder.com/150',
  ),
];

// In your Screen's build method:

// --- Models ---
class StoreItem {
  final String name;
  final String logoUrl;
  final double rating;

  StoreItem({
    required this.name,
    required this.logoUrl,
    required this.rating,
  });
}

class ClinicItem {
  final String name;
  final String tag;
  final String imageUrl;
  final double rating;
  final String distance;
  final String duration;
  final bool isVerified;

  ClinicItem({
    required this.name,
    required this.tag,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.duration,
    this.isVerified = true,
  });
}

// --- Main Row Container Widget ---
class HomeSectionsWidget extends StatelessWidget {
  final List<StoreItem> stores;
  final ClinicItem clinic;
  final VoidCallback? onViewAllStores;
  final VoidCallback? onViewAllClinics;

  const HomeSectionsWidget({
    super.key,
    required this.stores,
    required this.clinic,
    this.onViewAllStores,
    this.onViewAllClinics,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left Side: Featured Stores Section
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader('المتاجر المميزة', onViewAllStores),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 95,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: stores.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return _StoreCard(store: stores[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // Right Side: Nearest Clinics Section
            Expanded(
              flex: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader('أقرب العيادات إليك', onViewAllClinics),
                  const SizedBox(height: 8),
                  _ClinicCard(clinic: clinic),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String title, VoidCallback? onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3142),
          ),
        ),
        InkWell(
          onTap: onViewAll,
          child: const Row(
            children: [
              Text(
                'عرض الكل',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              Icon(
                Icons.arrow_back_ios_new,
                size: 9,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// --- Component 1: Store Card ---
class _StoreCard extends StatelessWidget {
  final StoreItem store;

  const _StoreCard({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo Circle
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.network(
                store.logoUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.store, size: 20, color: Colors.indigo),
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Name
          Text(
            store.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 2),

          // Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.star, size: 10, color: Colors.amber),
              const SizedBox(width: 2),
              Text(
                '${store.rating}',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- Component 2: Clinic Card ---
class _ClinicCard extends StatelessWidget {
  final ClinicItem clinic;

  const _ClinicCard({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Clinic Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              clinic.imageUrl,
              width: 65,
              height: 65,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 65,
                height: 65,
                color: Colors.grey.shade300,
                child: const Icon(Icons.local_hospital, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Badge
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDE7F6),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        clinic.tag,
                        style: const TextStyle(
                          fontSize: 9,
                          color: Color(0xFF6C5CE7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        clinic.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    if (clinic.isVerified)
                      const Icon(
                        Icons.check_circle,
                        size: 12,
                        color: Color(0xFF00CEC9),
                      ),
                  ],
                ),
                const SizedBox(height: 4),

                // Stars
                Row(
                  children: [
                    Text(
                      '${clinic.rating}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Row(
                      children: List.generate(
                        5,
                        (index) => const Icon(
                          Icons.star,
                          size: 10,
                          color: Colors.amber,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Distance & Duration info
                Row(
                  children: [
                    Text(
                      clinic.duration,
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      clinic.distance,
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
