+++
contentType = "md"
weight = 10
+++

---
layout: false
.left-column[
  ## Shell ou bash???
]
.right-column[
_Shell_ é o nome comumente dado ao interpretador de comandos num sistema
operacional.  (É onde os usuários digitam comandos ao abrir um terminal).

A maioria das distribuições Linux vem com o _bash_ como o shell default.
Vários outros shells estão disponíveis (fish, zsh, tcsh, ksh, etc). O foco
deste documento é no bash em particular.

Estes _slides_ contém algumas dicas para tornar o uso diário do bash mais fácil
e produtivo. O objetivo deste documento é tornar o uso da linha de comando mais
confortável para usuários iniciantes em Linux.

O domínio da linha de comando, é essencial para sysadmins e desenvolvedores
trabalhando no ambiente Linux/Unix.
]
---
.left-column[
  ## Arquivos de configuração
]
.right-column[
- Grande parte dos comandos de configuração pode ser digitada diretamente na _prompt_ do
  bash.

- Observe que configurações feitas dessa maneira **não sobrevivem ao final da
  sessão** e teriam que ser refeitas em cada janela, o que obviamente não é
  o comportamento desejável na maioria dos casos.

- Para tornar as configurações permanentes, edite o arquivo `~/.bashrc` (um dos
  arquivos de inicialização do bash) e insira os comandos naquele arquivo
  (normalmente, no final). Para iniciantos, o `nano` é um editor simples e
  intuitivo.
]
---
.left-column[
  ## VISUAL & EDITOR
]
.right-column[
Vários comandos abrem um editor por default. Para especificar o editor a ser
usado, use as variáveis de ambiente `VISUAL` e `EDITOR`.

Em alguns casos, `VISUAL` é o primeiro a ser tentado, e em caso de falha,
`EDITOR` é tentado. Recomendação: Configure as duas variáveis apontando para o
seu editor preferido

Execute os seguinte comandos:

```
echo '# Editor default' >>~/.bashrc
echo 'export EDITOR="nano"' >>~/.bashrc
echo 'export VISUAL="nano"' >>~/.bashrc
```

Para verificar, abra outro terminal e digite `echo $VISUAL`. A string `nano` deverá ser
mostrada.
]
---
class: center, middle, inverse

# Command History
## (Histórico de comandos)
---
.left-column[
  ## Histórico de comandos
]
.right-column[
Todos (ou quase todos) os comandos digitados são automaticamente armazenados no
arquivo `~/.bash_history`.

Quando digitamos seta-para-cima para recuperar o comando anterior, o bash está
retornando comandos armazenados no histórico de comandos.

É também possível usar o comando `history` para visualizar o que está guardado
no histórico até o momento:

Ex:

```plain
$ history
1  nano ~/.bashrc
2  echo $VISUAL
3  ls -l
```

**Dica**: Para executar um comando diretamente do prompt pelo número. Digite
`!n` onde `n` é o numero do comando no histórico.
]
---
.left-column[
  ## Histórico de comandos
  ### Buscando comandos
]
.right-column[
### A maneira mais óbvia

Usar `history` e filtrar apenas o que se deseja usando `grep`:
```text
$ history | grep "cd"
1  cd /tmp
5  cd
6  cd /home/meh/github/abc
9  vi cdcase.txt
```

E então usar o comando `!n` para executar o comando desejado.

### Uma maneira melhor
* Digite `Ctrl-R` (ativa a função de busca interativa reversa no histórico)
* Digite parte do comando a buscar.
* `Ctrl-R` novamente busca a próxima ocorrência.
* Para executar o comando mostrado, digite `Enter`.
]
---
.left-column[
  ## Histórico de comandos
  ### Buscando comandos
  ### Aumentando o histórico
]
.right-column[
Na configuração default, o histórico é relativamente pequeno (500 entradas). Para aumentar o tamanho do histórico,
adicione as seguintes linhas do seu `~/.bashrc`:

```
export HISTFILESIZE=100000
export HISTSIZE=$HISTFILESIZE
```

Isso aumentará o tamanho do histórico no disco e em memória para 100.000 entradas.

É também possível adicionar _timestamps_ ao histórico. Com isso, o comando
`history` passa a exibir a data e hora que um determinado comando foi
executado. Adicione ao seu `~/.bashrc`:

```
export HISTTIMEFORMAT='+%Y-%m-%d %H:%M:%S: '
```

Abra um novo terminal e experimente usar o comando `history` novamente.
]

