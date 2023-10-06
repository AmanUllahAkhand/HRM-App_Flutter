class Holiday {
  final String name;
  final String date;
  final String observed;
  final bool isPublic;

  Holiday({
    required this.name,
    required this.date,
    required this.observed,
    required this.isPublic,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) {
    return Holiday(
      name: json['name'],
      date: json['date'],
      observed: json['observed'],
      isPublic: json['public'],
    );
  }
}
