import '../entities/wedding.dart';

abstract class WeddingRepository {
  Future<List<Wedding>> getWeddings();
  Future<Wedding?> getWeddingById(String id);
  Future<List<Wedding>> getUpcomingWeddings({int days = 7});
  Future<List<Wedding>> getWeddingsByMonth(int year, int month);
  Future<void> addWedding(Wedding wedding);
  Future<void> updateWedding(Wedding wedding);
  Future<void> deleteWedding(String id);
  Stream<List<Wedding>> watchWeddings();
}
