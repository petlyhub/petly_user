import 'package:flutter/material.dart';
// --- نموذج بيانات الصيدلية ---
class Pharmacy {
  final String name;
  final String location;
  final double rating;
  final String deliveryTime;
  final bool isOpen;
  final List<String> availableMedicines;
  final String imageUrl;

  const Pharmacy({
    required this.name,
    required this.location,
    required this.rating,
    required this.deliveryTime,
    required this.isOpen,
    required this.availableMedicines,
    required this.imageUrl,
  });
}

// --- شاشة الصيدليات البيطرية ---
class PharmacyScreen extends StatelessWidget {
  const PharmacyScreen({super.key});

  // قائمة تجريبية للصيدليات
  final List<Pharmacy> pharmacies = const [
    Pharmacy(
      name: 'صيدلية الشفاء البيطرية',
      location: 'شارع الجامعة، القاهرة',
      rating: 4.9,
      deliveryTime: '30 - 45 دقيقة',
      isOpen: true,
      availableMedicines: ['مضادات حيوية', 'فيتامينات', 'طارد ديدان', 'لقاحات'],
      imageUrl: 'https://picsum.photos/id/1050/600/300',
    ),
    Pharmacy(
      name: 'صيدلية الرعاية الأليفة',
      location: 'حي المعادي، القاهرة',
      rating: 4.7,
      deliveryTime: '20 - 35 دقيقة',
      isOpen: true,
      availableMedicines: ['أدوية براغيث', 'شامبو طبي', 'مكملات غذائية'],
      imageUrl: 'https://picsum.photos/id/1060/600/300',
    ),
    Pharmacy(
      name: 'صيدلية فارما بيت 24/7',
      location: 'مدينة نصر، القاهرة',
      rating: 4.6,
      deliveryTime: '45 - 60 دقيقة',
      isOpen: false,
      availableMedicines: ['مستلزمات جراحية', 'إسعافات أولية', 'مسكنات'],
      imageUrl: 'https://picsum.photos/id/1070/600/300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الصيدليات البيطرية'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: pharmacies.length,
          itemBuilder: (context, index) {
            final pharmacy = pharmacies[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // صورة الصيدلية مع شارة الحالة (مفتوح / مغلق)
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(16),
                        ),
                        child: Image.network(
                          pharmacy.imageUrl,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 150,
                            color: Colors.grey[300],
                            child: const Icon(Icons.local_pharmacy, size: 50),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: pharmacy.isOpen
                                ? Colors.green
                                : Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            pharmacy.isOpen ? 'مفتوح الآن' : 'مغلق',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // تفاصيل الصيدلية
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // اسم الصيدلية والتقييم
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                pharmacy.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.star,
                                    color: Colors.amber, size: 18),
                                const SizedBox(width: 4),
                                Text(
                                  '${pharmacy.rating}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // الموقع ووقت التوصيل
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined,
                                size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              pharmacy.location,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const Spacer(),
                            Icon(Icons.access_time,
                                size: 16, color: Colors.grey[600]),
                            const SizedBox(width: 4),
                            Text(
                              pharmacy.deliveryTime,
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                            ),
                          ],
                        ),
                        const Divider(height: 24),

                        // الأدوية والمستلزمات المتاحة
                        const Text(
                          'الفئات والأدوية المتاحة:',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: pharmacy.availableMedicines
                              .map(
                                (item) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F8F5),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF1ABC9C),
                                      fontWeight: FontWeight.bold,
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
            );
          },
        ),
      ),
    );
  }
}