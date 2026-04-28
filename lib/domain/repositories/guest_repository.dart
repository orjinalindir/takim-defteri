import '../entities/guest.dart';

abstract class GuestRepository {
  Future<List<Guest>> getGuests();
  Future<Guest?> getGuestById(String id);
  Future<List<Guest>> searchGuests(String query);
  Future<List<Guest>> getGuestsByCity(String city);
  Future<List<Guest>> getGuestsByRelationship(String relationship);
  Future<void> addGuest(Guest guest);
  Future<void> updateGuest(Guest guest);
  Future<void> deleteGuest(String id);
  Stream<List<Guest>> watchGuests();
}
