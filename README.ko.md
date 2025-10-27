# MaverickMCP - 개인 주식 분석 MCP 서버

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Python 3.12+](https://img.shields.io/badge/python-3.12+-blue.svg)](https://www.python.org/downloads/)
[![FastMCP](https://img.shields.io/badge/FastMCP-2.0-green.svg)](https://github.com/jlowin/fastmcp)
[![GitHub Stars](https://img.shields.io/github/stars/wshobson/maverick-mcp?style=social)](https://github.com/wshobson/maverick-mcp)
[![GitHub Issues](https://img.shields.io/github/issues/wshobson/maverick-mcp)](https://github.com/wshobson/maverick-mcp/issues)
[![GitHub Forks](https://img.shields.io/github/forks/wshobson/maverick-mcp?style=social)](https://github.com/wshobson/maverick-mcp/network/members)

**MaverickMCP**는 개인 사용을 위한 FastMCP 2.0 서버로, Claude Desktop 인터페이스에 전문 수준의 금융 데이터 분석, 기술 지표 및 포트폴리오 최적화 도구를 제공합니다. 개별 트레이더와 투자자를 위해 설계되었으며, 인증이나 빌링의 복잡성 없이 포괄적인 주식 분석 기능을 제공합니다.

서버는 S&P 500의 모든 520개 주식으로 사전 시드되어 있으며, 여러 전략에 걸친 고급 스크리닝 추천을 제공합니다. Claude Desktop 및 기타 MCP 클라이언트와의 원활한 통합을 위한 HTTP/SSE/STDIO 전송 옵션으로 로컬에서 실행됩니다.

## 왜 MaverickMCP를 사용해야 할까요?

MaverickMCP는 Claude Desktop 인터페이스 내에서 직접 전문 수준의 금융 분석 도구를 제공합니다. 비싼 플랫폼이나 상업 서비스의 복잡성 없이 포괄적인 주식 분석 기능을 원하는 개별 트레이더와 투자자에게 완벽합니다.

**주요 이점:**

- **설정의 복잡성 없음**: 간단한 `make dev` 명령으로 시작 (또는 `uv sync` + `make dev`)
- **현대적인 Python 도구**: 번개처럼 빠른 의존성 관리를 위한 `uv`로 구축
- **Claude Desktop 통합**: 원활한 AI 기반 분석을 위한 네이티브 MCP 지원
- **포괄적인 분석**: 기술 지표, 스크리닝 및 포트폴리오 최적화를 포함한 29개 이상의 금융 도구
- **스마트 캐싱**: 우아한 폴백과 함께 Redis 기반 성능
- **빠른 개발**: 핫 리로드, 스마트 에러 처리 및 병렬 처리
- **오픈소스**: MIT 라이선스, 커뮤니티 주도 개발
- **교육 중심**: 금융 분석 및 MCP 개발 학습에 완벽

## 기능

- **사전 시드 데이터베이스**: 포괄적인 스크리닝 추천을 포함한 S&P 500의 520개 주식
- **고급 백테스팅**: 15개 이상의 내장 전략 및 ML 알고리즘을 갖춘 VectorBT 기반 엔진
- **빠른 개발**: 포괄적인 Makefile, 스마트 에러 처리, 핫 리로드 및 병렬 처리
- **주식 데이터 액세스**: 지능형 캐싱을 포함한 역사적 및 실시간 주식 데이터
- **기술 분석**: SMA, EMA, RSI, MACD, 볼린저 밴드 등 20개 이상의 지표
- **주식 스크리닝**: 병렬 처리를 포함한 여러 전략 (Maverick 강세/약세, 트렌딩 브레이크아웃)
- **포트폴리오 도구**: 상관관계 분석, 수익률 계산 및 최적화
- **시장 데이터**: 섹터 성능, 시장 움직임 및 실적 정보
- **스마트 캐싱**: 인메모리 저장소로 자동 폴백하는 Redis 기반 성능
- **데이터베이스 지원**: PostgreSQL/SQLite (기본값 SQLite)와 SQLAlchemy 통합
- **다중 전송 지원**: 모든 MCP 클라이언트를 위한 HTTP, SSE 및 STDIO 전송

## 빠른 시작

### 사전 요구사항

- **Python 3.12+**: 핵심 런타임 환경
- **[uv](https://docs.astral.sh/uv/)**: 현대적인 Python 패키지 관리자 (권장)
- **TA-Lib**: 고급 지표를 위한 기술 분석 라이브러리
- Redis (선택사항, 향상된 캐싱용)
- PostgreSQL 또는 SQLite (선택사항, 데이터 영속성용)

#### TA-Lib 설치

TA-Lib는 기술 분석 계산에 필요합니다.

**macOS 및 Linux (Homebrew):**
```bash
brew install ta-lib
```

**Windows (여러 옵션):**

**옵션 1: Conda/Anaconda (권장 - 가장 쉬움)**
```bash
conda install -c conda-forge ta-lib
```

**옵션 2: 사전 컴파일된 Wheels**
1. 다음에서 Python 버전에 맞는 적절한 wheel 다운로드:
   - [cgohlke/talib-build releases](https://github.com/cgohlke/talib-build/releases)
   - Python 버전과 일치하는 파일 선택 (예: Python 3.12 64비트용 `TA_Lib-0.4.28-cp312-cp312-win_amd64.whl`)
2. pip를 사용하여 설치:
```bash
pip install path/to/downloaded/TA_Lib-X.X.X-cpXXX-cpXXX-win_amd64.whl
```

**옵션 3: 대안 사전 컴파일된 패키지**
```bash
pip install TA-Lib-Precompiled
```

**옵션 4: 소스에서 빌드 (고급)**
다른 방법이 실패하면 소스에서 빌드할 수 있습니다:
1. Microsoft C++ Build Tools 설치
2. ta-lib C 라이브러리를 `C:\ta-lib`에 다운로드 및 추출
3. Visual Studio 도구를 사용하여 빌드
4. `pip install ta-lib` 실행

**검증:**
설치를 테스트:
```bash
python -c "import talib; print(talib.__version__)"
```

#### uv 설치 (권장)

```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Windows
powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"

# 대안: pip를 통해
pip install uv
```

### 설치

#### 옵션 1: uv 사용 (권장 - 가장 빠름)

```bash
# 저장소 클론
git clone https://github.com/wshobson/maverick-mcp.git
cd maverick-mcp

# 한 번의 명령으로 의존성 설치 및 가상 환경 생성
uv sync

# 환경 템플릿 복사
cp .env.example .env
# Tiingo API 키 추가 (tiingo.com에서 무료)
```

#### 옵션 2: pip 사용 (전통적인 방법)

```bash
# 저장소 클론
git clone https://github.com/wshobson/maverick-mcp.git
cd maverick-mcp

# 가상 환경 생성 및 설치
python -m venv .venv
source .venv/bin/activate  # Windows: .venv\Scripts\activate
pip install -e .

# 환경 템플릿 복사
cp .env.example .env
# Tiingo API 키 추가 (tiingo.com에서 무료)
```

### 서버 시작

```bash
# 모든 것을 시작하는 하나의 명령 (첫 실행 시 S&P 500 데이터 시드 포함)
make dev

# 서버는 다음으로 실행 중:
# - HTTP 엔드포인트: http://localhost:8003/mcp/
# - SSE 엔드포인트: http://localhost:8003/sse/
# - 520개 S&P 500 주식이 스크리닝 데이터와 함께 사전 로드됨
```

### Claude Desktop에 연결

**권장: SSE 연결 (안정적이고 신뢰할 수 있음)**

이 구성은 안정적인 도구 등록을 제공하며 도구가 사라지는 것을 방지합니다:

```json
{
  "mcpServers": {
    "maverick-mcp": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "http://localhost:8003/sse/"]
    }
  }
}
```

> **중요**: `/sse/`의 끝에 슬래시를 사용하세요 - 이것은 리다이렉트 문제를 방지하기 위해 필수입니다!

**설정 파일 위치:**
- macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
- Windows: `%APPDATA%\Claude\claude_desktop_config.json`

**이 구성이 가장 잘 작동하는 이유:**
- 안정적인 도구 등록 - 도구가 초기 연결 후 사라지지 않음
- SSE 전송을 통한 신뢰할 수 있는 연결 관리
- 장기 실행 분석 작업을 위한 적절한 세션 지속성
- 일관되게 29개 이상의 금융 도구 사용 가능

**대안: 직접 STDIO 연결 (개발 전용)**

```json
{
  "mcpServers": {
    "maverick-mcp": {
      "command": "uv",
      "args": [
        "run",
        "python",
        "-m",
        "maverick_mcp.api.server",
        "--transport",
        "stdio"
      ],
      "cwd": "/path/to/maverick-mcp"
    }
  }
}
```

> **중요**: 설정 변경 후 항상 **Claude Desktop을 재시작**하세요. mcp-remote를 통한 SSE 구성은 연결 끊김 없이 안정적이고 지속적인 도구 액세스를 제공하는 것으로 테스트되고 확인되었습니다.

완료! MaverickMCP 도구가 이제 Claude Desktop 인터페이스에서 사용 가능합니다.

#### Claude Desktop (가장 인기 있음) - 권장 구성

**설정 위치**:

- macOS: `~/Library/Application Support/Claude/claude_desktop_config.json`
- Windows: `%APPDATA%\Claude\claude_desktop_config.json`

#### Cursor IDE - STDIO 및 SSE

**옵션 1: STDIO (mcp-remote를 통해)**:

```json
{
  "mcpServers": {
    "maverick-mcp": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "http://localhost:8003/sse/"]
    }
  }
}
```

**옵션 2: 직접 SSE**:

```json
{
  "mcpServers": {
    "maverick-mcp": {
      "url": "http://localhost:8003/sse/"
    }
  }
}
```

**설정 위치**: Cursor → Settings → MCP Servers

#### Claude Code CLI - 모든 전송 방식

**HTTP 전송 (권장)**:

```bash
claude mcp add --transport http maverick-mcp http://localhost:8003/mcp/
```

**SSE 전송 (대안)**:

```bash
claude mcp add --transport sse maverick-mcp http://localhost:8003/sse/
```

**STDIO 전송 (개발)**:

```bash
claude mcp add maverick-mcp uv run python -m maverick_mcp.api.server --transport stdio
```

#### Windsurf IDE - STDIO 및 SSE

**옵션 1: STDIO (mcp-remote를 통해)**:

```json
{
  "mcpServers": {
    "maverick-mcp": {
      "command": "npx",
      "args": ["-y", "mcp-remote", "http://localhost:8003/mcp/"]
    }
  }
}
```

**옵션 2: 직접 SSE**:

```json
{
  "mcpServers": {
    "maverick-mcp": {
      "serverUrl": "http://localhost:8003/sse/"
    }
  }
}
```

**설정 위치**: Windsurf → Settings → Advanced Settings → MCP Servers

#### mcp-remote가 필요한 이유

`mcp-remote` 도구는 STDIO 전용 클라이언트(Claude Desktop과 같은)와 HTTP/SSE 서버 간의 격차를 메웁니다. 이것 없이는 이러한 클라이언트가 원격 MCP 서버에 연결할 수 없습니다:

- **mcp-remote 없이**: 클라이언트가 STDIO 시도 → 서버가 HTTP 기대 → 연결 실패
- **mcp-remote와 함께**: 클라이언트가 STDIO 사용 → mcp-remote가 HTTP로 변환 → 서버가 HTTP 수신 → 성공

## 사용 가능한 도구

MaverickMCP는 고급 AI 기반 연구 에이전트를 포함하여 포커스된 카테고리로 구성된 35개 이상의 금융 분석 도구를 제공합니다:

### 개발 명령어

```bash
# 서버 시작 (하나의 명령!)
make dev

# 대안 시작 방법
./scripts/start-backend.sh --dev    # 스크립트 기반 시작
./tools/fast_dev.sh                 # 초고속 시작 (< 3초)
uv run python tools/hot_reload.py   # 파일 변경 시 자동 재시작

# 서버는 다음에서 사용 가능:
# - HTTP 엔드포인트: http://localhost:8003/mcp/ (streamable-http - mcp-remote와 함께 사용)
# - SSE 엔드포인트: http://localhost:8003/sse/ (SSE - 직접 연결만, mcp-remote 아님)
# - 헬스 체크: http://localhost:8003/health
```

### 테스트

```bash
# 빠른 테스트 명령어
make test              # 유닛 테스트 실행 (5-10초)
make test-specific TEST=test_name  # 특정 테스트 실행
make test-watch        # 파일 변경 시 자동 테스트 실행

# uv 사용 (권장)
uv run pytest                 # 유닛 테스트만
uv run pytest --cov=maverick_mcp  # 커버리지 포함
uv run pytest -m ""           # 모든 테스트 (PostgreSQL/Redis 필요)

# 대안: 직접 pytest (venv에서 활성화된 경우)
pytest                 # 유닛 테스트만
pytest --cov=maverick_mcp  # 커버리지 포함
pytest -m ""           # 모든 테스트 (PostgreSQL/Redis 필요)
```

### 코드 품질

```bash
# 빠른 품질 명령어
make lint              # 코드 품질 확인 (ruff)
make format            # 코드 자동 포맷팅 (ruff)
make typecheck         # 타입 체크 실행 (ty)

# uv 사용 (권장)
uv run ruff check .    # 린팅
uv run ruff format .   # 포맷팅
uv run ty check .      # 타입 체크 (Astral의 현대적인 타입 체커)

# 대안: 직접 명령어 (venv에서 활성화된 경우)
ruff check .           # 린팅
ruff format .          # 포맷팅
ty check .             # 타입 체크

# 초고속 한 줄 명령어 (설치 불필요)
uvx ty check .         # 설치 없이 ty 직접 실행
```

## 구성

`.env` 파일 또는 환경 변수를 통해 MaverickMCP 구성:

**필수 설정:**

- `REDIS_HOST`, `REDIS_PORT` - Redis 캐시 (선택사항, 기본값 localhost:6379)
- `DATABASE_URL` - PostgreSQL 연결 또는 SQLite용 `sqlite:///maverick_mcp.db` (기본값)
- `LOG_LEVEL` - 로깅 상세도 (INFO, DEBUG, ERROR)
- S&P 500 데이터는 첫 시작 시 자동으로 시드됨

**필수 API 키:**

- `TIINGO_API_KEY` - 주식 데이터 제공자 ([tiingo.com](https://tiingo.com)에서 무료 티어 제공)

**선택적 API 키:**

- `OPENROUTER_API_KEY` - **연구용 강력 권장**: 지능형 비용 최적화로 400개 이상의 AI 모델에 액세스 (40-60% 비용 절감)
- `EXA_API_KEY` - **연구용 권장**: 포괄적인 연구를 위한 웹 검색 기능
- `OPENAI_API_KEY` - 직접 OpenAI 액세스 (폴백)
- `ANTHROPIC_API_KEY` - 직접 Anthropic 액세스 (폴백)
- `FRED_API_KEY` - 연준 경제 데이터
- `TAVILY_API_KEY` - 대안 웹 검색 제공자

**성능:**

- `CACHE_ENABLED=true` - Redis 캐싱 활성화
- `CACHE_TTL_SECONDS=3600` - 캐시 지속 시간

## 사용 예제

### 백테스팅 예제

Claude Desktop에 연결되면 자연어를 사용하여 백테스트를 실행할 수 있습니다:

```
"Run a backtest on AAPL using the momentum strategy for the last 6 months"

"Compare the performance of mean reversion vs trend following strategies on SPY"

"Optimize the RSI strategy parameters for TSLA with walk-forward analysis"

"Show me the Sharpe ratio and maximum drawdown for a portfolio of tech stocks using the adaptive ML strategy"

"Generate a detailed backtest report for the ensemble strategy on the S&P 500 sectors"
```

### 기술 분석 예제

```
"Show me the RSI and MACD analysis for NVDA"

"Identify support and resistance levels for MSFT"

"Get full technical analysis for the top 5 momentum stocks"
```

### 포트폴리오 최적화 예제

```
"Optimize a portfolio of AAPL, GOOGL, MSFT, and AMZN for maximum Sharpe ratio"

"Calculate the correlation matrix for my tech portfolio"

"Analyze the risk-adjusted returns for energy sector stocks"
```

## 도구

MaverickMCP는 고급 AI 기반 연구 에이전트를 포함하여 카테고리별로 구성된 35개 이상의 금융 분석 도구를 제공합니다:

### 주식 데이터 도구

- `fetch_stock_data` - 지능형 캐싱을 포함한 역사적 주식 데이터 가져오기
- `fetch_stock_data_batch` - 여러 티커에 대한 데이터 동시 가져오기
- `get_news_sentiment` - 모든 티커에 대한 뉴스 감정 분석
- `clear_cache` / `get_cache_info` - 캐시 관리 유틸리티

### 기술 분석 도구

- `get_rsi_analysis` - 매수/매도 신호와 함께 RSI 계산
- `get_macd_analysis` - 추세 식별과 함께 MACD 분석
- `get_support_resistance` - 주요 가격 수준 식별
- `get_full_technical_analysis` - 포괄적인 기술 분석
- `get_stock_chart_analysis` - 시각적 차트 생성

### 포트폴리오 도구

- `risk_adjusted_analysis` - 리스크 기반 포지션 사이징
- `compare_tickers` - 티커 나란히 비교
- `portfolio_correlation_analysis` - 상관관계 행렬 분석

### 주식 스크리닝 도구 (S&P 500으로 사전 시드됨)

- `get_maverick_stocks` - S&P 500의 520개 주식에서 강세 모멘텀 스크리닝
- `get_maverick_bear_stocks` - 사전 분석된 데이터에서 약세 설정 식별
- `get_trending_breakout_stocks` - 수급 분석과 함께 강한 상승 추세 단계 스크리닝
- `get_all_screening_recommendations` - 모든 전략을 통합한 스크리닝 결과
- 데이터베이스에는 정기적으로 업데이트되는 포괄적인 스크리닝 데이터 포함

### 고급 연구 도구 (새로운 기능) - AI 기반 심층 분석

- `research_comprehensive` - 여러 AI 에이전트를 사용한 전체 병렬 연구 (7-256배 빠름)
- `research_company` - 재무 분석을 포함한 회사별 심층 연구
- `analyze_market_sentiment` - 신뢰도 추적을 포함한 다소스 감정 분석
- `coordinate_agents` - 복잡한 연구 오케스트레이션을 위한 다중 에이전트 감독자

**연구 기능:**
- **병렬 실행**: 지능형 에이전트 오케스트레이션으로 7-256배 가속화
- **적응형 타임아웃 보호**: 연구 깊이와 복잡성에 따른 동적 타임아웃 (120s-600s)
- **지능형 모델 선택**: OpenRouter를 통한 400개 이상의 모델 자동 선택
- **비용 최적화**: 지능형 모델 라우팅을 통한 40-60% 비용 절감
- **조기 종료**: 시간과 비용을 절약하기 위한 신뢰도 기반 조기 중지
- **콘텐츠 필터링**: 고품질 결과를 위한 높은 신뢰도 소스 우선순위 지정
- **에러 복구**: 서킷 브레이커 및 포괄적인 에러 처리
- **다중 에이전트 오케스트레이션**: 복잡한 연구 조정을 위한 감독자 패턴

### 백테스팅 도구 (새로운 기능) - 프로덕션 준비 전략 테스트

- `run_backtest` - 모든 전략에 대해 VectorBT 엔진으로 백테스트 실행
- `compare_strategies` - 전략 비교를 위한 A/B 테스트 프레임워크
- `optimize_strategy` - 매개변수 튜닝과 함께 워크 포워드 최적화
- `analyze_backtest_results` - 포괄적인 성능 지표 및 리스크 분석
- `get_backtest_report` - 시각화를 포함한 상세 HTML 보고서 생성

**백테스팅 기능:**
- **15개 이상의 내장 전략**: ML 기반 적응형, 앙상블 및 레짐 인식 알고리즘 포함
- **VectorBT 통합**: 고성능 벡터화 백테스팅 엔진
- **병렬 처리**: 다중 전략 평가를 위한 7-256배 가속화
- **고급 지표**: Sharpe, Sortino, Calmar 비율, 최대 낙폭, 승률
- **워크 포워드 최적화**: 샘플 외 테스트 및 검증
- **몬테 카를로 시뮬레이션**: 신뢰 구간과 함께 강건성 테스트
- **다중 타임프레임 지원**: 1분부터 월간 데이터까지
- **커스텀 전략 개발**: 커스텀 전략을 위한 사용하기 쉬운 템플릿

### 시장 데이터 도구

- 시장 개요, 섹터 성능, 실적 캘린더
- 경제 지표 및 연방준비제도 데이터
- 실시간 시장 움직임 및 감정 분석

## 리소스

- `stock://{ticker}` - 최신 1년 주식 데이터
- `stock://{ticker}/{start_date}/{end_date}` - 사용자 지정 날짜 범위
- `stock_info://{ticker}` - 기본 주식 정보

## 프롬프트

- `stock_analysis(ticker)` - 포괄적인 주식 분석 프롬프트
- `market_comparison(tickers)` - 여러 주식 비교
- `portfolio_optimization(tickers, risk_profile)` - 포트폴리오 최적화 가이드

## 테스트 예제 - 모든 기능 검증

이 예제로 포괄적인 연구 기능과 병렬 처리 개선 사항을 테스트하세요:

### 핵심 연구 기능

1. **타임아웃 보호가 있는 기본 연구**
   ```
   "Research the current state of the AI semiconductor industry and identify the top 3 investment opportunities"
   ```
   - 테스트: 기본 연구, 적응형 타임아웃, 산업 분석

2. **병렬 에이전트를 사용한 포괄적인 회사 연구**
   ```
   "Provide comprehensive research on NVDA including fundamental analysis, technical indicators, competitive positioning, and market sentiment using multiple research approaches"
   ```
   - 테스트: 병렬 오케스트레이션, 다중 에이전트 조정, 회사 연구

3. **비용 최적화된 빠른 연구**
   ```
   "Give me a quick overview of AAPL's recent earnings and stock performance"
   ```
   - 테스트: 지능형 모델 선택, 비용 최적화, 빠른 분석

### 성능 테스트

4. **병렬 성능 벤치마크**
   ```
   "Research and compare MSFT, GOOGL, and AMZN simultaneously focusing on cloud computing revenue growth"
   ```
   - 테스트: 병렬 실행 가속화 (7-256배), 다중 회사 분석

5. **조기 종료를 사용한 심층 연구**
   ```
   "Conduct exhaustive research on Tesla's autonomous driving technology and its impact on the stock valuation"
   ```
   - 테스트: 심층 연구 깊이, 신뢰도 추적, 조기 종료 (0.85 임계값)

### 에러 처리 및 복구

6. **에러 복구 및 서킷 브레이커 테스트**
   ```
   "Research 10 penny stocks with unusual options activity and provide risk assessments for each"
   ```
   - 테스트: 서킷 브레이커 활성화, 에러 처리, 폴백 메커니즘

7. **감독자 에이전트 조정**
   ```
   "Analyze the renewable energy sector using both technical and fundamental analysis approaches, then synthesize the findings into actionable investment recommendations"
   ```
   - 테스트: 감독자 라우팅, 에이전트 조정, 결과 합성

### 고급 기능

8. **콘텐츠 필터링을 사용한 감정 분석**
   ```
   "Analyze market sentiment for Bitcoin and cryptocurrency stocks over the past week, filtering for high-credibility sources only"
   ```
   - 테스트: 감정 분석, 콘텐츠 필터링, 소스 신뢰도

9. **타임아웃 스트레스 테스트**
   ```
   "Research the entire S&P 500 technology sector companies and rank them by growth potential"
   ```
   - 테스트: 타임아웃 관리, 대규모 분석, 부하 하에서 성능

10. **다중 모달 연구 통합**
    ```
    "Research AMD using technical analysis, then find recent news about their AI chips, analyze competitor Intel's position, and provide a comprehensive investment thesis with risk assessment"
    ```
    - 테스트: 모든 연구 모드, 통합, 합성, 리스크 평가

### 추가 엣지 케이스 테스트

11. **빈/잘못된 쿼리 처리**
    ```
    "Research [intentionally leave blank or use symbol that doesn't exist like XYZABC]"
    ```
    - 테스트: 에러 메시지, 도움이 되는 수정 제안

12. **토큰 예산 최적화**
    ```
    "Provide the most comprehensive possible analysis of the entire semiconductor industry including all major players, supply chain dynamics, geopolitical factors, and 5-year projections"
    ```
    - 테스트: 점진적 토큰 할당, 예산 관리, 깊이 vs 폭

### 예상 성능 지표

이러한 테스트를 실행할 때 다음을 관찰해야 합니다:
- **병렬 가속화**: 다중 엔티티 쿼리에 대해 7-256배 빠름
- **응답 시간**: 간단한 쿼리 ~10초, 복잡한 연구 30-120초
- **비용 효율성**: 프리미엄 전용 모델 대비 60-80% 감소
- **신뢰도 점수**: 신뢰도 > 0.85일 때 조기 종료
- **에러 복구**: 충돌 없이 우아한 성능 저하
- **모델 선택**: 작업별 최적 모델로 자동 라우팅

## Docker (선택사항)

컨테이너화된 배포:

```bash
# 환경 복사 및 구성
cp .env.example .env

# Docker에서 uv 사용 (더 빠른 빌드를 위해 권장)
docker build -t maverick_mcp .
docker run -p 8003:8003 --env-file .env maverick_mcp

# 또는 docker-compose로 시작
docker-compose up -d
```

**참고**: Dockerfile은 빠른 의존성 설치 및 더 작은 이미지 크기를 위해 `uv`를 사용합니다.

## 문제 해결

### 일반적인 문제

**Claude Desktop에서 도구가 사라짐:**
- **해결 방법**: SSE 엔드포인트에 끝에 슬래시 있는지 확인: `http://localhost:8003/sse/`
- `/sse`에서 `/sse/`로의 307 리다이렉트가 도구 등록 실패를 일으킴
- 위에 표시된 대로 끝에 슬래시가 있는 정확한 구성 항상 사용

**연구 도구 타임아웃:**
- 연구 도구는 적응형 타임아웃 (120s-600s)을 가짐
- 심층 연구는 복잡성에 따라 2-10분이 걸릴 수 있음
- `make tail-log`로 서버 로그에서 진행 상황 모니터링

**OpenRouter 작동하지 않음:**
- `.env`에 `OPENROUTER_API_KEY`가 설정되어 있는지 확인
- [openrouter.ai](https://openrouter.ai)에서 API 키 유효성 확인
- OpenRouter를 사용할 수 없는 경우 시스템이 직접 제공자로 폴백

```bash
# 일반적인 개발 문제
make tail-log          # 서버 로그 보기
make stop              # 포트가 사용 중인 경우 서비스 중지
make clean             # 캐시 파일 정리

# 빠른 수정:
# 포트 8003 사용 중 → make stop
# Redis 연결 거부 → brew services start redis
# 테스트 실패 → make test (유닛 테스트만)
# 느린 시작 → ./tools/fast_dev.sh
# S&P 500 데이터 누락 → uv run python scripts/seed_sp500.py
# 연구 타임아웃 → 로그 확인, 타임아웃 설정 증가
```

## MaverickMCP 확장

간단한 데코레이터로 커스텀 금융 분석 도구 추가:

```python
@mcp.tool()
def my_custom_indicator(ticker: str, period: int = 14):
    """Calculate custom technical indicator."""
    # 여기에 분석 로직
    return {"ticker": ticker, "signal": "buy", "confidence": 0.85}

@mcp.resource("custom://analysis/{ticker}")
def custom_analysis(ticker: str):
    """Custom analysis resource."""
    # 여기에 리소스 로직
    return f"Custom analysis for {ticker}"
```

## 개발 도구

### 빠른 개발 워크플로우

```bash
make dev               # 모든 것 시작
make stop              # 서비스 중지
make tail-log          # 서버 로그 추적
make test              # 빠르게 테스트 실행
make experiment        # 커스텀 분석 스크립트 테스트
```

### 스마트 에러 처리

MaverickMCP는 유용한 에러 진단을 포함합니다:

- DataFrame 열 대소문자 구분 → 올바른 열 이름 표시
- 연결 실패 → 특정 수정 명령 제공
- 가져오기 에러 → 정확한 설치 명령 표시
- 데이터베이스 문제 → SQLite 폴백 제안

### 빠른 개발 옵션

- **핫 리로드**: `uv run python tools/hot_reload.py` - 변경 시 자동 재시작
- **빠른 시작**: `./tools/fast_dev.sh` - < 3초 시작
- **빠른 테스트**: `uv run python tools/quick_test.py --test stock` - 특정 기능 테스트
- **실험 하네스**: `.py` 파일을 `tools/experiments/`에 넣어 자동 실행

### 성능 기능

- **병렬 스크리닝**: ProcessPoolExecutor로 4배 빠른 주식 분석
- **스마트 캐싱**: 즉시 재실행을 위한 `@quick_cache` 데코레이터
- **최적화된 테스트**: 유닛 테스트가 5-10초에 완료

## 도움 받기

문제나 질문이 있으시면:

1. **문서 확인**: 이 README와 [CLAUDE.md](CLAUDE.md)로 시작
2. **이슈 검색**: 기존 [GitHub 이슈](https://github.com/wshobson/maverick-mcp/issues) 살펴보기
3. **버그 보고**: 새 [이슈](https://github.com/wshobson/maverick-mcp/issues/new) 생성 및 세부 정보 제공
4. **기능 요청**: GitHub 이슈를 통해 개선 사항 제안
5. **기여**: 개발 설정은 [Contributing Guide](CONTRIBUTING.md) 참조

## 최근 업데이트

### 프로덕션 준비 백테스팅 프레임워크 (새로운 기능)

- **VectorBT 통합**: 기관 수준의 성능을 위한 고성능 벡터화 백테스팅 엔진
- **15개 이상의 내장 전략**: ML 기반 적응형, 앙상블 및 레짐 인식 알고리즘 포함
- **병렬 처리**: 다중 전략 평가 및 최적화를 위한 7-256배 가속화
- **고급 분석**: Sharpe, Sortino, Calmar 비율 및 낙폭 분석을 포함한 포괄적인 지표
- **워크 포워드 최적화**: 자동 매개변수 튜닝과 함께 샘플 외 테스트
- **몬테 카를로 시뮬레이션**: 신뢰 구간과 함께 강건성 테스트
- **LangGraph 워크플로우**: 지능형 전략 선택 및 검증을 위한 다중 에이전트 오케스트레이션
- **프로덕션 기능**: 데이터베이스 영속성, 배치 처리 및 HTML 보고서

### 고급 연구 에이전트

- **병렬 연구 실행**: 지능형 에이전트 오케스트레이션으로 7-256배 가속화 달성 (2배 목표 초과)
- **적응형 타임아웃 보호**: 연구 깊이 및 복잡성에 따른 동적 타임아웃 (120s-600s)
- **지능형 모델 선택**: 400개 이상의 모델을 가진 OpenRouter 통합, 40-60% 비용 절감
- **포괄적인 에러 처리**: 서킷 브레이커, 재시도 로직 및 우아한 성능 저하
- **조기 종료**: 시간과 비용을 최적화하기 위한 신뢰도 기반 중지
- **콘텐츠 필터링**: 고품질 결과를 위한 높은 신뢰도 소스 우선순위 지정
- **다중 에이전트 오케스트레이션**: 복잡한 연구 조정을 위한 감독자 패턴

### 성능 개선

- **병렬 에이전트 실행**: 동시 에이전트를 4개에서 6개로 증가
- **최적화된 세마포어**: 더 나은 리소스 관리를 위한 BoundedSemaphore
- **속도 제한 감소**: 지연을 0.5초에서 0.05초로 감소
- **배치 처리**: 다중 연구 작업에 대한 처리량 개선
- **스마트 캐싱**: 인메모리 폴백과 함께 Redis 기반

### 테스트 및 품질

- **84% 테스트 커버리지**: 93개의 포괄적인 커버리지를 가진 테스트
- **제로 린팅 에러**: 깨끗한 코드베이스를 위해 947개의 이슈 수정
- **전체 타입 주석**: 연구 구성 요소에 대한 완전한 타입 커버리지
- **에러 복구 테스트**: 포괄적인 실패 시나리오 커버리지

### 개인 사용 최적화

- **인증 불필요**: 개인 사용을 위해 모든 인증/빌링 복잡성 제거
- **사전 시드 S&P 500 데이터베이스**: 포괄적인 스크리닝 추천을 포함한 520개 주식
- **간소화된 아키텍처**: 핵심 주식 분석 기능을 위한 깨끗하고 집중된 코드베이스
- **다중 전송 지원**: 모든 MCP 클라이언트를 위한 HTTP, SSE 및 STDIO

### 개발 경험 개선

- **포괄적인 Makefile**: 데이터베이스 시드를 포함하여 한 명령(`make dev`)으로 모든 것을 시작
- **스마트 에러 처리**: 일반적인 문제에 대한 자동 수정 제안
- **빠른 개발**: `./tools/fast_dev.sh`로 < 3초 시작
- **병렬 처리**: 주식 스크리닝 작업에 대한 4배 가속화
- **향상된 도구**: 핫 리로드, 실험 하네스, 빠른 테스트

### 기술 개선

- **현대적인 도구**: 더 빠른 의존성 관리 및 타입 체크를 위해 uv 및 ty로 마이그레이션
- **시장 데이터**: 개선된 폴백 로직 및 비동기 지원
- **캐싱**: 우아한 인메모리 폴백과 함께 스마트 Redis 캐싱
- **데이터베이스**: 향상된 성능을 위한 PostgreSQL 옵션과 함께 SQLite 기본값

## 감사

MaverickMCP는 다음 우수한 오픈소스 프로젝트를 기반으로 구축되었습니다:

- **[FastMCP](https://github.com/jlowin/fastmcp)** - 서버를 구동하는 MCP 프레임워크
- **[yfinance](https://github.com/ranaroussi/yfinance)** - 시장 데이터 액세스
- **[TA-Lib](https://github.com/mrjbq7/ta-lib)** - 기술 분석 지표
- **[pandas](https://pandas.pydata.org/)** & **[NumPy](https://numpy.org/)** - 데이터 분석
- **[FastAPI](https://fastapi.tiangolo.com/)** - 현대적인 웹 프레임워크
- 전체 Python 오픈소스 커뮤니티

## 라이선스

MIT 라이선스 - 자세한 내용은 [LICENSE](LICENSE) 파일 참조. 개인 및 상업 목적으로 자유롭게 사용 가능.

## 지원

MaverickMCP가 유용하다면:

- 저장소에 별표
- GitHub 이슈를 통해 버그 보고
- 기능 제안
- 문서 개선

---

트레이더와 투자자를 위해 구축. 행복한 트레이딩!

[![MSeeP.ai Security Assessment Badge](https://mseep.net/pr/wshobson-maverick-mcp-badge.png)](https://mseep.ai/app/wshobson-maverick-mcp)

**전체 빌드 가이드 읽기**: [How to Build an MCP Stock Analysis Server](https://sethhobson.com/2025/08/how-to-build-an-mcp-stock-analysis-server/)

## 면책 조항

<sub>**이 소프트웨어는 교육 및 정보 제공 목적으로만 사용됩니다. 금융 조언이 아닙니다.**</sub>

<sub>**투자 리스크 경고**: 과거 실적이 미래 결과를 보장하지 않습니다. 모든 투자는 자본 총손실을 포함한 손실의 위험을 수반합니다. 기술 분석 및 스크리닝 결과는 미래 성과를 예측하지 않습니다. 시장 데이터가 지연되거나 부정확하거나 불완전할 수 있습니다.</sub>

<sub>**전문 조언 없음**: 이 도구는 데이터 분석을 제공하며 투자 권고사항은 아닙니다. 투자 결정을 내리기 전에 항상 자격 있는 금융 고문과 상의하세요. 개발자는 자격 있는 금융 고문이나 투자 전문가가 아닙니다. 이 소프트웨어의 어떤 것도 전문 금융, 투자, 법률 또는 세무 조언을 구성하지 않습니다.</sub>

<sub>**데이터 및 정확성**: Tiingo, Yahoo Finance, FRED와 같은 제3자 소스에서 제공하는 시장 데이터. 데이터에 오류, 지연 또는 누락이 있을 수 있습니다. 기술 지표는 역사적 데이터를 기반으로 한 수학적 계산입니다. 데이터 정확성이나 완전성에 대해 보증하지 않습니다.</sub>

<sub>**규정 준수**: 미국 사용자 - 이 소프트웨어는 SEC, CFTC 또는 기타 규제 기관에 등록되지 않았습니다. 국제 사용자 - 사용 전 로컬 금융 소프트웨어 규정을 확인하세요. 사용자는 모든 적용 가능한 법률 및 규정을 준수할 책임이 있습니다. 일부 기능은 특정 관할권에서 사용할 수 없을 수 있습니다.</sub>

<sub>**책임 제한**: 개발자는 투자 손실이나 손해에 대해 모든 책임을 부인합니다. 자신의 위험으로 이 소프트웨어를 사용하세요. 소프트웨어 가용성이나 기능에 대한 보증은 없습니다.</sub>

<sub>MaverickMCP를 사용함으로써 귀하는 이러한 위험을 인정하고 교육 목적으로만 소프트웨어를 사용하는 데 동의합니다.</sub>
