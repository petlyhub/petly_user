import 'package:flutter/rendering.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/category/domain/models/category_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/paginated_list_view.dart';
import 'package:sixam_mart/common/widgets/veg_filter_widget.dart';
import 'package:sixam_mart/common/widgets/web_item_view.dart';
import 'package:sixam_mart/common/widgets/web_item_widget.dart';
import 'package:sixam_mart/common/widgets/web_menu_bar.dart';
import 'package:sixam_mart/features/checkout/screens/checkout_screen.dart';
import 'package:sixam_mart/features/search/widgets/custom_check_box_widget.dart';
import 'package:sixam_mart/features/store/widgets/customizable_space_bar_widget.dart';
import 'package:sixam_mart/features/store/widgets/store_banner_widget.dart';
import 'package:sixam_mart/features/store/widgets/store_description_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/store/widgets/store_details_screen_shimmer_widget.dart';

import '../widgets/bottom_cart_widget.dart';

class StoreScreen extends StatefulWidget {
  final Store? store;
  final bool fromModule;
  final String slug;
  const StoreScreen({super.key, required this.store, required this.fromModule, this.slug = ''});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool get _hideSubcats => _selectedParentCategoryId == null || _selectedParentCategoryId == 0;

  // الحالة المختارة للفلترة
  int? _selectedParentCategoryId;
  int? _selectedSubCategoryId;


