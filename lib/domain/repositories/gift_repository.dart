import '../entities/gift.dart';

abstract class GiftRepository {
  Future<List<Gift>> getGifts();
  Future<List<Gift>> getGiftsByWedding(String weddingId);
  Future<List<Gift>> getGiftsByGuest(String guestId);
  Future<double> getTotalGiftValueByGuest(String guestId);
  Future<void> addGift(Gift gift);
  Future<void> updateGift(Gift gift);
  Future<void> deleteGift(String id);
  Stream<List<Gift>> watchGiftsByWedding(String weddingId);
}