---
.left-column[
  ## Histórico de comandos
  ### Buscando comandos
  ### Aumentando o histórico
  ### Compartilhando o histórico
]
.right-column[
O histórico em memória só é salvo automaticamente no final de cada
sessão (quando o terminal é fechado). Com isso, os comandos de uma sessão só
ficam disponíveis para outras sessões quando a sessão se encerra (ex: `Ctrl-D`,
`exit`, etc).

Dica: Crie um _alias_ (chamado `hr`) que adiciona o histórico da sessão corrente
ao histórico em disco, recarregando em seguida o histórico de todas as sessões.

Edite o seu `~/.bashrc` e adicione:

```bash
alias hr='history -a; history -c; history -r'
```

Digite `hr` em cada sessão que onde precise compartilhar ou ler um histórico
compartilhado imediatamente.  O histórico continuará sendo salvo ao final da
sessão, normalmente.
]

---
class: center, middle, inverse

# Digitando menos
## (e fazendo mais)
---

.left-column[
  ## Digitando menos
  ### Usando as setas
]
.right-column[
Para rever os comandos anteriores no histórico, use `seta-para-cima` (ou
`Ctrl-P`). É possível navegar pelo histórico com `seta-pra-baixo` (ou `Ctrl-N`)
nesse modo.

Para achar um comando no histórico, use `Ctrl-R` (conforme mencionado anteriormente).

## Simplificando a busca

Adicione
os comandos abaixo ao arquivo `~/.inputrc` (atenção, não `~/.bashrc`! Crie o arquivo se
não existir):

<code class="javascript hjls remark-code">
"\e&#91;A": history-search-backward</code><br>
<code class="javascript hjls remark-code">
"\e&#91;B": history-search-forward
</code>

Com essa configuração, é possível iniciar um comando e usar `seta-para-cima` e
apenas os comandos no histórico começando com o string já digitado serão
mostrados.
]

---
.left-column[
  ## Digitando menos
  ### Usando as setas
  ### Designadores de eventos
]
.right-column[
O bash reconhece uma série de _Event Designators_, que são referências a um
comando digitado anteriormente. Existem diversos designadores e diversos
"modificadores". Os de uso mais comum:

* `!n` Expande para o comando número _n_ no histórico (ex: `!5`).

* `!!` Expande para o último comando digitado. Uso comum: Depois do comando
  digitado, descobre-se que é preciso rodar o comando com `sudo`. Neste caso,
  basta usar `sudo !!` para repetir o comando. Pode ser usado diretamente para
  repetir o último comando.

* `!string` Expande para o comando mais recente iniciando pelo string desejado.
  Ex: para repetir a última linha de compilação usando o gcc (supondo que uma
  exista no seu histórico): `!gcc`

]

---
.left-column[
  ## Digitando menos
  ### Usando as setas
  ### Designadores de eventos
  ### Mais designadores
]
.right-column[
* `^str1^str2^` Troca o string `str1` por `str2` no último comando a
  re-executa. Ex: Um comando foi digitado incorretamente: `ls /tmp/foo`, mas o
  correto seria `ls /tmp/bar`. Nesse caso, basta digitar `^foo^bar^`

Existem também designadores de palavras que permitem que certas palavras dentro
de um comando sejam extraídas, e "modificadores", que modificam o comportamento
das expansões. Exemplos práticos:

* `!!:$` Expande para a última palavra no comando anterior. Ex: Logo apos usar
  `cat arquivoX` pode-se usar `cp !!:$ /tmp` para copiar o `arquivoX` (última
  palavra do comando anterior) para `/tmp`.

A lista de possibilidades é grande. Consulte o _man page_ do bash (`man bash`)
e procure por _Event Designators_ para maiores detalhes.  ]

---
.left-column[
  ## Digitando menos
  ### Usando as setas
  ### Designadores de eventos
  ### Mais designadores
  ### Tab completion
]
.right-column[
A tecla `Tab` completa o arquivo começando com o string já digitado.  Exemplo:
`md5sum photos_1<tab>` vai listar todos os arquivos no diretório corrente
começando com `photos_1`.

### Melhorias

Edite o seu arquivo `~\.inputrc` e adicione as seguintes linhas:

```text
set show-all-if-ambiguous on
set completion-ignore-case On
set colored-completion-prefix on
```

Isso causa a tecla `Tab` mostrar todos os casos que podem ser completados,
ignorar maíusculas e minúsculas nos arquivos e mostrar o prefixo já digitado
com cores diferentes.

Nota: O bash possui um sistema complexo chamado _Programmable Completion_ que
adiciona inteligência à tecla Tab. Consulte a _man page_ do bash (`man bash`)
para maiores detalhes.

]

