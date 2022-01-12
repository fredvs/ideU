{ MSEgui Copyright (c) 1999-2022 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
} 

unit mseconsts_ide_pt;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  mseconsts_ide;

implementation

uses
  msetypes,
  SysUtils,
  msestockobjects,
  mseformatstr;

const

pt_modalresulttext: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '&Cancelar',   {&Cancel}
  '&Abortar',   {&Abort}
  '&OK',   {&OK}
  '&Sim',   {&Yes}
  '&Não',   {&No}
  'Sim e tudo',   {Yes &all}
  'Sim e tudo',   {Yes &all}
  'N&o e tudo',   {N&o all}
  '&Ignorar',   {&Ignore}
  'Saltar',   {&Skip}
  'Saltar tudo',   {Skip a&ll}
  'Co&ntinuar'   {Co&ntinue}
 );

pt_modalresulttextnoshortcut: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  'Cancelar',   {Cancel}
  'Abortar',   {Abort}
  'OK',   {OK}
  'Sim',   {Yes}
  'Não',   {No}
  'Sim e tudo',   {Yes all}
  'Sim e tudo',   {Yes all}
  'No e tudo',   {No all}
  'Ignorar',   {Ignore}
  'Saltar',   {Skip}
  'Saltar tudo',   {Skip all}
  'Continuar'   {Continue}
 );

pt_projectoptionscontext: projectoptionsconaty =
 (
  'A codificação errada pode danificar seus arquivos de origem.',   {Wrong encoding can damage your source files.}
  'Você deseja definir a codificação para',   {Do you wish to set encoding to}
  '*** AVISO ***',   {*** WARNING ***}
  'Desligar',   {Hangup}
  'Interromper',   {Interrupt}
  'Desistir',   {Quit}
  'Instrução ilegal',   {Illegal instruction}
  'Traço armadilha',   {Trace trap}
  'Abortar',   {Abort}
  'Erro de BUS',   {BUS error}
  'Exceção de ponto flutuante',   {Floating-point exception}
  'Matar',   {Kill}
  'Sinal definido pelo usuário 1',   {User-defined signal 1}
  'Violação de segmentação',   {Segmentation violation}
  'Sinal definido pelo usuário 2',   {User-defined signal 2}
  'Cano quebrado',   {Broken pipe}
  'Despertador',   {Alarm clock}
  'Terminação',   {Termination}
  'Falha de pilha',   {Stack fault}
  'O status da criança mudou',   {Child status has changed}
  'Continuar',   {Continue}
  'Pare desbloqueável',   {Stop, unblockable}
  'Parada do teclado',   {Keyboard stop}
  'Antecedentes lidos a partir de tty',   {Background read from tty}
  'Background write to tty',   {Background write to tty}
  'Condição urgente no soquete',   {Urgent condition on socket}
  'Limite de CPU excedido',   {CPU limit exceeded}
  'Limite de tamanho de arquivo excedido',   {File size limit exceeded}
  'Despertador virtual',   {Virtual alarm clock}
  'Despertador de perfil',   {Profiling alarm clock}
  'Mudança no tamanho da janela',   {Window size change}
  'I/O agora possível',   {I/O now possible}
  'Reinicialização por falha de energia'   {Power failure restart}
 );

