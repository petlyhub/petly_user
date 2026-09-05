// import 'package:flutter/material.dart';

// // --- Demo Hotel Data Model ---
// class Hotel {
//   final String name;
//   final String location;
//   final double rating;
//   final String petPolicy;
//   final String fee;
//   final String imageUrl;

//   const Hotel({
//     required this.name,
//     required this.location,
//     required this.rating,
//     required this.petPolicy,
//     required this.fee,
//     required this.imageUrl,
//   });
// }

// // --- Main ListView Screen ---
// class HotelPetsScreen extends StatelessWidget {
//   const HotelPetsScreen({super.key});

//   // Demo list of hotels
//   final List<Hotel> hotels = const [
//     Hotel(
//       name: 'Grand Horizon Resort',
//       location: 'Downtown, Miami',
//       rating: 4.8,
//       petPolicy: 'Dogs & Cats welcome (Up to 50 lbs)',
//       fee: '\$35/night',
//       imageUrl: 'https://picsum.photos/id/1040/600/300',
//     ),
//     Hotel(
//       name: 'Sunset Bay Hotel',
//       location: 'Beachside, Malibu',
//       rating: 4.5,
//       petPolicy: 'Small pets allowed (Up to 25 lbs)',
//       fee: '\$20/night',
//       imageUrl: 'https://picsum.photos/id/1039/600/300',
//     ),
//     Hotel(
//       name: 'Mountain Lodge Suites',
//       location: 'Aspen, Colorado',
//       rating: 4.9,
//       petPolicy: 'All pets welcome, no weight limit',
//       fee: 'Free',
//       imageUrl: 'https://picsum.photos/id/1015/600/300',
//     ),
//     Hotel(
//       name: 'Urban Park Hotel',
//       location: 'Central, Seattle',
//       rating: 4.2,
//       petPolicy: 'Dogs only (Max 2 dogs per room)',
//       fee: '\$15/night',
//       imageUrl: 'https://picsum.photos/id/1076/600/300',
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Pet Friendly Hotels'),
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           padding: const EdgeInsets.all(16.0),
//           itemCount: hotels.length,
//           itemBuilder: (context, index) {
//             final hotel = hotels[index];
//             return Card(
//               elevation: 2,
//               margin: const EdgeInsets.only(bottom: 16.0),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Hotel Image
//                   ClipRRect(
//                     borderRadius: const BorderRadius.vertical(
//                       top: Radius.circular(12),
//                     ),
//                     child: Image.network(
//                       hotel.imageUrl,
//                       height: 160,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                       errorBuilder: (context, error, stackTrace) => Container(
//                         height: 160,
//                         color: Colors.grey[300],
//                         child: const Icon(Icons.broken_image, size: 40),
//                       ),
//                     ),
//                   ),

//                   // Card Content
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Hotel Name and Rating Row
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Expanded(
//                               child: Text(
//                                 hotel.name,
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium
//                                     ?.copyWith(
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 const Icon(Icons.star,
//                                     color: Colors.amber, size: 18),
//                                 const SizedBox(width: 4),
//                                 Text(
//                                   '${hotel.rating}',
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 6),

//                         // Location Row
//                         Row(
//                           children: [
//                             Icon(
//                               Icons.location_on_outlined,
//                               size: 16,
//                               color: Colors.grey[600],
//                             ),
//                             const SizedBox(width: 4),
//                             Text(
//                               hotel.location,
//                               style: TextStyle(color: Colors.grey[600]),
//                             ),
//                           ],
//                         ),
//                         const Divider(height: 24),

//                         // Details Section (Pet Policy & Fee)
//                         Row(
//                           children: [
//                             const Icon(Icons.pets,
//                                 size: 18, color: Colors.indigo),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(
//                                 hotel.petPolicy,
//                                 style: const TextStyle(fontSize: 13),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 8),
//                         Row(
//                           children: [
//                             const Icon(Icons.payments_outlined,
//                                 size: 18, color: Colors.green),
//                             const SizedBox(width: 8),
//                             Text(
//                               'Pet Fee: ${hotel.fee}',
//                               style: const TextStyle(
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

// --- نموذج بيانات الفندق ---
class Hotel {
  final String name;
  final String location;
  final double rating;
  final String petPolicy;
  final String fee;
  final String imageUrl;

  const Hotel({
    required this.name,
    required this.location,
    required this.rating,
    required this.petPolicy,
    required this.fee,
    required this.imageUrl,
  });
}

// --- الشاشة الرئيسية ---
class HotelPetsScreen extends StatelessWidget {
  const HotelPetsScreen({super.key});

  // قائمة تجريبية للفنادق
  final List<Hotel> hotels = const [
    Hotel(
      name: 'منتجع الأفق الكبير',
      location: 'وسط المدينة، ميامي',
      rating: 4.8,
      petPolicy: 'يسمح بالكلاب والقطط (حتى 22 كجم)',
      fee: '35\$ / ليلة',
      imageUrl: 'https://www.pexels.com/photo/modern-hotel-sign-with-evening-glow-39035671/',
    ),
    Hotel(
      name: 'فندق شاطئ الغروب',
      location: 'الواجهة البحرية، ماليبو',
      rating: 4.5,
      petPolicy: 'يسمح بالحيوانات الصغيرة (حتى 11 كجم)',
      fee: '20\$ / ليلة',
      imageUrl: 'https://picsum.photos/id/1039/600/300',
    ),
    Hotel(
      name: 'أجنحة الكوخ الجبلي',
      location: 'أسبن، كولورادو',
      rating: 4.9,
      petPolicy: 'جميع الحيوانات الأليفة مرحب بها، بدون حد للوزن',
      fee: 'مجاناً',
      imageUrl: 'https://picsum.photos/id/1015/600/300',
    ),
    Hotel(
      name: 'فندق الحديقة الحضرية',
      location: 'المركز، سياتل',
      rating: 4.2,
      petPolicy: 'الكلاب فقط (حد أقصى كلبين لكل غرفة)',
      fee: '15\$ / ليلة',
      imageUrl: 'https://picsum.photos/id/1076/600/300',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('فنادق تسمح بالحيوانات الأليفة'),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: hotels.length,
          itemBuilder: (context, index) {
            final hotel = hotels[index];
            return Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // صورة الفندق
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      hotel.imageUrl,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 160,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 40),
                      ),
                    ),
                  ),

                  // محتوى البطاقة
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // اسم الفندق والتقييم
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                hotel.name,
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
                                  '${hotel.rating}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),

                        // الموقع
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              hotel.location,
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                        const Divider(height: 24),

                        // تفاصيل سياسة الحيوانات والرسوم
                        Row(
                          children: [
                            const Icon(Icons.pets,
                                size: 18, color: Colors.indigo),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                hotel.petPolicy,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.payments_outlined,
                                size: 18, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              'رسوم إقامة الحيوان: ${hotel.fee}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
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