import 'package:sport/pages/shared/widgets/curve_layout.dart';

import '../../extensions/imports.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CurveLayout(child: Container()),
    );
  }
}
