import 'package:flutter/material.dart';
import 'package:sport/extensions/imports.dart';

class BrandTabsWidget extends StatelessWidget {
  final List<String> names = [
    'Nike',
    'Addidas',
    'Jordan',
    'Puma',
    'Kay',
    'Balensiaga',
    'Gucci',
    'Other'
  ];
  BrandTabsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const SizedBox(width: 17),
          ...names.map(
            (e) => _TabItem(names: names, e: e),
          ),
          const SizedBox(width: 17),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({
    Key? key,
    required this.names,
    required this.e,
  }) : super(key: key);

  final List<String> names;
  final String e;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 30),
      child: Stack(
        children: [
          if (names.indexOf(e) == 0)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.grey.withOpacity(0.1),
                      Colors.white,
                    ],
                    stops: const [0.0, 0.5],
                  ),
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: Txt(
              e,
              style: context.theme.textBold.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.w,
                color: names.indexOf(e) == 0
                    ? context.theme.onlyBlack
                    : context.theme.onlyGrey.withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
