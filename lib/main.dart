import 'dart:async';
import 'package:atwoz_app/core/provider/default_provider_observer.dart';
import 'package:atwoz_app/core/util/log.dart';

import 'package:atwoz_app/features/auth/data/user_response.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'app/app.dart';

void main() {
  runZonedGuarded(() async {
    /// Splash 화면
    App.preserveSplash(
        widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

    /// 기기 방향 세로로 고정
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// Hive - 로컬 데이터 베이스
    await Hive.initFlutter();
    Hive.registerAdapter<User>(UserAdapter());

    /// 앱 실행
    runApp(
      ProviderScope(
        observers: [DefaultProviderObserver()],
        child: App(),
      ),
    );
  }, (error, stack) => Log.e('MAIN', errorObject: error, stackTrace: stack));
}
