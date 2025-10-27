# MaverickMCP 데이터베이스 설정

이 가이드는 MaverickMCP를 위한 SQLite 데이터베이스를 설정하고 샘플 주식 데이터로 시드하는 방법을 설명합니다.

## 빠른 시작

### 1. 완전한 설정 실행 (권장)

```bash
# 데이터베이스 URL 설정 (선택사항 - 기본값은 SQLite)
export DATABASE_URL=sqlite:///maverick_mcp.db

# 완전한 설정 스크립트 실행
./scripts/setup_database.sh
```

이렇게 하면:

- ✅ 모든 테이블과 함께 SQLite 데이터베이스 생성
- ✅ 40개의 샘플 주식으로 시드 (AAPL, MSFT, GOOGL 등)
- ✅ 1,370+ 가격 기록으로 채우기
- ✅ 샘플 스크리닝 결과 생성 (Maverick, Bear, Supply/Demand)
- ✅ 기술 지표 캐시 추가

### 2. 수동 단계별 설정

```bash
# 1단계: 데이터베이스 테이블 생성
python scripts/migrate_db.py

# 2단계: 샘플 데이터로 시드 (API 키 불필요)
python scripts/seed_db.py

# 3단계: 설정 테스트
python scripts/test_seeded_data.py
```

## 데이터베이스 구성

### 기본 구성 (SQLite)

- **데이터베이스**: `sqlite:///maverick_mcp.db`
- **위치**: 프로젝트 루트 디렉토리
- **설정 불필요**: 바로 작동

### PostgreSQL (선택사항)

```bash
# 환경 변수 설정
export DATABASE_URL=postgresql://localhost/maverick_mcp

# PostgreSQL 데이터베이스 생성
createdb maverick_mcp

# 마이그레이션 실행
python scripts/migrate_db.py
```

## 샘플 데이터 개요

### 포함된 주식 (총 40개)

- **대형주**: AAPL, MSFT, GOOGL, AMZN, TSLA, NVDA, META, BRK-B, JNJ, V
- **성장주**: AMD, CRM, SHOP, ROKU, ZM, DOCU, SNOW, PLTR, RBLX, U
- **가치주**: KO, PFE, XOM, CVX, JPM, BAC, WMT, PG, T, VZ
- **소형주**: UPST, SOFI, OPEN, WISH, CLOV, SPCE, LCID, RIVN, BYND, PTON

### 생성된 데이터

- **1,370+ 가격 기록**: 10개 주식의 200일 역사적 데이터
- **24 Maverick 주식**: 강세 모멘텀 추천
- **16 Bear 주식**: 기술 지표가 있는 약세 설정
- **16 Supply/Demand Breakout**: 누적 브레이크아웃 후보
- **600 기술 지표**: 분석을 위한 RSI, SMA 캐시

## MCP 도구 테스트

시드 후, 스크리닝 도구가 작동하는지 테스트:

```bash
python scripts/test_seeded_data.py
```

예상 출력:

```
✅ Found 5 Maverick recommendations
  1. PTON - Score: 100
  2. BYND - Score: 100
  3. RIVN - Score: 100

✅ Found 5 Bear recommendations
  1. MSFT - Score: 37
  2. JNJ - Score: 32
  3. TSLA - Score: 32

✅ Total screening results across all categories: 56
```

## Claude Desktop과 함께 사용

데이터베이스 설정 후, MCP 서버를 시작:

```bash
# 서버 시작
make dev

# 또는 수동으로
uvicorn maverick_mcp.api.server:app --host 0.0.0.0 --port 8003
```

그런 다음 `mcp-remote`를 사용하여 Claude Desktop에 연결:

```json
{
  "mcpServers": {
    "maverick-mcp": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "http://localhost:8003/mcp"]
    }
  }
}
```

다음과 같은 프롬프트로 테스트:

- "Show me the top maverick stock recommendations"
- "Get technical analysis for AAPL"
- "Find bearish stocks with high RSI"

## 데이터베이스 스키마

### 핵심 테이블

- **mcp_stocks**: 주식 심볼 및 회사 정보
- **mcp_price_cache**: 역사적 OHLCV 가격 데이터
- **mcp_technical_cache**: 계산된 기술 지표

### 스크리닝 테이블

- **mcp_maverick_stocks**: 강세 모멘텀 스크리닝 결과
- **mcp_maverick_bear_stocks**: 약세 설정 스크리닝 결과
- **mcp_supply_demand_breakouts**: 브레이크아웃 패턴 스크리닝 결과

## 문제 해결

### 데이터베이스 연결 문제

```bash
# 데이터베이스 존재 확인
ls -la maverick_mcp.db

# SQLite 연결 테스트
sqlite3 maverick_mcp.db "SELECT COUNT(*) FROM mcp_stocks;"
```

### 스크리닝 결과 없음

```bash
# 데이터가 시드되었는지 확인
sqlite3 maverick_mcp.db "
SELECT
  (SELECT COUNT(*) FROM mcp_stocks) as stocks,
  (SELECT COUNT(*) FROM mcp_price_cache) as prices,
  (SELECT COUNT(*) FROM mcp_maverick_stocks) as maverick;
"
```

### MCP 서버 연결

```bash
# 서버가 실행 중인지 확인
curl http://localhost:8003/health

# MCP 엔드포인트 확인
curl http://localhost:8003/mcp/capabilities
```

## 고급 구성

### 환경 변수

```bash
# 데이터베이스
DATABASE_URL=sqlite:///maverick_mcp.db

# 선택사항: 디버그 로깅 활성화
LOG_LEVEL=debug

# 선택사항: Redis 캐싱
REDIS_HOST=localhost
REDIS_PORT=6379
```

### 커스텀 주식 목록

`scripts/seed_db.py`를 편집하고 선호하는 주식 심볼을 포함하도록 `SAMPLE_STOCKS` 수정.

### 프로덕션 설정

- 더 나은 성능을 위해 PostgreSQL 사용
- Redis 캐싱 활성화
- 적절한 로깅 설정
- 속도 제한 구성

---

✅ **데이터베이스 준비 완료!** MaverickMCP 인스턴스는 이제 샘플 주식 데이터 및 스크리닝 결과가 포함된 완전한 SQLite 데이터베이스를 갖추고 있습니다.
