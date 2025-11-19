# AirPets

반려동물과 함께하는 외출을 위해 **날씨·공기질·장소 정보를 한 번에 확인**할 수 있는 웹 서비스입니다.

---

## 📌 소개

AirPets는 반려동물 보호자를 위한 위치 기반 서비스로, 다음과 같은 정보를 제공합니다.

- 현재/예측 **날씨 및 공기질** 정보 확인
- 반려동물 동반이 가능한 **장소 검색 및 상세 정보 조회**
- 이용자들의 **리뷰/후기 공유**
- 기본적인 **회원 가입, 로그인, 마이페이지, 공지사항** 기능

---

## 🧱 기술 스택

- **Language**: Java
- **Framework**: Spring MVC, Spring Security
- **View**: JSP, JSTL
- **Persistence**: MyBatis
- **Build Tool**: Maven (`pom.xml`)
- **Logging**: Log4j
- **Server**: Apache Tomcat (로컬 개발용)

---

## 📂 주요 패키지 구조

- `src/main/java/com/future/my`
  - `HomeController` : 기본 홈 화면 컨트롤러
  - `air` : 날씨/공기질 관련 서비스 및 컨트롤러
  - `member` : 회원, 공지사항 도메인(DAO, Service, Controller, VO)
  - `place` : 장소 검색/조회 도메인
  - `review` : 리뷰 도메인
- `src/main/resources`
  - `config/app.properties` : 환경 설정
  - `mybatis` : MyBatis 설정 및 매퍼 XML
  - `log4j.xml` : 로깅 설정
- `src/main/webapp`
  - `WEB-INF/views` : JSP 뷰 (air, member, notice, place, review, home 등)
  - `resources` : 정적 리소스 (CSS, JS, 이미지 등)

> `target/` 폴더는 빌드 결과물로, 추후 `.gitignore` 정리 시 제외하는 것을 권장합니다.

---

## ✨ 주요 기능

- **회원 기능**
  - 회원가입 / 로그인 / 로그아웃
  - 마이페이지(회원 정보 조회)
- **공지사항**
  - 공지사항 목록 / 상세 / 작성
- **날씨/공기질**
  - 외부 API(예: 공공데이터 포털, 기상 정보 등)를 통해 날씨/공기질 조회 (구체 API는 소스 참고)
- **장소 검색**
  - 반려동물 동반 가능 장소 목록 조회
  - 장소 상세 정보 확인
- **리뷰**
  - 장소에 대한 리뷰 작성, 조회

---

## 🚀 로컬 실행 방법

### 1. 사전 준비

- JDK 8 이상 설치
- Maven 설치 (또는 IDE 내장 Maven 사용)
- Tomcat 8 이상 설치 (또는 Spring 지원 내장 서버/IDE 톰캣 설정)

### 2. 프로젝트 빌드

루트 디렉터리(본 README가 있는 위치)에서 아래 명령 실행:

```bash
mvn clean package
```

- `target/` 폴더에 `.war` 파일이 생성됩니다.

### 3. Tomcat 배포

1. 생성된 `*.war` 파일을 Tomcat `webapps` 폴더에 복사
2. Tomcat 실행 후 브라우저에서 접속

```text
http://localhost:8080/AirPets
```

> 실제 컨텍스트 경로는 Tomcat 설정 및 war 파일명에 따라 달라질 수 있습니다.

---

## ⚙️ 환경 설정

- `src/main/resources/config/app.properties` 에 API key, DB 연결 정보 등이 정의될 수 있습니다.
- 민감 정보(API Key, DB 비밀번호 등)는 **소스에 직접 커밋하지 않고** 별도 설정 파일이나 환경 변수로 관리하는 것을 권장합니다.

---

## 📌 기타

- 이 README는 초기 버전이며, 추후에
  - 실제 사용 중인 외부 API 목록
  - DB 스키마 (테이블 구조)
  - 주요 화면 캡처
  등을 추가해 문서를 보완해 나갈 수 있습니다.