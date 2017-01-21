type identifier = string
and program =
  | Program of (identifier * expression) list
and expression =
  | Variable_expression of identifier
  | Number_expression of int
  | Binary_operation_expression of expression * binary_operator * expression
and binary_operator =
  | Plus | Minus | Mult | Div
