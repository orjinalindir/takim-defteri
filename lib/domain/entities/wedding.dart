class Wedding {
  final String id;
  final String userId;
  final String title;
  final String brideName;
  final String groomName;
  final DateTime weddingDate;
  final String? venue;
  final String? city;
  final String? notes;
  final bool isMyWedding;
  final int syncStatus;
  final DateTime? updatedAt;

  const Wedding({
    required this.id,
    required this.userId,
    required this.title,
    required this.brideName,
    required this.groomName,
    required this.weddingDate,
    this.venue,
    this.city,
    this.notes,
    this.isMyWedding = true,
    this.syncStatus = 0,
    this.updatedAt,
  });

  Wedding copyWith({
    String? id,
    String? userId,
    String? title,
    String? brideName,
    String? groomName,
    DateTime? weddingDate,
    String? venue,
    String? city,
    String? notes,
    bool? isMyWedding,
    int? syncStatus,
    DateTime? updatedAt,
  }) {
    return Wedding(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      brideName: brideName ?? this.brideName,
      groomName: groomName ?? this.groomName,
      weddingDate: weddingDate ?? this.weddingDate,
      venue: venue ?? this.venue,
      city: city ?? this.city,
      notes: notes ?? this.notes,
      isMyWedding: isMyWedding ?? this.isMyWedding,
      syncStatus: syncStatus ?? this.syncStatus,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
