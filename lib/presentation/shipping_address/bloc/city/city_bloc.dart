import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/datasources/raja_ongkir_remote_datasource.dart';
import '../../../../data/models/responses/city_response_model.dart';

part 'city_event.dart';
part 'city_state.dart';
part 'city_bloc.freezed.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  City defaultValue = City(
    cityId: '0',
    provinceId: '0',
    province: '0',
    type: '',
    cityName: '-- Pilih Kota --',
    postalCode: '',
  );

  CityBloc() : super(const _Initial()) {
    on<_GetAllByProvinceId>((event, emit) async {
      emit(const _Loading());
      final response =
          await RajaOngkirRemoteDatasource().getCities(event.province);
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
