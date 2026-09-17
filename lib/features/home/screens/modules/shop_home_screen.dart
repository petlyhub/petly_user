// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_instance/src/extension_instance.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:get/get_utils/src/extensions/internacionalization.dart';
// import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
// import 'package:sixam_mart/common/widgets/custom_button.dart';
// import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
// import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
// import 'package:sixam_mart/features/home/widgets/brands_view_widget.dart';
// import 'package:sixam_mart/features/home/widgets/highlight_widget.dart';
// import 'package:sixam_mart/features/home/widgets/views/offer_today_new.dart';
// import 'package:sixam_mart/features/home/widgets/views/top_offers_near_me.dart';
// import 'package:sixam_mart/features/language/controllers/language_controller.dart';
// import 'package:sixam_mart/features/language/screens/web_language_screen.dart';
// import 'package:sixam_mart/features/language/widgets/language_bottom_sheet_widget.dart';
// import 'package:sixam_mart/features/language/widgets/language_card_widget.dart';
// import 'package:sixam_mart/features/location/controllers/location_controller.dart';
// import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
// import 'package:sixam_mart/features/pet_types/screens/pet_type_screen.dart';
// import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
// import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
// import 'package:sixam_mart/features/store/screens/all_store_screen.dart';
// import 'package:sixam_mart/helper/address_helper.dart';
// import 'package:sixam_mart/helper/auth_helper.dart';
// import 'package:sixam_mart/helper/responsive_helper.dart';
// import 'package:sixam_mart/helper/route_helper.dart';
// import 'package:sixam_mart/util/app_constants.dart';
// import 'package:sixam_mart/util/dimensions.dart';
// import 'package:sixam_mart/util/images.dart';
// import 'package:sixam_mart/features/flash_sale/widgets/flash_sale_view_widget.dart';
// import 'package:sixam_mart/features/home/widgets/bad_weather_widget.dart';
// import 'package:sixam_mart/features/home/widgets/views/product_with_categories_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/featured_categories_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/popular_store_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/item_that_you_love_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/just_for_you_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/most_popular_item_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/new_on_mart_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/middle_section_banner_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/special_offer_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/promotional_banner_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/visit_again_view.dart';
// import 'package:sixam_mart/features/home/widgets/banner_view.dart';
// import 'package:sixam_mart/features/home/widgets/views/category_view.dart';
// import 'package:sixam_mart/util/styles.dart';

// class ShopHomeScreen extends StatefulWidget {
//   const ShopHomeScreen({super.key});

//   @override
//   State<ShopHomeScreen> createState() => _ShopHomeScreenState();
// }

// class _ShopHomeScreenState extends State<ShopHomeScreen> {
//   bool isArabic = true;
//   bool isLoggedIn = AuthHelper.isLoggedIn();

//   @override
//   Widget build(BuildContext context) {
//     // Toggle for AR/EN state demonstration

//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(Images.shopModuleBannerBg),
//               fit: BoxFit.cover,
//             ),
//           ),
//           child: const SingleChildScrollView(
//             child: Column(
//               children: [
//                 BadWeatherWidget(),
//                 SizedBox(height: 12),
//               ],
//             ),
//           ),
//         ),

//         _buildHeader(),
//         const SizedBox(height: 16),
//         _buildSearchBar(),
//         const SizedBox(height: 16),
//         const BannerView(isFeatured: false),
//         const SizedBox(height: 16),
//         _buildPetProfileCard(),
//         const SizedBox(height: 20),
//         const SizedBox(
//           height: 120,
//           child: PetTypeScreen()),
//        // _buildCategoriesSection(),
//         const SizedBox(height: 20),
//         _buildQuickServicesSection(),
//         const SizedBox(height: 20),
//         // const ItemThatYouLoveView(forShop: false,),
//         //_buildTodayOffersSection(),
//         const OfferTodayNew(),
//         const SizedBox(height: 20),
//         _buildStoresAndClinicsRow(),
//         const SizedBox(height: 20),
//         _buildGroomingBanner(),
//         const SizedBox(height: 20),
//       ]),
//     );
//   }

//   // --- 1. App Header ---
//   Widget _buildHeader() {
//     final isDark = Theme.of(context).brightness == Brightness.dark;
//     return Row(
//       children: [
//         GetBuilder<ProfileController>(builder: (profileController) {
//           return CircleAvatar(
//             radius: 28,
//             backgroundColor: isDark ? const Color(0xFF23242A) : Colors.grey.shade100,
//             backgroundImage: (profileController.userInfoModel != null &&
//                     isLoggedIn &&
//                     (profileController
//                             .userInfoModel!.imageFullUrl?.isNotEmpty ??
//                         false))
//                 ? NetworkImage(profileController.userInfoModel!.imageFullUrl!)
//                 : null,
//             child: (profileController.userInfoModel != null &&
//                     isLoggedIn &&
//                     (profileController
//                             .userInfoModel!.imageFullUrl?.isNotEmpty ??
//                         false))
//                 ? null
//                 : Image.asset(Images.guestIconLight, width: 36, height: 36),
//           );
//         }),
//         const SizedBox(width: 10),
//         Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 GetBuilder<ProfileController>(builder: (profileController) {
//                   bool isLoggedIn = Get.find<AuthController>().isLoggedIn();

