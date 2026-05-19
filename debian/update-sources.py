#!/usr/bin/env python3
import re
import shutil
import subprocess
import sys

from pathlib import Path

ZIG_VENDOR_DIR = Path.cwd() / "zig-vendor"
SYSTEM_DEPS = ["harfbuzz", "libpng", "freetype", "fontconfig", "zlib"]
SENTRY_AND_DEPS = ["sentry", "breakpad"]

def parse_zon_dependencies(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    # Regex to extract the value of .dependencies.
    dep_match = re.search(r'\.dependencies\s*=\s*\.\{(.*)\}\s*,\s*\}', content, re.DOTALL)
    if not dep_match:
        return []

    dep_content = dep_match.group(1)

    # remove comments from the searchable content
    dep_content = re.sub(r'^\s*//.*$', '', dep_content, flags=re.MULTILINE)

    # Regex to extract all name, url pairs:
    # \.(\w+)       -> Finds the dependency name (starts with a dot, followed by word chars)
    # \s*=\s*\.\{   -> Matches the assignment and the start of the object
    # .*?           -> Non-greedy match for content inside
    # \.url\s*=\s*"([^"]+)" -> Specifically captures the string inside the .url field
    pattern = r'\.(\w+)\s*=\s*\.\{[^}]*?\.url\s*=\s*"([^"]+)"'
    
    # We use re.DOTALL so the '.' matches newlines within the dependency blocks
    matches = re.findall(pattern, dep_content, re.DOTALL)
    return matches 

def fetch_deps(basedir="."):
    zonpath = Path(basedir) / "build.zig.zon" 
    if not zonpath.is_file():
        return
    deps = parse_zon_dependencies(zonpath)
    for name, url in deps:
        # Skip system-installed dependencies.
        # Also skip sentry and its dependencies, ghostty disables sentry by default on Linux.
        if name in SYSTEM_DEPS or name in SENTRY_AND_DEPS:
            continue

        print(f"Fetching {name}: {url}")

        try:
            subprocess.run(
                ["zig", "fetch", "--global-cache-dir", ZIG_VENDOR_DIR, url],
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
                check=True
            )
        except subprocess.CalledProcessError as e:
            print(f"Error: Command '{e.cmd}' failed with exit code {e.returncode}")
            if e.stderr:
                print(f"Details: {e.stderr.strip()}")
            continue

        p_dir = Path(ZIG_VENDOR_DIR) / "p"
        src_dir = next(p_dir.iterdir())
        dir_name = f"{name}-{src_dir.name}" if src_dir.name.startswith("N-V-") else src_dir.name
        dest = Path(ZIG_VENDOR_DIR) / dir_name
        if dest.exists():
            shutil.rmtree(src_dir)
        else:
            src_dir.rename(dest)

        sentry_example = dest / "tests/fixtures/sentry_example"
        if sentry_example.exists():
            sentry_example.unlink();

        if (dest / "build.zig.zon").is_file():
            fetch_deps(dest)


if __name__ == "__main__":
    shutil.rmtree(ZIG_VENDOR_DIR, ignore_errors=True)
    ZIG_VENDOR_DIR.mkdir(parents=True, exist_ok=True) 

    # root build.zig.zon
    fetch_deps()

    # upstream-vendored deps under pkg/
    for dep_path in Path("./pkg").iterdir():
        if dep_path.is_dir():
            fetch_deps(dep_path)

    # delete directories created by zig fetch
    for sub in ["p", "tmp"]:
        shutil.rmtree(ZIG_VENDOR_DIR / sub, ignore_errors=True)

    # delete binaries and HTML files
    extensions = {".exe", ".dll", ".chm", ".a", ".o", ".so", ".jar", ".html", ".info", ".texi"}
    for path in Path("./zig-vendor").rglob("*"):
        if path.suffix in extensions and path.is_file():
            path.unlink()
