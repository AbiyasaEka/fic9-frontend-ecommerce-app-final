import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/raja_ongkir_remote_datasource.dart';
import '../../../../data/models/responses/province_response_model.dart';
part 'province_event.dart';
part 'province_state.dart';
part 'province_bloc.freezed.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  Province defaultValue = Province(
    provinceId: '0',
    province: '-- Pilih Provinsi --',
  );

  ProvinceBloc() : super(const _Initial()) {
    on<ProvinceEvent>((event, emit) async {
      emit(const _Loading());
      final result = await RajaOngkirRemoteDatasource().getProvinces();
      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          r.rajaongkir.results.insert(0, defaultValue);
          emit(_Loaded(r.rajaongkir.results));
        },
      );
    });
  }
}
