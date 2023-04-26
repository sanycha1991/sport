import '../../../extensions/imports.dart';

class CurveWidget extends StatelessWidget {
  final bool reversed;
  const CurveWidget({
    Key? key,
    this.reversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Center(
        child: CustomPaint(
          size: const Size(400, 400),
          painter: !reversed ? CurvedPainter() : CurvedPainterReversed(),
        ),
      ),
    );
  }
}
