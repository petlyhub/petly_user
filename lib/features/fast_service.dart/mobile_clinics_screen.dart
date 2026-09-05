import 'package:flutter/material.dart';

// --- Petly Design System ---
class PetlyColors {
  static const  primary = Color(0xFF6C5CE7);
  static const Color secondary = Color(0xFFFF6B6B);
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF2B2D42);
  static const Color textMuted = Color(0xFF8D99AE);
  static const Color accentLight = Color(0xFFE8F5E9);
}
 
class MobileClinicsScreen extends StatefulWidget {
  const MobileClinicsScreen({super.key});

  @override
  State<MobileClinicsScreen> createState() => _MobileClinicsScreenState();
}

class _MobileClinicsScreenState extends State<MobileClinicsScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = [
    'الكل',
    'التطعيمات',
    'الكشف الطبي',
    'العناية والشعر',
    'الطوارئ'
  ];

  final List<Map<String, dynamic>> _clinics = [
    {
      'name': 'عيادة بيتلي المتنقلة #01',
      'doctor': 'د. سارة أحمد',
      'rating': 4.9,
      'reviews': 128,
      'distance': '1.2 كم',
      'status': 'متاحة اليوم',
      'services': ['التطعيمات', 'الكشف الطبي'],
    },
    {
      'name': 'عيادة بيتلي السريعة #03',
      'doctor': 'د. يوسف كريم',
      'rating': 4.8,
      'reviews': 95,
      'distance': '2.8 كم',
      'status': 'طوارئ',
      'services': ['الطوارئ', 'جراحة سريعة'],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // تفعيل الاتجاه من اليمين إلى اليسار
      child: Scaffold(
        backgroundColor: PetlyColors.background,
        appBar: AppBar(
          backgroundColor: PetlyColors.cardBg,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: PetlyColors.textDark, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'العيادات المتنقلة',
            style: TextStyle(
              color: PetlyColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.tune_rounded, color: PetlyColors.primary),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // --- 1. قسم الخريطة التفاعلية ---
            _buildMapPreviewSection(),

            // --- 2. تصنيفات الفلترة ---
            _buildCategoryFilters(),

            // --- 3. قائمة العيادات المتنقلة ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 12, bottom: 24),
                itemCount: _clinics.length,
                itemBuilder: (context, index) {
                  final clinic = _clinics[index];
                  return _buildClinicCard(context, clinic);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // قسم الخريطة
  Widget _buildMapPreviewSection() {
    return Container(
      height: 160,
      width: double.infinity,
      color: Colors.blueGrey[50],
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Icon(Icons.map_outlined, size: 240, color: PetlyColors.primary.withOpacity(0.15)),
            ),
          ),
          const Center(
            child: Chip(
              avatar: Icon(Icons.my_location, size: 16, color: Colors.white),
              label: Text(
                'عيادتان متنقلتان بالقرب منك',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
              backgroundColor: PetlyColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  // أزرار الفلترة
  Widget _buildCategoryFilters() {
    return Container(
      height: 50,
      color: PetlyColors.cardBg,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: Container(
              margin: const EdgeInsets.only(left: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected ? PetlyColors.primary : PetlyColors.background,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? PetlyColors.primary : Colors.grey[300]!,
                ),
              ),
              child: Text(
                _categories[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : PetlyColors.textMuted,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // كارت العيادة المتنقلة
  Widget _buildClinicCard(BuildContext context, Map<String, dynamic> clinic) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: PetlyColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: PetlyColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.airport_shuttle_rounded, color: PetlyColors.primary, size: 30),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      clinic['name'],
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: PetlyColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      clinic['doctor'],
                      style: const TextStyle(color: PetlyColors.textMuted, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                        Text(
                          ' ${clinic['rating']} (${clinic['reviews']})',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Text('•  تبعد ${clinic['distance']}', style: const TextStyle(color: PetlyColors.textMuted, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24),

          // الخدمات وزر الحجز
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 6,
                children: (clinic['services'] as List<String>)
                    .map((s) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: PetlyColors.accentLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(s, style: const TextStyle(fontSize: 11, color: PetlyColors.primary, fontWeight: FontWeight.w600)),
                        ))
                    .toList(),
              ),
              ElevatedButton(
                onPressed: () => _showBookingBottomSheet(context, clinic['name']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PetlyColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('حجز زيارة', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  // نافذة اختيار الخدمة والحجز
  void _showBookingBottomSheet(BuildContext context, String vanName) {
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
                Text('حجز $vanName', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: PetlyColors.textDark)),
                const SizedBox(height: 8),
                const Text('اختر نوع الخدمة المطلوبة عند باب المنزل:', style: TextStyle(color: PetlyColors.textMuted)),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.vaccines_outlined, color: PetlyColors.primary),
                  title: const Text('تطعيمات عامة'),
                  subtitle: const Text('150 ج.م • 20 دقيقة'),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.medical_services_outlined, color: PetlyColors.primary),
                  title: const Text('فحص طبي شامل'),
                  subtitle: const Text('250 ج.م • 40 دقيقة'),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }
}