// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fic9_ecommerce_template_app/data/models/responses/get_address_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/button.dart';
import '../../common/components/custom_dropdown.dart';
import '../../common/components/custom_text_field2.dart';
import '../../common/components/space_height.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/models/responses/city_response_model.dart';
import '../../data/models/responses/province_response_model.dart';
import '../../data/models/responses/subdistrict_response_model.dart';
import 'bloc/add_address/add_address_bloc.dart';
import 'bloc/city/city_bloc.dart';
import 'bloc/province/province_bloc.dart';
import 'bloc/subdistrict/subdistrict_bloc.dart';

class EditAddressPage extends StatefulWidget {
  final GetAddress data;
  const EditAddressPage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<EditAddressPage> createState() => _EditAddressPageState();
}

class _EditAddressPageState extends State<EditAddressPage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  bool isDefault = false;

  Province selectedProvince = Province(
    provinceId: '-1',
    province: '-',
  );

  City selectedCity = City(
    cityId: '-1',
    provinceId: '0',
    province: '0',
    type: '',
    cityName: '',
    postalCode: '',
  );

  SubDistrict selectedSubDistrict = SubDistrict(
    subdistrictId: '-1',
    provinceId: '0',
    province: '',
    cityId: '0',
    city: '',
    type: '',
    subdistrictName: '',
  );

  void getAllProvince() {
    context.read<ProvinceBloc>().add(const ProvinceEvent.getAll());
  }

  void getAllByProvinceId(String id) {
    context.read<CityBloc>().add(
          CityEvent.getAllByProvinceId(id),
        );
  }

  void getAllByCityId(String id) {
    context.read<SubdistrictBloc>().add(
          SubdistrictEvent.getAllByCityId(id),
        );
  }

  int getProvIndex(List data) {
    return data.indexWhere(
        (element) => element.provinceId == widget.data.attributes.provId);
  }

  int getCityIndex(List data) {
    return data.indexWhere(
        (element) => element.cityId == widget.data.attributes.cityId);
  }

  @override
  void initState() {
    nameController.text = widget.data.attributes.name;
    addressController.text = widget.data.attributes.address;
    phoneNumberController.text = widget.data.attributes.phone;
    zipCodeController.text = widget.data.attributes.codePos;

    getAllProvince();
    getAllByProvinceId(widget.data.attributes.provId);
    getAllByCityId(widget.data.attributes.cityId);

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();

    zipCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Alamat'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: nameController,
            label: 'Nama Lengkap',
            keyboardType: TextInputType.name,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: addressController,
            label: 'Alamat Jalan',
            maxLines: 3,
            keyboardType: TextInputType.multiline,
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: phoneNumberController,
            label: 'No Handphone',
            keyboardType: TextInputType.phone,
          ),
          const SpaceHeight(24.0),
          BlocBuilder<ProvinceBloc, ProvinceState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (provinces) {
                  if (selectedProvince.provinceId == '-1') {
                    selectedProvince = provinces[getProvIndex(provinces)];
                  }
                  return CustomDropdown<Province>(
                    value: provinces[getProvIndex(provinces)],
                    items: provinces,
                    label: 'Provinsi',
                    onChanged: (value) {
                      setState(() {
                        selectedProvince = value!;
                      });
                      getAllByProvinceId(value!.provinceId);
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<CityBloc, CityState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-- Pilih Kota --',
                    items: const ['-- Pilih Kota --'],
                    label: 'Kota/Kabupaten',
                    onChanged: (value) {},
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (cities) {
                  return CustomDropdown<City>(
                    value: cities.first,
                    items: cities,
                    label: 'Kota/Kabupaten',
                    onChanged: (value) {
                      setState(() {
                        selectedCity = value!;
                      });
                      getAllByCityId(value!.cityId);
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          BlocBuilder<SubdistrictBloc, SubdistrictState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return CustomDropdown(
                    value: '-- Pilih Kecamatan --',
                    items: const ['-- Pilih Kecamatan --'],
                    label: 'Kecamatan',
                    onChanged: (value) {},
                  );
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                loaded: (subdistricts) {
                  return CustomDropdown<SubDistrict>(
                    value: subdistricts.first,
                    items: subdistricts,
                    label: 'Kecamatan',
                    onChanged: (value) {
                      setState(() {
                        selectedSubDistrict = value!;
                      });
                    },
                  );
                },
              );
            },
          ),
          const SpaceHeight(24.0),
          CustomTextField2(
            controller: zipCodeController,
            label: 'Kode Pos',
            keyboardType: TextInputType.number,
          ),
          const SpaceHeight(24.0),
          CheckboxListTile(
            value: isDefault,
            onChanged: (value) {
              setState(() {
                isDefault = value!;
              });
            },
            title: const Text('Simpan sebagai alamat utama'),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<AddAddressBloc, AddAddressState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              loaded: (response) {
                Navigator.pop(context, response);
              },
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () {
                return Button.filled(
                  onPressed: () async {
                    //Validasi
                    if (nameController.text == '') {
                      _warning('Nama lengkap tidak boleh kosong!');
                      return;
                    }
                    if (addressController.text == '') {
                      _warning('Alamat tidak boleh kosong!');
                      return;
                    }
                    if (phoneNumberController.text == '') {
                      _warning('No handphone tidak boleh kosong!');
                      return;
                    }
                    if (selectedProvince.provinceId == '0') {
                      _warning('Provinsi belum dipilih!');
                      return;
                    }
                    if (selectedCity.cityId == '0') {
                      _warning('Kota belum dipilih!');
                      return;
                    }
                    if (selectedSubDistrict.subdistrictId == '0') {
                      _warning('Kecamatan belum dipilih!');
                      return;
                    }

                    //get userID from local storage
                    final userId = (await AuthLocalDataSource().getUser()).id;
                    context.read<AddAddressBloc>().add(
                          AddAddressEvent.editAddress(
                              name: nameController.text,
                              address: addressController.text,
                              phone: phoneNumberController.text,
                              provinceId: selectedProvince.provinceId,
                              cityId: selectedCity.cityId,
                              subdistrictId: selectedSubDistrict.subdistrictId,
                              provinceName: selectedProvince.province,
                              cityName: selectedCity.cityName,
                              subdistrictName:
                                  selectedSubDistrict.subdistrictName,
                              codePos: zipCodeController.text,
                              userId: userId!.toString(),
                              isDefault: isDefault,
                              id: widget.data.id.toString()),
                        );
                  },
                  label: 'Simpan Alamat',
                );
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              error: (message) {
                return Button.filled(
                  onPressed: () {},
                  label: 'Error',
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _warning(String pesan) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Peringatan'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(pesan),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Tutup'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
