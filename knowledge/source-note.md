---
note-type: knowledge
related:
    - [[about-these-notes]]
references:
    - [[article::andymatuschak-evergreen-notes]]
    - [[article::the-mkalvas-entry-point]]
---

# Source Note

Firstly this is an inbox for all incoming information, including notes about
books, articles, personal thoughts, bookmarks to read later. Essentially, any
information that should be captured for processing at a later time. It is
inspired by Zettelkasten's fleeting and literature notes.

Secondly it is a repository for all references used in my [[knowledge-note]].

Some quick notes can also go here. They are not meant to be processed into a
[[knowledge-note]].

Each note should have related notes that are connected to the main idea of the
note. If there are no relevant related note, the note should be a connected to
the [[root-note]]

## Motivation

- Avoid losing potentially valuable information.
- Protect [[knowledge-note|knowledge notes]] from being cluttered with
  unprocessed content.

## Workflow

1. Capture information. The format doesn't matter, but add a brief description
   in the content session.
2. Add related notes if necessary.
3. Review the note when there is time.
4. If it’s valuable, process it into a [[knowledge-note]].
5. Mark the note as done.
6. If it’s not useful, simply mark it as done.

## Implementation

Each note is stored as a Markdown file with a unique name.

- File name format: `{source-type}::{brief-description}.md` (in kebab-case).
- Main heading format: `{source-type} :: {brief-description}` (in Title Case).

All notes should be placed in the `source/` folder.

Use the `#todo` tag to mark sections that need fixing. It can be placed
anywhere in the note.

### Source types

- **book**: Notes about books.
- **article**: Notes about articles.
- **thought**: Personal thoughts.
- **repo**: Notes about repositories with source code on GitHub, GitLab, etc.
- **spec**: Notes about specifications.
- **video**: Notes about videos.
- **podcast**: Notes about podcasts.
- **app**: Notes about interesting applications. These can be web, mobile, or
  desktop application.
- **wiki**: Notes about Wikipedia articles.

### Structure

```
---
note-type: source
status: wip | done
source-type: book | article | thought | etc
source-link: https://example.com
---

# Article :: Brief Description

Content of the note.
```

**note-type** - The note’s type. For source notes, it should be `source`.

**status** - The note’s status:

- `wip` - Default for newly created notes; means the note is not yet processed
  or requires further review.
- `done` - The note is processed or no longer requires further action.

**source-type** - The type of the source. Based on [[#Source types]]

**source-link** - An external source link, if available.

**Content** - The main body of the note. It can include anything.
