import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/order_remote_datasource.dart';

part 'delete_address_event.dart';
part 'delete_address_state.dart';
part 'delete_address_bloc.freezed.dart';

class DeleteAddressBloc extends Bloc<DeleteAddressEvent, DeleteAddressState> {
  DeleteAddressBloc() : super(const _Initial()) {
    on<_DeleteAddress>((event, emit) async {
      emit(const _Loading());
      final response = await OrderRemoteDatasource().deleteAddress(event.id);

      response.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r)),
      );
    });
  }
}
