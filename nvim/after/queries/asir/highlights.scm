[
  "localf"
  "module"
  "end"
  "quit"
  "endmodule"
  "local"
] @keyword


"return" @keyword.return

[
  "while"
  "for"
  "do"
  "continue"
  "break"
] @repeat

[
  "if"
  "else"
] @conditional

[
  "="

  "-"
  "*"
  "/"
  "+"
  "%"
  "^"

  "<"
  "<="
  ">="
  ">"
  "=="
  "!="

  "!"
  "&&"
  "||"

  "-="
  "+="
  "*="
  "/="
  "%="
  "^="
  "--"
  "++"
] @operator

[
  "def"
] @keyword.function

(atom) @number

(comment) @comment

(variable) @variable

(def_statement
  (function) @function)

(string_literal) @string

(escape_sequence) @string.escape

"#define" @constant.macro
"#include" @include

