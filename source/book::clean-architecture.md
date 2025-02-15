---
note-type: source
status: wip
source-type: book
source-link: https://www.amazon.com/Clean-Architecture-Craftsmans-Software-Structure/dp/0134494164
---

# Book :: Clean Architecture

## Introduction

Getting a program to just work is not hard; getting it right is hard.

A "right" program one that is easy to create and maintain.

## What Is Design and Architecture

There is no difference between design and architecture.

> The goal of software architecture is to minimize the human resources required
> to build and maintain the required system.

There are interesting graphs in the 'the signature of a mess' subchapter

It seems that the author suggests that it is better develop a program 'right'
from the beginning. I'm not sure I agree. I think that common view that
architecture and other best practices are not so important in a startup.

I didn't find definitions of 'architecture' and 'design' in the chapter.

## A Tale of Two Values

Every software system provides two different values to the stakeholders:
behavior and structure.

- **Behavior** - making machines behave in a way that makes or saves money for
  the stakeholders.
- **Structure** - code organization, system architecture.

It is more important for the system to be easy to change than work

> - If you give me a program that works perfectly but is impossible to change,
>   then it won’t work when the requirements change, and I won’t be able to
>   make it work. Therefore the program will become useless.
> - If you give me a program that does not work but is easy to change, then I
>   can make it work, and keep it working as requirements change. Therefore the
>   program will remain continually useful.

Eisenhower's matrix:

1. Urgent and important
2. Not urgent and important
3. Urgent and not important
4. Not urgent and not important

Architecture is 1 or 2. Features are 1 or 3. It is important to separate those
features that are urgent but not important from those features that are urgent

The software team should fight for architecture with other stakeholders.

## Starting With the Bricks: Programming Paradigms

Just history stuff.

## Paradigm Overview

> Structured programming imposes discipline on direct transfer of control.

It means that structured programming is about avoiding `goto` statements and
using direct control flow constructs like `if`, `while`, `for`, etc.

Example:

Instead of:

```c
goto end;
...
end:
```

Use:

```c
if (condition) {
  ...
}
```

> Object-oriented programming imposes discipline on indirect transfer of
> control.

Determines which functions to call at runtime (dynamic dispatch).

Example:

Instead of:

```c
if (shape_type == CIRCLE) {
    draw_circle();
} else if (shape_type == RECTANGLE) {
    draw_rectangle();
}
```

Use:

```cpp
class Shape {
public:
    virtual void draw() = 0; // Abstract method
};

class Circle : public Shape {
public:
    void draw() override { /* Draw circle */ }
};

class Rectangle : public Shape {
public:
    void draw() override { /* Draw rectangle */ }
};

Shape* s = new Circle();
s->draw(); // Indirect control transfer via polymorphism
```

> Functional programming imposes discipline upon assignment.

Each paradims removes capabilities from a programmer. They tell us what **not**
to do more than what to do.
