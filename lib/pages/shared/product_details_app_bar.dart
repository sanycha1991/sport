import 'package:flutter/rendering.dart';
import 'package:sport/services/products/models/product.dart';

import '../../extensions/imports.dart';

class ProductDetailsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Product p;
  const ProductDetailsAppBar({
    Key? key,
    required this.p,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Transform.rotate(
          angle: 3.15,
          child: SvgPicture.asset(
            'arrow_right'.svg,
            color: context.theme.onlyWhite,
          ),
        ),
        onPressed: () {
          context.pop();
          // Add your code for handling the leading icon button press here
        },
      ),
      title: Txt(
        p.brand,
        style: context.theme.textMedium.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 18.w,
          color: context.theme.onlyWhite,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: context.theme.transparent,
      actions: [
        Center(
          child: Container(
            width: 35.w,
            height: 35.w,
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: p.color.withOpacity(0.5),
              borderRadius: BorderRadius.circular(50.w),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                'nav_heart'.svg,
                color: context.theme.onlyWhite,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
