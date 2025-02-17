---
note-type: knowledge
related: [[programming-paradigm]]
references:
    - [[book::clean-architecture]]
---

# Structured Programming

A [[programming-paradigm]] aims to avoid undisciplined direct control flow
(e.g., goto statements) and instead use structured control flow constructs
(e.g., loops, conditionals, functions) to improve code readability and
maintainability.

> Structured programming imposes discipline on direct transfer of control.
>
> - _Uncle Bob_

All programs can be constructed using only three control structures:

1. Sequence - execute statements in order
2. Selection - conditionals
3. Iteration - loops

But subroutines (functions, procedures, etc.) are also essential for
structuring code.

Structured programming forces us to decompose programs into smallet units. And
we can prove the correctness of each unit independently using
[[software-testing]]

## Example: Goto Statement vs. Structured Programming

Instead of:

```c
int main() {
    int i = 0;
    loop:
        if (i < 10) {
            printf("%d\n", i);
            i++;
            goto loop;
        }
    return 0;
}
```

Use:

```c
int main() {
    for (int i = 0; i < 10; i++) {
        printf("%d\n", i);
    }
    return 0;
}
```