//                   return Text(
//                     (isLoggedIn && profileController.userInfoModel != null)
//                         ? '${profileController.userInfoModel?.fName ?? ''} ${profileController.userInfoModel?.lName ?? ''}'
//                         : 'guest_user'.tr,
//                     style: robotoBold.copyWith(
//                         fontSize: Dimensions.fontSizeExtraLarge),
//                   );
//                 }),
//                 const SizedBox(width: 4),
//                 const Text('👋', style: TextStyle(fontSize: 14)),
//               ],
//             ),
//             InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () => Get.find<LocationController>()
//                   .navigateToLocationScreen('home'),
//               child: Container(
//                 height: 60,
//                 width: 200,
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: GetBuilder<LocationController>(
//                     builder: (locationController) {
//                   final address = AddressHelper.getUserAddressFromSharedPref();
//                   return Row(
//                     children: [
//                       Icon(Icons.location_on,
//                           size: 18, color: Theme.of(context).primaryColor),
//                       const SizedBox(width: 6),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               AuthHelper.isLoggedIn()
//                                   ? address?.addressType?.tr ??
//                                       'your_location'.tr
//                                   : 'your_location'.tr,
//                               style: robotoMedium.copyWith(
//                                 fontSize: 13,
//                                 color: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge!
//                                     .color,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             Text(
//                               address?.address ?? '',
//                               style: robotoRegular.copyWith(
//                                 fontSize: 11,
//                                 color: Theme.of(context).disabledColor,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 4),
//                       Icon(Icons.keyboard_arrow_down_rounded,
//                           size: 20, color: Theme.of(context).disabledColor),
//                     ],
//                   );
//                 }),
//               ),
//             ),

//             // Row(
//             //   children: [
//             //     const Icon(Icons.location_on,
//             //         size: 12, color: Color(0xFF6C5CE7)),
//             //     const SizedBox(width: 2),
//             //     Text(
//             //       isArabic ? 'الرياض' : 'Riyadh',
//             //       style: const TextStyle(fontSize: 12, color: Colors.grey),
//             //     ),
//             //     const Icon(Icons.keyboard_arrow_down,
//             //         size: 14, color: Colors.grey),
//             //   ],
//             // ),
//           ],
//         ),
//         const Spacer(),
//         // Language Toggle Action (For demonstration)
//         IconButton(
//           onPressed: () => _manageLanguageFunctionality(), // 👈 أضف () للتشغيل
//           icon: Icon(Icons.translate, color: Colors.grey[700]),
//         ),
//         InkWell(
//           borderRadius: BorderRadius.circular(40),
//           onTap: () => Get.toNamed(RouteHelper.getNotificationRoute()),
//           child: GetBuilder<NotificationController>(
//               builder: (notificationController) {
//             return Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   height: 40,
//                   width: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.black87.withValues(alpha: 0.08),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(CupertinoIcons.bell,
//                       size: 20, color: Colors.black87),
//                 ),
//                 if (notificationController.hasNotification)
//                   Positioned(
//                     top: 6,
//                     right: 6,
//                     child: Container(
//                       height: 8,
//                       width: 8,
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         shape: BoxShape.circle,
//                         border: Border.all(
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                             width: 1),
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           }),
//         ),

//         // IconButton(
//         //   onPressed: () {},
//         //   icon: const Icon(Icons.favorite_border),
//         // ),
//         // Stack(
//         //   children: [
//         //     IconButton(
//         //       onPressed: () {},
//         //       icon: const Icon(Icons.shopping_bag_outlined),
//         //     ),
//         //     Positioned(
//         //       right: 6,
//         //       top: 6,
//         //       child: Container(
//         //         padding: const EdgeInsets.all(4),
//         //         decoration: const BoxDecoration(
//         //           color: Color(0xFF6C5CE7),
//         //           shape: BoxShape.circle,
//         //         ),
//         //         child: const Text(
//         //           '3',
//         //           style: TextStyle(
//         //               color: Colors.white,
//         //               fontSize: 9,
//         //               fontWeight: FontWeight.bold),
//         //         ),
//         //       ),
//         //     )
//         //   ],
//         // ),
//       ],
//     );
//   }

//   // --- 2. Search Bar ---
//   Widget _buildSearchBar() {
//     return Row(
//       children: [
//         Expanded(
//           child: InkWell(
//             onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
//             borderRadius: BorderRadius.circular(30),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.grey.shade200),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.search, color: Colors.grey[400]),
//                   const SizedBox(width: 8),
//                   Text(
//                     isArabic
//                         ? 'ابحث عن منتج أو خدمة لحيوانك الأليف...'
//                         : 'Search for product or pet service...',
//                     style: TextStyle(color: Colors.grey[400], fontSize: 13),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Container(
//           padding: const EdgeInsets.all(10),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(12),
//             border: Border.all(color: Colors.grey.shade200),
//           ),
//           child: Icon(Icons.qr_code_scanner, color: Colors.grey[600]),
//         )
//       ],
//     );
//   }

//   // --- 3. Discount Banner Slider ---
//   Widget _buildBannerSlider() {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 140,
//           decoration: BoxDecoration(
//             color: const Color(0xFF6C5CE7),
//             borderRadius: BorderRadius.circular(16),
//           ),
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     RichText(
//                       text: TextSpan(
//                         children: [
//                           TextSpan(
//                             text: isArabic ? 'خصم ' : 'Discount ',
//                             style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                           const TextSpan(
//                             text: '20%',
//                             style: TextStyle(
//                                 fontSize: 22,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.amber),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Text(
//                       isArabic
//                           ? 'على أغذية القطط من أفضل الماركات'
//                           : 'On cat food from top brands',
//                       style:
//                           const TextStyle(color: Colors.white70, fontSize: 12),
//                     ),
//                     const SizedBox(height: 9),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFF9F43),
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(20)),
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 16, vertical: 6),
//                         minimumSize: Size.zero,
//                       ),
//                       child: Text(
//                         isArabic ? 'تسوق الآن' : 'Shop Now',
//                         style: const TextStyle(
//                             fontSize: 11,
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const Icon(Icons.pets, size: 80, color: Colors.white24),
//             ],
//           ),
//         ),
//         const SizedBox(height: 8),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//                 width: 16,
//                 height: 4,
//                 decoration: BoxDecoration(
//                     color: const Color(0xFF6C5CE7),
//                     borderRadius: BorderRadius.circular(2))),
//             const SizedBox(width: 4),
//             Container(
//                 width: 4,
//                 height: 4,
//                 decoration: const BoxDecoration(
//                     color: Colors.grey, shape: BoxShape.circle)),
//             const SizedBox(width: 4),
//             Container(
//                 width: 4,
//                 height: 4,
//                 decoration: const BoxDecoration(
//                     color: Colors.grey, shape: BoxShape.circle)),
//           ],
//         )
//       ],
//     );
//   }

