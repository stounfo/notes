---
note-type: knowledge
related:
    - [[about-these-notes]]
references:
    - [[article::andymatuschak-evergreen-notes]]
    - [[article::the-mkalvas-entry-point]]
---

# Knowledge Note

Notes that contain knowledge about a specific idea. Each note should contain
only one idea. Over time, they will be rewritten if knowledge is updated or new
information appears.

Each note should have related notes that are connected to the main idea of the
note. If there are no relevant related note, the note should be a connected to
the [[root-note]]

It should also have references to the source notes that were used to create the
knowledge note.

## Motivation

- Need a place for polished, valuable information.

## Workflow

1. Create a knowledge note.
2. Identify related knowledge notes and add them to the `related` section.
3. Identify source notes used to create the knowledge note and add them to the
   `references` section.
4. Identify other knowledge notes that could list the current note as a related
   note and add it to their `related` section.
5. Write the note
6. Review the note, consider splitting the note if it covers multiple ideas.

## Implementation

Each note is stored as a Markdown file with a unique name.

- File name format: `{brief-description}.md` (in kebab-case).
- Main heading format: `{brief-description}` (in Title Case).

All notes should be placed in the `knowledge/` folder.

Use the `#todo` tag to mark sections that need fixing. It can be placed anywhere
in the note.

### Structure

```
---
note-type: knowledge
related:
    - [[root-note]]
    - [[root-note]] some optional info
references:
    - [[root-note]]
    - [[root-note]] some optional info
---
# Note Name

Content of the note.
```

**note-type** - The note’s type. `knowledge` for Knowledge.

**related** - Links to other [[knowledge-note|knowledge notes]] that are related
to the current note.

**references** - Links to [[source-note]] that serve as sources for the current
note.

**content** - The main body of the note. It can include anything.
