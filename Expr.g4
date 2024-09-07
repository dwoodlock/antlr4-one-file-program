grammar Expr;

prog:   stat+ ; 

stat:   expr NEWLINE                
    |   ID Equals expr NEWLINE        
    |   NEWLINE                   
    ;

expr:   expr (Asterisk|Divide) expr   
    |   expr (Plus|Minus) expr   
    |   INT                    
    |   ID                    
    |   LeftParens expr RightParens         
    ;

Equals 	: '=';
Plus		: '+';
Minus		: '-';
Asterisk			: '*';
Divide : '/';
LeftParens : '(';
RightParens : ')';

ID  :   [a-zA-Z]+ ;      // match identifiers <label id="code.tour.expr.3"/>
INT :   [0-9]+ ;         // match integers
NEWLINE:'\r'? '\n' ;     // return newlines to parser (is end-statement signal)
WS  :   [ \t]+ -> skip ; // toss out whitespace


