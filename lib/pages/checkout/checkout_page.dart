import 'package:provider/provider.dart';
import 'package:sport/pages/shared/widgets/my_button.dart';
import 'package:sport/services/checkout/checkout_provider.dart';
import 'package:sport/services/products/models/product.dart';

import '../../extensions/imports.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late CheckoutProvider provider;
  @override
  void initState() {
    provider = context.read<CheckoutProvider>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.select((CheckoutProvider p) => p.simpleStateUpdate);
    return Scaffold(
      appBar: _CheckoutAppBar(
        title: 'APP_my_bag',
        rightLabel:
            '${context.trs('APP_total')} ${provider.totalItems} ${context.trs('APP_items')}',
        onTap: () {
          context.pop();
        },
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Products list

            if (provider.totalItems > 0)
              _ProductsList(
                products: provider.checkoutProducts,
              ),

            if (provider.totalItems == 0) const _EmptyBag(),

            // button
            if (provider.totalItems > 0)
              _Button(totalPrice: provider.totalPrice),
          ],
        ),
      ),
    );
  }
}

class _EmptyBag extends StatelessWidget {
  const _EmptyBag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Txt(
          'APP_bag_is_empty',
          style: context.theme.textRegular.copyWith(
            fontSize: 12.w,
            color: context.theme.onlyGrey,
          ),
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final double totalPrice;
  const _Button({
    Key? key,
    required this.totalPrice,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.w,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: context.theme.grayBorderColor,
          ),
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 14.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                context.trs('APP_total').toUpperCase(),
                style: context.theme.textBold.copyWith(
                  fontSize: 10.w,
                ),
              ),
              Txt(
                totalPrice.usdFormat,
                style: context.theme.textBold.copyWith(
                  fontSize: 22.w,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.w),
          MyButton(
            title: 'APP_next',
            onTap: () {},
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(vertical: 13.w),
          ),
        ],
      ),
    );
  }
}

class _ProductsList extends StatelessWidget {
  final List<Product> products;
  const _ProductsList({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.w),
            ...products.reversed.map(
              (Product item) => _ProductItem(p: item),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductItem extends StatefulWidget {
  final Product p;
  const _ProductItem({
    Key? key,
    required this.p,
  }) : super(key: key);

  @override
  State<_ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<_ProductItem>
    with TickerProviderStateMixin {
  late CheckoutProvider provider;

  bool animationState = false;
  bool hide = false;

  // scale
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  double _titlePosition = 0.w;
  double _pricePosition = -200.w;
  double _quantityPosition = -60.w;
  double _descriptionsOpacity = 0.2;
  double _height = 0.w;

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // provider init
    provider = context.read<CheckoutProvider>();

    // scale animation init
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(_scaleController);

    // start if it's needed
    if (provider.isLastAdded(widget.p)) {
      _productAnimationForward();
    } else {
      _productWithoutAnimation();
    }

    if (widget.p.cart!.quantity == 0) {
      hide = true;
    }

    Future.delayed(const Duration(milliseconds: 1200))
        .then((value) => provider.resetLasts());

    super.initState();
  }

  @override
  void didUpdateWidget(covariant _ProductItem oldWidget) {
    if (widget.p.cart!.quantity == 0) {
      _productAnimationReverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _productWithoutAnimation() {
    _scaleController.reset();
    _scaleController.duration = const Duration(milliseconds: 0);
    _scaleController.forward();
    _titlePosition = 35.w;
    _pricePosition = 35.w;
    _height = 110.w;
    _quantityPosition = 132.w;
    _descriptionsOpacity = 1;
  }

  void _productAnimationForward() {
    animationState = true;
    _scaleController.forward();

    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      setState(() {
        _titlePosition = 35.w;
        _pricePosition = 35.w;
        _quantityPosition = 132.w;
        _descriptionsOpacity = 1;
        _height = 110.w;
        animationState = false;
      });
    });
  }

  void _productAnimationReverse() {
    animationState = true;
    _scaleController.reset();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1, end: 0).animate(_scaleController);
    _scaleController.forward();
    setState(() {
      _titlePosition = 0.w;
      _pricePosition = -200.w;
      _quantityPosition = -60.w;
      _descriptionsOpacity = 0.2;
      _height = 0.w;
      animationState = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (hide) return const SizedBox();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: _height,
      width: double.infinity,
      padding: const EdgeInsets.all(0),
      // margin: EdgeInsets.only(bottom: 20.w),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          // image cover
          AnimatedBuilder(
              animation: _scaleAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.w),
                      color: context.theme.checkoutImgCover,
                    ),
                  ),
                );
              }),

          // product picture
          Positioned(
            top: -13,
            left: 5.w,
            child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: SizedBox(
                      width: 110.w,
                      child: widget.p.picture,
                    ),
                  );
                }),
          ),

          // title
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            top: 18.w,
            right: _titlePosition, //132.w,
            child: AnimatedOpacity(
              opacity: _descriptionsOpacity,
              duration: const Duration(milliseconds: 800),
              child: SizedBox(
                width: 200.w,
                child: Txt(
                  widget.p.brand.toUpperCase() +
                      ' ' +
                      widget.p.subTitle.toUpperCase(),
                  style: context.theme.textBold.copyWith(
                    fontSize: 10.w,
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            top: 38.w,
            right: _pricePosition, //132.w,
            child: AnimatedOpacity(
              opacity: _descriptionsOpacity,
              duration: const Duration(milliseconds: 800),
              child: SizedBox(
                width: 200.w,
                child: Txt(
                  widget.p.price.usdFormat,
                  style: context.theme.textBold.copyWith(
                    fontSize: 16.w,
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            top: 60.w,
            right: _quantityPosition, //132.w,
            child: AnimatedOpacity(
              opacity: _descriptionsOpacity,
              duration: const Duration(milliseconds: 800),
              child: SizedBox(
                width: 100.w,
                height: 24.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        context
                            .read<CheckoutProvider>()
                            .decreaseQuantityProduct(widget.p);
                      },
                      child: Container(
                        width: 26.w,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: context.theme.grayBorderColor,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: Center(
                          child: Txt(
                            '-',
                            style: context.theme.textRegular.copyWith(
                              fontSize: 25.w,
                              height: 0.95.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Txt(
                      widget.p.cart!.quantity.toString(),
                      style: context.theme.textBold.copyWith(
                        fontSize: 16.w,
                        height: 1.1,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        context.read<CheckoutProvider>().addProduct(widget.p);
                      },
                      child: Container(
                        width: 26.w,
                        decoration: BoxDecoration(
                          color: context.theme.grayBorderColor,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: Center(
                          child: Txt(
                            '+',
                            style: context.theme.textRegular.copyWith(
                              fontSize: 18.w,
                              height: 0.95.w,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String rightLabel;
  final Function onTap;

  const _CheckoutAppBar({
    Key? key,
    required this.title,
    required this.rightLabel,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 40.w,
            left: 10.w,
          ),
          child: InkWell(
            onTap: () => onTap(),
            child: Transform.rotate(
              angle: 3.15,
              child: SvgPicture.asset(
                'arrow_right'.svg,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.w),
        Padding(
          padding: EdgeInsets.only(
            left: 10.w,
            right: 10.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Txt(
                title,
                style: context.theme.textBold.copyWith(
                  fontSize: 26.w,
                ),
              ),
              Txt(
                rightLabel,
                style: context.theme.textMedium.copyWith(
                  fontSize: 13.w,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.w),
        Divider(height: 1.w, color: context.theme.onlyGrey),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(90.w);
}
