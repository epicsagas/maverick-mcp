# 보안 정책

## 보안 취약점 보고

MaverickMCP 팀은 보안을 심각하게 다룹니다. 귀하의 책임 있는 공개 노력을 감사하며 기여를 인정하기 위해 최선을 다하겠습니다.

## 취약점 보고

**공개 GitHub 이슈를 통한 보안 취약점 보고는 하지 말아주세요.**

대신 GitHub Security Advisories를 통해 보고해주세요 (권장).

다음을 포함해주세요:
- 취약점 유형
- 영향을 받는 소스 파일의 전체 경로
- 영향받는 코드의 위치 (태그/브랜치/커밋 또는 직접 URL)
- 재현에 필요한 특별한 구성
- 재현을 위한 단계별 지시사항
- 개념 증명 또는 익스플로잇 코드 (가능한 경우)
- 공격자가 이를 어떻게 악용할 수 있는지를 포함한 이슈의 영향

48시간 이내에 응답을 받으실 수 있습니다. 어떤 이유로든 응답을 받지 못한 경우, 원래 메시지를 받았는지 확인하기 위해 이메일로 후속 조치해주세요.

## 지원되는 버전

| 버전 | 지원 여부          |
| ------- | ------------------ |
| 0.1.x   | :white_check_mark: |
| < 0.1   | :x:                |

## 보안 기능

MaverickMCP는 개인 사용 소프트웨어에 적합한 보안 조치를 구현합니다:

### 개인 사용 보안 모델
- **로컬 배포**: 개별 사용자를 위해 로컬에서 실행되도록 설계
- **네트워크 인증 없음**: 복잡한 인증 시스템보다 단순함
- **환경 변수 보안**: 모든 API 키를 환경 변수로 저장
- **기본 속도 제한**: 과도한 API 호출에 대한 보호

### 데이터 보호
- **입력 검증**: 모든 입력에 대한 포괄적인 Pydantic 검증
- **SQL 삽입 방지**: 매개변수화된 쿼리를 사용한 SQLAlchemy ORM
- **API 키 보안**: 금융 데이터 제공자 자격 증명의 안전한 처리
- **로컬 데이터 저장**: 모든 분석 데이터는 기본적으로 로컬에 저장

### 인프라 보안
- **환경 변수**: 모든 비밀 외부화, 하드코딩된 자격 증명 없음
- **보안 헤더**: HSTS, CSP, X-Frame-Options, X-Content-Type-Options
- **감사 로깅**: 포괄적인 보안 이벤트 로깅
- **서킷 브레이커**: 연쇄 실패에 대한 보호

## 기여자를 위한 보안 모범 사례

### 구성
- 비밀 또는 API 키를 커밋하지 않기
- 모든 민감한 구성에 환경 변수 사용
- `.env.example` 템플릿 따르기
- 개발 데이터베이스에 강력하고 고유한 비밀번호 사용

### 코드 가이드라인
- 항상 사용자 입력을 검증하고 정제
- 매개변수화된 쿼리 사용 (SQLAlchemy ORM)
- 민감한 정보를 노출하지 않는 적절한 에러 처리 구현
- 최소 권한 원칙 따르기
- 새로운 엔드포인트에 속도 제한 추가

### 의존성
- 의존성을 최신 상태로 유지
- 보안 권고사항을 정기적으로 검토
- 릴리스 전에 `safety check` 실행
- 정적 보안 분석을 위해 `bandit` 사용

## Pull Request를 위한 보안 체크리스트

- [ ] 하드코딩된 비밀 또는 자격 증명 없음
- [ ] 모든 사용자 제공 데이터에 대한 입력 검증
- [ ] 정보 유출 없는 적절한 에러 처리
- [ ] API 키 처리가 환경 변수 패턴 따름
- [ ] 금융 데이터 처리에 적절한 면책 조항 포함
- [ ] 새 기능에 대한 보안 테스트
- [ ] 취약한 의존성 도입 없음
- [ ] 개인 사용 보안 모델 유지 (복잡한 인증 없음)

## 보안 감사 실행

### 의존성 스캔
```bash
# 보안 도구 설치
pip install safety bandit

# 알려진 취약점 확인
safety check

# 정적 보안 분석
bandit -r maverick_mcp/
```

### 추가 보안 도구
```bash
# OWASP 의존성 확인
pip install pip-audit
pip-audit

# 고급 정적 분석
pip install semgrep
semgrep --config=auto maverick_mcp/
```

## 보안 헤더 구성

애플리케이션은 다음 보안 헤더를 구현합니다:
- `Strict-Transport-Security: max-age=31536000; includeSubDomains`
- `X-Content-Type-Options: nosniff`
- `X-Frame-Options: DENY`
- `X-XSS-Protection: 1; mode=block`
- `Referrer-Policy: strict-origin-when-cross-origin`
- `Content-Security-Policy: default-src 'self'`

## 사고 대응

보안 사고가 발생한 경우:

1. **즉시 대응**: 심각성 및 영향 평가
2. **격리**: 영향받은 시스템 격리
3. **조사**: 근본 원인 및 범위 결정
4. **수정**: 취약점 수정
5. **복구**: 정상 작업 복원
6. **사후**: 교훈 문서화

## 보안 연락처

- **기본**: [GitHub Security Advisories](https://github.com/wshobson/maverick-mcp/security) (권장)
- **대안**: [GitHub Issues](https://github.com/wshobson/maverick-mcp/issues) (공개 보안 이슈만)
- **커뮤니티**: [GitHub Discussions](https://github.com/wshobson/maverick-mcp/discussions)

## 감사

책임 있게 보안 문제를 공개한 다음 개인에게 감사드립니다:

*취약점이 보고되고 수정됨에 따라 이 목록이 업데이트됩니다.*

## 금융 데이터 보안

### 투자 데이터 보호
- **개인 투자 정보**: 계정 세부정보, 포지션 또는 개인 금융 데이터를 공유하지 않기
- **API 키**: 금융 데이터 제공자 API 키의 안전한 저장 (Tiingo, FRED 등)
- **시장 데이터**: 데이터 제공자 서비스 약관 및 사용 제한 준수
- **분석 결과**: 금융 분석 출력에 민감한 투자 인사이트가 포함될 수 있음을 인지

### 규정 준수 고려사항
- **금융 규정**: 사용자는 적용 가능한 증권 법률 (SEC, CFTC 등) 준수
- **데이터 개인정보 보호**: 시장 분석 및 포트폴리오 데이터는 기밀로 취급되어야 함
- **감사 추적**: 규정 목적을 위해 금융 분석 활동이 로깅될 수 있음
- **경계 간 데이터**: 국경 간 금융 데이터 사용 시 규정 고려

## 보안 컨텍스트를 위한 금융 면책 조항

**중요**: 이 보안 정책은 소프트웨어의 기술적 보안만 다룹니다. MaverickMCP에서 제공하는 금융 분석 및 투자 도구는 교육 목적으로만 사용되며 금융 조언을 구성하지 않습니다. 투자 결정을 내리기 전에 항상 자격 있는 금융 전문가와 상의하세요.

## 리소스

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [Python 보안 모범 사례](https://python.readthedocs.io/en/latest/library/security_warnings.html)
- [FastAPI 보안](https://fastapi.tiangolo.com/tutorial/security/)
- [SEC 사이버보안 가이드라인](https://www.sec.gov/spotlight/cybersecurity)
- [금융 데이터 보안 모범 사례](https://www.cisa.gov/financial-services)

---

MaverickMCP와 사용자들을 안전하게 지켜주셔서 감사합니다!
