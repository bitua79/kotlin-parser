grammar proj;
start: statement*EOF;
statement: imports
    |defineVars
    |loops
    |class_statements
    |conditions
    |exceptions
    |methods
    |prints
    |expression;

WS:[ \t\n\r]+ -> skip;
CMT1: '/*' .* '*/' -> skip;
CMT2: '//' ~[\r\n]* -> skip;

///import *******************************************************************************************
imports:
    ('import'
            (LIB1|LIB2|CLASSFIELD|NAME)';'
    )

    |('from '
            (LIB1|NAME|CLASSFIELD)
     'import'
            ((LIB2|NAME|CLASSFIELD)(','))* (LIB2|NAME|CLASSFIELD|'*') ';'
      );


///define variable *******************************************************************************************
defineVars:
    ((ACCESS_MODIFIER)?'var'
            ((dfnVariable','dfnArray)|(dfnArray','dfnVariable)|dfnArray|dfnVariable)';'
    )

    |(ACCESS_MODIFIER)?('const' variD '='
        (init_value
        |'Array' '('
                (init_value ',' )*init_value
                ')'
        )';'
    )
    ;

dfnVariable:
    (variD ':'data_type
        ('=' init_value)?','
    )*

    (variD ':' data_type
        ('=' init_value)?
    )
    ;

dfnArray:
    variD ':' 'new' 'Array'  data_type?  '('INTV')'
    ('=' 'Array' '('
            (init_value ',' )*init_value')'
    )?
    ;


///loops *******************************************************************************************
loops:whiles|dowhiles|fors;
fors:
    'for''('
            ((initialize  ';'condition';'  (var in_decrease_operators))
             |(('var')?variD'in'variD))
         ')''{'
                statement*
         '}'
    ;

whiles:
    'while''('condition')'
    '{'
        statement*
    '}'
    ;

dowhiles:
    'do''{'
        statement*
     '}''while''('condition')'
     ;


///class *******************************************************************************************
class_statements:
    class
    |class_constructor
    |(('this''.'variD)|CLASSFIELD) '=' (regex|(var|init_value))';'
    |(ACCESS_MODIFIER)?('var'|'const') variD ':'
        'new' variD '('
                     (((var|init_value)',')*(var|init_value))?
                    ')'';'
    |class_regex';'
    ;

class:
    'class'variD ('extends' variD)?
        ('implements' variD
            ('with' variD)*
        )?
    '{'
        statement*
    '}'
    ;

class_regex:
    CLASSFIELD
    |variD
    |class_regex'.'class_regex
    |method_call
    |CLASSFIELD '('((CLASSFIELD|var|init_value',')*(CLASSFIELD|var|init_value))?')'
    ;


class_constructor:
    variD '('
            (data_type variD
                    ('=' (var|init_value))?','
            )*data_type variD('=' (var|init_value))?
          ')'
    '{'
          statement*
     '}'
    ;


///conditions *******************************************************************************************
conditions:ifs|switches;
ifs:
    'if''(' condition ')''{'
        statement*
    '}'

    ('elif''('condition')''{'
        statement*
     '}'
    )*

    ('else''{'
        statement*
     '}'
    )?
    ;


switches:
    'switch''('variD')''{'
        ('case'(init_value|STRV)':'
            statement*
                ('break'';')?
        )*

        ('default:'
            statement*
                ('break'';')?
        )?
    '}'
    ;


///exception *******************************************************************************************
exceptions:
    'try''{'
        statement*
    '}'
    (
        ('on'variD
            ('catch''('variD')')?'{'
                statement*
             '}'
        )
        |('catch''('variD')''{'
            statement*
         '}'
         )
    )+
    ;


///methods *******************************************************************************************
methods:
    (ACCESS_MODIFIER)? (data_type|'void') variD
        '('
            ((data_type variD',')*(data_type variD))?
         ')''{'
            statement*
        '}'
    |(ACCESS_MODIFIER)?variD
        '('
            ((data_type variD',')*(data_type variD))?
         ')''{'
            statement*
        '}'
    ;

