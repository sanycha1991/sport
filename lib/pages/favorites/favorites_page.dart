import 'package:sport/pages/shared/widgets/curve_layout.dart';

import '../../extensions/imports.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurveLayout(
        child: Container(),
        reversed: true,
      ),
    );
  }
}
