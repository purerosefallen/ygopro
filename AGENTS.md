# 项目规范

- 所有『解决合并冲突』的任务，需要用 3-way diff 法判定争议点如何处理。
  - 面对十分争议的点，应当停下来，然后询问我的意见。
  - 有时候冲突是假冲突，因为上游项目合并 PR 会采用 squash 形式，会出现二次冲突。面对这种情况，应该做正确识别而不是重新思考如何合并。
- 改完 C++ 代码，或者依赖之后，需要编译验证，使用 ./ygopro-build.sh。

## CI 相关要求

- CI 机器访问 `https://mat-cacher.moenext.com/` 和 `https://cdn02.moecube.com:444/` 均为 LAN 访问。
  - 外网 HTTP/HTTPS 依赖下载应通过 `https://mat-cacher.moenext.com/`，沿用已有缓存参数约定。
  - `cdn02.moecube.com` 上的资源直接下载，不再套 mat-cacher，也不要附加 mat-cacher 专用的查询参数。
- 本项目 Linux CI 是 [docker-ygopro-builder](https://code.moenext.com/mycard/docker-ygopro-builder) 发布镜像的消费者。同步上游 deps CI 变动前，先判断改动属于供应链还是本项目：
  - 镜像预装工具、系统依赖、编译器、工具链及内置 premake5 的版本调整，应在供应链项目构建并发布，本项目继续使用其镜像。
  - 本项目 CI 自行下载的源码依赖，以及本项目的 premake 参数、依赖目录和资源配置，才在这里按需同步。
  - 不要在本项目临时安装、重复下载或覆盖镜像已有依赖来替代供应链更新。
- builder 镜像内置 premake5 已更新为 stable。Linux CI 使用镜像内的 `premake5`，不要为版本更新额外增加下载、覆盖二进制或架构选择逻辑。
- 上游依赖版本更新应保持最小改动，默认只修改版本号和必要的下载、解压文件名。不要顺带修改下载策略、增加变量或诊断步骤、调整 job 结构或构建流程；额外逻辑变更必须有当前源码、镜像或构建行为的明确依据。
- 镜像和资源验证优先使用 `nanahira@yunomi.moenext.com`，避免本机跨网下载拖慢验证。验证镜像时先拉取当前版本，再按实际摘要运行；不能用本机旧镜像缓存推断 CI 当前版本。
- 如果合并的时候发现 .github 里面的 Actions 文件被改了，那么需要在本项目 GitLab CI 做出同步的修改。
  - 同时应该把本项目的依赖目录配置正确（用 CI 的形式获取，放在本目录下）
  - premake 参数的修改用环境变量形式，ci 和 ygopro-build.sh 都要修改。
  - 除非有冲突，否则不要自己修改 github actions 文件，这不属于本项目维护范围。

## server 验收标准

以下验收只针对原版、未启用 ZIP support 的 Linux server。所有命令均从项目根目录开始执行。

### 1. 编译原版 server

```bash
./ygopro-build.sh
```

后续验收使用生成的 `bin/release/ygopro`。

### 2. 写卡号测卡

```bash
./bin/release/ygopro 102380
```

通过标准：

- 进程以状态码 0 退出。
- 不得出现 `cards.cdb`、卡片脚本或初始化失败。
- 仅仅成功编译不算测卡通过。

### 3. 使用两个 WindBot 完成一盘

先在终端 1 启动 server：

```bash
./bin/release/ygopro 0 0 0 0 F T F 8000 5 1 180 0
```

参数中的首个 `0` 表示自动选择空闲端口。记下 server 输出的实际端口。

在终端 2 启动第一个 WindBot，将 `12345` 替换为实际端口：

```bash
ROOT="$(git rev-parse --show-toplevel)"
PORT=12345
cd "$ROOT/windbot/bin/Release"
set -o pipefail
mono WindBot.exe \
  Name=WindBot-A \
  Deck=Burn \
  Host=127.0.0.1 \
  Port="$PORT" \
  Version=4962 \
  Hand=1 \
  Chat=false \
  DbPath="$ROOT/cards.cdb" \
  2>&1 | tee /tmp/ygopro-windbot-a.log
```

在终端 3 启动第二个 WindBot，使用同一个端口：

```bash
ROOT="$(git rev-parse --show-toplevel)"
PORT=12345
cd "$ROOT/windbot/bin/Release"
set -o pipefail
mono WindBot.exe \
  Name=WindBot-B \
  Deck=OldSchool \
  Host=127.0.0.1 \
  Port="$PORT" \
  Version=4962 \
  Hand=2 \
  Chat=false \
  DbPath="$ROOT/cards.cdb" \
  2>&1 | tee /tmp/ygopro-windbot-b.log
```

通过标准：

- 两个 WindBot 均成功进入同一房间并开始对局。
- 两份日志均出现 `Duel started:`。
- 两份日志均出现 `Duel finished against` 和最终 `result:`。
- 两个 WindBot 收到 DuelEnd 后正常退出。
- 只进房、只开始对局、客户端异常断开或等待超时均不算通过。
