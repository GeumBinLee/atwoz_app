import 'package:atwoz_app/core/theme/theme.dart';
import 'package:flutter/material.dart';

class AgeSettingArea extends StatefulWidget {
  const AgeSettingArea({
    super.key,
  });

  @override
  State<AgeSettingArea> createState() => _AgeSettingAreaState();
}

class _AgeSettingAreaState extends State<AgeSettingArea> {
  double _startAge = 25;
  double _endAge = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "나이",
                style: AppStyles.body02Regular()
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                "${_startAge.toString().split(".")[0]}세~${_endAge.toString().split(".")[0]}세",
                style: AppStyles.body02Regular().copyWith(
                    fontWeight: FontWeight.w500, color: Color(0xff3B3B3B)),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: RangeSlider(
                values: RangeValues(_startAge, _endAge),
                min: 20,
                max: 46,
                onChanged: (RangeValues values) {
                  setState(() {
                    _startAge = values.start;
                    _endAge = values.end;
                  });
                },
                activeColor: AppColors.colorPrimary500,
                inactiveColor: Color(0xffEEEEEE),
              ),
            ),
          ],
        )
      ],
    );
  }
}