---
.left-column[
  ## Digitando menos
  ### Usando as setas
  ### Designadores de eventos
  ### Mais designadores
  ### Tab completion
  ### Outras pérolas
]
.right-column[
* Comando ficando muito complicado para editar na linha de comando? Digite
  `Ctrl-X` `Ctrl-E` e o bash abrirá o comando atual no editor de textos
  especificado na variável `$VISUAL`. O comando será executado ao sair do
  editor.

* No meio da digitação de um comando longo que quer salvar, mas não quer
  executar agora? Digite `<ESC>#` a qualquer ponto e o bash adicionará um
  caracter de comentário (`#`) na frente do comando e o salvará no histórico
  para uso posterior.

* Precisa de ajuda rápida em um comando interno mas não tem tempo de ler o _man page_
  inteiro? Use o comando `help`. Exemplo: `help history`.

* Precisa voltar para o diretório anterior mas não quer digitar o nome
  completo? Basta usar o comando `cd -` para mudar o diretório para o último
  diretório visitado.
]

---
.left-column[
  ## Push & Pop
]
.right-column[
* Os comandos `pushd` e `popd` oferecem alternativas mais poderosas ao comando `cd`.

* Tal como `cd`, `pushd` muda o diretório corrente, mas guarda o diretório numa lista
  de diretórios visitados.

* O comando `popd` permite voltar ao diretório anterior na lista.

* Quando chamado sem argumentos, o comando `pushd` muda o diretório corrente
  entre os os dois diretórios no topo da lista, alternadamente. Isso permite
  trabalhar entre dois diretórios de forma conveniente.

* O comando `dirs -p` mostra uma lista de diretórios memorizados.

**Atenção**: Não é possível usar o comando `pushd -` para retornar ao diretório anterior.
]

---
.left-column[
  ## Push & Pop
  ## Usando o pushd
]
.right-column[
Sem dúvida, é mais fácil e conveniente digitar `cd` do que `pushd`. Uma solução para este problema
é criar uma função chamada `cd` que utiliza o comando `pushd` internamente:

Edite o arquivo `~/.bashrc` e adicione:

```bash
function cd() {
  local dir="$1"
  if [[ "$dir" == "-" ]]; then
    pushd
    return
  fi
  [[ -z "$dir" ]] && dir="$HOME"
  command pushd "$dir"
}
```

Com essa função definida, é possível usar o comando `cd` normalmente e voltar
para os diretórios anteriores usando `popd`, assim como visualizar os
diretórios visitados com o comando `dirs -p`.
]

---
class: center, middle, inverse

# Mudando a(o?) _prompt_ do bash
---

.left-column[
  ## Shell Prompt
  ### Melhorias
]
.right-column[
A _prompt_ do bash é definida na variável de ambiente `PS1`, e tipicamente
se parece como algo como:

```text
user@hostname:/tmp$
```

É possível modificar a variável `PS1` para incluir mais detalhes do sistema como:
* Cores.
* Número corrente do comando no histórico.
* Numero de tarefas em _background_
* _Branch_ corrente do git.
* Qualquer outra informação que possa ser recuperada via comandos do bash.

No exemplo a seguir, mostraremos como mudar a _prompt_ default do seu usuário para
algo mais útil.
]

---

.left-column[
  ## Shell Prompt
  ### Um prompt melhor
  ### Modificando PS1
]
.right-column[
* Baixe o arquivo [ps1.sh](files/ps1.sh)

* Adicione o conteúdo deste arquivo ao seu arquivo `~/.bashrc`.

* Edite o conteúdo e modifique as variáveis que controlam as cores do prompt:
  * `GIT_BRANCH_COLOR`: Cor a ser usada no branch corrente do git.
  * `HOST_COLOR`: Cor a ser usada para o host na prompt.
  * `DIR_COLOR`: Cor do diretório na prompt.
  * `ROOT_COLOR`: Cor do host se o usuário for root.

* Observe o como as cores são definidas (em variáveis de ambiente, definidas no
  começo do arquivo) e siga o mesmo padrão.

* Abra um novo terminal e verifique se o novo prompt é mostrado corretamente.
]

