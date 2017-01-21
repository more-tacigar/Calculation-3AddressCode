{
  exception Syntax_error of string
}

let int = ['1'-'9']['0'-'9']*
let identifier = ['a'-'z' 'A'-'Z' '_'] ['a'-'z' 'A'-'Z' '0'-'9' '_']*

rule read = parse
  | '+' { Parser.PLUS }
  | '-' { Parser.MINUS }
  | '*' { Parser.MULT }
  | '/' { Parser.DIV }
  | '=' { Parser.ASSIGN }
  | ';' { Parser.SEMI }
  | eof { Parser.EOF }
  | int { Parser.NUMBER (int_of_string (Lexing.lexeme lexbuf)) }
  | [' ' '\009' '\012' '\n']+ { read lexbuf }
  | identifier { Parser.IDENTIFIER (Lexing.lexeme lexbuf) }
  | _ { raise (Syntax_error ("Unexpected char: " ^ (Lexing.lexeme lexbuf))) }