//   // --- 4. Pet Profile Card ---
//   Widget _buildPetProfileCard() {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFF3F0FF),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 20,
//             backgroundImage: NetworkImage('https://via.placeholder.com/100'),
//           ),
//           const SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     isArabic ? 'لولو' : 'Lulu',
//                     style: const TextStyle(
//                         fontWeight: FontWeight.bold, fontSize: 14),
//                   ),
//                   const SizedBox(width: 4),
//                   const Icon(Icons.female, size: 14, color: Colors.pink),
//                 ],
//               ),
//               Text(
//                 isArabic ? 'قط - عمره سنتان' : 'Cat - 2 years old',
//                 style: const TextStyle(fontSize: 11, color: Colors.grey),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.verified, size: 16, color: Color(0xFF6C5CE7)),
//                 const SizedBox(width: 4),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       isArabic ? 'التطعيم القادم' : 'Next Vaccine',
//                       style: const TextStyle(fontSize: 9, color: Colors.grey),
//                     ),
//                     Text(
//                       isArabic ? 'بعد 12 يوم' : 'In 12 days',
//                       style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF6C5CE7)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(width: 6),
//           TextButton(
//             onPressed: () {},
//             style: TextButton.styleFrom(
//                 padding: EdgeInsets.zero, minimumSize: Size.zero),
//             child: Row(
//               children: [
//                 Text(
//                   isArabic ? 'عرض ملفه' : 'View Profile',
//                   style: const TextStyle(fontSize: 11, color: Colors.grey),
//                 ),
//                 const Icon(Icons.arrow_forward_ios,
//                     size: 10, color: Colors.grey),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   // --- 5. Pet Categories ---
//   // Widget _buildCategoriesSection() {
//   //   final List<Map<String, String>> categories = [
//   //     {'ar': 'كلاب', 'en': 'Dogs', 'icon': '🐶'},
//   //     {'ar': 'قطط', 'en': 'Cats', 'icon': '🐱'},
//   //     {'ar': 'طيور', 'en': 'Birds', 'icon': '🦜'},
//   //     {'ar': 'أسماك', 'en': 'Fish', 'icon': '🐠'},
//   //     {'ar': 'قوارض', 'en': 'Rodents', 'icon': '🐹'},
//   //     {'ar': 'زواحف', 'en': 'Reptiles', 'icon': '🦎'},
//   //     {'ar': 'المزيد', 'en': 'More', 'icon': '•••'},
//   //   ];

//   //   return Row(
//   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //     children: categories.map((cat) {
//   //       return Column(
//   //         children: [
//   //           Container(
//   //             width: 44,
//   //             height: 44,
//   //             decoration: const BoxDecoration(
//   //               color: Color(0xFFFFF6EB),
//   //               shape: BoxShape.circle,
//   //             ),
//   //             alignment: Alignment.center,
//   //             child: Text(cat['icon']!, style: const TextStyle(fontSize: 18)),
//   //           ),
//   //           const SizedBox(height: 4),
//   //           Text(
//   //             isArabic ? cat['ar']! : cat['en']!,
//   //             style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
//   //           )
//   //         ],
//   //       );
//   //     }).toList(),
//   //   );
//   // }

//   Widget _buildCategoriesSection() {
//     final List<Map<String, String>> categories = [
//       {'ar': 'كلاب', 'en': 'Dogs', 'icon': '🐶'},
//       {'ar': 'قطط', 'en': 'Cats', 'icon': '🐱'},
//       {'ar': 'طيور', 'en': 'Birds', 'icon': '🦜'},
//       {'ar': 'أسماك', 'en': 'Fish', 'icon': '🐠'},
//       {'ar': 'قوارض', 'en': 'Rodents', 'icon': '🐹'},
//       {'ar': 'زواحف', 'en': 'Reptiles', 'icon': '🦎'},
//     ];

//     return SizedBox(
//       height: 70, // ارتفاع مناسب يحتوي على الأيقونة والنص
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         physics: const BouncingScrollPhysics(),
//         itemCount: categories.length,
//         separatorBuilder: (context, index) =>
//             const SizedBox(width: 16), // المسافة بين العناصر
//         itemBuilder: (context, index) {
//           final cat = categories[index];
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFFFF6EB),
//                   shape: BoxShape.circle,
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(cat['icon']!, style: const TextStyle(fontSize: 18)),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 isArabic ? cat['ar']! : cat['en']!,
//                 style:
//                     const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//   // --- 6. Quick Services ---
//   // Widget _buildQuickServicesSection() {
//   //   final List<Map<String, dynamic>> services = [
//   //     {
//   //       'ar': 'عيادات بيطرية',
//   //       'en': 'Clinics',
//   //       'icon': Icons.medical_services_outlined
//   //     },
//   //     {
//   //       'ar': 'صيدليات بيطرية',
//   //       'en': 'Pharmacy',
//   //       'icon': Icons.local_pharmacy_outlined
//   //     },
//   //     {'ar': 'خدمات العناية', 'en': 'Grooming', 'icon': Icons.bathtub_outlined},
//   //     {
//   //       'ar': 'فنادق الحيوانات',
//   //       'en': 'Pet Hotels',
//   //       'icon': Icons.pets_outlined
//   //     },
//   //     {'ar': 'استشارات', 'en': 'Consult', 'icon': Icons.plus_one},
//   //     {'ar': 'تدريب', 'en': 'Training', 'icon': Icons.sports_outlined},
//   //   ];

//   //   return Column(
//   //     children: [
//   //       _buildSectionHeader(
//   //         isArabic ? 'الخدمات السريعة' : 'Quick Services',
//   //         onViewAll: () {},
//   //       ),
//   //       const SizedBox(height: 10),
//   //       Row(
//   //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //         children: services.map((service) {
//   //           return Column(
//   //             children: [
//   //               Container(
//   //                 width: 50,
//   //                 height: 50,
//   //                 decoration: BoxDecoration(
//   //                   color: const Color(0xFFF3F0FF),
//   //                   borderRadius: BorderRadius.circular(14),
//   //                 ),
//   //                 child: Icon(service['icon'],
//   //                     color: const Color(0xFF6C5CE7), size: 22),
//   //               ),
//   //               const SizedBox(height: 4),
//   //               SizedBox(
//   //                 width: 52,
//   //                 child: Text(
//   //                   isArabic ? service['ar']! : service['en']!,
//   //                   textAlign: TextAlign.center,
//   //                   maxLines: 2,
//   //                   style: const TextStyle(
//   //                       fontSize: 9, fontWeight: FontWeight.w500),
//   //                 ),
//   //               )
//   //             ],
//   //           );
//   //         }).toList(),
//   //       ),
//   //     ],
//   //   );
//   // }

