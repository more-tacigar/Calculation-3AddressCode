class temp_variable_generator = object(self)
  val mutable current_number = 0
  method current =
    self#generate_variable_name current_number
  method generate =
    current_number <- current_number + 1;
    self#generate_variable_name current_number
  method private generate_variable_name number =
    "__tmp" ^ (string_of_int number)
end

let translate program =
  let buffer = Buffer.create 100 in
  let generator = new temp_variable_generator in
  let rec translate_expression = function
    | Ast.Variable_expression (id) ->
       let temp = generator#generate in
       Buffer.add_string buffer temp;
       Buffer.add_string buffer " = ";
       Buffer.add_string buffer id;
       Buffer.add_char buffer '\n'
    | Ast.Number_expression (n) ->
       let temp = generator#generate in
       Buffer.add_string buffer temp;
       Buffer.add_string buffer " = ";
       Buffer.add_string buffer (string_of_int n);
       Buffer.add_char buffer '\n'
    | Ast.Binary_operation_expression (lhs, op, rhs) ->
       translate_expression lhs;
       let current1 = generator#current in
       translate_expression rhs;
       let current2 = generator#current in
       let temp = generator#generate in
       let opstr = match op with
         | Ast.Plus  -> " + "
         | Ast.Minus -> " - "
         | Ast.Mult  -> " * "
         | Ast.Div   -> " / "
       in
       Buffer.add_string buffer temp;
       Buffer.add_string buffer " = ";
       Buffer.add_string buffer current1;
       Buffer.add_string buffer opstr;
       Buffer.add_string buffer current2;
       Buffer.add_char buffer '\n'
  in
  begin
    match program with
    | Ast.Program (assign_statements) -> 
       List.iter (fun assign_statement ->
           translate_expression (snd assign_statement);
           let current = generator#current in
           Buffer.add_string buffer (fst assign_statement);
           Buffer.add_string buffer " = ";
           Buffer.add_string buffer current;
           Buffer.add_char buffer '\n') assign_statements
  end;
  buffer
               
let main () =               
  let filename = Sys.argv.(1) in
  let lexbuf = Lexing.from_channel (open_in filename) in
  let program = Parser.program Lexer.read lexbuf in
  let result = translate program in
  print_string (Buffer.contents result)

let () = main ()
