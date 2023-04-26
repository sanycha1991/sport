import 'package:provider/provider.dart';
import 'package:sport/extensions/imports.dart';
import 'package:sport/pages/home/partials/pageview_animation.dart';
import 'package:sport/pages/home/states/home_scroll_provider.dart';

class ProductsSlider extends StatefulWidget {
  const ProductsSlider({Key? key}) : super(key: key);

  @override
  State<ProductsSlider> createState() => _ProductsSliderState();
}

class _ProductsSliderState extends State<ProductsSlider>
    with TickerProviderStateMixin {
  // borderAnimation
  late AnimationController _borderAnimationController;
  late Animation<double> _borderAnimation;

  // width Animation
  late AnimationController _widthAnimationController;
  late Animation<double> _widthAnimation;

  // move Animation
  late AnimationController _moveAnimationController;
  late Animation<double> _moveAnimation;

  @override
  void initState() {
    super.initState();
    initAnimations();
  }

  @override
  void dispose() {
    _borderAnimationController.dispose();
    _widthAnimationController.dispose();
    _moveAnimationController.dispose();
    super.dispose();
  }

  void initAnimations() {
    // border Animation
    _borderAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _borderAnimation = Tween<double>(
      begin: 0,
      end: 4,
    ).animate(_borderAnimationController);

    // with Animation
    _widthAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _widthAnimation = Tween<double>(
      begin: 30.w,
      end: 60.w,
    ).animate(_widthAnimationController);

    // move Animation
    _moveAnimationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _moveAnimation = Tween<double>(
      begin: 233.w,
      end: 80.w,
    ).animate(_moveAnimationController);
  }

  void fingerPrintListener(FingerPrint fingerPrint) async {
    if (fingerPrint == FingerPrint.forward) {
      _borderAnimationController.forward();
      await Future.delayed(const Duration(milliseconds: 200));
      _widthAnimationController.forward();
      _moveAnimationController.forward();
      await Future.delayed(const Duration(milliseconds: 350));

      _widthAnimationController.reset();
      _widthAnimation = Tween<double>(
        begin: 60.w,
        end: 30.w,
      ).animate(_widthAnimationController);
      _widthAnimationController.forward();

      _borderAnimationController.reset();
      _borderAnimation = Tween<double>(
        begin: 4,
        end: 0,
      ).animate(_borderAnimationController);
      _borderAnimationController.forward();

      // --------------- reset animations

      _widthAnimationController.reset();
      _widthAnimation = Tween<double>(
        begin: 30.w,
        end: 60.w,
      ).animate(_widthAnimationController);

      // reset
      _moveAnimationController.reset();
      _widthAnimationController.reset();
      _borderAnimationController.reset();
      _borderAnimation = Tween<double>(
        begin: 0,
        end: 4,
      ).animate(_borderAnimationController);
    }
    if (fingerPrint == FingerPrint.backward) {
      // _borderAnimationController.animateBack(0);
      // _widthAnimationController.animateBack(30);
    }
    // if (fingerPrint == FingerPrint.none) {}
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.withOf(100),
      child: Stack(
        children: [
          _Switcher(),
          const _List(),
          Consumer<HomeScrollProvider>(builder: (_, provider, child) {
            fingerPrintListener(provider.fingerPrint);
            return AnimatedBuilder(
                animation: _moveAnimation,
                builder: (context, child) {
                  return Positioned(
                    bottom: 50.w,
                    left: _moveAnimation.value,
                    child: AnimatedBuilder(
                        animation: _borderAnimation,
                        builder: (context, child) {
                          return AnimatedBuilder(
                              animation: _widthAnimation,
                              builder: (context, child) {
                                return Container(
                                  width: _widthAnimation.value,
                                  height: 30.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: _borderAnimation.value == 0
                                          ? context.theme.transparent
                                          : context.theme.onlyGrey,
                                      width: _borderAnimation.value,
                                    ),
                                  ),
                                );
                              });
                        }),
                  );
                });
          }),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class _Switcher extends StatelessWidget {
  _Switcher({Key? key}) : super(key: key);
  late BuildContext _context;
  Widget _item({required String title, bool active = false}) =>
      Transform.rotate(
        angle: 270 * 0.0174533,
        child: Txt(
          title,
          style: _context.theme.textMedium.copyWith(
            color: active ? _context.theme.onlyBlack : _context.theme.onlyGrey,
            fontSize: 13.w,
          ),
        ),
      );
  @override
  Widget build(BuildContext context) {
    _context = context;
    return SizedBox(
      width: context.withOf(17),
      child: Column(
        children: [
          SizedBox(height: 70.w),
          _item(title: 'APP_upcoming', active: false),
          SizedBox(height: 100.w),
          _item(title: 'APP_featured', active: true),
          SizedBox(height: 100.w),
          _item(title: 'APP_new', active: false),
          SizedBox(height: 50.w),
        ],
      ),
    );
  }
}

class _List extends StatefulWidget {
  const _List({Key? key}) : super(key: key);

  @override
  State<_List> createState() => _ListState();
}

class _ListState extends State<_List> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.withOf(100),
      // height: context.heightOf(35),
      child: Column(
        children: [
          SizedBox(height: 30.w),
          const PageViewAnimation(),
        ],
      ),
    );
  }
}
