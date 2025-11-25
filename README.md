# gitme

![Shell](https://img.shields.io/badge/shell-bash-1f425f.svg)
![Licence](https://img.shields.io/badge/licence-MIT-green.svg)
![Version](https://img.shields.io/badge/version-0.0.2-blue.svg)

`gitme` is a handy Bash function that lets you quickly jump to any of your
Git repositories by name or remote URL. It's perfect if you have dozens (or
hundreds) of repos spread across different directories.

## ✨ What it does

You give `gitme` a search string. It looks through all your Git repositories
in the directories you specify and, if it finds a match:

- If there's only one match, it changes to that directory.
- If there are multiple matches, it asks you to choose one.
- If there's no match, it tells you so.

## 🔧 Installation

Clone this repo and add the following to your shell config (`~/.bashrc`,
`~/.zshrc`, etc):

```bash
source /path/to/gitme/gitme.sh
```

If you have [`bash-completion`](https://github.com/scop/bash-completion)
installed, then `gitme` can make use of that to make things even easier. Just
add the following to your shell config file:

```
[[ -f /path/to/gitme/gitme-completion.bash ]] && source /path/to/gitme/gitme-completion.bash
```

> 💡 Replace `/path/to/gitme/` with the actual path to this repo on your machine.

Then reload your shell:

```bash
source ~/.bashrc   # or ~/.zshrc
```

## 📂 Config

`gitme` searches directories listed in the `GITME_DIRS` environment variable.
This should be a colon-separated list, like:

```bash
export GITME_DIRS="$HOME/code:$HOME/projects:$HOME/scratch"
```

If `GITME_DIRS` is not set, it defaults to:

```bash
$HOME/git
```

You can also customize the cache directory by setting `GITME_CACHE_DIR`:

```bash
export GITME_CACHE_DIR="$HOME/.gitme"  # default
```

## 🧪 Usage

```bash
gitme search-string
```

Examples:

```bash
gitme utils
gitme github.com/davorg
gitme my-project
```

## 🚀 Caching

`gitme` uses a cache to avoid scanning directories on every invocation, making
searches much faster. The cache is stored at `~/.gitme/cache` by default.

- The cache is **automatically built** on first use
- To **rebuild the cache** (e.g., after cloning new repos), run:

```bash
gitme --rebuild-cache
```

## 📘 Installing the man page

You can read the man page directly with:

```bash
man ./man/gitme.1
```

Or install it system-wide:

```bash
sudo cp man/gitme.1.gz /usr/local/share/man/man1/
sudo mandb
```

Alternatively, install it for just your user account:

```bash
mkdir -p ~/.local/share/man/man1
cp man/gitme.1.gz ~/.local/share/man/man1/
# (Optional) Add to your shell config:
# export MANPATH="$HOME/.local/share/man:$MANPATH"
```

## 💡 Features

- Matches both the **directory name** and the **remote.origin.url**
- Works across multiple base directories
- **Fast caching** for quick lookups
- Bash tab-completion for easy discovery
- Interactive selection if more than one match
- Written as a function so it can actually `cd` into the repo

## 🚀 Coming Soon?

Here are a few possible enhancements (pull requests welcome!):

- Optional `fzf`-powered fuzzy search
- Case-insensitive matching
- Support for multiple remotes, not just `origin`
- `gitme clone` helper for quick cloning into the right place

## 👤 Author

Dave Cross  
📍 [davorg](https://github.com/davorg)

---

This project is MIT licensed. Use it, share it, improve it.
