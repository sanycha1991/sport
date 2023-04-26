import 'package:sport/extensions/imports.dart';
import 'package:sport/extensions/localization.dart';

class Txt extends StatelessWidget {
  final String data;
  final bool translate;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final double? height;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  const Txt(
    this.data, {
    this.translate = true,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.height,
    this.overflow = TextOverflow.ellipsis,
    this.textScaleFactor,
    this.maxLines = 1,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String str = data;
    if (translate) {
      str = AppLocalizations.of(context)!.translate(str);
    }
    return Text(
      style?.fontFamily == context.theme.kJosefinSansBold
          ? str.toUpperCase()
          : str,
      key: key,
      style: style?.copyWith(
        fontSize: style!.fontSize!.sp,
        height: height ?? style!.height ?? 1,
      ),
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textWidthBasis: textWidthBasis,
      textHeightBehavior: textHeightBehavior,
    );
  }
}
