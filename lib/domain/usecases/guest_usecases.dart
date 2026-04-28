import '../entities/guest.dart';
import '../repositories/guest_repository.dart';

class GetGuests {
  final GuestRepository repository;
  GetGuests(this.repository);

  Future<List<Guest>> call() => repository.getGuests();
}

class SearchGuests {
  final GuestRepository repository;
  SearchGuests(this.repository);

  Future<List<Guest>> call(String query) => repository.searchGuests(query);
}

class AddGuest {
  final GuestRepository repository;
  AddGuest(this.repository);

  Future<void> call(Guest guest) => repository.addGuest(guest);
}

class UpdateGuest {
  final GuestRepository repository;
  UpdateGuest(this.repository);

  Future<void> call(Guest guest) => repository.updateGuest(guest);
}
