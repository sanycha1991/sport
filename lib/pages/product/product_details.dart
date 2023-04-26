import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sport/extensions/imports.dart';
import 'package:sport/pages/shared/product_details_app_bar.dart';
import 'package:sport/pages/shared/widgets/my_button.dart';
import 'package:sport/services/checkout/checkout_provider.dart';
import 'package:sport/services/products/models/product.dart';

class ProductDetails extends StatefulWidget {
  final Product p;
  const ProductDetails({Key? key, required this.p}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late double _opacity;
  late double _height;

  @override
  void initState() {
    _opacity = 0.2;
    _height = 100;
    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      setState(() {
        _opacity = 1;
        _height = 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _BackgroundBuble(p: widget.p),
          Column(
            children: [
              ProductDetailsAppBar(p: widget.p),
              _ProductImage(p: widget.p),
              Expanded(
                child: SingleChildScrollView(
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _opacity,
                    child: Column(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: _height,
                        ),
                        _ImagesList(p: widget.p),
                        _ProductDescription(p: widget.p),
                        SizedBox(height: 25.w),
                        _Size(
                          p: widget.p,
                          // onSizeTap: (FootSize size) {},
                        ),
                        SizedBox(height: 20.w),
                        MyButton(
                          title: 'APP_add_to_bag',
                          onTap: () {
                            context
                                .read<CheckoutProvider>()
                                .addProduct(widget.p);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Size extends StatefulWidget {
  final Product p;
  // final Function(FootSize) onSizeTap;
  const _Size({
    Key? key,
    required this.p,
    // required this.onSizeTap,
  }) : super(key: key);

  @override
  State<_Size> createState() => _SizeState();
}

class _SizeState extends State<_Size> {
  // late FootSize _activeFootSize;

  void onSizeTap(FootSize size) {
    setState(() {
      // _activeFootSize = size;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Txt(
                'APP_size',
                style: context.theme.textBold.copyWith(
                  fontSize: 20.w,
                ),
              ),
              const Spacer(),
              Txt(
                'APP_uk',
                style: context.theme.textBold.copyWith(
                  fontSize: 14.w,
                ),
              ),
              SizedBox(width: 10.w),
              Txt(
                'APP_usa',
                style: context.theme.textBold.copyWith(
                  fontSize: 14.w,
                  color: context.theme.onlyGrey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.w),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 20.w),
              _SizeItem(title: 'APP_try_it', onTap: () {}),
              ...widget.p.footSize.map((e) => _SizeItem(
                    title: e.value,
                    // isActive: _activeFootSize !,
                    onTap: () {
                      onSizeTap(e);
                    },
                  )),
              SizedBox(width: 20.w),
            ],
          ),
        )
      ],
    );
  }
}

class _SizeItem extends StatefulWidget {
  const _SizeItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;

  @override
  State<_SizeItem> createState() => _SizeItemState();
}

class _SizeItemState extends State<_SizeItem> with TickerProviderStateMixin {
  double _bgOpacity = 0;
  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        setState(() {
          _bgOpacity = 1;
          _textColor = Colors.white;
        });
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.w),
            margin: EdgeInsets.only(right: 10.w),
            decoration: BoxDecoration(
              color: context.theme.onlyBlack.withOpacity(_bgOpacity),
              borderRadius: BorderRadius.circular(5.w),
              border: Border.all(
                color: context.theme.onlyGrey,
              ),
            ),
            child: Center(
              child: Txt(
                widget.title,
                style: context.theme.textBold.copyWith(
                  color: _textColor,
                ),
              ),
            ),
          ),
          // Positioned.fill(
          //   top: 0,
          //   child: Center(
          //     child: Container(
          //       width: 20.w,
          //       height: 20.w,
          //       decoration: BoxDecoration(
          //         color: context.theme.transparent,
          //         borderRadius: BorderRadius.circular(15.w),
          //         border: Border.all(width: 1, color: context.theme.onlyGrey),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  final Product p;
  const _ProductDescription({
    Key? key,
    required this.p,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                p.subTitle.toUpperCase(),
                style: context.theme.textBold.copyWith(
                  fontSize: 20.w,
                ),
              ),
              Txt(
                p.price.usdFormat,
                style: context.theme.textBold.copyWith(
                  fontSize: 20.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.w),
          Text(
            'Nike, Inc. is an American multinational corporation that designs, develops, and sells athletic. ',
            style: context.theme.textRegular.copyWith(
              color: context.theme.onlyBlack.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 10.w),
          Txt(
            'APP_more_details',
            style: context.theme.textMedium.copyWith(
              color: context.theme.onlyBlack.withOpacity(0.6),
              fontSize: 12.w,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _ImagesList extends StatelessWidget {
  final Product p;
  _ImagesList({
    Key? key,
    required this.p,
  }) : super(key: key);

  late BuildContext _context;

  Widget _item({required Image img}) => Container(
        width: 74.w,
        height: 50.w,
        margin: EdgeInsets.only(right: 15.w),
        decoration: BoxDecoration(
          color: _context.theme.onlyBlack.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.w),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(width: 20.w),
              ...List.generate(
                6,
                (index) => _item(img: p.picture),
              ),
              SizedBox(width: 20.w),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.w,
          ),
          child: Divider(
            height: 2,
            color: context.theme.onlyBlack,
          ),
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({
    Key? key,
    required this.p,
  }) : super(key: key);

  final Product p;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Hero(
        tag: 'product-image${p.id}',
        child: p.picture,
      ),
    );
  }
}

class _BackgroundBuble extends StatelessWidget {
  final Product p;
  const _BackgroundBuble({
    Key? key,
    required this.p,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -450.w,
      left: -50.w,
      child: Hero(
        tag: 'product${p.id}',
        child: Container(
          width: context.withOf(200),
          height: 800.w,
          decoration: BoxDecoration(
            color: p.color,
            borderRadius: BorderRadius.circular(
              800.w,
            ),
          ),
        ),
      ),
    );
  }
}
