class Company {
  final String id;
  final String company_slug;
  final String cv_id;
  final String cover_letter_id;
  final int order_version;

  Company({
    required this.id,
    required this.company_slug,
    required this.cv_id,
    required this.cover_letter_id,
    required this.order_version,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as String,
      company_slug: json['company_slug'] as String,
      cv_id: json['cv_id'] as String,
      cover_letter_id: json['cover_letter_id'] as String,
      order_version: json['order_version'] as int,
    );
  }
}
