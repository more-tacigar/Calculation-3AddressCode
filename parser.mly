%token<string> IDENTIFIER
%token<int> NUMBER
%token PLUS MINUS MULT DIV SEMI ASSIGN EOF

%left PLUS MINUS
%left MULT DIV

%start program
%type<Ast.program> program

%%

program
  : ass = separated_list(SEMI, assign_statement); EOF
    {
      Ast.Program (ass)
    }
  ;
assign_statement
  : id = IDENTIFIER; ASSIGN; e = expression
    {
      (id, e)
    }
  ;
expression
  : id = IDENTIFIER
    {
      Ast.Variable_expression (id)
    }
  | n = NUMBER
    {
      Ast.Number_expression (n)
    }
  | lhs = expression; PLUS; rhs = expression
    {
      Ast.Binary_operation_expression (lhs, Ast.Plus, rhs)
    }
  | lhs = expression; MINUS; rhs = expression
    {
      Ast.Binary_operation_expression (lhs, Ast.Minus, rhs)
    }
  | lhs = expression; MULT; rhs = expression
    {
      Ast.Binary_operation_expression (lhs, Ast.Mult, rhs)
    }
  | lhs = expression; DIV; rhs = expression
    {
      Ast.Binary_operation_expression (lhs, Ast.Div, rhs)
    }
  ;