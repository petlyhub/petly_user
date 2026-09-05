import 'package:flutter/material.dart';

// --- Petly Design System Colors ---
class AppColors {
  static const Color primary = Color(0xFF6C5CE7);
  static const Color primaryLight = Color(0xFFF3F0FF);
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF1E1E2D);
  static const Color textMuted = Color(0xFF8A8A8E);
  static const Color border = Color(0xFFEBEBEB);

  // Status Colors
  static const Color purpleBg = Color(0xFFF1EAFF);
  static const Color purpleText = Color(0xFF6C5CE7);
  static const Color greenBg = Color(0xFFE8F8F5);
  static const Color greenText = Color(0xFF2ECC71);
  static const Color orangeBg = Color(0xFFFFF5EB);
  static const Color orangeText = Color(0xFFE67E22);
  static const Color pinkBg = Color(0xFFFFEFF2);
  static const Color pinkText = Color(0xFFE91E63);
  static const Color blueBg = Color(0xFFEFF6FF);
  static const Color blueText = Color(0xFF3B82F6);
}

class MedicalRecordScreen extends StatefulWidget {
  const MedicalRecordScreen({super.key});

  @override
  State<MedicalRecordScreen> createState() => _MedicalRecordScreenState();
}

class _MedicalRecordScreenState extends State<MedicalRecordScreen> {
  int _selectedTab = 1; // السجل الطبي
  int _selectedFilter = 0; // الكل
  int _navIndex = 1; // الحيوانات

  final List<String> _filters = ['الكل', 'زيارات', 'تطعيمات', 'تحاليل', 'عمليات'];

