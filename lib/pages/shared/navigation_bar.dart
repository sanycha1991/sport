import '../../extensions/imports.dart';

class NavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onSelect;
  const NavigationBar(
      {Key? key, required this.selectedIndex, required this.onSelect})
      : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  List<BottomNavigationBarItem> get _items => [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'nav_home'.svg,
            color: widget.selectedIndex == 0
                ? context.theme.cNavActiveIconColor
                : context.theme.cNavInActiveIconColor,
            width: 26,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'nav_heart'.svg,
            color: widget.selectedIndex == 1
                ? context.theme.cNavActiveIconColor
                : context.theme.cNavInActiveIconColor,
            width: 22,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'nav_location'.svg,
            color: widget.selectedIndex == 2
                ? context.theme.cNavActiveIconColor
                : context.theme.cNavInActiveIconColor,
            width: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'nav_shop'.svg,
            color: widget.selectedIndex == 3
                ? context.theme.cNavActiveIconColor
                : context.theme.cNavInActiveIconColor,
            width: 24,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            'nav_user'.svg,
            color: widget.selectedIndex == 4
                ? context.theme.cNavActiveIconColor
                : context.theme.cNavInActiveIconColor,
            width: 22,
          ),
          label: '',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (value) {
        widget.onSelect(value);
      },
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: widget.selectedIndex,
      backgroundColor: context.theme.cNavBgColor,
      items: _items,
    );
  }
}
