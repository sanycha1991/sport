import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sport/extensions/imports.dart';
import 'package:sport/pages/home/states/home_scroll_provider.dart';
import 'package:sport/pages/product/product_details.dart';
import 'package:sport/services/products/models/product.dart';
import 'package:sport/services/products/products_cubit.dart';

class PageViewAnimation extends StatefulWidget {
  const PageViewAnimation({Key? key}) : super(key: key);

  @override
  State<PageViewAnimation> createState() => _PageViewAnimationState();
}

enum ScrollDirection {
  goingForward,
  goingBack,
}

class _PageViewAnimationState extends State<PageViewAnimation> {
  late final ScrollController _scrollController = ScrollController();
  late List<Product> products;

  double offsetJump = AnimationDurations.offsetJump;
  int scrollIndex = 0;
  bool scrolling = false;
  int indexOfProduct = 0;
  double _startX = 0.0;
  double _currentX = 0.0;

  @override
  void initState() {
    context.read<ProductsCubit>().fetchProducts();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // animations
  void makeScrollForward() {
    _scrollController.animateTo(
      _scrollController.offset + offsetJump,
      duration: Duration(milliseconds: AnimationDurations.scrollDuration),
      curve: Curves.easeOut,
    );
  }

  void makeScrollBackwards() {
    _scrollController.animateTo(
      _scrollController.offset - offsetJump,
      duration: Duration(milliseconds: AnimationDurations.scrollDuration),
      curve: Curves.easeOut,
    );
  }

  // ---------------------------

  Future<bool> resetAllProductTypes() async {
    for (var e in products) {
      e.animationType = AnimationCardType.none;
      e.whereIsScollGoing = WhereIsScollGoing.nowhere;
    }
    return true;
  }

  void setAnimationTypeAt({
    required AnimationCardType type,
    required WhereIsScollGoing scrollDirection,
    required int at,
  }) {
    resetAllProductTypes().then((_) {
      setState(() {
        products[at].animationType = type;
        products[at].whereIsScollGoing = scrollDirection;
      });
    });
  }

  void onScrollChanged(ScrollDirection direction) {
    scrolling = true;

    Future.delayed(
            Duration(milliseconds: AnimationDurations.scrollDuration + 1))
        .then((value) {
      scrolling = false;
    });

    if (direction == ScrollDirection.goingForward) {
      indexOfProduct = scrollIndex + 1;
    }
    if (direction == ScrollDirection.goingBack) {
      indexOfProduct = scrollIndex - 1;
    }

    // dd('index of product: $indexOfProduct');
  }

  void onScrollForward() async {
    if (scrolling) return;
    if (scrollIndex == (products.length - 1)) return;

    Provider.of<HomeScrollProvider>(context, listen: false)
        .fingerPrintAnimationForward();

    await Future.delayed(const Duration(milliseconds: 400));

    onScrollChanged(ScrollDirection.goingForward);

    // animation
    makeScrollForward();
    setAnimationTypeAt(
      type: AnimationCardType.previousCard,
      scrollDirection: WhereIsScollGoing.right,
      at: scrollIndex,
    );
    setAnimationTypeAt(
      type: AnimationCardType.nextCard,
      scrollDirection: WhereIsScollGoing.right,
      at: scrollIndex + 1,
    );
    // makeCardTransformForward();

    setState(() {
      scrollIndex++;
    });
  }

  void onScrollBack() {
    if (scrolling) return;
    if (scrollIndex == 0) return;
    onScrollChanged(ScrollDirection.goingBack);

    // animation
    makeScrollBackwards();
    setAnimationTypeAt(
      type: AnimationCardType.previousCard,
      scrollDirection: WhereIsScollGoing.left,
      at: scrollIndex,
    );
    setAnimationTypeAt(
      type: AnimationCardType.nextCard,
      scrollDirection: WhereIsScollGoing.left,
      at: scrollIndex - 1,
    );

    Provider.of<HomeScrollProvider>(context, listen: false)
        .fingerPrintAnimationBackward();

    setState(() {
      scrollIndex--;
    });
  }

  void onProductTap(Product p) {
    context.read<HomeScrollProvider>().reset();
    context.push(ProductDetails(p: p));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsLoaded) products = state.products;
      },
      builder: (context, state) {
        if (state is ProductsLoaded) {
          return GestureDetector(
            onPanEnd: (details) {
              if (_currentX > _startX) {
                onScrollBack();
              } else {
                onScrollForward();
              }
            },
            onPanStart: (details) {
              _startX = details.localPosition.dx;
            },
            onPanUpdate: (details) {
              _currentX = details.localPosition.dx;
            },
            onLongPressStart: (details) {
              // start
            },
            onLongPressEnd: (details) {
              // end
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(width: 70.w),
                  ...products
                      .map(
                        (p) => InkWell(
                          onTap: () => onProductTap(p),
                          child: _Item(
                            p: p,
                            isFirstProduct: products.indexOf(p) == 0,
                          ),
                        ),
                      )
                      .toList(),
                  SizedBox(width: 200.w),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

class AnimationDurations {
  static double offsetJump = 310.w;
  static int scrollDuration = 400;
  static int rotateDuration = 500;
  static int spacerDuration = 400;
  static int productMovementDuration = 300;
}

class _Item extends StatefulWidget {
  final bool isFirstProduct;
  const _Item({
    Key? key,
    required this.p,
    this.isFirstProduct = false,
  }) : super(key: key);

  final Product p;

  @override
  State<_Item> createState() => _ItemState();
}

class _ItemState extends State<_Item> with SingleTickerProviderStateMixin {
  late final AnimationController _rotateYcontroller;
  late Animation<double> _rotateYAnimation;
  double spaceSize = 0.w;
  double productLeftPosition = 0.w;

  setSpacerSize(double size) {
    spaceSize = size;
  }

  setProductRightPosition(double size) {
    productLeftPosition = size;
  }

  @override
  void initState() {
    super.initState();

    if (widget.p.animationType == AnimationCardType.none) {
      setProductRightPosition(10);
    }

    _rotateYcontroller = AnimationController(
      duration: Duration(milliseconds: AnimationDurations.rotateDuration),
      vsync: this,
    );

    setFirstCardAnimation(0, 0);
  }

  void setFirstCardAnimation(double begin, double end) {
    _rotateYAnimation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(_rotateYcontroller);
  }

  void setSecondCardAnimation(double begin, double end) {
    _rotateYAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0, end: 0.3),
        weight: 1,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.3, end: 0),
        weight: 0.4,
      ),
    ]).animate(_rotateYcontroller);
  }

