class Gift {
  final String id;
  final String userId;
  final String weddingId;
  final String? guestId;
  final String guestNameSnapshot;
  final int? giftTypeId;
  final double quantity;
  final double? recordedAmountTry;
  final String? notes;
  final DateTime givenAt;
  final int syncStatus;
  final DateTime? createdAt;

  const Gift({
    required this.id,
    required this.userId,
    required this.weddingId,
    this.guestId,
    required this.guestNameSnapshot,
    this.giftTypeId,
    this.quantity = 1,
    this.recordedAmountTry,
    this.notes,
    required this.givenAt,
    this.syncStatus = 0,
    this.createdAt,
  });

  Gift copyWith({
    String? id,
    String? userId,
    String? weddingId,
    String? guestId,
    String? guestNameSnapshot,
    int? giftTypeId,
    double? quantity,
    double? recordedAmountTry,
    String? notes,
    DateTime? givenAt,
    int? syncStatus,
    DateTime? createdAt,
  }) {
    return Gift(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weddingId: weddingId ?? this.weddingId,
      guestId: guestId ?? this.guestId,
      guestNameSnapshot: guestNameSnapshot ?? this.guestNameSnapshot,
      giftTypeId: giftTypeId ?? this.giftTypeId,
      quantity: quantity ?? this.quantity,
      recordedAmountTry: recordedAmountTry ?? this.recordedAmountTry,
      notes: notes ?? this.notes,
      givenAt: givenAt ?? this.givenAt,
      syncStatus: syncStatus ?? this.syncStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
