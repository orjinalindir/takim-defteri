class Guest {
  final String id;
  final String userId;
  final String fullName;
  final String? phone;
  final String? city;
  final String? relationship;
  final String? notes;
  final int syncStatus;

  const Guest({
    required this.id,
    required this.userId,
    required this.fullName,
    this.phone,
    this.city,
    this.relationship,
    this.notes,
    this.syncStatus = 0,
  });

  Guest copyWith({
    String? id,
    String? userId,
    String? fullName,
    String? phone,
    String? city,
    String? relationship,
    String? notes,
    int? syncStatus,
  }) {
    return Guest(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      relationship: relationship ?? this.relationship,
      notes: notes ?? this.notes,
      syncStatus: syncStatus ?? this.syncStatus,
    );
  }
}
