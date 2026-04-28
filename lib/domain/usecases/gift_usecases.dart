import '../entities/gift.dart';
import '../repositories/gift_repository.dart';

class GetGiftsByWedding {
  final GiftRepository repository;
  GetGiftsByWedding(this.repository);

  Future<List<Gift>> call(String weddingId) =>
      repository.getGiftsByWedding(weddingId);
}

class AddGift {
  final GiftRepository repository;
  AddGift(this.repository);

  Future<void> call(Gift gift) => repository.addGift(gift);
}

class UpdateGift {
  final GiftRepository repository;
  UpdateGift(this.repository);

  Future<void> call(Gift gift) => repository.updateGift(gift);
}

class DeleteGift {
  final GiftRepository repository;
  DeleteGift(this.repository);

  Future<void> call(String id) => repository.deleteGift(id);
}

class GetTotalGiftValueByGuest {
  final GiftRepository repository;
  GetTotalGiftValueByGuest(this.repository);

  Future<double> call(String guestId) =>
      repository.getTotalGiftValueByGuest(guestId);
}
