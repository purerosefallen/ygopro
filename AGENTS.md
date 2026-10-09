# 项目规范

- 所有『解决合并冲突』的任务，需要用 3-way diff 法判定争议点如何处理。
  - 面对十分争议的点，应当停下来，然后询问我的意见。
  - 有时候冲突是假冲突，因为上游项目合并 PR 会采用 squash 形式，会出现二次冲突。面对这种情况，应该做正确识别而不是重新思考如何合并。
- 改完 C++ 代码，或者依赖之后，需要编译验证，使用 ./ygopro-build.sh。

## CI 相关要求

- CI 机器访问 `https://mat-cacher.moenext.com/` 和 `https://cdn02.moecube.com:444/` 均为 LAN 访问。
  - 外网 HTTP/HTTPS 依赖下载应通过 `https://mat-cacher.moenext.com/`，沿用已有缓存参数约定。
  - `cdn02.moecube.com` 上的资源直接下载，不再套 mat-cacher，也不要附加 mat-cacher 专用的查询参数。
- Linux builder 镜像由独立供应链维护，内置 premake5 已更新为 stable。Linux CI 使用镜像内的 `premake5`，不要为版本更新额外增加下载、覆盖二进制或架构选择逻辑。
- 上游依赖版本更新应保持最小改动，默认只修改版本号和必要的下载、解压文件名。不要顺带修改下载策略、增加变量或诊断步骤、调整 job 结构或构建流程；额外逻辑变更必须有当前源码、镜像或构建行为的明确依据。
- 镜像和资源验证优先使用 `nanahira@yunomi.moenext.com`，避免本机跨网下载拖慢验证。验证镜像时先拉取当前版本，再按实际摘要运行；不能用本机旧镜像缓存推断 CI 当前版本。
- 如果合并的时候发现 .github 里面的 Actions 文件被改了，那么需要在本项目 GitLab CI 做出同步的修改。
  - 同时应该把本项目的依赖目录配置正确（用 CI 的形式获取，放在本目录下）
  - premake 参数的修改用环境变量形式，ci 和 ygopro-build.sh 都要修改。
  - 除非有冲突，否则不要自己修改 github actions 文件，这不属于本项目维护范围。
