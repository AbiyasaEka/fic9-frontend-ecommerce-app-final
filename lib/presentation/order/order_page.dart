import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/components/space_height.dart';
import 'bloc/buyer_order/buyer_order_bloc.dart';
import 'models/transaction_model.dart';
import 'widgets/order_card.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  void initState() {
    context.read<BuyerOrderBloc>().add(const BuyerOrderEvent.getBuyerOrder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pesanan'),
          bottom: const TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.symmetric(horizontal: 10.0),
            tabs: <Widget>[
              Text('Belum Bayar'),
              Text('Dikemas'),
              Text('Dikirim'),
              Text('Selesai'),
              Text('Batal'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            BlocBuilder<BuyerOrderBloc, BuyerOrderState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SpaceHeight(0.0),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (data) {
                    List _waitingPaymentData = data
                        .where((o) => o.attributes.status == 'waiting-payment')
                        .toList();
                    if (_waitingPaymentData.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada data'),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                      itemCount: _waitingPaymentData.length,
                      itemBuilder: (context, index) => OrderCard(
                        data: _waitingPaymentData[index],
                      ),
                    );
                  },
                  error: (message) => Center(
                    child: Text(message),
                  ),
                );
              },
            ),
            BlocBuilder<BuyerOrderBloc, BuyerOrderState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SpaceHeight(0.0),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (data) {
                    List _packagingData = data
                        .where((o) => o.attributes.status == 'packaging')
                        .toList();
                    if (_packagingData.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada data'),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                      itemCount: _packagingData.length,
                      itemBuilder: (context, index) => OrderCard(
                        data: _packagingData[index],
                      ),
                    );
                  },
                  error: (message) => Center(
                    child: Text(message),
                  ),
                );
              },
            ),
            BlocBuilder<BuyerOrderBloc, BuyerOrderState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SpaceHeight(0.0),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (data) {
                    List _deliveryData = data
                        .where((o) => o.attributes.status == 'on-delivery')
                        .toList();
                    if (_deliveryData.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada data'),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                      itemCount: _deliveryData.length,
                      itemBuilder: (context, index) => OrderCard(
                        data: _deliveryData[index],
                      ),
                    );
                  },
                  error: (message) => Center(
                    child: Text(message),
                  ),
                );
              },
            ),
            BlocBuilder<BuyerOrderBloc, BuyerOrderState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SpaceHeight(0.0),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (data) {
                    List _doneData = data
                        .where((o) => o.attributes.status == 'done')
                        .toList();
                    if (_doneData.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada data'),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                      itemCount: _doneData.length,
                      itemBuilder: (context, index) => OrderCard(
                        data: _doneData[index],
                      ),
                    );
                  },
                  error: (message) => Center(
                    child: Text(message),
                  ),
                );
              },
            ),
            BlocBuilder<BuyerOrderBloc, BuyerOrderState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SpaceHeight(0.0),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  loaded: (data) {
                    List _cancel = data
                        .where((o) => o.attributes.status == 'cancel')
                        .toList();
                    if (_cancel.isEmpty) {
                      return const Center(
                        child: Text('Tidak ada data'),
                      );
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      separatorBuilder: (context, index) =>
                          const SpaceHeight(16.0),
                      itemCount: _cancel.length,
                      itemBuilder: (context, index) => OrderCard(
                        data: _cancel[index],
                      ),
                    );
                  },
                  error: (message) => Center(
                    child: Text(message),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