  @override
  void didUpdateWidget(covariant _Item oldWidget) {
    super.didUpdateWidget(oldWidget);

    // dd('Where is scroll going: ${widget.whereIsScrollGoing}');
    if (widget.p.animationType == AnimationCardType.previousCard) {
      setFirstCardAnimation(0, -0.3.w);

      _rotateYcontroller.reset();
      _rotateYcontroller.forward();
      setState(() {
        if (widget.p.whereIsScollGoing == WhereIsScollGoing.right) {
          setSpacerSize(50);
        }

        setProductRightPosition(-100.w);
      });
    }

    if (widget.p.animationType == AnimationCardType.nextCard) {
      setSecondCardAnimation(0, 0.7.w);
      _rotateYcontroller.reset();
      _rotateYcontroller.forward();

      setState(() {
        if (widget.p.whereIsScollGoing == WhereIsScollGoing.left) {
          setSpacerSize(0);
        }

        setProductRightPosition(10.w);
      });
    }

    // dd(widget.p.whereIsScollGoing);
  }

  Alignment get getAnimationTypeAlignment {
    // dd(widget.p.animationType);
    if (widget.p.animationType == AnimationCardType.previousCard) {
      return Alignment.centerLeft;
    }
    if (widget.p.animationType == AnimationCardType.nextCard) {
      return Alignment.topRight;
    }
    return Alignment.center;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            AnimatedBuilder(
              animation: _rotateYAnimation,
              builder: (context, child) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Transform(
                  alignment: getAnimationTypeAlignment,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(
                      _rotateYAnimation.value,
                    ),
                  child: _item,
                ),
              ),
            ),
            AnimatedContainer(
              duration: Duration(
                milliseconds: AnimationDurations.spacerDuration,
              ),
              width: spaceSize,
            ),
          ],
        ),

        // Product
        _ProductPicture(
          p: widget.p,
          isFirst: widget.isFirstProduct,
        ),
      ],
    );
  }

  Widget get _item => Hero(
        tag: 'product${widget.p.id}',
        child: Container(
          // key: Key('product#${widget.p.id}'),
          width: 220.w, //180.w,
          height: 320.w,
          margin: EdgeInsets.only(right: 40.w),
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: widget.p.color,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Txt(
                    widget.p.brand.toUpperCase(),
                    style: context.theme.textMedium.copyWith(
                      fontSize: 16.w,
                      color: context.theme.onlyWhite,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const Spacer(),
                  SvgPicture.asset(
                    'nav_heart'.svg,
                    width: 16.w,
                    color: context.theme.onlyWhite,
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Txt(
                widget.p.subTitle.toUpperCase(),
                style: context.theme.textBold.copyWith(
                  fontSize: 22.w,
                  color: context.theme.onlyWhite,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(height: 7),
              Txt(
                widget.p.price.usdFormat,
                style: context.theme.textMedium.copyWith(
                  fontSize: 14.w,
                  fontWeight: FontWeight.normal,
                  color: context.theme.onlyWhite,
                  decoration: TextDecoration.none,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(
                  'arrow_right'.svg,
                  color: context.theme.onlyWhite,
                ),
              ),
            ],
          ),
        ),
      );

  void reset() {
    setState(() {
      setSpacerSize(0.w);
      setProductRightPosition(10.w);
    });
  }

  @override
  void dispose() {
    _rotateYcontroller.dispose();
    super.dispose();
  }
}

class _ProductPicture extends StatefulWidget {
  final Product p;
  final bool isFirst;
  const _ProductPicture({
    Key? key,
    required this.p,
    required this.isFirst,
  }) : super(key: key);

  @override
  State<_ProductPicture> createState() => _ProductPictureState();
}

class _ProductPictureState extends State<_ProductPicture>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    // setAnimation(-0.5, -0.5);
    if (widget.isFirst) {
      setAnimation(0, 0);
    } else {
      setAnimation(-0.5, -0.5);
    }
  }

  @override
  void didUpdateWidget(covariant _ProductPicture oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.p.animationType == AnimationCardType.nextCard) {
      if (widget.p.whereIsScollGoing == WhereIsScollGoing.right) {
        setAnimation(-0.5, 0);
        _controller.forward();
      }
    }
    if (widget.p.animationType == AnimationCardType.previousCard) {
      if (widget.p.whereIsScollGoing == WhereIsScollGoing.left) {
        _controller.animateBack(-0.5);
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void setAnimation(double begin, double end) async {
    _animation = Tween<double>(
      begin: begin,
      end: end,
    ).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(
        milliseconds: AnimationDurations.productMovementDuration,
      ),
      bottom: 20.w,
      left: 10.w,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value,
            child: Hero(
              tag: 'product-image${widget.p.id}',
              child: widget.p.picture,
            ),
          );
        },
      ),
    );
  }
}