//   Widget _buildQuickServicesSection() {
//     final List<Map<String, dynamic>> services = [
//       {
//         'ar': 'عيادات بيطرية',
//         'en': 'Clinics',
//         'icon': Icons.medical_services_outlined
//       },
//       {
//         'ar': 'صيدليات بيطرية',
//         'en': 'Pharmacy',
//         'icon': Icons.local_pharmacy_outlined
//       },
//       {'ar': 'خدمات العناية', 'en': 'Grooming', 'icon': Icons.bathtub_outlined},
//       {
//         'ar': 'فنادق الحيوانات',
//         'en': 'Pet Hotels',
//         'icon': Icons.pets_outlined
//       },
//       {'ar': 'استشارات', 'en': 'Consult', 'icon': Icons.plus_one},
//       {'ar': 'تدريب', 'en': 'Training', 'icon': Icons.sports_outlined},
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildSectionHeader(
//           isArabic ? 'الخدمات السريعة' : 'Quick Services',
//           onViewAll: () {},
//         ),
//         const SizedBox(height: 10),
//         SizedBox(
//           height: 85, // ارتفاع كافٍ لاستيعاب الأيقونة والنص ذو السطرين
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.symmetric(horizontal: 4),
//             itemCount: services.length,
//             separatorBuilder: (context, index) => const SizedBox(width: 14),
//             itemBuilder: (context, index) {
//               final service = services[index];
//               return SizedBox(
//                 width: 60, // عرض ثابت آمن لكل عنصر
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: const Color(0xFFF3F0FF),
//                         borderRadius: BorderRadius.circular(14),
//                       ),
//                       child: Icon(
//                         service['icon'] as IconData,
//                         color: const Color(0xFF6C5CE7),
//                         size: 22,
//                       ),
//                     ),
//                     const SizedBox(height: 6),
//                     Expanded(
//                       child: Text(
//                         isArabic ? service['ar']! : service['en']!,
//                         textAlign: TextAlign.center,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w500,
//                           height: 1.1, // ضبط ارتفاع السطر لمنع تداخل الكلمات
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // --- 8. Split Stores and Clinics Row ---
//   Widget _buildStoresAndClinicsRow() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Featured Stores
//         Expanded(
//           flex: 5,
//           child: Column(
//             children: [
//               _buildSectionHeader(
//                   isArabic ? 'المتاجر المميزة' : 'Featured Stores',
//                   onViewAll: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (_) => const AllStoreScreen(
//                             isPopular: false,
//                             isFeatured: false,
//                             isNearbyStore: false,
//                             isTopOfferStore: false)));
//               }),
//               const SizedBox(height: 8),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(3, (index) {
//                   return Container(
//                     width: 50,
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(color: Colors.grey.shade200),
//                     ),
//                     child: const Column(
//                       children: [
//                         CircleAvatar(radius: 12, backgroundColor: Colors.amber),
//                         SizedBox(height: 4),
//                         Text('Store',
//                             style: TextStyle(
//                                 fontSize: 8, fontWeight: FontWeight.bold)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Icon(Icons.star, size: 8, color: Colors.amber),
//                             Text('4.8',
//                                 style:
//                                     TextStyle(fontSize: 8, color: Colors.grey)),
//                           ],
//                         )
//                       ],
//                     ),
//                   );
//                 }),
//               )
//             ],
//           ),
//         ),
//         const SizedBox(width: 12),
//         // Nearest Clinics
//         Expanded(
//           flex: 6,
//           child: Column(
//             children: [
//               _buildSectionHeader(
//                   isArabic ? 'أقرب العيادات' : 'Nearest Clinics',
//                   onViewAll: () {}),
//               const SizedBox(height: 8),
//               Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: Colors.grey.shade200),
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: 50,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child:
//                           const Icon(Icons.local_hospital, color: Colors.grey),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             isArabic ? 'مركز رعاية الحيوان' : 'Pet Care Center',
//                             maxLines: 1,
//                             style: const TextStyle(
//                                 fontSize: 10, fontWeight: FontWeight.bold),
//                           ),
//                           const Row(
//                             children: [
//                               Icon(Icons.star, size: 10, color: Colors.amber),
//                               Text('4.9',
//                                   style: TextStyle(
//                                       fontSize: 9,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                           Text(
//                             isArabic
//                                 ? '30-40 دقيقة | 2.10 كم'
//                                 : '30-40 min | 2.10 km',
//                             style: const TextStyle(
//                                 fontSize: 8, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   // --- 9. Grooming Banner ---
//   Widget _buildGroomingBanner() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: const Color(0xFFFF9F43),
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   isArabic
//                       ? 'خدمة الاستحمام والتنظيف'
//                       : 'Bathing & Grooming Service',
//                   style: const TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white),
//                 ),
//                 Text(
//                   isArabic
//                       ? 'لأن حيوانك يستحق الأفضل'
//                       : 'Because your pet deserves best',
//                   style: const TextStyle(fontSize: 10, color: Colors.white70),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
//                     minimumSize: Size.zero,
//                   ),
//                   child: Text(
//                     isArabic ? 'احجز الآن' : 'Book Now',
//                     style: const TextStyle(
//                         fontSize: 10,
//                         color: Color(0xFFFF9F43),
//                         fontWeight: FontWeight.bold),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const Icon(Icons.bathtub, size: 50, color: Colors.white30),
//         ],
//       ),
//     );
//   }

//   // --- Helper Section Header ---
//   Widget _buildSectionHeader(String title, {required VoidCallback onViewAll}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(title,
//             style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
//         InkWell(
//           onTap: onViewAll,
//           child: Row(
//             children: [
//               Text(isArabic ? 'عرض الكل' : 'View All',
//                   style: const TextStyle(fontSize: 10, color: Colors.grey)),
//               const Icon(Icons.arrow_forward_ios, size: 8, color: Colors.grey),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   _manageLanguageFunctionality() {
//     Get.find<LocalizationController>().saveCacheLanguage(null);
//     Get.find<LocalizationController>().searchSelectedLanguage();

//     showModalBottomSheet(
//       isScrollControlled: true,
//       useRootNavigator: true,
//       context: Get.context!,
//       backgroundColor: Colors.white,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(Dimensions.radiusExtraLarge),
//           topRight: Radius.circular(Dimensions.radiusExtraLarge),
//         ),
//       ),
//       builder: (context) {
//         return ConstrainedBox(
//           constraints: BoxConstraints(
//               maxHeight: MediaQuery.of(context).size.height * 0.8),
//           child: const LanguageBottomSheetWidget(),
//         );
//       },
//     ).then((value) => Get.find<LocalizationController>().setLanguage(
//         Get.find<LocalizationController>().getCacheLocaleFromSharedPref()));
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/home/widgets/brands_view_widget.dart';
import 'package:sixam_mart/features/home/widgets/highlight_widget.dart';
import 'package:sixam_mart/features/home/widgets/views/offer_today_new.dart';
import 'package:sixam_mart/features/home/widgets/views/top_offers_near_me.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/language/screens/web_language_screen.dart';
import 'package:sixam_mart/features/language/widgets/language_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/language/widgets/language_card_widget.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/loyalty/screens/loyalty_screen.dart';
import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
import 'package:sixam_mart/features/pet_types/screens/pet_type_screen.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/profile/screens/profile_screen.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/screens/all_store_screen.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/features/flash_sale/widgets/flash_sale_view_widget.dart';
import 'package:sixam_mart/features/home/widgets/bad_weather_widget.dart';
import 'package:sixam_mart/features/home/widgets/views/product_with_categories_view.dart';
import 'package:sixam_mart/features/home/widgets/views/featured_categories_view.dart';
import 'package:sixam_mart/features/home/widgets/views/popular_store_view.dart';
import 'package:sixam_mart/features/home/widgets/views/item_that_you_love_view.dart';
import 'package:sixam_mart/features/home/widgets/views/just_for_you_view.dart';
import 'package:sixam_mart/features/home/widgets/views/most_popular_item_view.dart';
import 'package:sixam_mart/features/home/widgets/views/new_on_mart_view.dart';
import 'package:sixam_mart/features/home/widgets/views/middle_section_banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/special_offer_view.dart';
import 'package:sixam_mart/features/home/widgets/views/promotional_banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/visit_again_view.dart';
import 'package:sixam_mart/features/home/widgets/banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/category_view.dart';
import 'package:sixam_mart/util/styles.dart';

class _ShopBreakpoints {
  static const double mobileMax = 600;
  static const double tabletMax = 1024;
}

class ShopHomeScreen extends StatefulWidget {
  const ShopHomeScreen({super.key});

  @override
  State<ShopHomeScreen> createState() => _ShopHomeScreenState();
}

class _ShopHomeScreenState extends State<ShopHomeScreen> {
  bool isArabic = true;
  bool isLoggedIn = AuthHelper.isLoggedIn();

  // Populated on every build from the current constraints.
  double _width = 0;
  bool get _isMobile => _width < _ShopBreakpoints.mobileMax;
  bool get _isTablet =>
      _width >= _ShopBreakpoints.mobileMax &&
      _width < _ShopBreakpoints.tabletMax;
  bool get _isDesktop => _width >= _ShopBreakpoints.tabletMax;

  /// Scales a value up for tablet / desktop while leaving mobile untouched.
  double _rs(double mobile, {double? tablet, double? desktop}) {
    if (_isDesktop) return desktop ?? tablet ?? mobile;
    if (_isTablet) return tablet ?? mobile;
    return mobile;
  }

  @override
  Widget build(BuildContext context) {
    // Toggle for AR/EN state demonstration

    return LayoutBuilder(
      builder: (context, constraints) {
        _width = constraints.maxWidth > 0
            ? constraints.maxWidth
            : MediaQuery.of(context).size.width;

        final double maxContentWidth =
            _isDesktop ? 960 : (_isTablet ? 720 : double.infinity);
        final double hPad = _rs(8, tablet: 20, desktop: 28);

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: Padding(
              padding: EdgeInsets.all(hPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.shopModuleBannerBg),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const SingleChildScrollView(
                      child: Column(
                        children: [
                          BadWeatherWidget(),
                          SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                  _buildHeader(),
                  SizedBox(height: _rs(16, tablet: 20, desktop: 24)),
                  _buildSearchBar(),
                  SizedBox(height: _rs(16, tablet: 20, desktop: 24)),
                  const BannerView(isFeatured: false),
                  SizedBox(height: _rs(14, tablet: 18, desktop: 20)),
                  //_buildPetProfileCard(),
                  SizedBox(height: _rs(14, tablet: 24, desktop: 28)),
                  // SizedBox(
                  //   height: _rs(120, tablet: 140, desktop: 150),
                  //   child: const PetTypeScreen(),
                  // ),
                  const CategoryView(),
                  // _buildCategoriesSection(),
                  SizedBox(height: _rs(20, tablet: 24, desktop: 28)),
                  const VisitAgainView(),
                  // const ItemThatYouLoveView(forShop: false,),
                  //_buildTodayOffersSection(),
                  SizedBox(height: _rs(20, tablet: 24, desktop: 28)),
                  const OfferTodayNew(),
                  SizedBox(height: _rs(20, tablet: 24, desktop: 28)),
                  const PopularStoreView(
                    isFeatured: false,
                    isPopular: false,
                  ),
                  SizedBox(height: _rs(20, tablet: 24, desktop: 28)),
                  const BrandsViewWidget(),
                  SizedBox(height: _rs(20, tablet: 24, desktop: 28)),
                  const FlashSaleViewWidget(),
                  // _buildStoresAndClinicsRow(),
                  SizedBox(height: _rs(20, tablet: 24, desktop: 28)),
                  _buildGroomingBanner(),
                  SizedBox(height: _rs(20, tablet: 24, desktop: 28)),
                  _buildQuickServicesSection(),
                  SizedBox(height: _rs(20, tablet: 24, desktop: 28)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // --- 1. App Header ---
  Widget _buildHeader() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bool isLoggedIn = Get.find<AuthController>().isLoggedIn();
    final double avatarRadius = _rs(20, tablet: 22, desktop: 24);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _rs(16, tablet: 20),
        vertical: _rs(12, tablet: 16),
      ),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السطر الأول: معلومات المستخدم (الصورة والاسم) + أزرار التحكم (اللغة والإشعارات)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // صورة واسم المستخدم
              Expanded(
                child: Row(
                  children: [
                    // الصورة الشخصية
                    GetBuilder<ProfileController>(builder: (profileController) {
                      bool hasImage = profileController.userInfoModel != null &&
                          isLoggedIn &&
                          (profileController
                                  .userInfoModel!.imageFullUrl?.isNotEmpty ??
                              false);

                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProfileScreen()));
                        },
                        child: CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: isDark
                              ? const Color(0xFF23242A)
                              : Colors.grey.shade200,
                          backgroundImage: hasImage
                              ? NetworkImage(
                                  profileController.userInfoModel!.imageFullUrl!)
                              : null,
                          child: !hasImage
                              ? Image.asset(
                                  Images.guestIconLight,
                                  width: avatarRadius * 1.2,
                                  height: avatarRadius * 1.2,
                                )
                              : null,
                        ),
                      );
                    }),
                    SizedBox(width: _rs(10, tablet: 12)),

                    // اسم المستخدم والترحيب
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: GetBuilder<ProfileController>(
                                builder: (profileController) {
                              return Text(
                                (isLoggedIn &&
                                        profileController.userInfoModel != null)
                                    ? '${profileController.userInfoModel?.fName ?? ''} ${profileController.userInfoModel?.lName ?? ''}'
                                    : 'guest_user'.tr,
                                style: robotoBold.copyWith(
                                  fontSize: _rs(16, tablet: 18),
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                          ),
                          SizedBox(width: _rs(4, tablet: 6)),
                          Text(
                            '👋',
                            style: TextStyle(fontSize: _rs(16, tablet: 18)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // أزرار التحكم: اللغة والإشعارات
              Row(
                children: [
                  // زر تغيير اللغة
                  _buildHeaderIconButton(
                    icon: Icons.translate,
                    onTap: () => _manageLanguageFunctionality(),
                  ),
                  SizedBox(width: _rs(8, tablet: 10)),

                  // زر الإشعارات مع الربط بالـ Controller
                  GetBuilder<NotificationController>(
                      builder: (notificationController) {
                    return _buildHeaderIconButton(
                      icon: CupertinoIcons.bell,
                      hasNotification: notificationController.hasNotification,
                      onTap: () =>
                          Get.toNamed(RouteHelper.getNotificationRoute()),
                    );
                  }),
                ],
              ),
            ],
          ),

          SizedBox(height: _rs(12, tablet: 14)),

          // السطر الثاني: كارت اختيار العنوان
          Row(
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => Get.find<LocationController>()
                    .navigateToLocationScreen('home'),
                child: Container(
                  width: _rs(200, tablet: 22),
                  padding: EdgeInsets.symmetric(
                    horizontal: _rs(12, tablet: 16),
                    vertical: _rs(10, tablet: 12),
                  ),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).primaryColor.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: GetBuilder<LocationController>(
                      builder: (locationController) {
                    final address =
                        AddressHelper.getUserAddressFromSharedPref();

                    return Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          color: Theme.of(context).primaryColor,
                          size: _rs(20, tablet: 22),
                        ),
                        SizedBox(width: _rs(8, tablet: 10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    AuthHelper.isLoggedIn()
                                        ? address?.addressType?.tr ??
                                            'your_location'.tr
                                        : 'your_location'.tr,
                                    style: robotoBold.copyWith(
                                      fontSize: _rs(12, tablet: 13),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: _rs(16, tablet: 18),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: _rs(2, tablet: 4)),
                              Text(
                                address?.address ?? '',
                                style: robotoRegular.copyWith(
                                  fontSize: _rs(11, tablet: 12),
                                  color: Theme.of(context).disabledColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              GetBuilder<ProfileController>(
                builder: (profileController) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoyaltyScreen(
                                    fromNotification: true,
                                  )));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: const Color(0xFFefa65a), width: 1),
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
                            child: const Icon(Icons.star_rounded,
                                size: 14, color: Colors.white),
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
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }

// ودجت بناء الأزرار الدائرية بالأيقونات (الإشعارات واللغة)
  Widget _buildHeaderIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasNotification = false,
  }) {
    final double btnSize = _rs(38, tablet: 42);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(btnSize),
      child: Container(
        height: btnSize,
        width: btnSize,
        decoration: BoxDecoration(
          color: Colors.black87.withValues(alpha: 0.06),
          shape: BoxShape.circle,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Icon(
              icon,
              size: _rs(20, tablet: 22),
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
            if (hasNotification)
              Positioned(
                top: _rs(6, tablet: 7),
                right: _rs(6, tablet: 7),
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      width: 1,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // --- 2. Search Bar ---
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: _rs(12, tablet: 16),
                  vertical: _rs(10, tablet: 14)),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.search,
                      color: Colors.grey[400], size: _rs(24, tablet: 26)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      Get.find<SplashController>()
                              .configModel!
                              .moduleConfig!
                              .module!
                              .showRestaurantText!
                          ? 'search_food_or_restaurant'.tr
                          : 'search_item_or_store'.tr,
                      style: robotoRegular.copyWith(
                        fontSize: Dimensions.fontSizeDefault,
                        color: Theme.of(context).hintColor.withValues(alpha: 0.8),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: EdgeInsets.all(_rs(10, tablet: 12)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(Icons.qr_code_scanner,
              color: Colors.grey[600], size: _rs(24, tablet: 26)),
        )
      ],
    );
  }

  // --- 4. Pet Profile Card ---
  Widget _buildPetProfileCard() {
    return Container(
      padding: EdgeInsets.all(_rs(12, tablet: 16)),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(children: _petProfileChildren()),
    );
  }

  List<Widget> _petProfileChildren() {
    return [
      CircleAvatar(
        radius: _rs(20, tablet: 24),
        backgroundImage: const NetworkImage('https://via.placeholder.com/100'),
      ),
      SizedBox(width: _rs(10, tablet: 14)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                isArabic ? 'لولو' : 'Lulu',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: _rs(14, tablet: 15)),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.female, size: 14, color: Colors.pink),
            ],
          ),
          Text(
            isArabic ? 'قط - عمره سنتان' : 'Cat - 2 years old',
            style: TextStyle(fontSize: _rs(11, tablet: 12), color: Colors.grey),
          ),
        ],
      ),
      const Spacer(),
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: _rs(8, tablet: 10), vertical: _rs(6, tablet: 8)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(Icons.verified,
                size: _rs(16, tablet: 18), color: const Color(0xFF6C5CE7)),
            const SizedBox(width: 4),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? 'التطعيم القادم' : 'Next Vaccine',
                  style: TextStyle(
                      fontSize: _rs(9, tablet: 10), color: Colors.grey),
                ),
                Text(
                  isArabic ? 'بعد 12 يوم' : 'In 12 days',
                  style: TextStyle(
                      fontSize: _rs(10, tablet: 11),
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF6C5CE7)),
                ),
              ],
            ),
          ],
        ),
      ),
      SizedBox(width: _rs(6, tablet: 10)),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero, minimumSize: Size.zero),
        child: Row(
          children: [
            Text(
              isArabic ? 'عرض ملفه' : 'View Profile',
              style:
                  TextStyle(fontSize: _rs(11, tablet: 12), color: Colors.grey),
            ),
            const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.grey),
          ],
        ),
      )
    ];
  }

  // --- 6. Quick Services ---
  // Widget _buildQuickServicesSection() {
  //   final List<Map<String, dynamic>> services = [
  //     {
  //       'ar': 'عيادات بيطرية',
  //       'en': 'Clinics',
  //       'icon': Icons.medical_services_outlined
  //     },
  //     {
  //       'ar': 'صيدليات بيطرية',
  //       'en': 'Pharmacy',
  //       'icon': Icons.local_pharmacy_outlined
  //     },
  //     {'ar': 'خدمات العناية', 'en': 'Grooming', 'icon': Icons.bathtub_outlined},
  //     {
  //       'ar': 'فنادق الحيوانات',
  //       'en': 'Pet Hotels',
  //       'icon': Icons.pets_outlined
  //     },
  //     {'ar': 'استشارات', 'en': 'Consult', 'icon': Icons.plus_one},
  //     {'ar': 'تدريب', 'en': 'Training', 'icon': Icons.sports_outlined},
  //   ];

  //   final double iconBoxSize = _rs(50, tablet: 58, desktop: 64);
  //   final double sectionHeight = _rs(85, tablet: 96, desktop: 104);
  //   final double itemWidth = _rs(60, tablet: 76, desktop: 84);

  //   Widget tile(Map<String, dynamic> service) {
  //     return SizedBox(
  //       width: itemWidth,
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           Container(
  //             width: iconBoxSize,
  //             height: iconBoxSize,
  //             decoration: BoxDecoration(
  //               color: const Color(0xFFF3F0FF),
  //               borderRadius: BorderRadius.circular(14),
  //             ),
  //             child: Icon(
  //               service['icon'] as IconData,
  //               color: const Color(0xFF6C5CE7),
  //               size: _rs(22, tablet: 26, desktop: 28),
  //             ),
  //           ),
  //           SizedBox(height: _rs(6, tablet: 8)),
  //           Expanded(
  //             child: Text(
  //               isArabic ? service['ar']! : service['en']!,
  //               textAlign: TextAlign.center,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               style: TextStyle(
  //                 fontSize: _rs(10, tablet: 11, desktop: 12),
  //                 fontWeight: FontWeight.w500,
  //                 height: 1.1, // ضبط ارتفاع السطر لمنع تداخل الكلمات
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _buildSectionHeader(
  //         isArabic ? 'الخدمات السريعة' : 'Quick Services',
  //         onViewAll: () {},
  //       ),
  //       const SizedBox(height: 10),
  //       if (_isMobile)
  //         // Mobile: keep the compact horizontal scroller.
  //         SizedBox(
  //           height: sectionHeight,
  //           child: ListView.separated(
  //             scrollDirection: Axis.horizontal,
  //             physics: const BouncingScrollPhysics(),
  //             padding: const EdgeInsets.symmetric(horizontal: 4),
  //             itemCount: services.length,
  //             separatorBuilder: (context, index) => const SizedBox(width: 14),
  //             itemBuilder: (context, index) => tile(services[index]),
  //           ),
  //         )
  //       else
  //         // Tablet / desktop: there's enough width to lay every service out
  //         // in an evenly spaced row instead of scrolling.
  //         Wrap(
  //           spacing: _rs(14, tablet: 20, desktop: 24),
  //           runSpacing: 16,
  //           children: services.map(tile).toList(),
  //         ),
  //     ],
  //   );
  // }
// --- 6. Quick Services ---
  Widget _buildQuickServicesSection() {
    final List<Map<String, dynamic>> services = [
      {
        'ar': 'عيادات بيطرية',
        'en': 'Clinics',
        'icon': Icons.medical_services_outlined
      },
      {
        'ar': 'صيدليات بيطرية',
        'en': 'Pharmacy',
        'icon': Icons.local_pharmacy_outlined
      },
      {'ar': 'خدمات العناية', 'en': 'Grooming', 'icon': Icons.bathtub_outlined},
      {
        'ar': 'فنادق الحيوانات',
        'en': 'Pet Hotels',
        'icon': Icons.pets_outlined
      },
      {'ar': 'استشارات', 'en': 'Consult', 'icon': Icons.plus_one},
      {'ar': 'تدريب', 'en': 'Training', 'icon': Icons.sports_outlined},
    ];

    final double iconBoxSize = _rs(50, tablet: 58, desktop: 64);
    final double sectionHeight = _rs(85, tablet: 96, desktop: 104);
    final double itemWidth = _rs(60, tablet: 76, desktop: 84);

    Widget tile(Map<String, dynamic> service) {
      return SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: iconBoxSize,
              height: iconBoxSize,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F0FF),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                service['icon'] as IconData,
                color: const Color(0xFF6C5CE7),
                size: _rs(22, tablet: 26, desktop: 28),
              ),
            ),
            SizedBox(height: _rs(6, tablet: 8)),
            Expanded(
              child: Text(
                isArabic ? service['ar']! : service['en']!,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: _rs(10, tablet: 11, desktop: 12),
                  fontWeight: FontWeight.w500,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          isArabic ? 'الخدمات السريعة' : 'Quick Services',
          onViewAll: () {},
        ),
        const SizedBox(height: 10),

        // استخدام Stack لتغطية السكشن بطبقة "قريباً"
        Stack(
          children: [
            // المحتوى الأصلي للسكشن
            if (_isMobile)
              SizedBox(
                height: sectionHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  itemCount: services.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 14),
                  itemBuilder: (context, index) => tile(services[index]),
                ),
              )
            else
              Wrap(
                spacing: _rs(14, tablet: 20, desktop: 24),
                runSpacing: 16,
                children: services.map(tile).toList(),
              ),

            // طبقة المغطي (Overlay) لمنع الضغط وإظهار كلمة قريباً
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Colors.white.withValues(alpha: 0.75), // خلفية شبه شفافة
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C5CE7),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      'Coming Soon',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: _rs(12, tablet: 14, desktop: 15),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- 8. Split Stores and Clinics Row ---
  Widget _buildStoresAndClinicsRow() {
    final int storeCount = _isMobile ? 3 : (_isTablet ? 4 : 5);
    final double storeAvatarBox = _rs(50, tablet: 60, desktop: 66);

    Widget storesColumn() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isArabic ? 'المتاجر المميزة' : 'Featured Stores',
              onViewAll: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AllStoreScreen(
                        isPopular: false,
                        isFeatured: false,
                        isNearbyStore: false,
                        isTopOfferStore: false)));
          }),
          const SizedBox(height: 8),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            spacing: 8,
            runSpacing: 8,
            children: List.generate(storeCount, (index) {
              return Container(
                width: storeAvatarBox,
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                        radius: _rs(12, tablet: 14),
                        backgroundColor: Colors.amber),
                    const SizedBox(height: 4),
                    Text('Store',
                        style: TextStyle(
                            fontSize: _rs(8, tablet: 9),
                            fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star,
                            size: _rs(8, tablet: 9), color: Colors.amber),
                        Text('4.8',
                            style: TextStyle(
                                fontSize: _rs(8, tablet: 9),
                                color: Colors.grey)),
                      ],
                    )
                  ],
                ),
              );
            }),
          )
        ],
      );
    }

    Widget clinicsColumn() {
      final int clinicCount = _isMobile ? 1 : (_isTablet ? 2 : 3);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(isArabic ? 'أقرب العيادات' : 'Nearest Clinics',
              onViewAll: () {}),
          const SizedBox(height: 8),
          Column(
            children: List.generate(clinicCount, (i) {
              return Padding(
                padding: EdgeInsets.only(bottom: i == clinicCount - 1 ? 0 : 8),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: _rs(50, tablet: 58),
                        height: _rs(50, tablet: 58),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.local_hospital,
                            color: Colors.grey, size: _rs(24, tablet: 28)),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic
                                  ? 'مركز رعاية الحيوان'
                                  : 'Pet Care Center',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: _rs(10, tablet: 11),
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    size: 10, color: Colors.amber),
                                Text('4.9',
                                    style: TextStyle(
                                        fontSize: _rs(9, tablet: 10),
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            Text(
                              isArabic
                                  ? '30-40 دقيقة | 2.10 كم'
                                  : '30-40 min | 2.10 km',
                              style: TextStyle(
                                  fontSize: _rs(8, tablet: 9),
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      );
    }

    // On mobile keep the tight two-column split; on tablet / desktop give
    // each side its own row so nothing gets cramped.
    if (_isMobile) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 5, child: storesColumn()),
          const SizedBox(width: 12),
          Expanded(flex: 6, child: clinicsColumn()),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: storesColumn()),
        const SizedBox(width: 20),
        Expanded(flex: 7, child: clinicsColumn()),
      ],
    );
  }

  // --- 9. Grooming Banner ---

