import 'package:flutter/material.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart'; // تأكد من استيراد CustomImage الخاص بالشرط
import 'package:sixam_mart/features/pet_types/domain/models/pet_type_model.dart';

class PetTypeCardWidget extends StatelessWidget {
  final PetTypeModel petType;

  const PetTypeCardWidget({super.key, required this.petType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Theme.of(context).primaryColor,
            child: ClipOval(
              child: Container(
                width: 60,
                height: 60,
                color: Colors.grey[200],
                child: petType.imageFullUrl.isNotEmpty
                    ? CustomImage(
                        image: petType.imageFullUrl,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      )
                    : Center(
                        child: Text(
                          petType.name.isNotEmpty ? petType.name[0].toUpperCase() : '?',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            petType.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${petType.breeds.length} Breeds',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}