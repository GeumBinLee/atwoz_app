import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'interview_state.dart';

part 'interview_notifier.g.dart';

@riverpod
class InterviewNotifier extends _$InterviewNotifier {
  @override
  InterviewState build() {
    return InterviewState.initial(); // 초기 상태 반환
  }

  // 특정 질문에 답변을 저장하는 메서드
  void saveAnswer(String question, String answer) {
    state = state.copyWith(
      answers: Map.from(state.answers)..[question] = answer,
    );
  }

  // 특정 질문에 대한 답변을 가져오는 메서드
  String? getAnswer(String question) {
    return state.answers[question];
  }
}
