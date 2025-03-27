class Job {
  final String id;
  final String userId;
  final String name;
  final String details;
  final String description;
  final String requirements;
  final double price;
  final String type;
  final String contract;
  final String time;
  final bool isPeriodic;

  Job({
    required this.id,
    required this.userId,
    required this.name,
    required this.details,
    required this.description,
    required this.requirements,
    required this.price,
    required this.type,
    required this.contract,
    required this.time,
    required this.isPeriodic,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      details: json['details'],
      description: json['description'],
      requirements: json['requirements'],
      price: json['price'],
      type: json['type'],
      contract: json['contract'],
      time: json['time'],
      isPeriodic: json['isPeriodic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'details': details,
      'description': description,
      'requirements': requirements,
      'price': price,
      'type': type,
      'contract': contract,
      'time': time,
      'isPeriodic': isPeriodic,
    };
  }
}

