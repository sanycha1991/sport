import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport/extensions/imports.dart';
import 'package:provider/provider.dart';
import 'package:sport/pages/product/product_details.dart';
import 'package:sport/services/products/models/product.dart';
import 'package:sport/services/products/products_cubit.dart';

class ProductsHorizontalWidget extends StatefulWidget {
  const ProductsHorizontalWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductsHorizontalWidget> createState() =>
      _ProductsHorizontalWidgetState();
}

class _ProductsHorizontalWidgetState extends State<ProductsHorizontalWidget> {
  late List<Product> products;

  @override
  void initState() {
    context.read<ProductsCubit>().fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0.w),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Row(
              children: [
                Txt(
                  'APP_more',
                  style: context.theme.textBold.copyWith(
                    fontSize: 18.w,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset('arrow_right'.svg),
              ],
            ),
          ),
          BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {
            if (state is ProductsLoaded) products = state.products;
          }, builder: (context, state) {
            if (state is ProductsLoaded) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SizedBox(width: 20.w),
                    ...products.map(
                      (p) => InkWell(
                        onTap: () {
                          context.push(ProductDetails(p: p));
                        },
                        child: Container(
                          width: context.withOf(42),
                          height: 166.w,
                          margin: EdgeInsets.only(
                            right: 20.w,
                            top: 10.w,
                          ),
                          decoration: BoxDecoration(
                            color: context.theme.onlyWhite,
                            borderRadius: BorderRadius.circular(10.w),
                            boxShadow: [
                              BoxShadow(
                                color: context.theme.onlyGrey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 24.w,
                                left: -22.w,
                                child: Transform.rotate(
                                  angle: -pi / 2,
                                  child: Container(
                                    width: 70.w,
                                    height: 24.w,
                                    decoration: BoxDecoration(
                                      color: context.theme.btnColor,
                                    ),
                                    child: Center(
                                      child: Txt(
                                        'APP_new',
                                        style:
                                            context.theme.textRegular.copyWith(
                                          color: context.theme.onlyWhite,
                                          fontSize: 11.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      // width: 130.w,
                                      height: 115.w,
                                      child: p.picture,
                                    ),
                                  ),
                                  Txt(
                                    p.brand.toUpperCase() +
                                        ' ' +
                                        p.subTitle.toUpperCase(),
                                    style: context.theme.textBold.copyWith(
                                      fontSize: 13.w,
                                    ),
                                  ),
                                  SizedBox(height: 6.w),
                                  Txt(
                                    p.price.usdFormat,
                                    style: context.theme.textRegular.copyWith(
                                      fontSize: 13.w,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox();
          }),
        ],
      ),
    );
  }
}
