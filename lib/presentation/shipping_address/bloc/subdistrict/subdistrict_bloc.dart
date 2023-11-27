import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/raja_ongkir_remote_datasource.dart';
import '../../../../data/models/responses/subdistrict_response_model.dart';

part 'subdistrict_event.dart';
part 'subdistrict_state.dart';
part 'subdistrict_bloc.freezed.dart';

class SubdistrictBloc extends Bloc<SubdistrictEvent, SubdistrictState> {
  SubDistrict defaultValue = SubDistrict(
    subdistrictId: '0',
    provinceId: '0',
    province: '',
    cityId: '0',
    city: '',
    type: '',
    subdistrictName: '-- Pilih Kecamatan --',
  );

  SubdistrictBloc() : super(const _Initial()) {
    on<_GetAllByCityId>((event, emit) async {
      emit(const _Loading());
      final response =
          await RajaOngkirRemoteDatasource().getSubDistrict(event.city);
      response.fold(
        (l) => emit(_Error(l)),
        (r) {
          r.rajaongkir.results.insert(0, defaultValue);
          emit(_Loaded(r.rajaongkir.results));
        },
      );
    });
  }
}
