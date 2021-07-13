// COMPONENTES DO GRUPO: Marco Antonio Borges Mateus 1721244,
//Pedro Antonio Tibau Velozo 1812013
//sss

%{
      #include <stdlib.h>
      #include <stdio.h>
      #include <string.h>
 
 // criação de uma variável para o retorno
 // conflito shift/reduce ( segunda linha da gramatica),
 // foi resolvido invertendo a ordem ( ID varlist para varlist ID)
 // criação do novo token newline para representar o \n
 // Ao criar ENQUANTO ID FACA cmds gerou um erro de shift/reduce, para concertar
 // foi aterado para ENQUANTO ID FACA cmds FIM
 // Ao rodar o teste tivemos o erro " malloc (): corrupted top size", para concertar
 // o erro adicionamos mais "espaço" ao malloc, com um valor arbitrário de 100

int yylex();
void yyerror(const char *s){
      fprintf(stderr, "%s\n", s);
   };
//Arquivo de saida.c
   FILE *f;
   

%}

%union
 {
   char *str;// Usado para definir os tokens do tipo str
   int  number;// Usado para definir os tokens do tipo number
};
// Declaração dos tokens
%type <str> program varlist varlistsaida cmds cmd;
%token <str> ID;// Declaracao da variavel
%token <str> NUM;// Numero
%token <number> ENQUANTO;// While
%token <number> FACA; // inicio aos comandos dos condicionais
%token <number> FOR; // for
%token <number> ENTRADA; // Entrada do programa
%token <number> SAIDA; // Retorno do programa
%token <number> END;  // Final do programa
%token <number> NEWLINE; // \n
%token <number> ENTAO; // Dentro do if
%token <number> SE;   // O if
%token <number> SENAO;// Else
%token <number> INC; // Incrementa a variavel em +1
%token <number> ZERA;// Zera a variavel
%token <number> FIM; // Indica o final dos comandos condicionais
%token <number> ASSIGN;// Sinal de igualdade (atribuicao)
%token <number> AP; // Abre parenteses
%token <number> FP; // Fecha parenteses
%token <number> MAIOR;// >
%token <number> MENOR;// <
%token <number> IGIG;// ==

%start program // variavel que "starta" o programa
%%
program: ENTRADA varlist SAIDA varlistsaida cmds END NEWLINE
{
  fprintf(f, "#include <stdio.h>\n");
  fprintf(f, "unsigned int CodigoObjeto (){ \n %s\n%s\n%s\n }\n", $2,$5,$4);
  fprintf(f,"int main(void){\n unsigned int resp = CodigoObjeto();\n printf(\"Resposta: %%u\",resp);\n return 0;\n}");
  fclose(f);
  printf("Programa executado.Nenhum erro encontrado.");
  exit(0);
};
varlist: varlist ID {
  char *entrada=malloc(strlen($1) + strlen($2) + 20);
  sprintf(entrada, "%s unsigned int %s;\n", $1, $2);
  $$ = entrada;
};
| ID {
    char *var = malloc(strlen($1) + 20);
    sprintf(var,"unsigned int %s;",$1);
    $$ = var;

};

| varlist ID ASSIGN NUM {
    char *var1 = malloc(strlen($1) + strlen($2) + strlen($4) + 20);
    sprintf(var1,"%s unsigned int %s = %s;",$1,$2,$4);
    $$ = var1;
};
cmds: cmds cmd {
          char *comandos=malloc(strlen($1) + strlen($2) + 1);
          sprintf(comandos, "%s%s\n", $1, $2);
          $$=comandos;
        };
        | cmd {
          char *comando=malloc(strlen($1) + 1);
          sprintf(comando, "%s", $1);
          $$=comando;
        };
