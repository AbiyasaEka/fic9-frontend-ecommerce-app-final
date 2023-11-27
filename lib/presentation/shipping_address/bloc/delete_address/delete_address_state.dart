part of 'delete_address_bloc.dart';

@freezed
class DeleteAddressState with _$DeleteAddressState {
  const factory DeleteAddressState.initial() = _Initial;
  const factory DeleteAddressState.loading() = _Loading;
  const factory DeleteAddressState.success(String message) = _Success;
  const factory DeleteAddressState.error(String message) = _Error;
}
