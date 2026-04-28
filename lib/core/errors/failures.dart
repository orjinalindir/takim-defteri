abstract class Failure {
  final String message;
  const Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Sunucu hatası oluştu']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Yerel veri hatası oluştu']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'İnternet bağlantısı yok']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Kimlik doğrulama hatası']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Geçersiz veri']);
}

class SyncFailure extends Failure {
  const SyncFailure([super.message = 'Senkronizasyon hatası']);
}

class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Bilinmeyen bir hata oluştu']);
}