---

.left-column[
  ## O comando alias
  ### ls

]
.right-column[
O comando `alias` permite definir um comando ou criar um novo comando (simples)
sem a necessidade de criação de uma nova funçao ou script.

Nas seções abaixo, encontram-se vários _aliases_ úteis que podem ser copiados e
colados diretamente no seu `/.bashrc`.

### Comando ls mais curto

Os comandos abaixo criam aliases com o nome de `l` para ls simples e `ll` para
obter uma listagem completa, ordenada pela data/hora de modificação do arquivo.
O comando `ls` é reconfigurado para emitir a listagem dos diretórios
usando cores para distinguir os diferentes tipos de arquivos.

```text
alias l='ls'
alias ll='ls -ltr'
alias ls='ls --color=auto'
```
]

---

.left-column[
  ## O comando alias
  ### ls
  ### grep & less

]
.right-column[
### Grep em cores

O comando grep pode mostrar os strings encontrados com cores diferentes.

```text
alias grep='grep --color'
```

### Melhorando o comando 'less'

Com o alias abaixo, o comando less automaticamente faz busca sem considerar
maíusculas/minúsculas, Não apaga a tela ao sair, e permite a exibição correta
de cores e acentos dentro do `less`.

```text
alias less='less -iXR'
```

Use `alias less='less -iXRS'` se preferir que linhas longas não sejam quebradas
em múltiplas linhas.
]

---

.left-column[
  ## O comando alias
  ### ls
  ### grep & less
  ### ps

]
.right-column[
### Ver todos os processos por default

Por default, o comando `ps` só mostra os processos do próprio usuário, o que
normalmente não é tão útil. É possível criar o comando `p` para mostrar
informações sobre todo o sistema com:


```text
alias p='ps aux'
```

### Árvore de processos

O comando ps possui opções para mostrar uma "árvore" de processos no sistema
(como o programa `pstree`).  Nesse caso, criamos o _alias_ `ptree`:

```text
alias ptree=`ps axjf`
```
]

---