method_call:
    (variD)'('((var',')*var)?')'
    ;


///print *******************************************************************************************
prints:
    'print''('
        ((variD|init_value|regex)',')*?
        (init_value|variD|regex)
    ')'';'
    ;


///String Interpolation *******************************************************************************************
strpol:'"'('\\"' |.~('"')~(';')* |('$''{'regex+'}'))+'"' ;

///used parsers *******************************************************************************************
condition:
    BOOLV
    |regex
    |(regex compare_operators regex)
    ;

data_type:
    Boolean
    |Integer
    |DoubleType
    |String
    |Character
    |Array
    ;

init_value:
    BOOLV
    |strpol
    |STRV
    |CHARV
    |INTV
    |DBLV
    ;

var:
    ID
    |NAME
    |INTV
    |DBLV
    |class_regex
    ;

variD:
    ID
    |NAME
    ;

initialize:
    variD '=' (regex|init_value)
    ;

expression:
    regex';'
    |(var
        (Assign | '=')
        regex';'
    )
    |('return' regex ';')
    |variD'='STRV';'
    ;

in_decrease_operators:
    Increase
    | Decrease
    ;

bit_operators:
     Rsft
    | Lsft
    |Orbit
    | Andbit
    | Xor
    ;

logical_operators1:
    '*'
    | Divd
    | Divdfloor
    | Rmind
    ;


logical_operators2:
    Pls
    | Neg
    ;

compare_operators:
    Eq
    | Neq
    | Neq2
    | Gt
    | Lt
    | Let
    | '>='
    ;

logic_operators:
    And
    | Or
    | Not
    ;

regex:
    LP regex RP
    |regex '**' regex
    | Cmp regex
    | (Neg|Pls) regex

    | regex in_decrease_operators | in_decrease_operators regex
    | regex logical_operators1 regex
    | regex logical_operators2 regex
    | regex bit_operators regex
    | regex compare_operators regex
    | regex logic_operators regex
    | method_call
    | class_regex
    | variD
    |var
    ;



///lexers ******************************************************************************************

ACCESS_MODIFIER:('public'|'private'|'protected')' '*('final')?' '*('static')?;

CLASSFIELD:( (ID|NAME)+('.') )+?  (NAME|LETTERS);

LIB1:(NAME+('.'))+(NAME|'*');
LIB2:(LIB1|NAME+(' '*'=>'' '*)NAME'=>'NAME);

BOOLV: 'true' | 'false';
INTV : ('-')? DIGITS+ ;
DBLV:('-')? ([0-9]+   |   [0-9]*('.')[0-9]+('e'('-')?[0-9]+)?);
STRV: '"' (~["\\\r\n${}] | '\\' [btnfr"'\\])* '"';
CHARV:'\''LETTERS'\'' ;

Boolean: 'Boolean';
Integer : 'Int';
DoubleType:'Double';
String:'String' ;
Character:'Char' ;
Array:'Array';

NAME: LETTERS+LETTERS+;
LETTERS:[A-Za-z];
DIGITS:[0-9];
ID: [a-zA-Z_$]+[a-zA-Z_$0-9]+;

SIMCLM:';';

LBlk:'{';
RBlk:'}';
LP:'(';
RP:')';

Cmp:'~';
Increase:'++';
Decrease:'--';

Divd:'/';
Divdfloor:'//';
Rmind:'%';

Andbit:'&';
Orbit:'|';
Xor:'^';

Neg:'-';
Pls:'+';

Rsft:'>>';Lsft:'<<';

And:'&&';
Or:'||';
Not:'!';

Eq:'==';
Neq:'!=';
Neq2:'<>';

Gt:'>';
Lt:'<';
Let:'<=';

Assign:'='|'+='|'-='|'**='|'*='|'/='|'//='|'%='|'>>='|'<<='|'^='|'&='|'|=';
