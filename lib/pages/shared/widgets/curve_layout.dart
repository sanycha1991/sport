import 'package:sport/pages/shared/widgets/curve_widget.dart';

import '../../../extensions/imports.dart';

class CurveLayout extends StatelessWidget {
  final Widget child;
  final bool reversed;
  const CurveLayout({
    Key? key,
    required this.child,
    this.reversed = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CurveWidget(reversed: reversed),
        child,
      ],
    );
  }
}
