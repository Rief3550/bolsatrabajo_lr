class Profession {
  final String id;
  final String name;
  final String experience;
  final String development;
  final String rubroId;
  final bool isAvailable;
  final String? imageUrl;
  final int matchesCount;
  final int jobsCount;

  Profession({
    required this.id,
    required this.name,
    required this.experience,
    required this.development,
    required this.rubroId,
    required this.isAvailable,
    this.imageUrl,
    required this.matchesCount,
    required this.jobsCount,
  });

  factory Profession.fromJson(Map<String, dynamic> json) {
    return Profession(
      id: json['id'],
      name: json['name'],
      experience: json['experience'],
      development: json['development'],
      rubroId: json['rubroId'],
      isAvailable: json['isAvailable'],
      imageUrl: json['imageUrl'],
      matchesCount: json['matchesCount'],
      jobsCount: json['jobsCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'experience': experience,
      'development': development,
      'rubroId': rubroId,
      'isAvailable': isAvailable,
      'imageUrl': imageUrl,
      'matchesCount': matchesCount,
      'jobsCount': jobsCount,
    };
  }
}

