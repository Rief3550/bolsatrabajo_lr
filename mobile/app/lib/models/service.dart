class Service {
  final String id;
  final String name;
  final String experience;
  final String development;
  final String rubroId;
  final double rating;
  final bool isAvailable;
  final int matchesCount;
  final int jobsCount;

  Service({
    required this.id,
    required this.name,
    required this.experience,
    required this.development,
    required this.rubroId,
    required this.rating,
    required this.isAvailable,
    required this.matchesCount,
    required this.jobsCount,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      experience: json['experience'],
      development: json['development'],
      rubroId: json['rubroId'],
      rating: json['rating'],
      isAvailable: json['isAvailable'],
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
      'rating': rating,
      'isAvailable': isAvailable,
      'matchesCount': matchesCount,
      'jobsCount': jobsCount,
    };
  }
}

