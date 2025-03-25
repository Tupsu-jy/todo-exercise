class Company {
  final String id;
  final String company_slug;
  final String cv_id;
  final String cover_letter_id;

  Company({
    required this.id,
    required this.company_slug,
    required this.cv_id,
    required this.cover_letter_id,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'] as String,
      company_slug: json['company_slug'] as String,
      cv_id: json['cv_id'] as String,
      cover_letter_id: json['cover_letter_id'] as String,
    );
  }
}