pt_actionsmoduletext: actionsmoduleaty =
 (
  'Configurar ideU',   {Configure ideU}
  'ID do processo',   {Process ID}
  'Anexar ao processo',   {Attach to process}
  'Moduleclass desconhecido para "',   {Unknown moduleclass for "}
  'Componente herdado "',   {Inherited component "}
  '"não pode ser excluído.',   {" can not be deleted.}
  'ERRO',   {ERROR}
  'Faça abortado.',   {Make aborted.}
  'Download abortado.',   {Download aborted.}
  'Runerror com "',   {Runerror with "}
  'Erro: Tempo limite.',   {Error: Timeout.}
  'Fazer.',   {Making.}
  'Faça não correr.',   {Make not running.}
  'Baixando.',   {Downloading.}
  'O download não está funcionando.',   {Download not running.}
  '" correndo.',   {" running.}
  'Roteiro',   {Script}
  'Herança de forma recursiva de "',   {Recursive form inheritance of "}
  'Componente "',   {Component "}
  '" existe.',   {" exists.}
  'Ancestral para "',   {Ancestor for "}
  '" não encontrado.',   {" not found.}
  'Módulo "',   {Module "}
  'Nome inválido "',   {Invalid name "}
  'Nome do método inválido',   {Invalid methodname}
  'Módulo não encontrado',   {Module not found}
  'Método não encontrado',   {Method not found}
  'Método publicado (gerenciado)',   {Published (managed) method}
  'não existe.',   {does not exist.}
  'Deseja deletar o evento?',   {Do you wish to delete the event?}
  'AVISO',   {WARNING}
  'Método',   {Method}
  'tem parâmetros diferentes.',   {has different parameters.}
  'Um módulo "',   {A module "}
  '"já está aberto.',   {" is already open.}
  'Referência (s) não resolvida (s) para',   {Unresolved reference(s) to}
  'Módulo (s):',   {Module(s):}
  'Não é possível ler o formfile "',   {Can not read formfile "}
  'Nome de componente inválido.',   {Invalid component name.}
  'Exceção inválida',   {Invalid exception}
  'Ferramentas',   {T&ools}
  'Formulários',   {Forms}
  'Fonte',   {Source}
  'Todos os arquivos',   {All Files}
  'Programa MSE',   {MSE Program}
  'Unidade MSE',   {MSE Unit}
  'MSE Textfile',   {MSE Textfile}
  'Mainform',   {Mainform}
  'Forma simples',   {Simple Form}
  'Forma de encaixe',   {Docking Form}
  'Datamodule',   {Datamodule}
  'Subform',   {Subform}
  'Scrollboxform',   {Scrollboxform}
  'Tabform',   {Tabform}
  'Dockpanel',   {Dockpanel}
  'Relatório',   {Report}
  'Scriptform',   {Scriptform}
  'Formulário herdado',   {Inherited Form}
  'Deseja substituir as configurações por',   {Do you want to replace the settings by}
  'Arquivo "',   {File "}
  'Você deseja substituir?',   {Do you want to overwrite?}
  'Desconhecido',   {Unknown}
  'Erro',   {Error}
  'Comece',   {Startup}
  'Exceção',   {Exception}
  'GDB morreu',   {GDB died}
  'Ponto de interrupção atingido',   {Breakpoint hit}
  'Watchpoint acionado',   {Watchpoint triggered}
  'Ler ponto de controle acionado',   {Read Watchpoint triggered}
  'Access Watchpoint acionado',   {Access Watchpoint triggered}
  'Fim do intervalo de passos',   {End stepping range}
  'Função concluída',   {Function finished}
  'Saiu normalmente',   {Exited normally}
  'Saiu',   {Exited}
  'Separado',   {Detached}
  'Sinal recebido',   {Signal received}
  'Erro de parada',   {Stop error}
  'Não é possível ler o projeto',   {Can not read project}
  'Cerca de',   {About}
  'Inspetor de objetos',   {Object Inspector}
  'Armazém Componentes',   {Store Component}
  'Processo de anexação',   {Attaching Process}
  'Carregando'   {Loading}
 );

pt_mainformtext: mainformaty =
 (
  'Referências não resolvidas em',   {Unresolved references in}
  'para',   {to}
  'Você deseja pesquisar o arquivo de formulário?',   {Do you wish to search the formfile?}
  'AVISO',   {WARNING}
  'Formfile para',   {Formfile for}
  'Formfiles',   {Formfiles}
  'Hierarquia de forma recursiva para "',   {Recursive form hierarchy for "}
  'ERRO',   {ERROR}
  'Tipo de classe',   {Classtype}
  'não encontrado.',   {not found.}
  'Projeto',   {Project}
  'é modificado. Salve ?',   {is modified. Save?}
  'Confirmação',   {Confirmation}
  'Impossível abrir o ficheiro "',   {Unable to open file "}
  '*** Correndo ***',   {*** Running ***}
  'Baixando',   {Downloading}
  'Baixado',   {Downloaded}
  'Iniciar o comando do servidor gdb "',   {Start gdb server command "}
  '" correndo.',   {" running.}
  'Iniciar servidor gdb',   {Start gdb Server}
  'erro de inicialização do servidor gdb',   {gdb server start error}
  'gdb server start cancelled.',   {gdb server start canceled.}
  'Não é possível executar o comando start gdb.',   {Can not run start gdb command.}
  'Uploadcommand "',   {Uploadcommand "}
  'Erro de download***',   {Download ***ERROR***}
  'Download concluído.',   {Download finished.}
  'Download cancelado.',   {Download canceled.}
  'Arquivo "',   {File "}
  '" não encontrado.',   {" not found.}
  '" existe.',   {" exists.}
  'Novo',   {New}
  'Selecionar ancestral',   {Select ancestor}
  'Nova forma',   {New form}
  'Arquivos Pascal',   {Pascal Files}
  'novo',   {new}
  'Não é possível carregar o projeto "',   {Can not load Project "}
  'Selecionar modelo de projeto',   {Select project template}
  'Arquivos de projeto',   {Project files}
  'Todos os arquivos',   {All files}
  'Selecionar arquivo de programa',   {Select program file}
  'Arquivos de programa Pascal',   {Pascal program files}
  'Arquivos de programa C',   {C program files}
  'Novo projeto',   {New Project}
  'Não é possível iniciar o processo',   {Can not start process}
  'Processo',   {Process}
  'correndo.',   {running.}
  'Processo encerrado',   {Process terminated}
  'Processo encerrado normalmente.',   {Process terminated normally.}
  'Faça *** ERROR ***',   {Make ***ERROR***}
  'Faça OK.',   {Make OK.}
  'A fonte mudou você deseja refazer o projeto?',   {Source has changed, do you wish to remake project?}
  'Carregar layout da janela',   {Load Window Layout}
  'Área atracagem'   {Docking area}
 );

pt_sourceformtext: sourceformaty =
 (
  'Arquivo "',   {File "}
  '" mudou.',   {" has changed.}
  'Existem modificações no buffer de edição também.',   {There are modifications in edit buffer also.}
  'Deseja recarregar do disco?',   {Do you wish to reload from disk?}
  'Confirmação',   {Confirmation}
  '<nenhum>',   {<none>}
  'Deseja substituir:',   {Do you wish to replace:}
  'com:',   {with:}
  '<novo>',   {<new>}
  'Syntaxdeffile:',   {Syntaxdeffile:}
  'Texto',   {Text}
  'não encontrado.',   {not found.}
  'Reiniciar do início do arquivo?',   {Restart from begin of file?}
  'Cancelar?',   {Cancel?}
  'Deseja substituir esta ocorrência?',   {Do you wish to to replace this occurence?}
  'Vá para a linha número:',   {Go to line number:}
  'Encontrar linha',   {Find line}
  'Existem modificações no buffer de edição também.'   {There are modifications in edit buffer also.}
 );

pt_settingstext: isettingsaty =
 (
  'Aplicar',   {Apply}
  'Configuração assistiva de voz sak',   {sak voice assistive config}
  'Diretório pai do sakit',   {Parent directory of sakit}
  'Habilitar sak assistive ao carregar',   {Enable sak assistive at loading}
  'Layout do sistema',   {System layout}
  'Diretórios universais',   {Universal path layout}
  'Nenhum pedido Z',   {No Z order handling}
  'Use "Shift" para selecionar palavra',   {Use shift key to select a word}
  'Foco automático no menu principal',   {Auto focus in main-menu}
  'Caminho completo no título',   {Full path of project in window title}
  'Definir diálogo como modal',   {Set dialog-forms as modal vs as tool}
  'Altura fonte',   {Font height}
  'Nome fonte',   {Font name}
  'Sem confirmação para deletar linha',   {No confirmation to delete row}
  'Circuito piscando',   {Blinking caret}
  'Redesenhar tela',   {Repaint canvas}
  'Editor de código-fonte',   {Source Editor}
  'Use essas opções',   {Use those options instead of project options}
  'Adicionar espaço após "" ao auto-analisar',   {Add space after comma -> auto-parsing}
  'Quando um arquivo foi alterado',   {When a file has changed}
  'Sem diálogo => recarregar o novo',   {No dialog box => reload the new one}
  'Sem diálogo => manter o antigo',   {No dialog box => keep the old one}
  'Diálogo pergunta o que fazer ...',   {A dialog box ask what to do...}
  'Retângulo em torno da seleção'   {Rectangle around multi-select}
 );

pt_projectoptionstext: projectoptionsaty =
 (
  'Opções de projeto',   {Project options}
  'Editor',   {Editor}
  'Linha margem',   {Right margin line}
  'Mark Brackets',   {Mark Brackets}
  'Números de linha',   {Line Numbers}
  'Mark Pairwords',   {Mark Pairwords}
  'Cortar espaço branco',   {Trim trailing whitespace on save}
  'Recuo automático',   {Auto Indent}
  'Sem editor de código-fonte',   {No Source Editor}
  'Tab indent',   {Tab indent}
  'Guia de espaço',   {Space tab}
  'Mostrar guias',   {Show tabs}
  'Fonte com suavização de serrilhado',   {Anti aliased font}
  'Codificação',   {Encoding}
  'Marcar cor',   {Mark Color}
  'Stat cor',   {Stat Color}
  'Scr Y',   {Scr Y}
  'Nb char',   {Nb char}
  'Estilo EOL',   {EOL Style}
  'Backup',   {Backup}
  'Tabstops',   {Tabstops}
  'Indentação',   {Indent}
  'ExtS',   {ExtS}
  'Espaço extra entre linhas',   {Extra space between lines}
  'Largura',   {Width}
  'Altura',   {Height}
  'Fonte',   {Font}
  'Font Bk. color',   {Font Bk. color}
  'Cor da fonte',   {Font color}
  'Filtro de arquivo',   {File filter}
  'Nome',   {Name}
  'Máscara de arquivo',   {File mask}
  'Arquivo de definição de sintaxe',   {Syntax definition file}
  'Modelos de código',   {Code Templates}
  'Diretórios de modelo de código extensão de arquivo = .mct',   {Code template directories, file extension = .mct}
  'Selecione o diretório da unidade',   {Select unit directory}
  '&Depurador',   {&Debugger}
  'Depurador Projecto',   {Project Debugger}
  'Pesquisa e diretórios',   {Search &Directories}
  'Caminho de pesquisa para obter informações sobre o código',   {Search path to get infos about code}
  'Selecione o diretório de origem',   {Select source directory}
  'Object &Base Directory (empty = Make Directory)',   {Object &Base Directory (empty = Make Directory)}
  'Selecionar diretório base de origem',   {Select source base directory}
  'Definições',   {Defi&nes}
  '&Sinais',   {&Signals}
  '&Exceção',   {&Exception}
  '&Alvo',   {&Target}
  'Iniciar gdb server command attach target',   {Start gdb server command attach target}
  'Não espere pela saída',   {No wait for exit}
  'Antes de conectar o script gdb',   {Before connect gdb script}
  'Antes de carregar o script gdb',   {Before load gdb script}
  'Antes de executar o script gdb',   {Before run gdb script}
  'Depois de conectar o script gdb',   {After connect gdb script}
  'Depois de carregar o script gdb',   {After load gdb script}
  'Iniciar gdb server command run target',   {Start gdb server command run target}
  'Aguarde antes de conectar',   {Wait before connect}
  'Iniciar uma vez',   {Start once}
  'Comando de download',   {Download command}
  'Processador',   {Processor}
  'Simulator',   {Simulator}
  'gdb descarregar',   {gdb download}
  'BKPT de inicialização',   {Startup BKPT}
  'Conexão de destino',   {Target connection}
  'Sempre baixar',   {Always download}
  'Sempre baixe antes de executar',   {Always download before run}
  'Tempo limite de carregamento',   {Load Timeout}
  'Consola &Externa',   {&Extern Console}
  '&Stop on Exc',   {&Stop on Exc}
  'Parar nas exceções',   {Stop on exceptions}
  '&Acti-Break',   {&Acti-Break}
  'Ativar no intervalo',   {Activate on Break}
  '&Valor Dica',   {&Value Hints}
  'Chamar GUI_DEB',   {Call GUI_DEB}
  'Solte a garra do mouse pela parada do alvo. gdb às vezes trava com esta opção.',   {Release mouse grab by target stop. gdb sometimes crashes with this option.}
  'Definir TT&Y',   {Set TT&Y}
  'Levantar/pausa',   {&Raise-Break}
  'Levantar na pausa',   {Raise on break}
  '&FPC bugs',   {&FPC bugs}
  'Use soluções alternativas para bugs FPC / gdb',   {Use workarounds for FPC/gdb bugs}
  'Debug alvo',   {Debug &target}
  'Comando xterm',   {xterm command}
  'Executar comando',   {Run command}
  'Depurador padrão',   {Default Debugger}
  'Depurar e opções',   {Debug &options}
  '&Make',   {&Make}
  'Coluna make por defeito',   {Default make col}
  'Ficheiro principal',   {Mainfile}
  'Seleccionar ficheiro principal',   {Select mainfile}
  'Nome ficheiro alvo',   {Targetfile name}
  'Selecionar arquivo de destino',   {Select target file}
  'Compilador padrão',   {Default Compiler}
  'Selecione o comando make',   {Select make command}
  'Mostrar linha de comando',   {Show Command Line}
  'Copiar mensagens para o arquivo',   {Copy messages to file}
  'Fechar mensagem',   {Close message}
  'Verificar cabeçalho',   {Check head}
  'Verificar cabeçalhos de método',   {Check method headers}
  'Project Compiler',   {Project Compiler}
  'Comando antes',   {Command before}
  'Opções de criação',   {Make options}
  'Diretórios',   {Directories}
  'Selecione o diretório da unidade',   {Select unit directory}
  'Comando depois de',   {Command after}
  'Exe Extension',   {Exe Extension}
  'Comentários',   {Comments}
  'Criar diretório',   {Make Directory}
  'Selecione criar diretório',   {Select make directory}
  'Cor do erro',   {Error Color}
  'Cor de Aviso',   {Warning Color}
  'Nota Cor',   {Note Color}
  'Strip ESC',   {Strip ESC}
  'Retirar sequências ESC na forma de mensagens e terminal',   {Strip ESC sequences in Messages and Terminal form}
  'Mostrar console',   {Show Console}
  'Objetivo',   {Purpose}
  'Arquivo de saída de mensagem',   {Message output file}
  'Selecionar arquivo de destino',   {Select target file}
  'Macros',   {Macros}
  'Grupo ativo',   {Active group}
  '&Alias da fonte',   {&Font Alias}
  'Designers',   {Designers}
  'Usuário e cores',   {User &Colors}
  'Copiar o código "setcolormapvalue" para a área de transferência',   {Copy "setcolormapvalue" code to clipboard}
  'F&ormat Macros',   {F&ormat Macros}
  'Usado por formatfloatmse () e formatdatetimemse ()',   {Used by formatfloatmse() and formatdatetimemse()}
  'Modelos',   {Templates}
  'Novo projeto',   {New project}
  'Script antes da cópia',   {Script before copy}
  'Script após cópia',   {Script after copy}
  'Novo arquivo',   {New File}
  'Novo formulário',   {New Form}
  'Ferramentas',   {Tools}
  'Armazenamento',   {Storage}
  'Infos',   {Infos}
  'Nome completo do projeto',   {Full name of project}
  'Criador',   {Creator}
  'Licença',   {License}
  'Data de criação'   {Date of creation}
 );

pt_stockcaption: stockcaptionaty =
(
  '',   {}
  'é inválido',   {is invalid}
  'Erro de formato',   {Format error}
  'O valor é obrigatório',   {Value is required}
  'Erro',   {Error}
  'Min',   {Min}
  'Max',   {Max}
  'Erro de intervalo',   {Range error}
  '&Desfazer',   {&Undo}
  '&Refazer',   {&Redo}
  '&Copiar',   {&Copy}
  'Cu &t',   {Cu&t}
  '&Paste',   {&Paste}
  'Selecionar &tudo',   {Select &all}
  '&Inserir linha',   {&Insert Row}
  '&Append Row',   {&Append Row}
  '&Excluir linha',   {&Delete Row}
  '&Dir',   {&Dir}
  '&Home',   {&Home}
  '&Up',   {&Up}
  '&Novo',   {&New}
  '&Nome',   {&Name}
  '&Mostrar arquivos ocultos',   {&Show hidden files}
  '&Filtro',   {&Filter}
  'Salvar',   {Save}
  'Abrir',   {Open}
  'Nome',   {Name}
  'Criar novo diretório',   {Create new directory}
  'Voltar',   {Back}
  'Avançar',   {Forward}
  'Up',   {Up}
  'Arquivo',   {File}
  'existe você deseja sobrescrever?',   {exists, do you want to overwrite?}
  'é modificado. Salve ?',   {is modified. Save?}
  'AVISO',   {WARNING}
  'ERRO',   {ERROR}
  'Exceção',   {Exception}
  'Sistema',   {System}
  'não existe',   {does not exist}
  'PASSWORD',   {PASSWORD}
  'Digite a senha',   {Enter password}
  'Senha inválida!',   {Invalid password!}
  'Não é possível ler o diretório',   {Can not read directory}
  'Formato gráfico não suportado',   {Graphic format not supported}
  'Erro de formato gráfico',   {Graphic format error}
  'MS Bitmap',   {MS Bitmap}
  'Ícone MS',   {MS Icon}
  'Imagem JPEG',   {JPEG Image}
  'Imagem PNG',   {PNG Image}
  'Imagem XPM',   {XPM Image}
  'Imagem PNM',   {PNM Image}
  'Imagem TARGA',   {TARGA Image}
  'Imagem TIFF',   {TIFF Image}
  'Todos',   {All}
  'Confirmação',   {Confirmation}
  'Excluir registro?',   {Delete record?}
  'Copiar registro?',   {Copy record?}
  'Fechar página',   {Close page}
  'Primeiro',   {First}
  'Prior',   {Prior}
  'Próximo',   {Next}
  'Último',   {Last}
  'Anexar',   {Append}
  'Eliminar',   {Delete}
  'Editar',   {Edit}
  'Post',   {Post}
  'Cancelar',   {Cancel}
  'Atualizar',   {Refresh}
  'Editar filtro',   {Edit filter}
  'Editar filtro mínimo',   {Edit filter minimum}
  'Editar filtro máximo',   {Edit filter maximum}
  'Redefinir filtro',   {Reset filter}
  'Filtrar',   {Filter on}
  'Pesquisa',   {Search}
  'Edição automática',   {Auto edit}
  'Copiar registro',   {Copy record}
  'Diálogo',   {Dialog}
  'Inserir',   {Insert}
  'Copiar',   {Copy}
  'Colar',   {Paste}
  'Inserir linha',   {Row insert}
  'Apêndice fila',   {Row append}
  'Eliminar fila',   {Row delete}
  'Desfazer',   {Undo}
  'Refazer',   {Redo}
  'Cut',   {Cut}
  'Selecionar tudo',   {Select all}
  'Filtro desligado',   {Filter off}
  'Retrato',   {Portrait}
  'Paisagem',   {Landscape}
  'Excluir linha?',   {Delete row?}
  'linhas selecionadas?',   {selected rows?}
  'Somente item único',   {Single item only}
  'Copiar células',   {Copy Cells}
  'Colar células',   {Paste Cells}
  'Fechar',   {Close}
  'Maximizar',   {Maximize}
  'Normalizar',   {Normalize}
  'Minimizar',   {Minimize}
  'Tamanho fixo',   {Fix size}
  'Flutuar',   {Float}
  'Fique por dentro',   {Stay on top}
  'Fique em segundo plano',   {Stay in background}
  'Bloquear filhos',   {Lock children}
  'Sem bloqueio',   {No lock}
  'Input',   {Input}
  'Botão',   {Button}
  'Ligar',   {On}
  'Desligar',   {Off}
  'Borda esquerda',   {Left border}
  'Borda superior',   {Top border}
  'Borda direita',   {Right border}
  'Borda inferior',   {Bottom border}
  'Início do texto',   {Begin of text}
  'Fim do texto',   {End of text}
  'Inputmode',   {Inputmode}
  'Overwrite',   {Overwrite}
  'Excluído',   {Deleted}
  'Copiado',   {Copied}
  'Inserido',   {Inserted}
  'Colado',   {Pasted}
  'Retirado',   {Withdrawn}
  'Janela ativada',   {Window activated}
  'Menu',   {Menu}
  'Início do arquivo',   {Beginning of file}
  'Fim do arquivo',   {End of file}
  'Saída de voz',   {Voice output}
  'Fale de novo',   {Speak again}
  'Primeira coluna',   {First column}
  'Primeira linha',   {First row}
  'Última coluna',   {Last column}
  'Última linha',   {Last row}
  'Seleção',   {Selection}
  'Fale o caminho',   {Speak path}
  'Botão desativado',   {Disabled button}
  'Primeiro campo',   {First field}
  'Último campo',   {Last field}
  'Primeiro elemento',   {First element}
  'Último elemento',   {Last element}
  'Mais lento',   {Slower}
  'Mais rápido',   {Faster}
  'Janela',   {Window}
  'Área',   {Area}
  'Área ativada',   {Area activated}
  'Diminuir o volume',   {Volume down}
  'Aumentar o volume',   {Volume up}
  'Cancelar discurso',   {Cancel speech}
  'Alvo',   {Target}
  'Ver',   {View}
  'Formulários',   {Forms}
  'Layout',   {Layout}
  'Sintaxe',   {Syntax}
  'Projeto',   {Project}
  'Editado',   {Edited}
  'Widgets',   {Widgets}
  'Configurações',   {Settings}
  'Cerca de',   {About}
  'Novo',   {New}
  'Salvar como ...',   {Save as...}
  'Salvar tudo',   {Save all}
  'Fechar tudo',   {Close all}
  'Imprimir',   {Print}
  'Desistir',   {Quit}
  'Linha',   {Line}
  'Pesquisar novamente',   {Search again}
  'Pesquisar de volta',   {Search back}
  'Localizar e substituir',   {Find & replace}
  'Encontrar em arquivos',   {Find in files}
  'Lista de procedimentos',   {Procedures list}
  'Selecionar página de edição',   {Select edit page}
  'Copiar palavra no cursor',   {Copy word at cursor}
  'Copiar LaTeX',   {Copy LaTeX}
  'Indentação',   {Indent}
  'Desindentar',   {Unindent}
  'Ambiente',   {Environment}
  'Processo de anexação',   {Attach process}
  'Anexe alvo',   {Attach target}
  'Desprender alvo',   {Detach target}
  'Descarregar',   {Download}
  'Ferramentas',   {Tools}
  'Make',   {Make}
  'Build',   {Build}
  'Abortar make',   {Abort make}
  'Debug-Run',   {Debug-Run}
  'Opções',   {Options}
  'Árvore',   {Tree}
  'Fonte',   {Source}
  'Abrir cópia',   {Open copy}
  'Salvar cópia como',   {Save copy as}
  'Beautifier',   {Beautifier}
  'Painéis',   {Panels}
  'Forçar ordem Z',   {Force Z order}
  'Lista de árvores',   {Tree list}
  'Mensagens',   {Messages}
  'Encontrar resultado',   {Find result}
  'Comandante',   {Commander}
  'Símbolos',   {Symbols}
  'Relógios',   {Watches}
  'Pilha',   {Stack}
  'Fios',   {Threads}
  'CPU',   {CPU}
  'Assembler',   {Assembler}
  'Pontos parada',   {Breakpoints}
  'Pontos vigilância',   {Watchpoints}
  'Memória',   {Memory}
  'Console de destino',   {Target console}
  'Alternar forma / unidade',   {Toggle form/unit}
  'Módulos MSE',   {MSE modules}
  'Fechar todos os módulos MSE',   {Close all MSE modules}
  'Configurações gerais',   {General settings}
  'Configurações extras',   {Extra settings}
  'Idiomas',   {Languages}
  'Configurar widgets',   {Configure widgets}
  'Configurar compiladores',   {Configure compilers}
  'Configurar depuradores',   {Configure debuggers}
  'Temas',   {Themes}
  'Directório',   {Directory}
  'Sem ícones',   {No icons}
  'Sem lateral',   {No lateral}
  'Compacto',   {Compact}
  'Abrir projeto',   {Open project}
  'Abrir arquivo',   {Open file}
  'Path',   {Path}
  'Outro',   {Other}
  'Comando de impressão',   {Print command}
  'Atalho',   {Shortcut}
  'Valor',   {Value}
  'Sensível a maiúsculas e minúsculas',   {Case sensitive}
  'Selecionado apenas',   {Selected only}
  'Palavra inteira',   {Whole word}
  'Texto para encontrar',   {Text to find}
  'Pesquisar no arquivo atual',   {Search in current file}
  'Pesquisar em arquivos abertos',   {Search in open files}
  'Pesquisar no diretório do projeto',   {Search in project directory}
  'Pesquisar nos diretórios',   {Search in directories}
  'Incluir subdiretórios',   {Include subdirectories}
  'Substituir',   {Replace}
  'Substituir tudo',   {Replace all}
  'Substituir por',   {Replace with}
  'Solicitar ao substituir',   {Prompt on replace}
  'Paleta de componentes',   {Components palette}
  'Encontrar componentes',   {Find components}
  'Reset',   {Reset}
  'Step',   {Step}
  'Instrução de etapa',   {Step instruction}
  'Próxima instrução',   {Next instruction}
  'Reiniciar o depurador',   {Restart debugger}
  'Alternar ponto de interrupção',   {Toggle breakpoint}
  'Alternar ponto de interrupção habilitado',   {Toggle breakpoint enabled}
  'Ligado / desligado a dica de linhas executadas',   {Executed lines hint on/off}
  'Por favor compile primeiro.',   {Please compile it first.}
  'Concluir',   {Finish}
  'Definir como padrão',   {Set as default}
  'Anfitrião',   {Host}
  'Copyright'   {Copyright}
 );

pt_langnamestext: array[0..6] of msestring =
(
  'Inglês',   {English}
  'Russo',   {Russian}
  'Francês',   {French}
  'Alemão',   {German}
  'Espanhol',   {Spanish}
  'Português',   {Portuguese}
  'Chinese (not complete)'   {Chinese (not complete)}
 );

pt_extendedtext: extendedaty =
(
  'Excluir linha selecionada?',   {Delete selected row?}
  'Excluir %s linhas selecionadas?'   {Delete %s selected rows?}
 );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := pt_extendedtext[ex_del_row_selected]
    else
      Result := StringReplace(pt_extendedtext[ex_del_rows_selected], #37#115, inttostrmse(vinteger), [rfReplaceAll]);
end;

const
pt_textgenerator: defaultgeneratortextty = (
 {$ifdef FPC} @{$endif}delete_n_selected_rows);

initialization

registerlangconsts(langnames[la_pt], @pt_langnamestext, @pt_extendedtext, @pt_mainformtext, @pt_sourceformtext,
                   @pt_projectoptionscontext, @pt_actionsmoduletext, @pt_settingstext, @pt_projectoptionstext,
                   @pt_stockcaption, @pt_modalresulttext, @pt_modalresulttextnoshortcut, @pt_textgenerator);

end.

