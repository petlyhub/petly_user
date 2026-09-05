import 'package:flutter/material.dart';

// --- نموذج بيانات المستشار البيطري ---
class Consultant {
  final String name;
  final String title;
  final String specialty;
  final double rating;
  final int reviewsCount;
  final String experience;
  final String fee;
  final bool isOnline;
  final String imageUrl;

  const Consultant({
    required this.name,
    required this.title,
    required this.specialty,
    required this.rating,
    required this.reviewsCount,
    required this.experience,
    required this.fee,
    required this.isOnline,
    required this.imageUrl,
  });
}

// --- شاشة الاستشارات البيطرية ---
class ConsultationsScreen extends StatelessWidget {
  const ConsultationsScreen({super.key});

  final List<Consultant> consultants = const [
    Consultant(
      name: 'د. أحمد صبري',
      title: 'أخصائي طب وجراحة الحيوانات الأليفة',
      specialty: 'تغذية وسلوكيات الكلاب والقطط',
      rating: 4.9,
      reviewsCount: 120,
      experience: 'خبرة 8 سنوات',
      fee: '200 ج.م / 20 دقيقة',
      isOnline: true,
      imageUrl: 'https://picsum.photos/id/1062/300/300',
    ),
    Consultant(
      name: 'د. مي محمود',
      title: 'استشاري الأمراض الباطنية البيطرية',
      specialty: 'أمراض الجلدية والحساسية',
      rating: 4.8,
      reviewsCount: 95,
      experience: 'خبرة 11 سنة',
      fee: '250 ج.م / 20 دقيقة',
      isOnline: true,
      imageUrl: 'https://picsum.photos/id/1027/300/300',
    ),
    Consultant(
      name: 'د. خالد عبد الرحمن',
      title: 'طبيب بيطري عام',
      specialty: 'الإسعافات الأولية والتطعييمات',
      rating: 4.7,
      reviewsCount: 64,
      experience: 'خبرة 5 سنوات',
      fee: '150 ج.م / 20 دقيقة',
      isOnline: false,
      imageUrl: 'https://picsum.photos/id/1005/300/300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('الاستشارات البيطرية'),
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
          itemCount: consultants.length,
          itemBuilder: (context, index) {
            final consultant = consultants[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // صورة الطبيب مع شارة الاتصال (Online Badge)
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 36,
                              backgroundImage: NetworkImage(consultant.imageUrl),
                              backgroundColor: Colors.grey[200],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 2,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: consultant.isOnline
                                      ? Colors.green
                                      : Colors.grey,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),

                        // معلومات الطبيب
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    consultant.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Icons.star,
                                          color: Colors.amber, size: 16),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${consultant.rating}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      Text(
                                        ' (${consultant.reviewsCount})',
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                consultant.title,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF9B59B6),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'التخصص: ${consultant.specialty}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                consultant.experience,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),

                    // السعر ورابط الحجز
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'سعر الاستشارة',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              consultant.fee,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF9B59B6),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.chat_outlined, size: 18),
                          label: Text(
                            consultant.isOnline ? 'استشارة فورية' : 'حجز موعد',
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: consultant.isOnline
                                ? const Color(0xFF9B59B6)
                                : Colors.grey[400],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}