import '../entities/wedding.dart';
import '../repositories/wedding_repository.dart';

class GetWeddings {
  final WeddingRepository repository;
  GetWeddings(this.repository);

  Future<List<Wedding>> call() => repository.getWeddings();
}

class GetUpcomingWeddings {
  final WeddingRepository repository;
  GetUpcomingWeddings(this.repository);

  Future<List<Wedding>> call({int days = 7}) =>
      repository.getUpcomingWeddings(days: days);
}

class GetWeddingsByMonth {
  final WeddingRepository repository;
  GetWeddingsByMonth(this.repository);

  Future<List<Wedding>> call(int year, int month) =>
      repository.getWeddingsByMonth(year, month);
}

class AddWedding {
  final WeddingRepository repository;
  AddWedding(this.repository);

  Future<void> call(Wedding wedding) => repository.addWedding(wedding);
}

class UpdateWedding {
  final WeddingRepository repository;
  UpdateWedding(this.repository);

  Future<void> call(Wedding wedding) => repository.updateWedding(wedding);
}

class DeleteWedding {
  final WeddingRepository repository;
  DeleteWedding(this.repository);

  Future<void> call(String id) => repository.deleteWedding(id);
}