  int? _idOf(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is CategoryIds) return v.id;       // من موديل sixam_mart
    if (v is CategoryModel) return v.id;     // احتياطًا لو مرت كائنات CategoryModel
    if (v is Map) {
      final val = v['id'];
      if (val is int) return val;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    initDataCall();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> initDataCall() async {
    if(Get.find<StoreController>().isSearching) {
      Get.find<StoreController>().changeSearchStatus(isUpdate: false);
    }
    Get.find<StoreController>().hideAnimation();
    await Get.find<StoreController>().getStoreDetails(Store(id: widget.store!.id), widget.fromModule, slug: widget.slug).then((value) {
      Get.find<StoreController>().showButtonAnimation();
    });
    if(Get.find<CategoryController>().categoryList == null) {
      Get.find<CategoryController>().getCategoryList(true);
    }
    Get.find<StoreController>().getStoreBannerList(widget.store!.id ?? Get.find<StoreController>().store!.id);
    Get.find<StoreController>().getRestaurantRecommendedItemList(widget.store!.id ?? Get.find<StoreController>().store!.id, false);
    Get.find<StoreController>().getStoreItemList(widget.store!.id ?? Get.find<StoreController>().store!.id, 1, 'all', false);

    scrollController.addListener(() {
      if(scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(Get.find<StoreController>().showFavButton){
          Get.find<StoreController>().changeFavVisibility();
          Get.find<StoreController>().hideAnimation();
        }
      }else{
        if(!Get.find<StoreController>().showFavButton){
          Get.find<StoreController>().changeFavVisibility();
          Get.find<StoreController>().showButtonAnimation();
        }
      }
    });
  }

  // ===== Helpers: استخراج الأقسام الفرعية وفلترة العناصر =====
  List<CategoryModel> _getSubCategories(CategoryController cc, int? parentId) {
    if (cc.categoryList == null || parentId == null) return const [];
    return cc.categoryList!.where((c) => c.parentId == parentId).toList();
  }

  /// تأكيد أن عنصر ما ينتمي لقسم معيّن (يدعم categoryId أو categoryIds)
  bool _itemBelongsToCategory(Item item, int categoryId, CategoryController cc) {
    final Set<int> itemCats = {};
    try {
      final cidInt = _idOf(item.categoryId);
      if (cidInt != null) itemCats.add(cidInt);
    } catch (_) {}


    try {
      final ids = item.categoryIds;
      if (ids != null) {
        for (final x in ids) {
          final idInt = _idOf(x);
          if (idInt != null) itemCats.add(idInt);
        }
      }
    } catch (_) {}



    // يطابق القسم ذاته؟
    if (itemCats.contains(categoryId)) return true;

    // يطابق أب القسم؟
    final Map<int, int?> parentOf = {
      for (final c in (cc.categoryList ?? [])) if (c.id != null) c.id!: c.parentId
    };
    for (final id in itemCats) {
      if (parentOf[id] == categoryId) return true;
    }
    return false;
  }

  List<Item>? _applyCategoryFilter(List<Item>? base, CategoryController cc) {
    if (base == null) return null;
    if (_selectedSubCategoryId != null) {
      return base.where((it) => _itemBelongsToCategory(it, _selectedSubCategoryId!, cc)).toList();
    }
    if (_selectedParentCategoryId != null) {
      return base.where((it) => _itemBelongsToCategory(it, _selectedParentCategoryId!, cc)).toList();
    }
    return base;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
        endDrawer: const MenuDrawer(),endDrawerEnableOpenDragGesture: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: GetBuilder<StoreController>(builder: (storeController) {
          return GetBuilder<CategoryController>(builder: (categoryController) {
            Store? store;
            if(storeController.store != null && storeController.store!.name != null && categoryController.categoryList != null) {
              store = storeController.store;
              storeController.setCategoryList();
              // تهيئة اختيار مبدئي: أول قسم رئيسي
              _selectedParentCategoryId ??= (storeController.categoryList!.isNotEmpty ? storeController.categoryList![storeController.categoryIndex].id : null);
            }

            final bool ready = (storeController.store != null && storeController.store!.name != null && categoryController.categoryList != null);

            return ready ? CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              slivers: [

                // ======= WEB HEADER / APP BAR (كما هو) =======
                ResponsiveHelper.isDesktop(context) ? SliverToBoxAdapter(
                  child: Container(
                    color: const Color(0xFF171A29),
                    padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                    alignment: Alignment.center,
                    child: Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                      child: Row(children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            child: Stack(
                              children: [
                                CustomImage(
                                  fit: BoxFit.fitHeight, height: 240, width: 590,
                                  image: store?.coverPhotoFullUrl ?? '',
                                ),
                                store?.discount != null ? Positioned(
                                  bottom: 0, left: 0, right: 0,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                    child: Text(
                                      '${store?.discount!.discountType == 'percent' ? '${store?.discount!.discount}% ${'off'.tr}'
                                          : '${PriceConverter.convertPrice(store?.discount!.discount)} ${'off'.tr}'} '
                                          '${'on_all_products'.tr}, ${'after_minimum_purchase'.tr} ${PriceConverter.convertPrice(store?.discount!.minPurchase)},'
                                          ' ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(store!.discount!.startTime!)} '
                                          '- ${DateConverter.convertTimeToTime(store.discount!.endTime!)}',
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.black),
                                      textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ) : const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: Dimensions.paddingSizeLarge),
                        Expanded(child: StoreDescriptionViewWidget(store: store)),
                      ]),
                    ))),
                  ),
                ) : SliverAppBar(
                  expandedHeight: 300, toolbarHeight: 100,
                  pinned: true, floating: false, elevation: 0.5,
                  backgroundColor: Theme.of(context).cardColor,
                  leading: IconButton(
                    icon: Container(
                      height: 50, width: 50,
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Icon(Icons.chevron_left, color: Theme.of(context).cardColor),
                    ),
                    onPressed: () => Get.back(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    titlePadding: EdgeInsets.zero,
                    centerTitle: true,
                    expandedTitleScale: 1.1,
                    title: CustomizableSpaceBarWidget(
                      builder: (context, scrollingRate) {
                        return Container(
                          height: store!.discount != null ? 145 : 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
                          ),
                          child: Column(
                            children: [
                              store.discount != null ? Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withValues(alpha: 1 - scrollingRate),
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
                                ),
                                padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall - (GetPlatform.isAndroid ? (scrollingRate * Dimensions.paddingSizeExtraSmall) : 0)),
                                child: Text(
                                  '${store.discount!.discountType == 'percent' ? '${store.discount!.discount}% ${'off'.tr}'
                                      : '${PriceConverter.convertPrice(store.discount!.discount)} ${'off'.tr}'} '
                                      '${'on_all_products'.tr}, ${'after_minimum_purchase'.tr} ${PriceConverter.convertPrice(store.discount!.minPurchase)},'
                                      ' ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(store.discount!.startTime!)} '
                                      '- ${DateConverter.convertTimeToTime(store.discount!.endTime!)}',
                                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                                    color: Colors.black.withValues(alpha: 1 - scrollingRate),
                                  ),
                                  textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                                ),
                              ) : const SizedBox(),

                              Container(
                                color: Theme.of(context).cardColor.withValues(alpha: scrollingRate),
                                padding: EdgeInsets.only(
                                  bottom: 0,
                                  left: Get.find<LocalizationController>().isLtr ? 40 * scrollingRate : 0,
                                  right: Get.find<LocalizationController>().isLtr ? 0 : 40 * scrollingRate,
                                ),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    height: 100, color: Theme.of(context).cardColor.withValues(alpha: scrollingRate == 0.0 ? 1 : 0),
                                    padding: EdgeInsets.only(
                                      left: Get.find<LocalizationController>().isLtr ? 20 : 0,
                                      right: Get.find<LocalizationController>().isLtr ? 0 : 20,
                                    ),
                                    child: Row(children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                        child: Stack(children: [
                                          Material(
                                            elevation: 12,
                                            borderOnForeground: true,
                                            
                                            child: CustomImage(
                                              image: '${store.logoFullUrl}',
                                              
                                              height: 60 - (scrollingRate * 15), width: 70 - (scrollingRate * 15), fit: BoxFit.cover,
                                            ),
                                          ),
                                          storeController.isStoreOpenNow(store.active!, store.schedules) ? const SizedBox() : Positioned(
                                            bottom: 0, left: 0, right: 0,
                                            child: Container(
                                              height: 30,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Dimensions.radiusSmall)),
                                                color: Colors.black.withValues(alpha: 0.6),
                                              ),
                                              child: Text('closed_now'.tr, textAlign: TextAlign.center,
                                                style: robotoRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ),
                                      const SizedBox(width: Dimensions.paddingSizeSmall),
                                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Row(children: [
                                          Expanded(child: Text(
                                            store.name!, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge - (scrollingRate * 3), color: Theme.of(context).textTheme.bodyMedium!.color),
                                            maxLines: 1, overflow: TextOverflow.ellipsis,
                                          )),
                                          const SizedBox(width: Dimensions.paddingSizeSmall),
                                        ]),
                                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                        Text(
                                          store.address ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
                                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall - (scrollingRate * 2), color: Theme.of(context).disabledColor),
                                        ),
                                        SizedBox(height: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0),
                                        Row(children: [
                                          Flexible(
                                            child: Text('minimum_order'.tr, style: robotoRegular.copyWith(
                                              fontSize: Dimensions.fontSizeExtraSmall - (scrollingRate * 2), color: Theme.of(context).disabledColor,
                                            ), maxLines: 1, overflow: TextOverflow.ellipsis),
                                          ),
                                          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                          Text(
                                            PriceConverter.convertPrice(store.minimumOrder), textDirection: TextDirection.ltr,
                                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall - (scrollingRate * 2), color: Theme.of(context).primaryColor),
                                          ),
                                        ]),
                                      ])),
                                      GetBuilder<FavouriteController>(builder: (favouriteController) {
                                        bool isWished = favouriteController.wishStoreIdList.contains(store!.id);
                                        return InkWell(
                                          onTap: () {
                                            if(AuthHelper.isLoggedIn()) {
                                              isWished
                                                  ? favouriteController.removeFromFavouriteList(store!.id, true)
                                                  : favouriteController.addToFavouriteList(null, store?.id, true);
                                            }else {
                                              showCustomSnackBar('you_are_not_logged_in'.tr);
                                            }
                                          },
                                          child: Material(
                                            elevation: 12,
                                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                              ),
                                              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                              child: Icon(
                                                isWished ? Icons.favorite : Icons.favorite_border,
                                                color: isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                                                size: 24  - (scrollingRate * 4),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                      const SizedBox(width: Dimensions.paddingSizeSmall),
                                      AppConstants.webHostedUrl.isNotEmpty ? InkWell(
                                        onTap: () { storeController.shareStore(); },
                                        child: Material(
                                          elevation: 12,
                                           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                            ),
                                            padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                            child: const Icon(Icons.share,),
                                          ),
                                        ),
                                      ) : const SizedBox(),
                                      const SizedBox(width: Dimensions.paddingSizeSmall),
                                    ]),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    background: CustomImage(fit: BoxFit.cover, image: '${store!.coverPhotoFullUrl}'),
                  ),
                  actions: const [SizedBox()], 
                ),

