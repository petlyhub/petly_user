import 'package:flutter/material.dart';

// --- Petly Design System ---
class PetlyColors {
  static const primary = Color(0xFF6C5CE7);
  static const Color secondary = Color(0xFFFF6B6B);
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2B2D42);
  static const Color textMuted = Color(0xFF8D99AE);
  static const Color accentLight = Color(0xFFE8F5E9);
  static const Color softPink = Color(0xFFFFF0F5);
}

class CareAndBeautyScreen extends StatefulWidget {
  const CareAndBeautyScreen({super.key});

  @override
  State<CareAndBeautyScreen> createState() => _CareAndBeautyScreenState();
}

class _CareAndBeautyScreenState extends State<CareAndBeautyScreen> {
  int _selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'قص وتصفيف', 'icon': Icons.content_cut_rounded},
    {'name': 'استحمام وسبا', 'icon': Icons.bathtub_rounded},
    {'name': 'عناية بالأظافر', 'icon': Icons.pets_rounded},
    {'name': 'تنظيف الأسنان', 'icon': Icons.clean_hands_rounded},
  ];

  final List<Map<String, dynamic>> _packages = [
    {
      'title': 'باقة السبا والعناية الملكية',
      'duration': '60 دقيقة',
      'price': '450 ج.م',
      'rating': 4.9,
      'reviews': 142,
      'description': 'حمام فقاعات، تقليم الأظافر، تنظيف الأذن، وتصفيف الفراء.',
      'badge': 'الأكثر طلباً',
      'color': PetlyColors.softPink,
    },
    {
      'title': 'باقة العناية السريعة',
      'duration': '30 دقيقة',
      'price': '250 ج.م',
      'rating': 4.7,
      'reviews': 88,
      'description': 'غسيل سريع، تمشيط الفراء، وتعطير الفم والنعومة.',
      'badge': 'زيارة سريعة',
      'color': PetlyColors.accentLight,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // تفعيل الاتجاه العربي
      child: Scaffold(
        backgroundColor: PetlyColors.background,
        appBar: AppBar(
          backgroundColor: PetlyColors.cardBg,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: PetlyColors.textDark, size: 20),
            onPressed: () => Navigator.maybePop(context),
          ),
          title: const Text(
            'العناية والجمال',
            style: TextStyle(
              color: PetlyColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search_rounded, color: PetlyColors.textDark),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. الإعلان الترويجي ---
              _buildPromoBanner(),

              const SizedBox(height: 20),

              // --- 2. قائمة الخدمات ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'الخدمات',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PetlyColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildCategorySelector(),

              const SizedBox(height: 24),

              // --- 3. باقات العناية المميزة ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'باقات العناية والجمال',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: PetlyColors.textDark,
                      ),
                    ),
                    Text(
                      'عرض الكل',
                      style: TextStyle(
                        color: PetlyColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _packages.length,
                itemBuilder: (context, index) {
                  return _buildPackageCard(context, _packages[index]);
                },
              ),

              const SizedBox(height: 20),

              // --- 4. أفضل الخبراء ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'أفضل خبراء العناية',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PetlyColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildSpecialistsList(),
            ],
          ),
        ),
      ),
    );
  }

  // بنر الخصومات
  Widget _buildPromoBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [PetlyColors.primary, Color(0xFF00796B)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: PetlyColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'خصم 20% لأول تجربة سبا',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'دلل أليفك اليوم',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'عناية ونظافة احترافية في المركز أو عند باب المنزل.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white24,
            child: Icon(Icons.spa_rounded, color: Colors.white, size: 38),
          ),
        ],
      ),
    );
  }

  // تصنيفات الخدمات
  Widget _buildCategorySelector() {
    return SizedBox(
      height: 95,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          final cat = _categories[index];
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: Container(
              width: 90,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? PetlyColors.primary : PetlyColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? PetlyColors.primary : Colors.grey[200]!,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    cat['icon'],
                    color: isSelected ? Colors.white : PetlyColors.primary,
                    size: 28,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    cat['name'],
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : PetlyColors.textDark,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // كارت باقة العناية
  Widget _buildPackageCard(BuildContext context, Map<String, dynamic> pkg) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PetlyColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: pkg['color'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  pkg['badge'],
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: PetlyColors.primary,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                  Text(
                    ' ${pkg['rating']} (${pkg['reviews']})',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            pkg['title'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: PetlyColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            pkg['description'],
            style: const TextStyle(color: PetlyColors.textMuted, fontSize: 13),
          ),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time_rounded, size: 16, color: PetlyColors.textMuted),
                  const SizedBox(width: 4),
                  Text(pkg['duration'], style: const TextStyle(color: PetlyColors.textMuted, fontSize: 13)),
                  const SizedBox(width: 12),
                  Text(
                    pkg['price'],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: PetlyColors.primary,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _showBookingBottomSheet(context, pkg['title'], pkg['price']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PetlyColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                ),
                child: const Text('احجز الآن', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  // قائمة أفضل الخبراء
  Widget _buildSpecialistsList() {
    final specialists = [
      {'name': 'إلينا روستوفا', 'role': 'خبيرة تصفيف', 'exp': 'خبرة 6 سنوات'},
      {'name': 'عمر فاروق', 'role': 'أخصائي سبا وحلاقة', 'exp': 'خبرة 4 سنوات'},
    ];

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: specialists.length,
        itemBuilder: (context, index) {
          final s = specialists[index];
          return Container(
            width: 210,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: PetlyColors.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: PetlyColors.primary.withOpacity(0.15),
                  child: Text(
                    s['name']![0],
                    style: const TextStyle(color: PetlyColors.primary, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(s['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('${s['role']} • ${s['exp']}', style: const TextStyle(color: PetlyColors.textMuted, fontSize: 11)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // نافذة خيارات الحجز
  void _showBookingBottomSheet(BuildContext context, String title, String price) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                  ),
                ),
                const SizedBox(height: 16),
                Text('حجز $title', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: PetlyColors.textDark)),
                const SizedBox(height: 4),
                Text('إجمالي السعر: $price', style: const TextStyle(color: PetlyColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 20),
                const Text('اختر مكان الزيارة:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: PetlyColors.background,
                  leading: const Icon(Icons.store_rounded, color: PetlyColors.primary),
                  title: const Text('زيارة الفرع'),
                  subtitle: const Text('في أقرب مركز رعاية تابع لـ Petly'),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 8),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: PetlyColors.background,
                  leading: const Icon(Icons.airport_shuttle_rounded, color: PetlyColors.primary),
                  title: const Text('عيادة متنقلة عند المنزل'),
                  subtitle: const Text('تصلك سيارة الخدمة حتى باب بيتك'),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}