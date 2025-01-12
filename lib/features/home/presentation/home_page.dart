import 'package:atwoz_app/app/widget/button/default_elevated_button.dart';
import 'package:atwoz_app/app/widget/button/default_text_button.dart';
import 'package:atwoz_app/app/widget/attachment/custom_file_picker.dart';
import 'package:atwoz_app/app/widget/image/default_image.dart';
import 'package:atwoz_app/app/widget/image/rounded_image.dart';
import 'package:atwoz_app/app/widget/view/default_bottom_navigation_bar.dart';
import 'package:atwoz_app/app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: DefaultScrollbar(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('홈페이지'),
              AppFileAttachmentInput(
                onFilesPicked: (List<File> pickedFiles) {
                  // 선택된 파일을 처리하는 로직을 여기에 작성
                  for (var file in pickedFiles) {
                    debugPrint('Picked file: ${file.path}');
                  }
                },
              ),
              const SizedBox(height: 20),
              const AppRoundedImage(
                imageURL: 'https://via.placeholder.com/150',
                size: 200.0,
              ),
              const SizedBox(height: 20),
              const AppImage(
                imageURL: 'https://via.placeholder.com/300x200',
                width: 300,
                height: 200,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Row의 자식 정렬
                children: [
                  Flexible(
                    child: AppTextButton(
                      child: const Text('버튼1'),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 10), // 버튼 간 간격 추가
                  Flexible(
                    child: AppElevatedButton(
                      child: const Text('버튼2'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: DefaultBottomNavigationBar(currentIndex: 0),
    );
  }
}