  final List<Map<String, dynamic>> _records = [
    {
      'title': 'كشف عام',
      'clinic': 'عيادة الأصدقاء البيطرية',
      'desc': 'الفحص العام ممتاز ولا توجد أي ملاحظات.',
      'doctor': 'د. أحمد السيد',
      'role': 'طبيب بيطري',
      'date': '2025/08/15',
      'tag': 'زيارة',
      'tagColor': AppColors.purpleBg,
      'tagTextColor': AppColors.purpleText,
      'icon': Icons.medical_services_outlined,
      'iconBg': AppColors.purpleBg,
      'iconColor': AppColors.purpleText,
    },
    {
      'title': 'تطعيم داء الكلب',
      'clinic': 'عيادة الأصدقاء البيطرية',
      'desc': 'تم إعطاء تطعيم داء الكلب.',
      'doctor': 'د. أحمد السيد',
      'role': 'طبيب بيطري',
      'date': '2025/05/20',
      'tag': 'تطعيم',
      'tagColor': AppColors.greenBg,
      'tagTextColor': AppColors.greenText,
      'icon': Icons.vaccines_outlined,
      'iconBg': AppColors.greenBg,
      'iconColor': AppColors.greenText,
    },
    {
      'title': 'تحليل دم شامل',
      'clinic': 'مركز الرحمة البيطري',
      'desc': 'نتائج التحاليل ضمن المعدلات الطبيعية.',
      'doctor': 'د. سارة محمد',
      'role': 'أخصائية مختبرات',
      'date': '2025/05/18',
      'tag': 'تحليل',
      'tagColor': AppColors.orangeBg,
      'tagTextColor': AppColors.orangeText,
      'icon': Icons.science_outlined,
      'iconBg': AppColors.orangeBg,
      'iconColor': AppColors.orangeText,
    },
    {
      'title': 'عملية تعقيم',
      'clinic': 'مركز الرحمة البيطري',
      'desc': 'عملية تعقيم ناجحة ولا توجد مضاعفات.',
      'doctor': 'د. محمد علي',
      'role': 'جراح بيطري',
      'date': '2024/12/10',
      'tag': 'عملية',
      'tagColor': AppColors.pinkBg,
      'tagTextColor': AppColors.pinkText,
      'icon': Icons.favorite_border_rounded,
      'iconBg': AppColors.pinkBg,
      'iconColor': AppColors.pinkText,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.cardBg,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textDark),
            onPressed: () => Navigator.maybePop(context),
          ),
          centerTitle: true,
          title: const Text(
            'السجل الطبي',
            style: TextStyle(color: AppColors.textDark, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actions: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 20),
              label: const Text(
                'إضافة',
                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. كارت بروفايل الأليف ---
              _buildPetProfileCard(),

              const SizedBox(height: 12),

              // --- 2. تبويبات التنقل العلوية ---
              _buildTopTabBar(),

              const SizedBox(height: 20),

              // --- 3. ملخص السجل الطبي (الكروت الـ 4) ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'ملخص السجل الطبي',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ),
              const SizedBox(height: 12),
              _buildSummaryCards(),

              const SizedBox(height: 20),

              // --- 4. شريط الفلترة ---
              _buildFilterChips(),

              const SizedBox(height: 16),

              // --- 5. قائمة السجل الطبي مع التايم لاين ---
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'السجل الطبي',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
              ),
              const SizedBox(height: 12),
              _buildTimelineList(),

              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Text('عرض المزيد', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
                  label: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: _buildBottomNavigationBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  // كارت بروفايل الأليف العلوي
  Widget _buildPetProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // الصورة الشخصية مع أيقونة الكاميرا
          Stack(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1552053831-71594a27632d?auto=format&fit=crop&w=300&q=80'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.cardBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt_outlined, size: 14, color: AppColors.primary),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          // الاسم والتفاصيل
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text('لولو', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(color: AppColors.purpleBg, shape: BoxShape.circle),
                      child: const Icon(Icons.pets, size: 10, color: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text('جولدن ريتريفر', style: TextStyle(color: AppColors.textMuted, fontSize: 13)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: AppColors.purpleBg, borderRadius: BorderRadius.circular(6)),
                  child: const Text('نشطة', style: TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          // التفاصيل بالجانب الأيسر
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Row(
                children: [
                  Text('PET-000248', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.qr_code_2_rounded, color: AppColors.primary, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              _buildPetInfoRow(Icons.calendar_today_outlined, 'تاريخ الميلاد', '2023/08/15'),
              const SizedBox(height: 4),
              _buildPetInfoRow(Icons.female, 'الجنس', 'أنثى'),
              const SizedBox(height: 4),
              _buildPetInfoRow(Icons.scale_outlined, 'الوزن', '28 كجم'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPetInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Text(value, style: const TextStyle(color: AppColors.textDark, fontSize: 11, fontWeight: FontWeight.w600)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
        const SizedBox(width: 4),
        Icon(icon, size: 12, color: AppColors.primary),
      ],
    );
  }

  // التبويبات العلوية
  Widget _buildTopTabBar() {
    final tabs = [
      {'title': 'الملف الشخصي', 'icon': Icons.person_outline},
      {'title': 'السجل الطبي', 'icon': Icons.medical_services_outlined},
      {'title': 'التطعيمات', 'icon': Icons.vaccines_outlined},
      {'title': 'التأمين', 'icon': Icons.shield_outlined},
    ];

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return InkWell(
            onTap: () => setState(() => _selectedTab = index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: isSelected
                    ? const Border(bottom: BorderSide(color: AppColors.primary, width: 2.5))
                    : null,
              ),
              child: Column(
                children: [
                  Icon(
                    tabs[index]['icon'] as IconData,
                    color: isSelected ? AppColors.primary : AppColors.textMuted,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    tabs[index]['title'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.primary : AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // الكروت الملخصة الأربعة
  Widget _buildSummaryCards() {
    return SizedBox(
      height: 115,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _buildSummaryCard('عمليات جراحية', '1', 'مسجلة', Icons.assignment_outlined, AppColors.blueBg, AppColors.blueText),
          _buildSummaryCard('حساسية', '3', 'مسجلة', Icons.medication_outlined, AppColors.orangeBg, AppColors.orangeText),
          _buildSummaryCard('تطعيمات', '5', 'القادم بعد\n12 يوم', Icons.eco_outlined, AppColors.greenBg, AppColors.greenText),
          _buildSummaryCard('زيارات طبية', '6', 'آخر زيارة منذ\n15 يوم', Icons.medical_services_outlined, AppColors.purpleBg, AppColors.purpleText),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String count, String subtext, IconData icon, Color bgColor, Color iconColor) {
    return Container(
      width: 105,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 22),
              Text(count, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              const SizedBox(height: 2),
              Text(subtext, style: const TextStyle(fontSize: 10, color: AppColors.textMuted, height: 1.1)),
            ],
          ),
        ],
      ),
    );
  }

  // شريط الفلترة الأفقي
  Widget _buildFilterChips() {
    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              children: [
                Icon(Icons.tune_rounded, size: 16, color: AppColors.primary),
                SizedBox(width: 4),
                Text('فلتر', style: TextStyle(fontSize: 12, color: AppColors.textDark, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          ...List.generate(_filters.length, (index) {
            final isSelected = _selectedFilter == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedFilter = index),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.cardBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                ),
                child: Center(
                  child: Text(
                    _filters[index],
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? Colors.white : AppColors.textMuted,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // قائمة السجلات المصممة كـ Timeline
  Widget _buildTimelineList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _records.length,
      itemBuilder: (context, index) {
        final item = _records[index];
        final isLast = index == _records.length - 1;

        return Stack(
          children: [
            // خط التايم لاين الرأسي
            Positioned(
              top: 0,
              bottom: isLast ? 40 : 0,
              left: 24,
              child: Container(
                width: 2,
                color: AppColors.border,
              ),
            ),
            // نود (نقطة) التايم لاين
            Positioned(
              top: 24,
              left: 17,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 3),
                ),
              ),
            ),
            // كارت المحتوى
            Container(
              margin: const EdgeInsets.only(left: 16, right: 48, bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.more_vert_rounded, color: AppColors.textMuted, size: 18),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: item['tagColor'],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          item['tag'],
                          style: TextStyle(color: item['tagTextColor'], fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: item['iconBg'], shape: BoxShape.circle),
                        child: Icon(item['icon'], color: item['iconColor'], size: 20),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['title'], style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                            const SizedBox(height: 2),
                            Text(item['clinic'], style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(item['desc'], style: const TextStyle(color: AppColors.textDark, fontSize: 12, height: 1.3)),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item['doctor'], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary)),
                          Text(item['role'], style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
                        ],
                      ),
                      Row(
                        children: [
                          Text(item['date'], style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                          const SizedBox(width: 4),
                          const Icon(Icons.calendar_today_outlined, size: 12, color: AppColors.textMuted),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // شريط التنقل السفلي (Bottom Navigation Bar)
  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home_outlined, Icons.home_rounded, 'الرئيسية', 0),
            _buildNavItem(Icons.grid_view_outlined, Icons.grid_view_rounded, 'الخدمات', 1),
            const SizedBox(width: 40), // مسافة لزر الفلوتينج
            _buildNavItem(Icons.pets_outlined, Icons.pets_rounded, 'الحيوانات', 2),
            _buildNavItem(Icons.person_outline_rounded, Icons.person_rounded, 'الحساب', 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, IconData activeIcon, String label, int index) {
    final isSelected = _navIndex == index;
    return InkWell(
      onTap: () => setState(() => _navIndex = index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isSelected ? activeIcon : icon, color: isSelected ? AppColors.primary : AppColors.textMuted, size: 22),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isSelected ? AppColors.primary : AppColors.textMuted,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}