import 'package:atwoz_app/core/theme/app_colors.dart';
import 'package:atwoz_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

enum BubblePosition { top, bottom }

Widget bubbleWidget({
  required String comment, // 말풍선 텍스트
  String? boldText, // bold 처리할 텍스트
  Color bubbleColor = AppColors.colorWhite, // 말풍선 배경색
  Color textColor = AppColors.colorBlack, // 텍스트 색깔
  double width = 200, // 말풍선 너비
  double height = 60, // 말풍선 높이
  double shadowBlur = 5, // 그림자 흐림 정도
  double shadowOffset = 5, // 그림자 아래 이동 정도
  Color shadowColor = AppColors.colorGrey100, // 그림자 색깔
  TextStyle? textStyle, // 텍스트 스타일
  BubblePosition trianglePosition = BubblePosition.bottom, // 삼각형 위치
  bool isShadow = true, // 기본값 true, shadow 여부
}) {
  // 텍스트 스타일 기본값
  final TextStyle defaultStyle = textStyle ?? AppStyles.body03Regular();
  final TextStyle boldStyle =
      defaultStyle.copyWith(fontWeight: FontWeight.bold);

  // 텍스트 위젯 생성
  Widget textWidget;
  if (boldText != null && comment.contains(boldText)) {
    final parts = comment.split(boldText);
    textWidget = RichText(
      text: TextSpan(
        text: parts[0],
        style: defaultStyle,
        children: [
          TextSpan(text: boldText, style: boldStyle),
          if (parts.length > 1) TextSpan(text: parts[1], style: defaultStyle),
        ],
      ),
    );
  } else {
    textWidget = Text(comment, style: defaultStyle);
  }

  return Stack(
    clipBehavior: Clip.none,
    children: [
      if (isShadow)
        CustomPaint(
          size: Size(width, height + 20), // 그림자의 크기
          painter: ShadowPainter(
            width: width,
            height: height,
            shadowBlur: shadowBlur,
            shadowOffset: shadowOffset,
            shadowColor: shadowColor,
            borderRadius: 50,
            trianglePosition: trianglePosition,
          ),
        ),
      ClipPath(
        clipper: BubbleClipper(
          borderRadius: 50,
          trianglePosition: trianglePosition,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: bubbleColor,
          ),
          padding: EdgeInsets.only(
            top: trianglePosition == BubblePosition.top ? 7 : 0,
            left: 15,
            right: 15,
            bottom: trianglePosition == BubblePosition.bottom ? 7 : 0,
          ),
          width: width,
          height: height,
          child: Center(child: textWidget),
        ),
      ),
    ],
  );
}

class ShadowPainter extends CustomPainter {
  final double width;
  final double height;
  final double shadowBlur;
  final double shadowOffset;
  final Color shadowColor;
  final double borderRadius;
  final BubblePosition trianglePosition;

  ShadowPainter({
    required this.width,
    required this.height,
    required this.shadowBlur,
    required this.shadowOffset,
    required this.shadowColor,
    required this.borderRadius,
    required this.trianglePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = shadowColor
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlur);

    final Path bubblePath = BubbleClipper(
      borderRadius: borderRadius,
      trianglePosition: trianglePosition,
    ).getBubblePath(Size(width, height));

    canvas.drawPath(bubblePath.shift(Offset(0, shadowOffset)), shadowPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class BubbleClipper extends CustomClipper<Path> {
  final double borderRadius;
  final BubblePosition trianglePosition;

  BubbleClipper({
    this.borderRadius = 10,
    this.trianglePosition = BubblePosition.bottom,
  });

  @override
  Path getClip(Size size) => getBubblePath(size);

  Path getBubblePath(Size size) {
    final Path path = Path();
    final double tailHeight = 10;
    final double tailWidth = 15;

    switch (trianglePosition) {
      case BubblePosition.bottom:
        path.addRRect(RRect.fromLTRBAndCorners(
          0,
          0,
          size.width,
          size.height - tailHeight,
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ));
        final double tailCenterX = size.width / 2;
        path.moveTo(tailCenterX - tailWidth / 2, size.height - tailHeight);
        path.lineTo(tailCenterX + tailWidth / 2, size.height - tailHeight);
        path.lineTo(tailCenterX, size.height);
        break;

      case BubblePosition.top:
        path.addRRect(RRect.fromLTRBAndCorners(
          0,
          tailHeight,
          size.width,
          size.height,
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ));
        final double tailCenterX = size.width / 2;
        path.moveTo(tailCenterX - tailWidth / 2, tailHeight);
        path.lineTo(tailCenterX + tailWidth / 2, tailHeight);
        path.lineTo(tailCenterX, 0);
        break;
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
