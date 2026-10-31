# rollcall-system — 点名系统 Skill

一个**跨工具 Agent Skill**：**Claude Code / Codex / 小龙虾(OpenClaw)** 都能用。别人只要说一句「**我现在要做一个点名系统**」，它就会引导对方完成 **语言 → 每组人数 → 班级名 → 学生姓名 → 学号** 的设置，然后自动补齐其余功能，最终产出一个**单个 HTML 文件**——可离线运行、有浏览器**永久记忆**（localStorage），Mac / Windows 双击浏览器即用。

> 三个工具读的是**同一份 `SKILL.md`**（YAML frontmatter `name` + `description` + Markdown 正文），只是各自安装目录不同，见下。

## 它能生成什么

| 特性 | 说明 |
|---|---|
| 6 语言界面 | 简体中文 / 繁體中文 / 日本語 / English / 한국어 / Français，右上角随时切换 |
| 永久记忆 | 数据存 localStorage，关掉再打开班级/学生/历史/语言都还在 |
| 抽选算法 | 每组固定 N 人（默认 3，可改）；不足 N 自动滚入补齐；请假者下次强制出现 |
| 可配置 | 班级名、学生姓名、学号初次生成 + 之后在「设置」里随时增删改 |
| 备份 | 导出/导入 JSON 备份 |
| 离线 | 单个 HTML，不依赖任何网络/CDN |

## 安装这个 Skill（三种工具，一键）

三个工具各自从不同目录加载 Skill，但读的是同一个格式。最简单：跑 `install.sh`，一次性软链到全部位置：

```bash
cd rollcall-system    # 或你 clone 下来的目录
./install.sh
```

等价的手动安装（`$(pwd)` = 这个文件夹的绝对路径）：

```bash
ln -s "$(pwd)" ~/.claude/skills/rollcall-system              # Claude Code
ln -s "$(pwd)" ~/.codex/skills/rollcall-system               # Codex
ln -s "$(pwd)" ~/.openclaw/skills/rollcall-system            # 小龙虾 用户全局
ln -s "$(pwd)" ~/.openclaw/workspace/skills/rollcall-system  # 小龙虾 默认专用
ln -s "$(pwd)" ~/.agents/skills/rollcall-system              # 通用目录
```

各工具加载目录与显式调用对照：

| 工具 | 安装目录 | 显式调用 |
|---|---|---|
| Claude Code | `~/.claude/skills/rollcall-system` | `/rollcall-system` |
| Codex | `~/.codex/skills/rollcall-system` | `$rollcall-system` |
| 小龙虾 (OpenClaw) | `~/.openclaw/skills/rollcall-system` | `/skill rollcall-system` |
| 通用共享目录 | `~/.agents/skills/rollcall-system` | — |

安装后**重启**对应工具（或开新会话），说「我现在要做一个点名系统」即可触发。

> 想要「复制」而非「软链」：把 `ln -s` 换成 `cp -R`。软链的好处是改一处、所有工具同步生效；复制更稳、但更新要重拷。

## 目录结构

```
rollcall-system/
  SKILL.md        # Skill 定义（三工具通用的触发条件 + 引导流程 + 生成规则）
  template.html   # 成品 HTML 模板（内含唯一的 __SEED_DATA__ 占位符）
  install.sh      # 一键安装到 Claude Code / Codex / 小龙虾
  README.md       # 本说明
```

`template.html` 里唯一需要替换的就是 `__SEED_DATA__`，其余代码（6 语言、算法、界面）都不要动。

## 发布到 GitHub

1. 在 GitHub 新建一个空仓库（例如 `rollcall-system`），**不要**勾选自动生成 README。
2. 本地提交并推送：
   ```bash
   cd /Users/d/Desktop/rollcall-system
   git init
   git add .
   git commit -m "Add rollcall-system skill"
   git branch -M main
   git remote add origin https://github.com/你的用户名/rollcall-system.git
   git push -u origin main
   ```
3. 别人安装：`git clone` 后跑 `./install.sh` 即可。

> 想让这个 Skill 也能被当作「插件」分发，可以把它包成标准的 Claude Code skill 插件结构（加 `skills/` 清单），但当前这个仓库形式已可直接被个人使用。

## 生成的 HTML 怎么用（给最终用户的话）

- **双击 `点名系统.html`** 用浏览器打开即可，Mac（Safari/Chrome）和 Windows（Edge/Chrome）都行。
- 数据自动存在浏览器本地；**换浏览器或清缓存会丢**，重要名单记得点「设置 → 导出备份」存一份 JSON。
- 首次打开已经按你刚才口述的内容填好了班级和学生；要改，进「设置 → 班级与学生管理」。

## 常见问题

- **localStorage 失效？** 个别浏览器在 `file://` 下限制本地存储；用 Chrome/Edge 打开最稳，或用「导出备份」兜底。
- **想换默认语言？** 右上角下拉直接切。
- **软链装了但工具不认？** 重启工具/开新会话再试；个别工具不跟符号链接，换成 `cp -R` 复制方式。
