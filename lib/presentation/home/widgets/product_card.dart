import 'package:fic9_ecommerce_template_app/common/constants/variables.dart';
import 'package:fic9_ecommerce_template_app/common/extensions/int_ext.dart';
import 'package:fic9_ecommerce_template_app/data/models/responses/products_response_model.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/bloc/cart/cart_bloc.dart';
import 'package:fic9_ecommerce_template_app/presentation/cart/widgets/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/components/space_height.dart';
import '../../../common/constants/colors.dart';
import '../../product_detail/product_detail_page.dart';
import '../product_model.dart';

class ProductCard extends StatelessWidget {
  final Product data;
  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                    product: data,
                  )),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              offset: const Offset(
                1.0,
                1.0,
              ), //Offset
              blurRadius: 2.0,
              spreadRadius: 0.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.white,
              offset: const Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 2.0,
            ), //BoxShadow
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Image.network(
                          '${Variables.baseUrl}${data.attributes.images.data.first.attributes.url}',
                          width: 170.0,
                          height: 112.0,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SpaceHeight(14.0),
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Flexible(
                                    child: Text(
                                      data.attributes.name,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SpaceHeight(4.0),
                                  Text(
                                    int.parse(data.attributes.price)
                                        .currencyFormatRp,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: SizedBox(
                                  width: 30,
                                  child: IconButton(
                                      onPressed: () {
                                        context.read<CartBloc>().add(
                                            CartEvent.add(CartModel(
                                                product: data, quantity: 1)));
                                      },
                                      icon: Icon(Icons.add))),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
