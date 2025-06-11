class Contact {
  final String id;
  final String name;
  final String phone;
  final String email;
  final bool isFavorite;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.isFavorite = false,
  });

  // For Firebase
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'isFavorite': isFavorite,
      };

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'],
        name: json['name'],
        phone: json['phone'],
        email: json['email'],
        isFavorite: json['isFavorite'] ?? false,
      );

  // For SQLite
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'isFavorite': isFavorite ? 1 : 0,
      };

  factory Contact.fromMap(Map<String, dynamic> map) => Contact(
        id: map['id'],
        name: map['name'],
        phone: map['phone'],
        email: map['email'],
        isFavorite: map['isFavorite'] == 1,
      );
}
