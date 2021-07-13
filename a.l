/* COMPONENTES DO GRUPO:Marco Antonio Borges Mateus 1721244,*/
/*Pedro Antonio Tibau Velozo 1812013 */

%option yywrap
      #include <stdio.h>
      #include <string.h>
      #include "a.tab.h"
%%
[E|e][N|n][D|d]         return(END);
[S|s][A|a][I|i][D|d][A|a]       return(SAIDA);
[E|e][N|n][T|t][R|r][A|a][D|d][A|a]     return(ENTRADA);
[E|e][N|n][Q|q][U|u][A|a][N|n][T|t][O|o]    return (ENQUANTO);
[F|f][A|a][C|c][A|a]        return (FACA);
[F|f][O|o][R|r]          return (FOR);     
[S|s][E|e]          return(SE);
[E|e][N|n][T|t][A|a][O|o]       return(ENTAO);
[S|s][E|e][N|n][A|a][O|o]       return(SENAO);
[Z|z][E|e][R|r][A|a] 		return(ZERA);
[I|i][N|n][C|c] 		return(INC);
[F|f][I|i][M|m]		return(FIM);
\n		return(NEWLINE);
">"         return (MAIOR);
"<"         return (MENOR);
"=="        return (IGIG);
"=" 		return(ASSIGN);
"(" 		return(AP);
")"		return(FP);
[0-9]+      {yylval.str=strdup(yytext);return NUM;}
[a-zA-Z]+   {yylval.str=strdup(yytext);return ID;}
