# Flutter 관련 기본 설정
FLUTTER ?= flutter
DART ?= dart

# 기본 타겟
all: help

# 헬프 메시지
help:
	@echo "사용 가능한 명령:"
	@echo ""
	@echo "=== 프로젝트 관리 ==="
	@echo "  make clean         - 프로젝트 정리"
	@echo "  make get           - 패키지 설치"
	@echo "  make init          - 프로젝트 초기화 (처음 클론 후 실행 필수)"
	@echo ""
	@echo "=== 빌드 ==="
	@echo "  make build         - 기본 APK 빌드"
	@echo "  make android-dev-build  - 개발용 APK 빌드 (dev 환경)"
	@echo "  make android-prod-build - 배포용 APK 빌드 (prod 환경)"
	@echo "  make ios-dev-build      - 개발용 IPA 빌드 (macOS 환경에서 실행 가능)"
	@echo "  make ios-prod-build     - 배포용 IPA 빌드 (macOS 환경에서 실행 가능)"
	@echo ""
	@echo "=== 실행 ==="
	@echo "  make run           - 기본 앱 실행 (환경 변수를 설정하여 실행 가능)"
	@echo ""
	@echo "=== 테스트 및 품질 관리 ==="
	@echo "  make test          - 테스트 실행"
	@echo "  make lint          - 코드 린트 실행"
	@echo "  make format        - 코드 포맷팅"
	@echo ""
	@echo "=== Firebase 설정 ==="
	@echo "  make download-firebase  - Firebase 설정 파일 다운로드 (URL 수정 필요)"
	@echo ""
	@echo "=== 도움말 ==="
	@echo "  make help          - 사용 가능한 명령어 목록 표시"
	@echo ""
	@echo "명령어 뒤에 추가적인 변수 설정으로 빌드와 실행을 세분화할 수 있습니다."
	@echo "예시:"
	@echo "  make run FLAVOR=dev ENV_FILE=dev.env  # 환경 파일 지정 필요"
	@echo "  make android-dev-build"
	@echo "  make ios-prod-build"


# Flutter 명령어
clean:
	$(FLUTTER) clean

get:
	$(FLUTTER) pub get

build:
	$(FLUTTER) build apk --release

# run:
# 	$(FLUTTER) run

test:
	$(FLUTTER) test

lint:
	$(FLUTTER) analyze

format:
	$(FLUTTER) format .

# init 명령: 처음 프로젝트를 클론받았을 때 실행
init:
	$(FLUTTER) pub get
	$(DART) run flutter_native_splash:create
	$(FLUTTER) pub run flutter_launcher_icons:main
	$(DART) run build_runner build --delete-conflicting-outputs

# --dart-define-from-file: 플러터 버전에 따라 사용이 불가할 수 있음
# 명령어 예시: make run FLAVOR=dev ENV_FILE=dev.env
# 명령어 예시: make run FLAVOR=prod ENV_FILE=prod.env
run:
	$(FLUTTER) pub get
	$(DART) run build_runner build --delete-conflicting-outputs
	$(FLUTTER) run --flavor=$(FLAVOR) --dart-define-from-file=$(ENV_FILE)

android-dev-build:
	$(FLUTTER) build apk --release --flavor=dev --dart-define-from-file="dev.env"

android-prod-build:
	$(FLUTTER) build apk --release --flavor=prod --dart-define-from-file="prod.env"

ios-dev-build:
	@if [[ "$$OSTYPE" == "darwin"* ]]; then \
		$(FLUTTER) build ipa --release --flavor=dev --dart-define-from-file="dev.env"; \
	else \
		echo "iOS 빌드는 macOS 환경에서만 실행 가능합니다."; \
	fi

ios-prod-build:
	@if [[ "$$OSTYPE" == "darwin"* ]]; then \
		$(FLUTTER) build ipa --release --flavor=prod --dart-define-from-file="prod.env"; \
	else \
		echo "iOS 빌드는 macOS 환경에서만 실행 가능합니다."; \
	fi

# 실제 Firebase 파일 경로로 교체 필요
download-firebase:
	curl -o android/app/google-services.json https://example.com/firebase-dev.json
	curl -o ios/Runner/GoogleService-Info.plist https://example.com/firebase-dev.plist
