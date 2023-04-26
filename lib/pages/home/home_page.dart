import 'package:provider/provider.dart';
import 'package:sport/pages/home/partials/brand_tabs.dart';
import 'package:sport/pages/home/partials/horizontal_product_list.dart';
import 'package:sport/pages/home/partials/products_slider.dart';
import 'package:sport/pages/home/states/home_scroll_provider.dart';
import 'package:sport/pages/shared/custom_app_bar.dart';
import 'package:sport/pages/shared/widgets/curve_layout.dart';

import '../../extensions/imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeScrollProvider homeScrollProvider = HomeScrollProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SportAppBarWithIcons(
        title: 'APP_discover',
        icon1: Icons.search,
        icon2: Icons.notifications_none_sharp,
        onPressed1: () {
          // dd('Search event');
        },
        onPressed2: () {
          // dd('Notifications event');
        },
      ),
      body: CurveLayout(
        child: Material(
          color: context.theme.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.w),
              BrandTabsWidget(),
              ChangeNotifierProvider.value(
                value: homeScrollProvider,
                child: const ProductsSlider(),
              ),
              const Expanded(
                child: ProductsHorizontalWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
