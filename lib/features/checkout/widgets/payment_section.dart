import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/checkout/widgets/payment_method_bottom_sheet.dart';

class PaymentSection extends StatelessWidget {
  final int? storeId;
  final bool isCashOnDeliveryActive;
  final bool isDigitalPaymentActive;
  final bool isWalletActive;
  final double total;
  final CheckoutController checkoutController;
  final bool isOfflinePaymentActive;

  const PaymentSection({
    super.key,
    this.storeId,
    required this.isCashOnDeliveryActive,
    required this.isDigitalPaymentActive,
    required this.isWalletActive,
    required this.total,
    required this.checkoutController,
    required this.isOfflinePaymentActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // --- الجزء العلوي: العنوان وزر الاختيار ---
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(storeId != null ? 'payment_method'.tr : 'choose_payment_method'.tr,
            style: robotoMedium),
        storeId == null && !ResponsiveHelper.isDesktop(context)
            ? InkWell(
                onTap: () {
                  Get.bottomSheet(
                    PaymentMethodBottomSheet( 
                      isCashOnDeliveryActive: isCashOnDeliveryActive,
                      isDigitalPaymentActive: isDigitalPaymentActive,
                      isWalletActive: isWalletActive,
                      storeId: storeId,
                      totalPrice: total,
                      isOfflinePaymentActive: isOfflinePaymentActive,
                    ),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
                child: Image.asset(Images.paymentSelect, height: 24, width: 24),
              )
            : const SizedBox(),
      ]),

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text('طريقة الدفع'),
      //         Text('المزيد'),
      //       ],
      //     ),
          
      //     const Divider(),
      //     InkWell(
      //       splashColor: Colors.grey,
      //       onTap: (){
              
      //       },
      //       child: Row(
      //         children: [
      //           Image.asset('assets/image/credit-card.png',height: 28,),
      //           const SizedBox(width: 16,),
      //           Row(
      //             children: [
      //               Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   const Text('اضافة بطاقة جديده',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
      //                   Padding(
      //                     padding: const EdgeInsets.only(top: 12,bottom: 12),
      //                     child: Row(
      //                       spacing: 12,
      //                       children: [
      //                         Image.asset(
      //                           'assets/image/mada.png',
      //                           height: 22,
      //                         ),
      //                         Image.asset(
      //                           'assets/image/mastercard.webp',
      //                           height: 22,
      //                         ),
      //                         Image.asset(
      //                           'assets/image/visa.png',
      //                           height: 22,
      //                         ),
      //                         Image.asset(
      //                           'assets/image/apple_pay.JPG',
      //                           height: 22,
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //           const Spacer(),
      //           const Icon( Icons.keyboard_arrow_left),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),

      !ResponsiveHelper.isDesktop(context)
          ? const Divider()
          : const SizedBox(height: Dimensions.paddingSizeSmall),
      SizedBox(
          height: !ResponsiveHelper.isDesktop(context)
              ? Dimensions.paddingSizeSmall
              : 0),

      // --- الجزء السفلي: عرض وسيلة الدفع المحددة حالياً ---
      Container(
        decoration: ResponsiveHelper.isDesktop(context)
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                color: Theme.of(context).cardColor,
                border: Border.all(
                    color:
                        Theme.of(context).disabledColor.withValues(alpha: 0.3),
                    width: 1),
              )
            : const BoxDecoration(),
        padding: ResponsiveHelper.isDesktop(context)
            ? const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeSmall,
                horizontal: Dimensions.radiusDefault)
            : EdgeInsets.zero,
        child: storeId != null
            ? (checkoutController.paymentMethodIndex == 0
                ? Row(children: [
                    Image.asset(
                      Images.cash,
                      width: 20,
                      height: 20,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                        child: Text(
                      'cash_on_delivery'.tr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                          color: Theme.of(context).disabledColor),
                    )),
                    Text(
                      PriceConverter.convertPrice(total),
                      textDirection: TextDirection.ltr,
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).primaryColor),
                    )
                  ])
                : const SizedBox())
            : InkWell(
                onTap: () {
                  if (ResponsiveHelper.isDesktop(context) &&
                      checkoutController.paymentMethodIndex == -1) {
                    Get.dialog(Dialog(
                        backgroundColor: Colors.transparent,
                        child: PaymentMethodBottomSheet(
                          isCashOnDeliveryActive: isCashOnDeliveryActive,
                          isDigitalPaymentActive: isDigitalPaymentActive,
                          isWalletActive: isWalletActive,
                          storeId: storeId,
                          totalPrice: total,
                          isOfflinePaymentActive: isOfflinePaymentActive,
                        )));
                  }
                },
                child: Row(children: [
                  // عرض الأيقونة بناءً على الـ Index المختار
                  checkoutController.paymentMethodIndex != -1
                      ? Image.asset(
                          checkoutController.paymentMethodIndex == 0
                              ? Images.cash
                              : checkoutController.paymentMethodIndex == 1
                                  ? Images.wallet
                                  : checkoutController.paymentMethodIndex == 2
                                      ? Images.digitalPayment
                                      : checkoutController.paymentMethodIndex ==
                                              4
                                          ? Images
                                              .offlinePayment // أيقونة تمارا المضافة من قبلك
                                          : Images.cash,
                          width: 20,
                          height: 20,
                          color: Theme.of(context).textTheme.bodyMedium!.color,
                        )
                      : Icon(
                          !ResponsiveHelper.isDesktop(context)
                              ? Icons.wallet_outlined
                              : Icons.add_circle_outline_sharp,
                          size: 18,
                          color: !ResponsiveHelper.isDesktop(context)
                              ? Theme.of(context).disabledColor
                              : Theme.of(context).primaryColor,
                        ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  // عرض النص المترجم بناءً على الـ Index المختار
                  Expanded(
                      child: Row(children: [
                    Text(
                      checkoutController.paymentMethodIndex == 0
                          ? 'cash_on_delivery'.tr
                          : checkoutController.paymentMethodIndex == 1
                              ? 'wallet_payment'.tr
                              : checkoutController.paymentMethodIndex == 2
                                  ? 'digital_payment'.tr
                                  : checkoutController.paymentMethodIndex == 4
                                      ? 'tamara'.tr // نص تمارا مع الترجمة
                                      : checkoutController.paymentMethodIndex ==
                                              3
                                          ? '${'offline_payment'.tr}(${checkoutController.offlineMethodList![checkoutController.selectedOfflineBankIndex].methodName})'
                                          : !ResponsiveHelper.isDesktop(context)
                                              ? 'select_payment_method'.tr
                                              : 'add_payment_method'.tr,
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: !ResponsiveHelper.isDesktop(context)
                            ? Theme.of(context).disabledColor
                            : checkoutController.paymentMethodIndex == -1
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).disabledColor,
                      ),
                    ),

                    // إشارة تحذيرية في حالة عدم اختيار وسيلة دفع
                    checkoutController.paymentMethodIndex == -1 &&
                            !ResponsiveHelper.isDesktop(context)
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: Dimensions.paddingSizeExtraSmall),
                            child: Icon(Icons.warning_rounded,
                                size: 16,
                                color: Theme.of(context).colorScheme.error),
                          )
                        : const SizedBox(),
                  ])),

                  // عرض السعر النهائي متضمناً حركة الأنيميشن المعتمدة في السكريبت
                  checkoutController.paymentMethodIndex != -1
                      ? PriceConverter.convertAnimationPrice(
                          checkoutController.viewTotalPrice,
                          textStyle: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Theme.of(context).primaryColor),
                        )
                      : const SizedBox(),

                  SizedBox(
                      width: ResponsiveHelper.isDesktop(context)
                          ? Dimensions.paddingSizeSmall
                          : 0),

                  storeId == null && ResponsiveHelper.isDesktop(context)
                      ? InkWell(
                          onTap: () {
                            Get.dialog(Dialog(
                                backgroundColor: Colors.transparent,
                                child: PaymentMethodBottomSheet(
                                  isCashOnDeliveryActive:
                                      isCashOnDeliveryActive,
                                  isDigitalPaymentActive:
                                      isDigitalPaymentActive,
                                  isWalletActive: isWalletActive,
                                  storeId: storeId,
                                  totalPrice: total,
                                  isOfflinePaymentActive:
                                      isOfflinePaymentActive,
                                )));
                          },
                          child: Image.asset(Images.paymentSelect,
                              height: 24, width: 24),
                        )
                      : const SizedBox(),
                ]),
              ),
      ),
    ]);
  }
}
