import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/flash_sale/controllers/flash_sale_controller.dart';
import 'package:sixam_mart/features/home/controllers/advertisement_controller.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/home/widgets/views/best_review_product_view.dart';
import 'package:sixam_mart/features/home/widgets/views/item_that_you_love_view.dart';
import 'package:sixam_mart/features/home/widgets/views/offer_today_new.dart';
import 'package:sixam_mart/features/home/widgets/views/special_offer_view.dart';
import 'package:sixam_mart/features/home/widgets/views/top_offers_near_me.dart';
import 'package:sixam_mart/features/item/controllers/campaign_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
import 'package:sixam_mart/features/parcel/controllers/parcel_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/screens/all_store_screen.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

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
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  bool isArabic = true; // Toggle for AR/EN state demonstration

  @override
  Widget build(BuildContext context) {
    final textDirection = isArabic ? TextDirection.rtl : TextDirection.ltr;
    return Directionality(
      textDirection: textDirection,
      child: GetBuilder<HomeController>(
        builder: (homeController) {
          return Scaffold(
            backgroundColor: const Color(0xFFF9FAFC),
            bottomNavigationBar: _buildBottomNavigationBar(),
            body: SafeArea(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildBannerSlider(),
                    const SizedBox(height: 16),
                    _buildPetProfileCard(),
                    const SizedBox(height: 20),
                    _buildCategoriesSection(),
                    const SizedBox(height: 20),
                    _buildQuickServicesSection(),
                    const SizedBox(height: 20),
                  // const ItemThatYouLoveView(forShop: false,),
                   //_buildTodayOffersSection(),
                     const OfferTodayNew(),
                    const SizedBox(height: 20),
                    _buildStoresAndClinicsRow(),
                    const SizedBox(height: 20),
                    _buildGroomingBanner(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  // --- 1. App Header ---
  Widget _buildHeader() {
    return Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage('https://via.placeholder.com/100'),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  isArabic ? 'مرحباً أحمد' : 'Welcome Ahmed',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 4),
                const Text('👋', style: TextStyle(fontSize: 14)),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 12, color: Color(0xFF6C5CE7)),
                const SizedBox(width: 2),
                Text(
                  isArabic ? 'الرياض' : 'Riyadh',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const Icon(Icons.keyboard_arrow_down,
                    size: 14, color: Colors.grey),
              ],
            ),
          ],
        ),
        const Spacer(),
        // Language Toggle Action (For demonstration)
        IconButton(
          onPressed: () => setState(() => isArabic = !isArabic),
          icon: Icon(Icons.translate, color: Colors.grey[700]),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_outlined),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border),
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_bag_outlined),
            ),
            Positioned(
              right: 6,
              top: 6,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF6C5CE7),
                  shape: BoxShape.circle,
                ),
                child: const Text(
                  '3',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  // --- 2. Search Bar ---
  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.grey[400]),
                const SizedBox(width: 8),
                Text(
                  isArabic
                      ? 'ابحث عن منتج أو خدمة لحيوانك الأليف...'
                      : 'Search for product or pet service...',
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(Icons.qr_code_scanner, color: Colors.grey[600]),
        )
      ],
    );
  }

  // --- 3. Discount Banner Slider ---
  Widget _buildBannerSlider() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 140,
          decoration: BoxDecoration(
            color: const Color(0xFF6C5CE7),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: isArabic ? 'خصم ' : 'Discount ',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          const TextSpan(
                            text: '20%',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      isArabic
                          ? 'على أغذية القطط من أفضل الماركات'
                          : 'On cat food from top brands',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 9),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF9F43),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        minimumSize: Size.zero,
                      ),
                      child: Text(
                        isArabic ? 'تسوق الآن' : 'Shop Now',
                        style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              const Icon(Icons.pets, size: 80, color: Colors.white24),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 16,
                height: 4,
                decoration: BoxDecoration(
                    color: const Color(0xFF6C5CE7),
                    borderRadius: BorderRadius.circular(2))),
            const SizedBox(width: 4),
            Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                    color: Colors.grey, shape: BoxShape.circle)),
            const SizedBox(width: 4),
            Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                    color: Colors.grey, shape: BoxShape.circle)),
          ],
        )
      ],
    );
  }

  // --- 4. Pet Profile Card ---
  Widget _buildPetProfileCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F0FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage('https://via.placeholder.com/100'),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    isArabic ? 'لولو' : 'Lulu',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.female, size: 14, color: Colors.pink),
                ],
              ),
              Text(
                isArabic ? 'قط - عمره سنتان' : 'Cat - 2 years old',
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.verified, size: 16, color: Color(0xFF6C5CE7)),
                const SizedBox(width: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic ? 'التطعيم القادم' : 'Next Vaccine',
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                    ),
                    Text(
                      isArabic ? 'بعد 12 يوم' : 'In 12 days',
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C5CE7)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero, minimumSize: Size.zero),
            child: Row(
              children: [
                Text(
                  isArabic ? 'عرض ملفه' : 'View Profile',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.grey),
              ],
            ),
          )
        ],
      ),
    );
  }

  // --- 5. Pet Categories ---
  Widget _buildCategoriesSection() {
    final List<Map<String, String>> categories = [
      {'ar': 'كلاب', 'en': 'Dogs', 'icon': '🐶'},
      {'ar': 'قطط', 'en': 'Cats', 'icon': '🐱'},
      {'ar': 'طيور', 'en': 'Birds', 'icon': '🦜'},
      {'ar': 'أسماك', 'en': 'Fish', 'icon': '🐠'},
      {'ar': 'قوارض', 'en': 'Rodents', 'icon': '🐹'},
      {'ar': 'زواحف', 'en': 'Reptiles', 'icon': '🦎'},
      {'ar': 'المزيد', 'en': 'More', 'icon': '•••'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: categories.map((cat) {
        return Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF6EB),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(cat['icon']!, style: const TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 4),
            Text(
              isArabic ? cat['ar']! : cat['en']!,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
            )
          ],
        );
      }).toList(),
    );
  }

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

    return Column(
      children: [
        _buildSectionHeader(
          isArabic ? 'الخدمات السريعة' : 'Quick Services',
          onViewAll: () {},
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: services.map((service) {
            return Column(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F0FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(service['icon'],
                      color: const Color(0xFF6C5CE7), size: 22),
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 52,
                  child: Text(
                    isArabic ? service['ar']! : service['en']!,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 9, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ],
    );
  }


  // --- 8. Split Stores and Clinics Row ---
  Widget _buildStoresAndClinicsRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Featured Stores
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _buildSectionHeader(
                  isArabic ? 'المتاجر المميزة' : 'Featured Stores',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(3, (index) {
                  return Container(
                    width: 50,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: const Column(
                      children: [
                        CircleAvatar(radius: 12, backgroundColor: Colors.amber),
                        SizedBox(height: 4),
                        Text('Store',
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, size: 8, color: Colors.amber),
                            Text('4.8',
                                style:
                                    TextStyle(fontSize: 8, color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                  );
                }),
              )
            ],
          ),
        ),
        const SizedBox(width: 12),
        // Nearest Clinics
        Expanded(
          flex: 6,
          child: Column(
            children: [
              _buildSectionHeader(
                  isArabic ? 'أقرب العيادات' : 'Nearest Clinics',
                  onViewAll: () {}),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          const Icon(Icons.local_hospital, color: Colors.grey),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isArabic ? 'مركز رعاية الحيوان' : 'Pet Care Center',
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.star, size: 10, color: Colors.amber),
                              Text('4.9',
                                  style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Text(
                            isArabic
                                ? '30-40 دقيقة | 2.10 كم'
                                : '30-40 min | 2.10 km',
                            style: const TextStyle(
                                fontSize: 8, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  // --- 9. Grooming Banner ---
  Widget _buildGroomingBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
                      ? 'خدمة الاستحمام والتنظيف'
                      : 'Bathing & Grooming Service',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  isArabic
                      ? 'لأن حيوانك يستحق الأفضل'
                      : 'Because your pet deserves best',
                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    minimumSize: Size.zero,
                  ),
                  child: Text(
                    isArabic ? 'احجز الآن' : 'Book Now',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFFFF9F43),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          const Icon(Icons.bathtub, size: 50, color: Colors.white30),
        ],
      ),
    );
  }

  // --- Helper Section Header ---
  Widget _buildSectionHeader(String title, {required VoidCallback onViewAll}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        InkWell(
          onTap: onViewAll,
          child: Row(
            children: [
              Text(isArabic ? 'عرض الكل' : 'View All',
                  style: const TextStyle(fontSize: 10, color: Colors.grey)),
              const Icon(Icons.arrow_forward_ios, size: 8, color: Colors.grey),
            ],
          ),
        )
      ],
    );
  }

  // --- Bottom Navigation Bar ---
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF6C5CE7),
      unselectedItemColor: Colors.grey,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home),
          label: isArabic ? 'الرئيسية' : 'Home',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.search),
          label: isArabic ? 'البحث' : 'Search',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.receipt_long),
          label: isArabic ? 'الطلبات' : 'Orders',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.favorite_border),
          label: isArabic ? 'المفضلة' : 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.person_outline),
          label: isArabic ? 'حسابي' : 'Account',
        ),
      ],
    );
  }
  

}