Widget _buildGroomingBanner({bool isComingSoon = true}) {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(_rs(12, tablet: 18, desktop: 22)),
        decoration: BoxDecoration(
          color: const Color(0xFFFF9F43),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isArabic
                        ? 'خدمة الحلاقة والتنظيف'
                        : 'Bathing & Grooming Service',
                    style: TextStyle(
                      fontSize: _rs(13, tablet: 16, desktop: 18),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    isArabic
                        ? 'لأن حيوانك يستحق الأفضل'
                        : 'Because your pet deserves best',
                    style: TextStyle(
                      fontSize: _rs(10, tablet: 12, desktop: 13),
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: _rs(8, tablet: 12)),
                  ElevatedButton(
                    onPressed: isComingSoon ? null : () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      disabledBackgroundColor: Colors.white.withValues(alpha: 0.6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: _rs(14, tablet: 18),
                        vertical: _rs(4, tablet: 8),
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: Text(
                      isArabic ? 'احجز الآن' : 'Book Now',
                      style: TextStyle(
                        fontSize: _rs(10, tablet: 12),
                        color: isComingSoon
                            ? Colors.grey
                            : const Color(0xFFFF9F43),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Icon(
              Icons.bathtub,
              size: _rs(50, tablet: 64, desktop: 72),
              color: Colors.white30,
            ),
          ],
        ),
      ),

      // شارة قريباً (Coming Soon Badge)
      if (isComingSoon)
        Positioned(
          top: 10,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: _rs(10, tablet: 12),
              vertical: _rs(4, tablet: 6),
            ),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.65),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: Colors.amber,
                  size: _rs(12, tablet: 14),
                ),
                SizedBox(width: _rs(4, tablet: 6)),
                Text(
                  isArabic ? 'قريباً' : 'Coming Soon',
                  style: TextStyle(
                    fontSize: _rs(10, tablet: 11),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
  );
}
  // --- Helper Section Header ---
  Widget _buildSectionHeader(String title, {required VoidCallback onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: _rs(13, tablet: 15, desktop: 16),
                fontWeight: FontWeight.bold)),
        InkWell(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(isArabic ? 'عرض الكل' : 'View All',
                  style: TextStyle(
                      fontSize: _rs(10, tablet: 12), color: Colors.grey)),
              const Icon(Icons.arrow_forward_ios, size: 8, color: Colors.grey),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildHeadertest(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // السطر الأول: الترحيب باسم المستخدم والأزرار (التنبيهات واللغة)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // اسم المستخدم مع رمز الترحيب
              Row(
                children: [
                  Text(
                    '👋',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'mandoayman708',
                    style: robotoBold.copyWith(
                      fontSize: 16.sp,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),

              // الأزرار: الإشعارات وتغيير اللغة
              Row(
                children: [
                  _buildCircleIconButton(
                    icon: Icons.language_rounded,
                    onTap: () {
                      // تغيير اللغة
                    },
                  ),
                  SizedBox(width: 8.w),
                  _buildCircleIconButton(
                    icon: Icons.notifications_none_rounded,
                    hasNotification: true, // نقطة إشعارات إن وجدت
                    onTap: () {
                      // فتح التنبيهات
                    },
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 10.h),

          // السطر الثاني: كارت اختيار العنوان
          InkWell(
            onTap: () {
              // فتح شاشة اختيار العناوين
            },
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'أخرى',
                              style: robotoBold.copyWith(
                                fontSize: 12.sp,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        Text(
                          'حي الصفا، جدة السعودية',
                          style: robotoRegular.copyWith(
                            fontSize: 11.sp,
                            color: Theme.of(context).hintColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// ودجت للأزرار الدائرية (الإشعارات واللغة)
  Widget _buildCircleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasNotification = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(icon, size: 20.sp, color: Colors.black87),
            if (hasNotification)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
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
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: const LanguageBottomSheetWidget(),
        );
      },
    ).then((value) => Get.find<LocalizationController>().setLanguage(
        Get.find<LocalizationController>().getCacheLocaleFromSharedPref()));
  }
}
