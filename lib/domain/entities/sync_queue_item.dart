class SyncQueueItem {
  final int? id;
  final String tableName;
  final String operation;
  final String localId;
  final String payload;
  final int retryCount;
  final String? lastError;
  final DateTime createdAt;

  const SyncQueueItem({
    this.id,
    required this.tableName,
    required this.operation,
    required this.localId,
    required this.payload,
    this.retryCount = 0,
    this.lastError,
    required this.createdAt,
  });

  SyncQueueItem copyWith({
    int? id,
    String? tableName,
    String? operation,
    String? localId,
    String? payload,
    int? retryCount,
    String? lastError,
    DateTime? createdAt,
  }) {
    return SyncQueueItem(
      id: id ?? this.id,
      tableName: tableName ?? this.tableName,
      operation: operation ?? this.operation,
      localId: localId ?? this.localId,
      payload: payload ?? this.payload,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