                // ======= Recommended (كما هو) =======
                (ResponsiveHelper.isDesktop(context)  && storeController.recommendedItemModel != null && storeController.recommendedItemModel!.items!.isNotEmpty)
                    ? SliverToBoxAdapter(
                  child: Container(
                    color: Theme.of(context).primaryColor.withValues(alpha: 0.10),
                    child: Center(
                      child: SizedBox(
                        width: Dimensions.webMaxWidth,
                        height: ResponsiveHelper.isDesktop(context) ? 325 : 125,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: Dimensions.paddingSizeSmall),
                            Text('recommended_for_you'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w700)),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                            Text('here_is_what_you_might_like'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
                            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: storeController.recommendedItemModel!.items!.length,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                itemBuilder: (context, index) {
                                  return Container(
                                    width:  225,
                                    padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, left: Dimensions.paddingSizeExtraSmall),
                                    margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                    child: WebItemWidget(
                                      isStore: false, item: storeController.recommendedItemModel!.items![index],
                                      store: null, index: index, length: null, isCampaign: false, inStore: true,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),  
                    ),
                  ),
                ): const SliverToBoxAdapter(child: SizedBox()),
                const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeSmall)),

                /// ========== WEB VIEW: أقسام + أقسام فرعية + فلترة ==========
                ResponsiveHelper.isDesktop(context) ? SliverToBoxAdapter(
                  child: FooterView(
                    child: SizedBox(
                      width: Dimensions.webMaxWidth,
                      child: Padding(
                        padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 240,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // الأقسام الرئيسية
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: storeController.categoryList!.length,
                                          padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            final cat = storeController.categoryList![index];
                                            final isActive = index == storeController.categoryIndex;
                                            return InkWell(
                                              onTap: () {
                                                storeController.setCategoryIndex(index, itemSearching: storeController.isSearching);
                                                setState(() {
                                                  _selectedParentCategoryId = cat.id;
                                                  _selectedSubCategoryId = null; // reset
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                                child: Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          begin: Alignment.bottomRight,
                                                          end: Alignment.topLeft,
                                                          colors: <Color>[
                                                            isActive ? Theme.of(context).primaryColor.withValues(alpha: 0.50) : Colors.transparent,
                                                            isActive ? Theme.of(context).cardColor : Colors.transparent,
                                                          ]
                                                      )
                                                  ),
                                                  child: Text(
                                                    cat.name ?? '',
                                                    maxLines: 1, overflow: TextOverflow.ellipsis,
                                                    style: isActive
                                                        ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)
                                                        : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: storeController.categoryList!.length * 50, width: 1,
                                        color: Theme.of(context).disabledColor.withValues(alpha: 0.5),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: Dimensions.paddingSizeSmall),

                                  // الأقسام الفرعية للقسم المحدد
                                  Builder(
                                    builder: (_) {
                                      final subs = _getSubCategories(categoryController, _selectedParentCategoryId);
                                      if (subs.isEmpty) return const SizedBox();
                                      return Container(
                                        padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall),
                                        child: Wrap(
                                          spacing: 8, runSpacing: 8,
                                          children: subs.map((sub) {
                                            final selected = _selectedSubCategoryId == sub.id;
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  _selectedSubCategoryId = sub.id;
                                                });
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                                  border: Border.all(
                                                    color: selected ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withValues(alpha: 0.25),
                                                  ),
                                                  color: selected ? Theme.of(context).primaryColor.withValues(alpha: 0.08) : Theme.of(context).cardColor,
                                                ),
                                                child: Text(sub.name ?? '', style: robotoRegular.copyWith(
                                                  fontSize: Dimensions.fontSizeSmall,
                                                  color: selected ? Theme.of(context).primaryColor : null,
                                                )),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeLarge),

                            // المنتجات (ويب) مع الفلترة
                            Expanded(child: Column (
                              children: [
                                // شريط البحث والفلاتر (كما هو)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                      height: 45,
                                      width: 430,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                        color: Theme.of(context).cardColor,
                                        border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.40)),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: TextField(
                                              controller: _searchController,
                                              textInputAction: TextInputAction.search,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                                hintText: 'search_for_items'.tr,
                                                hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), borderSide: BorderSide.none),
                                                filled: true, fillColor:Theme.of(context).cardColor,
                                                isDense: true,
                                                prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor.withValues(alpha: 0.50)),
                                              ),
                                              onSubmitted: (String? value) {
                                                if(value!.isNotEmpty) {
                                                  Get.find<StoreController>().getStoreSearchItemList(
                                                    _searchController.text.trim(), widget.store!.id.toString(), 1, storeController.type,
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: Dimensions.paddingSizeSmall),
                                          !storeController.isSearching ? CustomButton(
                                            radius: Dimensions.radiusSmall,
                                            height: 40,
                                            width: 74,
                                            buttonText: 'search'.tr,
                                            isBold: false,
                                            fontSize: Dimensions.fontSizeSmall,
                                            onPressed: () {
                                              storeController.getStoreSearchItemList(
                                                _searchController.text.trim(), widget.store!.id.toString(), 1, storeController.type,
                                              );
                                            },
                                          ) : InkWell(
                                            onTap: () {
                                              _searchController.text = '';
                                              storeController.initSearchData();
                                              storeController.changeSearchStatus();
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context).primaryColor,
                                                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 3, horizontal: Dimensions.paddingSizeSmall),
                                              child: const Icon(Icons.clear, color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: Dimensions.paddingSizeSmall),

                                    (Get.find<SplashController>().configModel!.moduleConfig!.module!.vegNonVeg! && Get.find<SplashController>().configModel!.toggleVegNonVeg!)
                                        ? SizedBox(
                                      width: 300,
                                      height:  30,
                                      child:  ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: Get.find<ItemController>().itemTypeList.length,
                                        padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                            child:  CustomCheckBoxWidget(
                                              title: Get.find<ItemController>().itemTypeList[index].tr,
                                              value: storeController.type == Get.find<ItemController>().itemTypeList[index],
                                              onClick: () {
                                                if(storeController.isSearching){
                                                  storeController.getStoreSearchItemList(
                                                    storeController.searchText, widget.store!.id.toString(), 1, Get.find<ItemController>().itemTypeList[index],
                                                  );
                                                } else {
                                                  storeController.getStoreItemList(storeController.store!.id, 1, Get.find<ItemController>().itemTypeList[index], true);
                                                }
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                    ) : const SizedBox(),
                                  ],
                                ),
                                const SizedBox(height: Dimensions.paddingSizeSmall),

                                // مصدر العناصر + تطبيق الفلترة
                                Builder(
                                  builder: (_) {
                                    final baseItems = storeController.isSearching
                                        ? storeController.storeSearchItemModel?.items
                                        : (storeController.categoryList!.isNotEmpty && storeController.storeItemModel != null)
                                        ? storeController.storeItemModel!.items
                                        : null;

                                    final filtered = _applyCategoryFilter(baseItems, categoryController);

                                    return PaginatedListView(
                                      scrollController: scrollController,
                                      onPaginate: (int? offset) {
                                        if(storeController.isSearching){
                                          storeController.getStoreSearchItemList(
                                            storeController.searchText, widget.store!.id.toString(), offset!, storeController.type,
                                          );
                                        } else {
                                          storeController.getStoreItemList(widget.store!.id ?? storeController.store!.id, offset!, storeController.type, false);
                                        }
                                      },
                                      totalSize: storeController.isSearching
                                          ? storeController.storeSearchItemModel?.totalSize
                                          : storeController.storeItemModel?.totalSize,
                                      offset: storeController.isSearching
                                          ? storeController.storeSearchItemModel?.offset
                                          : storeController.storeItemModel?.offset,
                                      itemView: WebItemsView(
                                        isStore: false, stores: null, fromStore: true,
                                        items: filtered,
                                        inStorePage: true,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: Dimensions.paddingSizeSmall,
                                          vertical: Dimensions.paddingSizeSmall,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ) : const SliverToBoxAdapter(child:SizedBox()),

                /// ========== MOBILE VIEW ==========
                ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox()) :
                SliverToBoxAdapter(child: Center(child: Container(
                  width: Dimensions.webMaxWidth,
                  padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                  color: Theme.of(context).cardColor,
                  child: Column(children: [
                    ResponsiveHelper.isDesktop(context) ? const SizedBox() : StoreDescriptionViewWidget(store: store),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    store?.announcementActive??false ? Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        border: Border.all(color: Theme.of(context).primaryColor.withValues(alpha: 0.2)),
                      ),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                      margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                      child: Row(children: [
                        Image.asset(Images.announcement, height: 20, width: 20),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        Flexible(child: Text(store?.announcementMessage??'', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
                      ]),
                    ) : const SizedBox(),

                    StoreBannerWidget(storeController: storeController),
                    const SizedBox(height: Dimensions.paddingSizeLarge),

                    (!ResponsiveHelper.isDesktop(context) && storeController.recommendedItemModel != null && storeController.recommendedItemModel!.items!.isNotEmpty) ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('recommended_for_you'.tr, style: robotoMedium),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                        SizedBox(
                          height: ResponsiveHelper.isDesktop(context) ? 150 : 130,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: storeController.recommendedItemModel!.items!.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.symmetric(vertical: 20) : const EdgeInsets.symmetric(vertical: 10) ,
                                child: Container(
                                  width: ResponsiveHelper.isDesktop(context) ? 500 : 300,
                                  padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, left: Dimensions.paddingSizeExtraSmall),
                                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                  child: ItemWidget(
                                    isStore: false, item: storeController.recommendedItemModel!.items![index],
                                    store: null, index: index, length: null, isCampaign: false, inStore: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ) : const SizedBox(),
                  ]),
                ))),

                // ======= شريط العناوين (موبايل) + الأقسام الفرعية + فلترة =======
                ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox()) :
                (storeController.categoryList!.isNotEmpty) ? SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(height: 128, child: Center(child: Container(
                    width: Dimensions.webMaxWidth,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                    child: Column(
                      children: [
                        // العنوان والبحث/الفلاتر
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                          child: Row(children: [
                            Text('all_products'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                            const Expanded(child: SizedBox()),
                            !ResponsiveHelper.isDesktop(context) ? InkWell(
                              onTap: ()=> Get.toNamed(RouteHelper.getSearchStoreItemRoute(store!.id)),
                              child: Material(
                                elevation: 12,
                                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                                  ),
                                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                                  child: Icon(Icons.search, size: 28, color: Theme.of(context).primaryColor),
                                ),
                              ),
                            ) : const SizedBox(),
                            storeController.type.isNotEmpty ? VegFilterWidget(
                              type: storeController.type,
                              onSelected: (String type) {
                                storeController.getStoreItemList(storeController.store!.id, 1, type, true);
                              },
                            ) : const SizedBox(),
                          ]),
                        ),
                        const SizedBox(height: Dimensions.paddingSizeSmall),

                        // الأقسام الرئيسية (موبايل)
                        SizedBox(
                          height:  30 ,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: storeController.categoryList!.length,
                            padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final cat = storeController.categoryList![index];
                              final isActive = index == storeController.categoryIndex;
                              return InkWell(
                                onTap: () async {
                                  storeController.setCategoryIndex(index);
                                  setState(() {
                                    _selectedParentCategoryId = cat.id;
                                    _selectedSubCategoryId = null;
                                  });
                                  // اطلب الفرعية فقط إذا id != 0
                                  if (cat.id != null && cat.id != 0) {
                                    Get.find<CategoryController>().getSubCategoryList(cat.id.toString());
                                  }                                  setState(() {});
                                },

                                child: Container( 
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                                  margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                    color: isActive ? Theme.of(context).primaryColor.withValues(alpha: 0.1) : Colors.transparent,
                                  ),
                                  child: Text(
                                    cat.name ?? '',
                                    style: isActive
                                        ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)
                                        : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 6),

                        // الأقسام الفرعية (موبايل) – فلترة محلية
                        Builder(
                          builder: (_) {
                            if (_hideSubcats) return const SizedBox(height: 0); // اخفاء عند 0 أو null
                            final subs = categoryController.subCategoryList ?? const <CategoryModel>[];
                            if (subs.isEmpty) return const SizedBox(height: 0);
                            return SizedBox(
                              height: 28,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: subs.length,
                                padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, i) {
                                  final sub = subs[i];
                                  final selected = _selectedSubCategoryId == sub.id;
                                  return InkWell(
                                    onTap: () => setState(() => _selectedSubCategoryId = sub.id),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 4),
                                      margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                        border: Border.all(
                                          color: selected ? Theme.of(context).primaryColor
                                              : Theme.of(context).primaryColor.withValues(alpha: 0.25),
                                        ),
                                        color: selected ? Theme.of(context).primaryColor.withValues(alpha: 0.08)
                                            : Theme.of(context).cardColor,
                                      ),
                                      child: Center(child: Text(sub.name ?? '', style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: selected ? Theme.of(context).primaryColor : null,
                                      ))),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ))),
                ) : const SliverToBoxAdapter(child: SizedBox()),

                // المنتجات (موبايل) مع الفلترة
                ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox()) :
                SliverToBoxAdapter(child: Builder(
                  builder: (_) {
                    final baseItems = (storeController.categoryList!.isNotEmpty && storeController.storeItemModel != null)
                        ? storeController.storeItemModel!.items
                        : null;
                    final filtered = _applyCategoryFilter(baseItems, categoryController);

                    return Container(
                      width: Dimensions.webMaxWidth,
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
                      child: PaginatedListView(
                        scrollController: scrollController,
                        onPaginate: (int? offset) => storeController.getStoreItemList(
                            widget.store!.id ?? storeController.store!.id, offset!, storeController.type, false),
                        totalSize: storeController.storeItemModel?.totalSize,
                        offset: storeController.storeItemModel?.offset,
                        itemView: ItemsView(
                          isStore: false, stores: null,
                          items: filtered,
                          inStorePage: true,
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeSmall,
                            vertical: Dimensions.paddingSizeSmall,
                          ),
                        ),
                      ),
                    );
                  },
                )),
              ],
            ) : const StoreDetailsScreenShimmerWidget();
          });
        }),

        floatingActionButton: GetBuilder<StoreController>(
            builder: (storeController) {
              return Visibility(
                visible: storeController.showFavButton && Get.find<SplashController>().configModel!.moduleConfig!.module!.orderAttachment!
                    && (storeController.store != null && storeController.store!.prescriptionOrder!)
                    && Get.find<SplashController>().configModel!.prescriptionStatus! && AuthHelper.isLoggedIn(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: 0.5), blurRadius: 10, offset: const Offset(2, 2))],
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 800),
                      width: storeController.currentState == true ? 0 : ResponsiveHelper.isDesktop(context) ? 180 : 150,
                      height: 30,
                      curve: Curves.linear,
                      child:  Center(
                        child: Text(
                          'prescription_order'.tr, textAlign: TextAlign.center,
                          style: robotoMedium.copyWith(color: Theme.of(context).primaryColor), maxLines: 1, overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Get.toNamed(
                        RouteHelper.getCheckoutRoute('prescription', storeId: storeController.store!.id),
                        arguments: CheckoutScreen(fromCart: false, cartList: null, storeId: storeController.store!.id,),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        ),
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: Image.asset(Images.prescriptionIcon, height: 25, width: 25),
                      ),
                    ),
                  ]),
                ),
              );
            }
        ),

        bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
          return cartController.cartList.isNotEmpty && !ResponsiveHelper.isDesktop(context) ? const BottomCartWidget() : const SizedBox();
        })
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 100});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) => child;
  @override
  double get maxExtent => height;
  @override
  double get minExtent => height;
  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}

class CategoryProduct {
  CategoryModel category;
  List<Item> products;
  CategoryProduct(this.category, this.products);
}