cmd: ENQUANTO ID FACA cmds FIM{
        char *enquanto = malloc(strlen($2) + strlen($4) + 20);
        sprintf(enquanto, "while(%s) {\n\t%s}\n",$2,$4);
        $$ = enquanto;
        };
      | ENQUANTO ID IGIG ID FACA cmds FIM{
        char *enquanto1 = malloc(strlen($2) + strlen($4) + strlen($6) + 20);
        sprintf(enquanto1, "while(%s==%s) {\n\t%s}\n",$2,$4,$6);
        $$ = enquanto1;
        };
      | SE ID ENTAO cmds FIM{
        char *se = malloc(strlen($2) + strlen($4) + 15);
        sprintf(se, "if(%s) {\n\t%s}\n",$2,$4);
        $$ = se;
      };
      | SE ID MAIOR NUM ENTAO cmds FIM{
        char *se1 = malloc(strlen($2) + strlen($4) + strlen($6) + 15);
        sprintf(se1, "if(%s>%s) {\n\t%s}\n",$2,$4,$6);
        $$ = se1;
      };
      | FOR ID FACA cmds FIM{
        char *for1 = malloc(strlen($2) + strlen($4) + 15);
        sprintf(for1, "for(;%s;) {\n\t%s}\n",$2,$4);
        $$ = for1;
        };
      | FOR ID ID FACA cmds FIM{
        char *for2 = malloc(strlen($2) + strlen($3) + strlen($5) + 20);
        sprintf(for2, "for(%s;%s;) {\n\t%s}\n",$2,$3,$5);
        $$ = for2;
        };
      | FOR ID ID ID FACA cmds FIM{
        char *for3 = malloc(strlen($2) + strlen($3) + strlen($4) + strlen($6) + 20);
        sprintf(for3, "for(%s;%s;%s) {\n\t%s}\n",$2,$3,$4,$6);
        $$ = for3;
      };
      | FOR ID ASSIGN ID ID ID FACA cmds FIM{
        char *for4 = malloc(strlen($2) + strlen($4) + strlen($5) + strlen($6) + strlen($8)+ 20);
        sprintf(for4, "for(%s=%s;%s;%s) {\n\t%s}\n",$2,$4,$5,$6,$8);
        $$ = for4;
      };
      | FOR ID ASSIGN NUM ID ID FACA cmds FIM{
        char *for5 = malloc(strlen($2) + strlen($4) + strlen($5) + strlen($6) + strlen($8)+ 20);
        sprintf(for5, "for(%s=%s;%s;%s) {\n\t%s}\n",$2,$4,$5,$6,$8);
        $$ = for5;
      };
      | FOR ID ASSIGN NUM ID MENOR NUM INC AP ID FP FACA cmds FIM{
        char *for6 = malloc(strlen($2) + strlen($4) + strlen($5) + strlen($7) + strlen($10)+strlen($13) + 20);
        sprintf(for6, "for(%s=%s;%s<%s;%s++) {\n\t%s}\n",$2,$4,$5,$7,$10,$13);
        $$ = for6;
      };
      | SE ID ENTAO cmds SENAO cmds FIM{
        char *seEntao = malloc(strlen($2) + strlen($4) + strlen($6) + 25);
        sprintf(seEntao, "if(%s) {\n\t%s} else {\n\t%s }\n",$2,$4,$6);
        $$ = seEntao;
      };
      | ID ASSIGN ID{
        char *assign=malloc(strlen($1) + strlen($3) + 10);
        sprintf(assign, "%s = %s;\n",$1,$3);
        $$ = assign;
      };
      | ID ASSIGN NUM{
        char *assignN=malloc(strlen($1) + strlen($3) + 10);
        sprintf(assignN, "%s = %s;\n",$1,$3);
        $$ = assignN;
      };
      | INC AP ID FP{
        char *incrementa=malloc(strlen($3) + 10);
        sprintf(incrementa, "%s++;\n",$3);
        $$ = incrementa;
      };
      | ZERA AP ID FP{
        char *zera=malloc(strlen($3) + 10);
        sprintf(zera, "%s = 0;\n",$3);
        $$ = zera;
      };
varlistsaida: ID {
      char *var2 = malloc(strlen($1) +100);
      sprintf(var2,"return %s;",$1);
      $$ = var2;
};
%%

int main(int argc, char *argv[]){
    f = fopen("codObjeto.c", "w");
    if(f == NULL)
    {
        printf("Erro ao tentar abrir o arquivo.");
        exit(1);
    }
    yyparse();
    return(0);
}