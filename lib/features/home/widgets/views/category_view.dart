import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';

class CategoryView extends StatefulWidget {
  const CategoryView({super.key});
  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      return GetBuilder<CategoryController>(builder: (categoryController) {
        final categories = categoryController.categoryList;
        if (categories == null) {
          return CategoryShimmer(categoryController: categoryController);
        }
        if (categories.isEmpty) {
          return const SizedBox();
        }

        return SizedBox(
          height: 280.h,
          child: GridView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              childAspectRatio: 1.1,
            ),
            itemCount: categories.length,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            itemBuilder: (context, index) {
              final cat = categories[index];
              final name = cat.name ?? '';
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(RouteHelper.getCategoryItemRoute(cat.id, name));
                  },
                  borderRadius: BorderRadius.circular(16.r),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        elevation: 8,
                        borderRadius: BorderRadius.circular(14.r),
                        child: SizedBox(
                          height: 90.h,
                          width: 90.w,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(14.r),
                            child: CustomImage(
                              image: cat.imageFullUrl ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  SizedBox(height: 5.h),
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: robotoBold.copyWith(fontSize: 11.sp),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      });
    });
  }
}

// نفس كلاس الشيمر بلا تعديل

class CategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  const CategoryShimmer({super.key, required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 185.h,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 0,
          childAspectRatio: 0.79,
        ),
        itemCount: 8,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
            child: Shimmer(
              duration: const Duration(seconds: 2),
              enabled: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 55.h,
                    width: 62.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.r),
                      color: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    height: 12.h,
                    width: 48.w,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