.left-column[
  ## O comando alias
  ### ls
  ### grep & less
  ### ps
  ### etc...

]
.right-column[
### Quem está usando mais memória?

O _alias_ `topmem` usa o comando top para mostrar de forma não-interativa os
cinco programas usando mais memória no momento (coluna `%MEM`, total em memória
em `RES`):

```text
alias topmem='top -b -n1 -o"%MEM" -Em | grep -A5 PID'

```

### Evitando operações perigosas na raiz

Operações recursivas a partir de `/` podem ter consequências catastróficas. O
grupo de _aliases_ abaixo reduz a chance de erros dessa natureza:

```text
alias rm='rm --preserve-root'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
```

**Nota**: É uma boa idéia colocar esses comandos no `~/.bashrc` do root (normalmente
em `/root/.bashrc`.
]

---
class: center, middle, inverse

# Truques & Quebra-galhos
## (Em ordem completamente aleatória)
---

.left-column[
  ## Truques & Quebra Galhos

]
.right-column[
### Quem está usando espaço em disco?

O comando abaixo mostra o espaço utilizado em cada diretório abaixo do corrente:

```bash
$ du -xmd1 | sort -n
```

### Editando todos os arquivos contendo uma string

```bash
$ $EDITOR $(grep -r "string_desejado_aqui" *)
```

### Trocando texto em vários arquivos

O exemplo abaixo muda todas as ocorrências da string `foobar` para `fubax`.  Os
strings são na verdade expressões regulares, logo substituições mais complexas
são possíveis:

```bash
$ sed -i.bak -e 's/foobar/fubax/g' *
```

Os arquivos originais serão salvos com a extensão `.bak`
]
---

.left-column[
  ## Truques & Quebra Galhos

]
.right-column[
### Executando um comando em todos os arquivos, recursivamente

Use o comando find. O exemplo abaixo calcula o md5 checksum de todos os arquivos
abaixo do diretório corrente.

```bash
$ find . -type f -exec md5sum "{}" \;
```

### Repetindo um comando várias vezes

Usando um `for` loop é possível repetir um comando quantas vezes forem
necessárias.  O comando abaixo repete o comando `date` cinco vezes com um
segundo entre cada execução.

```bash
for i in {1..5}; do
  date
  sleep 1
done

```
]

---

.left-column[
  ## Truques & Quebra Galhos

]
.right-column[
### Observando a saída de um comando

O comando watch permite a execução de um comando e a monitoração da saída.
Útil para verificar a saída de programas em tempo real:

```bash
$ watch -n 1 'ps -ax'
```

Observe como apenas as áreas modificadas são re-impressas. Tudo além da
largura do terminal é cortado automaticamente.

### Listando arquivos modificados

Para visualizar todos os arquivos e diretórios modificados nas últimas seis
horas (360 minutos):

```bash
$ find . -mmin +360 -print
```

Dica: Use `-ls` ao invés de `-print` para ver mais informações sobre os arquivos.
]

---

.left-column[
  ## Truques & Quebra Galhos
]
.right-column[
### Verificando o conteúdo de arquivos

Procurando por caracteres "invisíveis" no seu arquivo? Use o comando `od`:

```bash
$ od -c arquivo
```

### Dump em hexa de arquivos

Use o comando hexdump. Uma alternativa é definir o comando abaixo num alias chamado `hd`:

```bash
$ hexdump -e '"%06.6_ax: " 16/1 "%x " "   " 16/1 "%_p" "\n"' arquivo
```

### Onde está o programa XXX?

```bash
$ type XXX
```
]

---

.left-column[
  ## Truques & Quebra Galhos
]
.right-column[
### Convertendo um arquivo em multiplas colunas

Suponha um arquivo com uma palavra por linha. O comando abaixo le o arquivo e produz
quatro colunas na saída (uma por linha de entrada):

```bash
$ cat arquivo | paste - - - -
```

Para converter a saída em colunas do mesmo tamanho, use `columns -t`:

```bash
$ cat arquivo | paste - - - - | columns -t
```

### Trocando espaços por underscores

Para renomear todos os arquivos no diretório corrente, trocando espaços
no nome por underscores (`_`):

```bash
for i in *; do
  mv -v "$i" "$(echo $i | tr ' ' '_')"
done
```
]

---

.left-column[
  ## Truques & Quebra Galhos
]
.right-column[
### Renomeando arquivos para minúsculas

Para renomear todos os arquivos no diretório corrente para letras minúsculas:

```bash
for i in *; do
  mv -v "$i" "$(echo $i | tr '[A-Z]' '[a-z]')"
done
```

Dica: Para renomear de minúsculas para maíusculas, troque `[A-Z] [a-z]` acima por
`[a-z] [A-Z]` (mas por favor, não faça isso) 🤣

### Contando o número de linhas em um arquivo

```bash
$ wc -l arquivo
```

Dica: É possível contar o número de palavras com `-w` ao invés de `-l`.
]

---

.left-column[
  ## Truques & Quebra Galhos
]
.right-column[
### Quebrando linha em espaços

Um arquivo com uma (ou várias) linhas longas pode ser quebrado em espaços com:

```bash
$ fmt -1 < arquivo
```

### Quebrando um arquivo em vários pedaços.

O exemplo abaixo produz arquivos chamados `splitfoo.NN` de 10MB cada, a partir
de um arquivo `foo` original (note que o arquivo original não é modificado):

```bash
$ split -b 10M -d foo splitfoo.
```

Para recriar o arquivo foo a partir das partes, use o comando cat:

```bash
$ cat splitfoo.* >foo
```
]

---

.left-column[
  ## Truques & Quebra Galhos
]
.right-column[
### Criando um arquivo de tamanho arbitrário

Para criar um arquivo de tamanho arbitrário contendo dados randômicos, use
o comando `dd`, lendo diretamente de `/dev/urandom`. O comando abaixo gera um
arquivo chamado `arquivo` de 100M (100k blocos de 1k cada):

```bash
$ dd if=/dev/urandom of=arquivo bs=1k count=100k
```
]

### Comparando dois diretórios

Para comparar os arquivos entre dois diretórios recursivamente, use:

```bash
$ diff -qr /dir1 /dir2
```

A opção `-q` acima faz com que o comando `diff` mostre somente o nome dos
arquivos modificados (ou inexistentes em um dos diretórios). Para ver a
diferença do conteúdo dos arquivos, use apenas `-r`.
]
---
class: center, middle, inverse

#.fonth2[The End]
