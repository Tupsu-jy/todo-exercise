class Notepad {
  final String id;
  final String name;
  final String companyId;
  int orderVersion;
  int orderIndex;

  Notepad({
    required this.id,
    required this.name,
    required this.companyId,
    required this.orderVersion,
    required this.orderIndex,
  });

  Notepad copyWith({
    String? id,
    String? name,
    String? companyId,
    int? orderVersion,
    int? orderIndex,
  }) {
    return Notepad(
      id: id ?? this.id,
      name: name ?? this.name,
      companyId: companyId ?? this.companyId,
      orderVersion: orderVersion ?? this.orderVersion,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  factory Notepad.fromJson(Map<String, dynamic> json) {
    return Notepad(
      id: json['id'] as String,
      name: json['name'] as String,
      companyId: json['company_id'] as String,
      orderVersion: json['order_version'] as int,
      orderIndex: json['order_index'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'company_id': companyId,
      'order_version': orderVersion,
      'order_index': orderIndex,
    };
  }
}
