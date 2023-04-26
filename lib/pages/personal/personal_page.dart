import 'package:sport/pages/shared/widgets/curve_layout.dart';

import '../../extensions/imports.dart';

class PersonalPage extends StatefulWidget {
  const PersonalPage({Key? key}) : super(key: key);

  @override
  State<PersonalPage> createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
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
