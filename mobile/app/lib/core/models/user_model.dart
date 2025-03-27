import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id;
  final String username;
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
  
  const UserModel({
    required this.id,
    required this.username,
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
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
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
  
  UserModel copyWith({
    String? id,
    String? username,
    String? name,
    String? lastName,
    String? email,
    String? address,
    int? age,
    String? profileType,
    bool? isPhysicalPerson,
    bool? isNonPhysicalPerson,
    List<String>? requestedProfessions,
    String? contractionType,
    double? rating,
    bool? isBlocked,
    bool? isAvailable,
    bool? hasAgreedToConfidentiality,
    String? profileImageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      address: address ?? this.address,
      age: age ?? this.age,
      profileType: profileType ?? this.profileType,
      isPhysicalPerson: isPhysicalPerson ?? this.isPhysicalPerson,
      isNonPhysicalPerson: isNonPhysicalPerson ?? this.isNonPhysicalPerson,
      requestedProfessions: requestedProfessions ?? this.requestedProfessions,
      contractionType: contractionType ?? this.contractionType,
      rating: rating ?? this.rating,
      isBlocked: isBlocked ?? this.isBlocked,
      isAvailable: isAvailable ?? this.isAvailable,
      hasAgreedToConfidentiality: hasAgreedToConfidentiality ?? this.hasAgreedToConfidentiality,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
  
  @override
  List<Object?> get props => [
    id,
    username,
    name,
    lastName,
    email,
    address,
    age,
    profileType,
    isPhysicalPerson,
    isNonPhysicalPerson,
    requestedProfessions,
    contractionType,
    rating,
    isBlocked,
    isAvailable,
    hasAgreedToConfidentiality,
    profileImageUrl,
  ];
}

