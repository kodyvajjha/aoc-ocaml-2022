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
let letters = 'A' | 'B' | 'C' | 'X' | 'Y' | 'Z'
let newline = '\r' | '\n' 

rule token = parse 
| white { token lexbuf }
| newline {next_line lexbuf; token lexbuf} 
| 'A' {OPPROCKTOK}
| 'B' {OPPPAPERTOK}
| 'C' {OPPSCISSTOK}
| 'X' {PLAROCKTOK} 
| 'Y' {PLAPAPERTOK} 
| 'Z' {PLASCISSTOK}
| eof { EOF }
| _ { raise (SyntaxError ("Unexpected char: " ^ Lexing.lexeme lexbuf))}
