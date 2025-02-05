---
note-type: source
status: wip
source-type: repo
source-link: https://github.com/mxschmitt/action-tmate
related:
    - [[root-note]]
---

# Repo :: Github Action Tmate

Debug your GitHub Actions via SSH by using tmate to get access to the runner
system itself.

```yaml
name: CI
on: [push]
jobs:
    build:
        runs-on: ubuntu-latest
        steps:
            - uses: actions/checkout@v4
            - name: Setup tmate session
              uses: mxschmitt/action-tmate@v3
```
