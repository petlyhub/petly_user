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
  static const Color softOrange = Color(0xFFFFF3E0);
}

class PetTrainingScreen extends StatefulWidget {
  const PetTrainingScreen({super.key});

  @override
  State<PetTrainingScreen> createState() => _PetTrainingScreenState();
}

class _PetTrainingScreenState extends State<PetTrainingScreen> {
  int _selectedCategoryIndex = 0;

  final List<String> _categories = [
    'الكل',
    'طاعة وأوامر',
    'تعديل سلوك',
    'تدريب جراء',
    'مهارات متقدمة',
  ];

  final List<Map<String, dynamic>> _courses = [
    {
      'title': 'كورس الطاعة الأولي والسيطرة',
      'trainer': 'الكابتن / أحمد مصطفى',
      'level': 'مبتدئ',
      'duration': '4 أسابيع (8 جلسات)',
      'price': '800 ج.م',
      'rating': 4.9,
      'reviews': 96,
      'description': 'تعليم الأوامر الأساسية: الجلوس، الثبات، الثبات بجانب صاحب الكلب، والاستجابة للاستدعاء.',
      'tag': 'الأكثر طلباً',
      'tagColor': PetlyColors.accentLight,
    },
    {
      'title': 'برنامج حل مشاكل الشراسة والخوف',
      'trainer': 'د. مهند طارق',
      'level': 'متوسط إلى متقدم',
      'duration': '6 أسابيع (12 جلسة)',
      'price': '1400 ج.م',
      'rating': 4.8,
      'reviews': 64,
      'description': 'علاج السلوكيات العدوانية، العض، الخوف من الأصوات العالية والتعامل مع الغرباء.',
      'tag': 'تعديل سلوك',
      'tagColor': PetlyColors.softOrange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
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
            'تدريب السلوك والمهارات',
            style: TextStyle(
              color: PetlyColors.textDark,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.bookmark_border_rounded, color: PetlyColors.textDark),
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
              // --- 1. بنر التدريب والمفهوم ---
              _buildHeaderBanner(),

              const SizedBox(height: 20),

              // --- 2. أزرار الفلترة ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'أقسام التدريب',
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

              // --- 3. قائمة الكورسات والبرامج ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'البرامج المتاحة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: PetlyColors.textDark,
                      ),
                    ),
                    Text(
                      'فلترة البرامج',
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
                itemCount: _courses.length,
                itemBuilder: (context, index) {
                  return _buildCourseCard(context, _courses[index]);
                },
              ),

              const SizedBox(height: 20),

              // --- 4. نخبة المدربين المعتمَدين ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'مدربون معتمدون',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: PetlyColors.textDark,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildTrainersList(),
            ],
          ),
        ),
      ),
    );
  }

  // بنر الهيدر الرئيسي
  Widget _buildHeaderBanner() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2B2D42), Color(0xFF3F4261)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
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
                    color: PetlyColors.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'تدريب معتمد 100%',
                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ابنِ علاقة مثالية مع أليفك',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'جلسات تدريب منزلية أو داخل مراكزنا تحت إشراف أفضل خبراء السلوك.',
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const CircleAvatar(
            radius: 36,
            backgroundColor: Colors.white12,
            child: Icon(Icons.sports_score_rounded, color: PetlyColors.primary, size: 38),
          ),
        ],
      ),
    );
  }

  // أزرار الفلترة
  Widget _buildCategorySelector() {
    return SizedBox(
      height: 42,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedCategoryIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategoryIndex = index),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? PetlyColors.primary : PetlyColors.cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? PetlyColors.primary : Colors.grey[300]!,
                ),
              ),
              child: Center(
                child: Text(
                  _categories[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.white : PetlyColors.textDark,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // كارت البرنامج التدريبي
  Widget _buildCourseCard(BuildContext context, Map<String, dynamic> course) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: course['tagColor'],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  course['tag'],
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
                    ' ${course['rating']} (${course['reviews']})',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            course['title'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: PetlyColors.textDark,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            course['trainer'],
            style: const TextStyle(color: PetlyColors.primary, fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            course['description'],
            style: const TextStyle(color: PetlyColors.textMuted, fontSize: 13),
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('المدة: ${course['duration']}', style: const TextStyle(color: PetlyColors.textMuted, fontSize: 11)),
                  const SizedBox(height: 2),
                  Text(
                    course['price'],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: PetlyColors.textDark,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _showBookingBottomSheet(context, course['title'], course['price']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PetlyColors.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text('انضم للبرنامج', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ],
          )
        ],
      ),
    );
  }

  // قائمة المدربين
  Widget _buildTrainersList() {
    final trainers = [
      {'name': 'كابتن / أحمد مصطفى', 'spec': 'خبير تدريب طاعة', 'exp': '8 سنوات خبرة'},
      {'name': 'د / مهند طارق', 'spec': 'أخصائي تعديل سلوك', 'exp': '5 سنوات خبرة'},
    ];

    return SizedBox(
      height: 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: trainers.length,
        itemBuilder: (context, index) {
          final t = trainers[index];
          return Container(
            width: 220,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: PetlyColors.cardBg,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: PetlyColors.primary.withOpacity(0.12),
                  child: const Icon(Icons.person, color: PetlyColors.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(t['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text('${t['spec']} • ${t['exp']}', style: const TextStyle(color: PetlyColors.textMuted, fontSize: 11)),
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

  // نافذة اختيار مكان وجدولة التدريب
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
                Text('التكلفة الإجمالية: $price', style: const TextStyle(color: PetlyColors.primary, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 20),
                const Text('اختر أسلوب التدريب المفضّل:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: PetlyColors.background,
                  leading: const Icon(Icons.home_work_rounded, color: PetlyColors.primary),
                  title: const Text('تدريب منزلي (شخصي)'),
                  subtitle: const Text('يحضر المدرب إلى منزلك لتدريب الأليف'),
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 8),
                ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  tileColor: PetlyColors.background,
                  leading: const Icon(Icons.groups_rounded, color: PetlyColors.primary),
                  title: const Text('تدريب داخل أكاديمية Petly'),
                  subtitle: const Text('جلسات جماعية لتشجيع التفاعل الاجتماعي'),
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