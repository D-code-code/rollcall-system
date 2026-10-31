#!/usr/bin/env bash
# 一键把 rollcall-system Skill 安装到 Claude Code / Codex / 小龙虾(OpenClaw) / 通用目录
# 用法：在 rollcall-system 目录下执行  ./install.sh
set -euo pipefail

SKILL_NAME="rollcall-system"
# 脚本所在目录 = 技能目录（无论从哪 clone 下来都通用）
SKILL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_to() {
  local dir="$1"
  mkdir -p "$dir"
  local link="$dir/$SKILL_NAME"
  if [ -L "$link" ]; then rm -f "$link"; fi
  if [ -e "$link" ] && [ ! -L "$link" ]; then
    echo "  ⚠️  已存在真实目录，跳过：$link"
    return
  fi
  ln -s "$SKILL_DIR" "$link"
  echo "  ✅ $link"
}

echo "安装 $SKILL_NAME 到："
install_to "$HOME/.claude/skills"              # Claude Code
install_to "$HOME/.codex/skills"               # OpenAI Codex CLI
install_to "$HOME/.openclaw/skills"            # 小龙虾(OpenClaw) 用户全局
install_to "$HOME/.openclaw/workspace/skills"  # 小龙虾(OpenClaw) 默认专用
install_to "$HOME/.agents/skills"              # 通用目录（多工具识别）

echo
echo "完成 ✅ 重启/新开会话后生效："
echo "  触发语：我现在要做一个点名系统"
echo "  显式：Claude /rollcall-system ｜ Codex \$rollcall-system ｜ 小龙虾 /skill rollcall-system"
