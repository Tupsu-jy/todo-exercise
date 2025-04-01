class Notepad {
  final String id;
  final String name;
  final String companyId;
  int orderVersion;

  Notepad({
    required this.id,
    required this.name,
    required this.companyId,
    required this.orderVersion,
  });

  factory Notepad.fromJson(Map<String, dynamic> json) {
    return Notepad(
      id: json['id'] as String,
      name: json['name'] as String,
      companyId: json['company_id'] as String,
      orderVersion: json['order_version'] as int,
    );
  }
}
