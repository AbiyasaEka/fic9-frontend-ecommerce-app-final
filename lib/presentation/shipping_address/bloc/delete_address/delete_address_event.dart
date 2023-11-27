part of 'delete_address_bloc.dart';

@freezed
class DeleteAddressEvent with _$DeleteAddressEvent {
  const factory DeleteAddressEvent.started() = _Started;
  const factory DeleteAddressEvent.deleteAddress(String id) = _DeleteAddress;
}
