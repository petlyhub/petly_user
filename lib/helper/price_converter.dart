import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/styles.dart';

class PriceConverter {
  static String convertPrice(double? price, {double? discount, String? discountType, bool forDM = false, bool isFoodVariation = false, String? formatedStringPrice, bool forTaxi = false}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount' && !isFoodVariation) {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool isArabic = Get.locale?.languageCode == 'ar';
    bool isRightSide = true;
    String currency = isArabic ? 'ر.س' : 'SAR';

    String formatted;
    if(forTaxi && price! > 100000) {
      formatted = '${isRightSide ? '' : '$currency '}'
          '${intl.NumberFormat.compact().format(price)}'
          '${isRightSide ? ' $currency' : ''}';
    } else {
      formatted = '${isRightSide ? '' : '$currency '}'
          '${formatedStringPrice ?? toFixed(price!).toStringAsFixed(forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!)
          .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
          '${isRightSide ? ' $currency' : ''}';
    }
    return isArabic ? _toArabicDigits(formatted) : formatted;
  }

  static String _toArabicDigits(String s) {
    return s.replaceAll('0', '\u0660').replaceAll('1', '\u0661').replaceAll('2', '\u0662')
        .replaceAll('3', '\u0663').replaceAll('4', '\u0664').replaceAll('5', '\u0665')
        .replaceAll('6', '\u0666').replaceAll('7', '\u0667').replaceAll('8', '\u0668').replaceAll('9', '\u0669');
  }

  static Widget convertAnimationPrice(double? price, {double? discount, String? discountType, bool forDM = false, TextStyle? textStyle}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    bool isArabic = Get.locale?.languageCode == 'ar';
    bool isRightSide = true;
    String currency = isArabic ? 'ر.س' : 'SAR';
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedFlipCounter(
        duration: const Duration(milliseconds: 500),
        value: toFixed(price!),
        textStyle: textStyle ?? robotoMedium,
        fractionDigits: forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!,
        prefix: isRightSide ? '' : '$currency ',
        suffix: isRightSide ? ' $currency' : '',
      ),
    );
  }

  static double? convertWithDiscount(double? price, double? discount, String? discountType, {bool isFoodVariation = false}) {
    if(discountType == 'amount' && !isFoodVariation) {
      price = price! - discount!;
    }else if(discountType == 'percent') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double? discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount' || type == 'fixed') {
      calculatedAmount = discount! * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount! / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    bool isArabic = Get.locale?.languageCode == 'ar';
    String currency = isArabic ? 'ر.س' : 'SAR';
    return '$discount${discountType == 'percent' ? '%' : currency} OFF';
  }

  static double toFixed(double val) {
    num mod = power(10, Get.find<SplashController>().configModel!.digitAfterDecimalPoint!);
    return (((val * mod).toPrecision(Get.find<SplashController>().configModel!.digitAfterDecimalPoint!)).floor().toDouble() / mod);
  }

  static int power(int x, int n) {
    int retval = 1;
    for (int i = 0; i < n; i++) {
      retval *= x;
    }
    return retval;
  }

}