This is a test file for checking the correct working grammar of markdown.

The first type is inline formats, including **bold**, *italic*, `inline code`, ==highlight==, ~~strikethrough~~, $inline formula$  and also the <u>underline</u>. The signal also need to test like ^1^~1~.

---

After that, the block components:

## Quote

> quote
> 
> multiple line

## Code Fences

```go
code fences
log.print("go working.")
```

## Math Block

$$
Latex \\
Math\ Block
$$

## Table

| Header Key            | Description or Value |
| --------------------- | -------------------- |
| The table key like id | and the value.       |

## Comment

<!--Comment-->

## Link References and Footnotes

Link References[^1]

[1]: Link Reference

Footnotes,

[^1]: Footnotes

## List

1. ordered list
2. the part 2
   1. the 2.1


- unordered list
- another one
  - and different level.

- [ ] task list
- [x] finished



