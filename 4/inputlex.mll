{
    open Inputgram 
    open Lexing 
    
    exception SyntaxError of string 

    let next_line lexbuf = 
     let pos = lexbuf.lex_curr_p in
     lexbuf.lex_curr_p <-
    {   pos with pos_bol = lexbuf.lex_curr_pos;
            pos_lnum = pos.pos_lnum + 1
    }
}

let white = [' ' '\t']+
let nums = '0' | ['1' - '9']['0'-'9']*
let newline = '\r' | '\n' 

rule token = parse 
| white { token lexbuf }
| newline {next_line lexbuf; token lexbuf} 
| nums as i { INT (int_of_string i)}
| "," {COMMATOK}
| "-" {HYPHENTOK}
| eof { EOF }
| _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf))}
