import 'package:sport/extensions/imports.dart';

class MyButton extends StatefulWidget {
  final String title;
  final Function onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const MyButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.margin,
    this.padding,
  }) : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton>
    with SingleTickerProviderStateMixin {
  // scale
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;

  double _opacity = 1;

  @override
  void initState() {
    // scale animation init
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(begin: 1, end: 0.9).animate(_scaleController);

    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: InkWell(
              onTap: () {
                _scaleController.forward();
                _opacity = 0.5;

                Future.delayed(const Duration(milliseconds: 300)).then((value) {
                  _scaleController.reverse();
                  _opacity = 1;
                  widget.onTap();
                });
              },
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _opacity,
                child: Container(
                  margin:
                      widget.margin ?? EdgeInsets.symmetric(horizontal: 20.w),
                  padding:
                      widget.padding ?? EdgeInsets.symmetric(vertical: 13.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.w),
                    color: context.theme.btnColor,
                  ),
                  child: Center(
                    child: Txt(
                      widget.title,
                      style: context.theme.textMedium.copyWith(
                        fontSize: 12.w,
                        color: context.theme.onlyWhite,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
