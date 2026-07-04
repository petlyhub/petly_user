class Pet {
  int? id;
  int? userId;
  String? name;
  int? age;
  String? type;
  String? breed;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? typeName;

  Pet({
    this.id,
    this.userId,
    this.name,
    this.age,
    this.type,
    this.breed,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.typeName,
  });

  // ================= FROM JSON =================

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      age: json['age'],
      type: json['type'], 
      breed: json['breed'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      typeName: json['type_name'],
    );
  }

  // ================= TO JSON =================

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'age': age,
      'type': type,
      'breed': breed,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'type_name': typeName,
    };
  }
}