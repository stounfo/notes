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

**Structured Programming**

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

**Object-Oriented Programming**

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

**Functional Programming**

> Functional programming imposes discipline upon assignment.

Example:

Instead of:

```python
numbers = [1, 2, 3, 4]
for i in range(len(numbers)):
    numbers[i] *= 2  # Mutates the original list

print(numbers)  # Output: [2, 4, 6, 8]
```

Use:

```python
numbers = [1, 2, 3, 4]
doubled_numbers = list(map(lambda x: x * 2, numbers))  # No mutation

print(numbers)         # Output: [1, 2, 3, 4] (unchanged)
print(doubled_numbers) # Output: [2, 4, 6, 8]
```

Each paradims removes capabilities from a programmer. They tell us what **not**
to do more than what to do.

All this paradigms are useful on architecture level.

**Polymorphism and Architectural Boundaries**

A Service Interface that different implementations (e.g., local vs. cloud
storage) can use without changing the client code

**Functional Programming and Data Management Discipline**

Using immutable data structures in a system ensures that data flows in a
predictable, controlled manner rather than being modified unpredictably across
the codebase.

**Structured Programming as the Algorithmic Foundation**

A well-structured function that processes a request in a REST API should have
clear input, processing, and output phases.

## Structured Programming

All programs can be constructed using only three control structures:

1. Sequence - execute statements in order
2. Selection - conditionals
3. Iteration - loops

But subroutines (functions, procedures, etc.) are also essential for
structuring code.

Sturctured programming help modules to be decomposed into smaller units.

Scientific theories and laws can't be proven correct as opposed to mathematical
theorems. Science does not work by proving things correct, but by proving them
incorrect.

Similarly, testing helps to prove that a program is incorrect, but not that it
is correct.

Structured programming forces us to decompose program into a set of small
provable units. And we can use testing to prove that those units are correct.

At every level, from the smallest function to the largest component, software
is like a science and, therefore, is driven by falsifiability

## Object-Oriented Programming

Some folks say OO - a proper mix of encapsulation, inheritance, and
polymorphism

**Encapsulation**

Encapsulation is about combining a cohesive set of data and functions within a
single unit and hiding implementation details from the rest of the system.

In C, encapsulation is better than in C++ or Java. For this reason, OO doesn't
depend on strong encapsulation.

**Inheritance**

Inheritance is the redeclaration of a group of variables and functions within
an enclosing scope.

Inheritance existed a long before OO languages.

New languages didn't add something new to inheritance. They just made it more
convenient.
