---
related:
    - "[[Python]]"
---

# Awesome Python Code Snippets And Tips

## Better way to read/write file

```python
# Default way
with open("./text_file", "w") as f:
    f.write("some text")
with open("./text_file", "r") as f:
    file_content = f.read()

# Better way
import pathlib
pathlib.Path("./text_file").write_text("some text")
file_content = pathlib.Path("./text_file").read_text()
```
