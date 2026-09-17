class PetTypeModel {
  final int id;
  final String name;
  final String slug;
  final bool status;
  final String createdAt;
  final String imageFullUrl;
  final String updatedAt;
  final List<BreedModel> breeds;

  PetTypeModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.breeds, 
    required this.imageFullUrl,
  });

  factory PetTypeModel.fromJson(Map<String, dynamic> json) {
    return PetTypeModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '', 
      imageFullUrl: json['image_full_url'] ?? '',
      status: json['status'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      breeds: (json['breeds'] as List<dynamic>?)
              ?.map((e) => BreedModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class BreedModel {
  final int id;
  final int petTypeId;
  final String name;
  final bool status;
  final String createdAt;
  final String updatedAt;

  BreedModel({
    required this.id,
    required this.petTypeId,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BreedModel.fromJson(Map<String, dynamic> json) {
    return BreedModel(
      id: json['id'] ?? 0,
      petTypeId: json['pet_type_id'] ?? 0,
      name: json['name'] ?? '',
      status: json['status'] ?? false,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}