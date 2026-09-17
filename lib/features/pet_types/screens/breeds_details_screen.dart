import 'package:flutter/material.dart';
import 'package:sixam_mart/features/pet_types/domain/models/pet_type_model.dart';

class BreedDetailsScreen extends StatelessWidget {
  final BreedModel breed;
  final PetTypeModel petType;

  const BreedDetailsScreen({
    super.key,
    required this.breed,
    required this.petType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(breed.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. بطاقة الهيدر الرئيسية
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: const Icon(
                      Icons.pets,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    breed.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: breed.status ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      breed.status ? 'Active' : 'Inactive',
                      style: TextStyle(
                        color: breed.status ? Colors.green[800] : Colors.red[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 2. قسم المعلومات التفصيلية
            const Text(
              'Breed Details',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    _buildDetailItem(
                      icon: Icons.category_outlined,
                      title: 'Pet Type',
                      value: petType.name,
                    ),
                    const Divider(height: 1),
                    _buildDetailItem(
                      icon: Icons.numbers,
                      title: 'Breed ID',
                      value: '#${breed.id}',
                    ),
                    const Divider(height: 1),
                    _buildDetailItem(
                      icon: Icons.calendar_today_outlined,
                      title: 'Created At',
                      value: _formatDate(breed.createdAt),
                    ),
                    const Divider(height: 1),
                    _buildDetailItem(
                      icon: Icons.update_outlined,
                      title: 'Last Updated',
                      value: _formatDate(breed.updatedAt),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ودجت المكون التكراري لعرض صف التفاصيل
  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          color: Colors.grey[600],
        ),
      ),
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  // دالة بسيطة لتهيئة عرض التاريخ
  String _formatDate(String rawDate) {
    if (rawDate.isEmpty) return 'N/A';
    try {
      final dateTime = DateTime.parse(rawDate);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (_) {
      return rawDate;
    }
  }
}