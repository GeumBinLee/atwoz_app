import 'package:atwoz_app/core/theme/app_colors.dart';
import 'package:atwoz_app/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';

class HomeCategoryButtonsArea extends StatelessWidget {
  const HomeCategoryButtonsArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> buttonLabels = [
      "상위 5%",
      "새로 가입했어요",
      "지금 근처인 사람!",
      "종교가 같아요",
      "취미가 같아요",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "이런 분들은 어떠세요? 🧐",
          style: AppStyles.header03().copyWith(fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 16),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 45.5, vertical: 24),
            decoration: BoxDecoration(
                color: AppColors.colorGrey50,
                borderRadius: BorderRadius.circular(16)),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: buttonLabels.map((label) {
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.colorBlack,
                            padding: EdgeInsets.all(10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))
                        .copyWith(
                      backgroundColor:
                          WidgetStateProperty.all(AppColors.colorBlack),
                    ),
                    onPressed: null,
                    child: Text(
                      label,
                      style: AppStyles.body02Regular().copyWith(
                          fontWeight: FontWeight.w400, color: Colors.white),
                    ));
              }).toList(),
            )),
      ],
    );
  }
}
