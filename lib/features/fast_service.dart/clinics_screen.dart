import 'package:flutter/material.dart';

// --- نموذج بيانات العيادة ---
class VeterinaryClinic {
  final String name;
  final double rating;
  final int reviewsCount;
  final String distance;
  final String neighborhood;
  final String closingTime;
  final bool isOpen;
  final List<String> tags;
  final String imageUrl;

  const VeterinaryClinic({
    required this.name,
    required this.rating,
    required this.reviewsCount,
    required this.distance,
    required this.neighborhood,
    required this.closingTime,
    required this.isOpen,
    required this.tags,
    required this.imageUrl,
  });
}

// --- الشاشة الرئيسية للعيادات البيطرية ---
class ClinicsScreen extends StatefulWidget {
  const ClinicsScreen({super.key});

  @override
  State<ClinicsScreen> createState() =>
      _ClinicsScreenState();
}

class _ClinicsScreenState extends State<ClinicsScreen> {
  int _selectedIndex = 0;
  int _selectedFilterIndex = 0;

  final List<String> filters = [
    'الكل',
    'عيادات قريبة',
    'كشف',
    'تطعيم',
    'جراحة',
    'مختبرات',
    'عناية أسنان',
  ];

  final List<VeterinaryClinic> clinics = const [
    VeterinaryClinic(
      name: 'عيادة الأصدقاء البيطرية',
      rating: 4.8,
      reviewsCount: 120,
      distance: '1.2 كم',
      neighborhood: 'حي النخيل',
      closingTime: 'تفتح حتى 10:00 م',
      isOpen: true,
      tags: ['كشف', 'تطعيم', 'جراحة', 'أسنان'],
      imageUrl: 'https://picsum.photos/id/1025/600/400',
    ),
    VeterinaryClinic(
      name: 'مركز الرحمة البيطري',
      rating: 4.6,
      reviewsCount: 85,
      distance: '2.5 كم',
      neighborhood: 'حي الربيع',
      closingTime: 'تفتح حتى 9:00 م',
      isOpen: true,
      tags: ['كشف', 'تطعيم', 'جراحة', 'مختبر'],
      imageUrl: 'https://picsum.photos/id/1062/600/400',
    ),
    VeterinaryClinic(
      name: 'عيادة الحيوان الأليف',
      rating: 4.5,
      reviewsCount: 64,
      distance: '3.1 كم',
      neighborhood: 'حي الملقا',
      closingTime: 'تفتح حتى 11:00 م',
      isOpen: true,
      tags: ['كشف', 'تطعيم', 'أسنان', 'عناية'],
      imageUrl: 'https://picsum.photos/id/1074/600/400',
    ),
    VeterinaryClinic(
      name: 'مركز الطب البيطري المتكامل',
      rating: 4.9,
      reviewsCount: 210,
      distance: '3.8 كم',
      neighborhood: 'حي الياسمين',
      closingTime: 'تفتح حتى 10:30 م',
      isOpen: true,
      tags: ['كشف', 'تطعيم', 'جراحة', 'طوارئ'],
      imageUrl: 'https://picsum.photos/id/1084/600/400',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const primaryPurple = Color(0xFF6C5CE7);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9FB),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'العيادات البيطرية',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.tune, color: primaryPurple, size: 20),
              label: const Text(
                'فلتر',
                style: TextStyle(
                  color: primaryPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // 1. حقل البحث
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'ابحث عن خدمة أو عيادة',
                    hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                    suffixIcon: Icon(Icons.search, color: Colors.grey.shade400),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),

            // 2. الفلاتر الأفقية (Categories)
            SizedBox(
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilterIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilterIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8.0),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? primaryPurple : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? primaryPurple : Colors.grey.shade200,
                        ),
                      ),
                      child: Text(
                        filters[index],
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontSize: 13,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // 3. قائمة بطاقات العيادات
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: clinics.length,
                itemBuilder: (context, index) {
                  final clinic = clinics[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // الصورة + زر المفضلة + شارة مفتوح الآن
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      clinic.imageUrl,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    left: 6,
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        Icons.favorite_border,
                                        size: 16,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 6,
                                    right: 6,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 3,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          CircleAvatar(
                                            radius: 3,
                                            backgroundColor: Colors.green,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'مفتوح الآن',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(width: 12),

                              // معلومات العيادة
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            clinic.name,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                            color: primaryPurple.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: const Icon(
                                            Icons.shield_outlined,
                                            color: primaryPurple,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),

                                    // التقييم
                                    Row(
                                      children: [
                                        const Icon(Icons.star,
                                            color: Colors.amber, size: 16),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${clinic.rating}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          ' (${clinic.reviewsCount} تقييم)',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),

                                    // المسافة والحي
                                    Row(
                                      children: [
                                        Icon(Icons.location_on_outlined,
                                            size: 14, color: primaryPurple),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${clinic.distance} • ${clinic.neighborhood}',
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),

                                    // وقت الإغلاق
                                    Row(
                                      children: [
                                        Icon(Icons.access_time,
                                            size: 14, color: Colors.grey.shade400),
                                        const SizedBox(width: 4),
                                        Text(
                                          clinic.closingTime,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    // الوسوم (Tags)
                                    Wrap(
                                      spacing: 4,
                                      runSpacing: 4,
                                      children: clinic.tags
                                          .map(
                                            (tag) => Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 3,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                tag,
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // زر عرض التفاصيل السفلي
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: primaryPurple.withOpacity(0.06),
                              borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'عرض التفاصيل',
                                style: TextStyle(
                                  color: primaryPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // 4. شريط التصفح السفلي (Bottom Navigation Bar)
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: primaryPurple,
          unselectedItemColor: Colors.grey.shade400,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined),
              activeIcon: Icon(Icons.calendar_today),
              label: 'حجوزاتي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pets_outlined),
              activeIcon: Icon(Icons.pets),
              label: 'حيواناتي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              activeIcon: Icon(Icons.shopping_bag),
              label: 'المتجر',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'الحساب',
            ),
          ],
        ),
      ),
    );
  }
}