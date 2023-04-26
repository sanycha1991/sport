import 'package:flutter/rendering.dart';

import '../../extensions/imports.dart';

// ignore: must_be_immutable
class SportAppBarWithIcons extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final IconData icon1;
  final IconData icon2;
  final Function() onPressed1;
  final Function() onPressed2;

  SportAppBarWithIcons({
    Key? key,
    required this.title,
    required this.icon1,
    required this.icon2,
    required this.onPressed1,
    required this.onPressed2,
  }) : super(key: key);

  late BuildContext _context;

  Widget _iconSuroundedLayout(Widget icon, Function() onTap) => SizedBox(
        width: 37,
        height: 37,
        child: CircleAvatar(
          backgroundColor: _context.theme.lightGray,
          radius: 28,
          child: IconButton(
            focusColor: _context.theme.transparent,
            splashColor: _context.theme.transparent,
            hoverColor: _context.theme.transparent,
            highlightColor: _context.theme.lightGray,
            icon: icon,
            onPressed: onTap,
            color: Colors.black,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    _context = context;
    return AppBar(
      title: Txt(
        title,
        style: context.theme.textMedium.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 26.w,
          color: context.theme.onlyBlack,
        ),
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: context.theme.transparent,
      actions: [
        _iconSuroundedLayout(Icon(icon1), onPressed1),
        const SizedBox(width: 5),
        _iconSuroundedLayout(Icon(icon2), onPressed2),
        const SizedBox(width: 10),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
