class User {
  final String id;
  final String username;
  final String password;
  final String name;
  final String lastName;
  final String email;
  final String address;
  final int age;
  final String profileType;
  final bool isPhysicalPerson;
  final bool isNonPhysicalPerson;
  final List<String> requestedProfessions;
  final String contractionType;
  final double rating;
  final bool isBlocked;
  final bool isAvailable;
  final bool hasAgreedToConfidentiality;
  final String? profileImageUrl;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.lastName,
    required this.email,
    required this.address,
    required this.age,
    required this.profileType,
    required this.isPhysicalPerson,
    required this.isNonPhysicalPerson,
    required this.requestedProfessions,
    required this.contractionType,
    required this.rating,
    required this.isBlocked,
    required this.isAvailable,
    required this.hasAgreedToConfidentiality,
    this.profileImageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      name: json['name'],
      lastName: json['lastName'],
      email: json['email'],
      address: json['address'],
      age: json['age'],
      profileType: json['profileType'],
      isPhysicalPerson: json['isPhysicalPerson'],
      isNonPhysicalPerson: json['isNonPhysicalPerson'],
      requestedProfessions: List<String>.from(json['requestedProfessions']),
      contractionType: json['contractionType'],
      rating: json['rating'],
      isBlocked: json['isBlocked'],
      isAvailable: json['isAvailable'],
      hasAgreedToConfidentiality: json['hasAgreedToConfidentiality'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'lastName': lastName,
      'email': email,
      'address': address,
      'age': age,
      'profileType': profileType,
      'isPhysicalPerson': isPhysicalPerson,
      'isNonPhysicalPerson': isNonPhysicalPerson,
      'requestedProfessions': requestedProfessions,
      'contractionType': contractionType,
      'rating': rating,
      'isBlocked': isBlocked,
      'isAvailable': isAvailable,
      'hasAgreedToConfidentiality': hasAgreedToConfidentiality,
      'profileImageUrl': profileImageUrl,
    };
  }
}

