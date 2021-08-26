{ MSEgui Copyright (c) 1999-2006 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    Portuguese translation by Fred vS.
}

unit mseconsts_ide_pt;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  mseconsts_ide;

implementation

uses
  msetypes{msestrings},
  SysUtils,
  mseformatstr;

const
  pt_modalresulttext: defaultmodalresulttextty =
    (
     '', // mr_none
     '', // mr_canclose
     '', // mr_windowclosed
     '', // mr_windowdestroyed
     '', // mr_escape
     '', // mr_f10
     '', // mr_exception
     '&Cancelar', // mr_cancel
     '&Abortar', // mr_abort
     '&OK', // mr_ok
     '&Sim', // mr_yes
     '&Não', // mr_no
     'Sim e tudo', // mr_all
     'Sim e tudo', // mr_yesall
     'N&o e tudo', // mr_noall
     '&Ignorar', // mr_ignore
     'Saltar', // mr_skip
     'Saltar tudo', // mr_skipall
     'Co&ntinuar' // mr_continue
    );

  pt_modalresulttextnoshortcut: defaultmodalresulttextty =
    (
     '', // mr_none
     '', // mr_canclose
     '', // mr_windowclosed
     '', // mr_windowdestroyed
     '', // mr_escape
     '', // mr_f10
     '', // mr_exception
     'Cancelar', // mr_cancel
     'Abortar', // mr_abort
     'OK', // mr_ok
     'Sim', // mr_yes
     'Não', // mr_no
     'Sim e tudo', // mr_all
     'Sim e tudo', // mr_yesall
     'No e tudo', // mr_noall
     'Ignorar', // mr_ignore
     'Saltar', // mr_skip
     'Saltar tudo', // mr_skipall
     'Continuar' // mr_continue
    );
    
  pt_mainformtext: mainformaty = (
      'Referências não resolvidas em',
      'para',
      'Você deseja pesquisar o arquivo de formulário?',
      'AVISO',
      'Formfile para',
      'Formfiles',
      'Hierarquia de forma recursiva para "',
      'ERRO',
      'Tipo de classe',
      'não encontrado.',
      'Projeto',
      'é modificado. Salve ?',
      'Confirmação',
      'Impossível abrir o ficheiro "',
      '*** Correndo ***',
      'Baixando',
      'Baixado',
      'Iniciar o comando do servidor gdb "',
      '" correndo.',
      'Iniciar servidor gdb',
      'erro de inicialização do servidor gdb',
      'gdb server start cancelled.',
      'Não é possível executar o comando start gdb.',
      'Uploadcommand "',
      'Erro de download***',
      'Download concluído.',
      'Download cancelado.',
      'Arquivo "',
      '" não encontrado.',
      '" existe.',
      'Novo',
      'Selecionar ancestral',
      'Nova forma',
      'Arquivos Pascal',
      'novo',
      'Não é possível carregar o projeto "',
      'Selecionar modelo de projeto',
      'Arquivos de projeto',
      'Todos os arquivos',
      'Selecionar arquivo de programa',
      'Arquivos de programa Pascal',
      'Arquivos de programa C',
      'Novo projeto',
      'Não é possível iniciar o processo',
      'Processo',
      'correndo.',
      'Processo encerrado',
      'Processo encerrado normalmente.',
      'Faça *** ERROR ***',
      'Faça OK.',
      'A fonte mudou, você deseja refazer o projeto?',
      'Carregar layout da janela',
      'Área atracagem'
   );   
    

  pt_actionsmoduletext: actionsmoduleaty = (
    'Configurar ideU',
    'ID do processo',
    'Anexar ao processo',
    'Moduleclass desconhecido para "',
    'Componente herdado "',
    '"não pode ser excluído.',
    'ERRO',
    'Faça abortado.',
    'Download abortado.',
    'Runerror com "',
    'Erro: Tempo limite.',
    'Fazer.',
    'Faça não correr.',
    'Baixando.',
    'O download não está funcionando.',
    '" correndo.',
    'Roteiro',
    'Herança de forma recursiva de "',
    'Componente "',
    '" existe.',
    'Ancestral para "',
    '" não encontrado.',
    'Módulo "',
    'Nome inválido "',
    'Nome do método inválido',
    'Módulo não encontrado',
    'Método não encontrado',
    'Método publicado (gerenciado)',
    'não existe.',
    'Deseja deletar o evento?',
    'AVISO',
    'Método',
    'tem parâmetros diferentes.',
    'Um módulo "',
    '"já está aberto.',
    'Referência (s) não resolvida (s) para',
    'Módulo (s):',
    'Não é possível ler o formfile "',
    'Nome de componente inválido.',
    'Exceção inválida',
    'Ferramentas',
    'Formulários',
    'Fonte',
    'Todos os arquivos',
    'Programa MSE',
    'Unidade MSE',
    'MSE Textfile',
    'Mainform',
    'Forma simples',
    'Forma de encaixe',
    'Datamodule',
    'Subform',
    'Scrollboxform',
    'Tabform',
    'Dockpanel',
    'Relatório',
    'Scriptform',
    'Formulário herdado',
    'Deseja substituir as configurações por',
    'Arquivo "',
    'Você deseja substituir?',
    'Desconhecido',
    'Erro',
    'Comece',
    'Exceção',
    'GDB morreu',
    'Ponto de interrupção atingido',
    'Watchpoint acionado',
    'Ler ponto de controle acionado',
    'Access Watchpoint acionado',
    'Fim do intervalo de passos',
    'Função concluída',
    'Saiu normalmente',
    'Saiu',
    'Separado',
    'Sinal recebido',
    'Erro de parada',
    'Não é possível ler o projeto',
    'Cerca de',
    'Inspetor de objetos',
    'Armazém Componentes',
    'Processo de anexação',
    'Carregando'
    );

  pt_projectoptionscontext: projectoptionsconaty = (
     'A codificação errada pode danificar seus arquivos de origem.',
     'Você deseja definir a codificação para',
     '*** AVISO ***',
     'Desligar',
     'Interromper',
     'Desistir',
     'Instrução ilegal',
     'Traço armadilha',
     'Abortar',
     'Erro de BUS',
     'Exceção de ponto flutuante',
     'Matar',
     'Sinal definido pelo usuário 1',
     'Violação de segmentação',
     'Sinal definido pelo usuário 2',
     'Cano quebrado',
     'Despertador',
     'Terminação',
     'Falha de pilha',
     'O status da criança mudou',
     'Prosseguir',
     'Pare, desbloqueável',
     'Parada do teclado',
     'Antecedentes lidos a partir de tty',
     'Background write to tty',
     'Condição urgente no soquete',
     'Limite de CPU excedido',
     'Limite de tamanho de arquivo excedido',
     'Despertador virtual',
     'Despertador de perfil',
     'Mudança no tamanho da janela',
     'I/O agora possível',
     'Reinicialização por falha de energia'
  );

  pt_settingstext: isettingsaty = (
    'Aplicar', // se_apply
    'Configuração assistiva de voz sak', // se_groupassistive
    'Diretório pai do sakit', // se_sakitdir
    'Habilitar sak assistive ao carregar', // se_enableassistive
    'Layout do sistema', // se_groupsystemlayout
    'Diretórios universais', // se_universalpath
    'Nenhum pedido Z', // se_nozorder
    'Use "Shift" para selecionar palavra', // se_doubleclic
    'Foco automático no menu principal', // se_autofocusmenu
    'Caminho completo no título', // se_fullpath
    'Definir diálogo como modal', // se_modaldial
    'Altura fonte', // se_fontsize
    'Nome fonte', // se_fontname
    'Sem confirmação para deletar linha', // se_confirmdel
    'Circuito piscando', // se_blinkcaret
    'Redesenhar tela', // se_repaintcanvas
    'Editor de código-fonte', // se_groupsourceeditor
    'Use essas opções', // se_usedefaulteditoroptions
    'Adicionar espaço após "," ao auto-analisar', // se_addwhiteaftercomma
    'Quando um arquivo foi alterado', // se_groupfilechange
    'Sem diálogo => recarregar o novo', // se_filereload
    'Sem diálogo => manter o antigo', // se_filenoload
    'Diálogo pergunta o que fazer ...' // se_fileaskload
    );

  pt_projectoptionstext: projectoptionsaty = (
    'Opções de projeto', // po_projectoptions
    'Editor', // po_editor
    'Linha margem', // po_rightmarginline
    'Mark Brackets', // po_markbrackets
    'Números de linha', // po_linenumbers
    'Mark Pairwords', // po_markpairwords
    'Cortar espaço branco'#10'on salvar', // po_trimtrailing
    'Recuo automático', // po_autoindent
    'Sem editor de código-fonte', // po_nosource
    'Tab indent', // po_tabindent
    'Guia de espaço', // po_spacetab
    'Mostrar guias', // po_showtabs
    'Fonte com suavização de serrilhado', // po_antialisedfont
    'Codificação', // po_encoding
    'Marcar cor', // po_markcolor

    'Stat cor', // po_statcolor
    'Scr Y', // po_scrollbary
    'Nb char', // po_nbchar
    'Estilo EOL', // po_eolstyle
    'Backup', // po_backup
    'Tabstops', // po_tabstops
    'Indentação', // po_indent
    'ExtS', // po_extraspace
    'Espaço extra entre linhas', // po_extraspacehint
    'Largura', // po_width
    'Altura', // po_height
    'Fonte', // po_font
    'Font Bk. color ', // po_fontbkcolor
    'Cor da fonte', // po_fontcolor
    'Filtro de arquivo', // po_filefilter
    'Nome', // po_name
    'Máscara de arquivo', // po_filemask
    'Arquivo de definição de sintaxe', // po_syntaxdeffile
    'Modelos de código', // po_codetemplate
    'Diretórios de modelo de código, extensão de arquivo = .mct', // po_fontcodetemplatedir
    'Selecione o diretório da unidade', // po_selectunitdir
    '&Depurador', // po_debuggerpage
    'Depurador Projecto', // po_projectdebugger
    'Pesquisa e diretórios', // po_searchdirectories
    'Caminho de pesquisa para obter informações sobre o código', // po_searchdirectorieshint
    'Selecione o diretório de origem', // po_selectsourcedir
    'Object &Base Directory (empty = Make Directory)', // po_objectbasedir
    'Selecionar diretório base de origem', // po_selectsourcebasedir
    'Definições', // po_define
    '&Sinais', // po_signals
    '&Exceção', // po_exception
    '&Alvo', // po_target
    'Iniciar gdb server command attach target', // po_startgdbattachtarget
    'Não espere pela saída', // po_nogdbserverexit
    'Antes de conectar o script gdb', // po_beforeconnect
    'Antes de carregar o script gdb', // po_beforeload
    'Antes de executar o script gdb', // po_beforerun
    'Depois de conectar o script gdb', // po_afterconnect
    'Depois de carregar o script gdb', // po_afterload
    'Iniciar gdb server command run target', // gdbservercommand
    'Aguarde antes de conectar', // po_gdbserverwait
    'Iniciar uma vez', // po_gdbserverstartonce
    'Comando de download', // po_uploadcommand
    'Processador', // po_gdbprocessor
    'Simulator', // po_gdbsimulator
    'gdb descarregar', // po_gdbdownload

    'BKPT de inicialização', // po_startupbkpt
    'Conexão de destino', // po_remoteconnection
    'Sempre baixar', // po_downloadalways
    'Sempre baixe antes de executar', // po_downloadalwayshint
    'Tempo limite de carregamento', // po_gdbloadtimeout
    'Consola &Externa', // po_externalconsole
    '&Stop on Exc', // po_stoponexception
    'Parar nas exceções', // po_stoponexceptionhint
    '&Acti-Break', // po_activateonbreak
    'Ativar no intervalo', // po_activateonbreakhint
    '&Valor'#10'Dica', // po_valuehints
    'Chamar GUI_DEB', // po_nodebugbeginend
    'Solte a garra do mouse pela parada do alvo. gdb às vezes trava com esta opção. ', // po_nodebugbeginendhint
    'Definir TT&Y', // po_settty
    'Levantar/pausa', // po_raiseonbreak
    'Levantar na pausa', // po_raiseonbreakhint
    '&FPC bugs', // po_fpcgdbworkaround
    'Use soluções alternativas para bugs FPC / gdb', // po_fpcgdbworkaroundhint
    'Debug alvo', // po_debugtarget
    'Comando xterm', // po_xtermcommand
    'Executar comando', // po_runcommand
    'Depurador padrão', // po_debugcommand
    'Depurar e opções', // po_debugoptions
    '&Make', // po_makepage

    'Coluna make por defeito', // po_defaultmake
    'Ficheiro principal', // po_mainfile
    'Seleccionar ficheiro principal', // po_selectmainfile
    'Nome ficheiro alvo', // po_targetfile
    'Selecionar arquivo de destino', // po_selecttargetfile
    'Compilador padrão', // po_makecommand
    'Selecione o comando make', // po_selectmakecommand
    'Mostrar linha de comando', // po_showcommandline
    'Copiar mensagens para o arquivo', // po_copymessages
    'Fechar mensagem', // po_closemessages
    'Verificar cabeçalho', // po_checkmethods
    'Verificar cabeçalhos de método', // po_checkmethodshint
    'Project Compiler', // po_projectcompiler
    'Comando antes', // po_commandbefore
    'Opções de criação', // po_makeoptions
    'Diretórios', // po_diretórios
    'Selecione o diretório da unidade', // po_unitdirs
    'Comando depois de', // po_commandafter
    'Exe Extension', // po_exeextension
    'Comentários', // po_comments
    'Criar diretório', // po_makedir
    'Selecione criar diretório', // po_selectmakedir
    'Cor do erro', // po_colorerror
    'Cor de Aviso', // po_colorwarning
    'Nota Cor', // po_colornote
    'Strip ESC', // po_stripmessageesc
    'Retirar sequências ESC na forma de mensagens e terminal', // po_stripmessageeschint
    'Mostrar console', // po_showconsole
    'Objetivo', // po_enablepurpose
    'Arquivo de saída de mensagem', // po_messageoutputfile
    'Selecionar arquivo de destino', // po_selectmessageoutputfile
    'Macros', // po_macros
    'Grupo ativo', // po_selectactivegroupgrid
    '&Alias da fonte', // po_fontaliaspage
    'Designers', // po_designers
    'Usuário e cores', // po_usercolors
    'Copiar o código "setcolormapvalue" para a área de transferência', // po_copycolor
    'F&ormat Macros', // po_formatmacro
    'Usado por formatfloatmse () e formatdatetimemse ()', // po_formatmacrohint
    'Modelos', // po_templates
    'Novo projeto', // po_newproject
    'Script antes da cópia', // po_scriptbeforecopy
    'Script após cópia', // po_scriptaftercopy
    'Novo arquivo', // po_newfile
    'Novo formulário', // po_newform
    'Ferramentas', // po_tools
    'Armazenamento', // po_storage
    'Infos', // po_infos
    'Nome completo do projeto', // po_projectfullname
    'Criador', // po_creator
    'Licença', // po_license
    'Data de criação' // po_projectdate

    );
    
   pt_sourceformtext: sourceformaty = (
       'Arquivo "',
       '" mudou.',
       'Existem modificações no buffer de edição também.',
       'Deseja recarregar do disco?',
       'Confirmação',
       '<nenhum>',
       'Deseja substituir:',
       'com:',
       '<novo>',
       'Syntaxdeffile:',
       'Texto',
       'não encontrado.',
       'Reiniciar do início do arquivo?',
       'Cancelar?',
       'Deseja substituir esta ocorrência?',
       'Vá para a linha número:',
       'Encontrar linha',
       'Existem modificações no buffer de edição também.'
    );
   

  pt_stockcaption: stockcaptionaty = (
    '', // sc_none
    'é inválido', // sc_is_invalid
    'Erro de formato', // sc_Format_error
    'O valor é obrigatório', // sc_Value_is_required
    'Erro', // sc_Error
    'Min', // sc_Min
    'Max', // sc_Max
    'Erro de intervalo', // sc_Range_error

    '&Desfazer', // sc_Undohk /// ///
    '&Refazer', // sc_Redohk // //
    '&Copiar', // sc_Copyhk // teclas de atalho //
    'Cu &t', // sc_Cuthk // //
    '&Paste', // sc_Pastehk // // teclas de atalho
    'Selecionar &tudo', // sc_Select_allhk /// //
    '&Inserir linha', // sc_insert_rowhk /// //
    '&Append Row', // sc_append_rowhk // hotkeys //
    '&Excluir linha', // sc_delete_rowhk /// ///

    '&Dir', // sc_Dirhk ///
    '&Home', // sc_homehk //
    '&Up', // sc_Uphk //
    '&Novo', // sc_New_dirhk // teclas de atalho
    '&Nome', // sc_Namehk //
    '&Mostrar arquivos ocultos', // sc_Show_hidden_fileshk //
    '&Filtro', // sc_Filterhk ///
    'Salvar', // sc_save
    'Abrir', // sc_open
    'Nome', // sc_name
    'Criar novo diretório', // sc_create_new_directory
    'Voltar', // sc_back
    'Avançar', // sc_forward
    'Up', // sc_up
    'Arquivo', // sc_file
    'existe, você deseja sobrescrever?', // sc_exists_overwrite
    'é modificado. Salvar? ', // sc_is_modified_save
    'AVISO', // sc_warningupper
    'ERROR', // sc_errorupper
    'Exceção', // sc_exception
    'Sistema', // sc_system
    'não existe', // sc_does_not_exist
    'PASSWORD', // sc_passwordupper
    'Digite a senha', // sc_enterpassword
    'Senha inválida!', // sc_invalidpassword
    'Não é possível ler o diretório', // sc_can_not_read_directory
    'Formato gráfico não suportado', // sc_graphic_not_supported
    'Erro de formato gráfico', // sc_graphic_format_error
    'MS Bitmap', // sc_MS_Bitmap
    'Ícone MS', // sc_MS_Icon
    'Imagem JPEG', // sc_JPEG_Image
    'Imagem PNG', // sc_PNG_Image
    'Imagem XPM', // sc_XPM_Image
    'Imagem PNM', // sc_PNM_Image
    'Imagem TARGA', // sc_TARGA_image
    'Imagem TIFF', // sc_TIFF_image
    'Todos', // sc_All
    'Confirmação', // sc_Confirmation
    'Excluir registro?', // sc_Delete_record_question
    'Copiar registro?', // sc_Copy_record_question
    'Fechar página', // sc_close_page
    'Primeiro', // sc_first
    'Prior', // sc_prior
    'Próximo', // sc_next
    'Último', // sc_last
    'Anexar', // sc_append
    'Eliminar', // sc_delete
    'Editar', // sc_edit
    'Post', // sc_post
    'Cancelar', // sc_cancel
    'Atualizar', // sc_refresh
    'Editar filtro', // sc_filter_filter
    'Editar filtro mínimo', // sc_edit_filter_min
    'Editar filtro máximo', // sc_filter_edit_max
    'Redefinir filtro', // sc_reset_filter
    'Filtrar', // sc_filter_on
    'Pesquisa', // sc_search
    'Edição automática', // sc_auto_edit
    'Copiar registro', // sc_copy_record
    'Diálogo', // sc_dialog
    'Inserir', // sc_insert
    'Copiar', // sc_copy
    'Colar', // sc_paste

    'Inserir linha', // sc_row_insert
    'Apêndice fila', // sc_row_append
    'Eliminar fila', // sc_row_delete
    'Desfazer', // sc_undo
    'Refazer', // sc_redo
    'Cut', // sc_cut
    'Selecionar tudo', // sc_select_all

    'Filtro desligado', // sc_filter_off
    'Retrato', // orientação de impressão do sc_portrait
    'Paisagem', // orientação de impressão do sc_landscape
    'Excluir linha?', // sc_Delete_row_question
    'linhas selecionadas?', // sc_selected_rows
    'Somente item único', // sc_Single_item_only
    'Copiar células', // sc_Copy_Cells
    'Colar células', // sc_Paste_Cells
    'Fechar', // sc_close
    'Maximizar', // sc_maximize
    'Normalizar', // sc_normalize
    'Minimizar', // sc_minimize
    'Tamanho fixo', // sc_fix_size
    'Flutuar', // sc_float
    'Fique por dentro', // sc_stay_on_top
    'Fique em segundo plano', // sc_stay_in_background
    'Bloquear filhos', // sc_lock_children
    'Sem bloqueio', // sc_no_lock
    'Input', // sc_input
    'Botão', // sc_button
    'Ligar', // sc_on
    'Desligar', // sc_off
    'Borda esquerda', // sc_leftborder
    'Borda superior', // sc_topborder
    'Borda direita', // sc_rightborder
    'Borda inferior', // sc_bottomborder
    'Início do texto', // sc_beginoftext
    'Fim do texto', // sc_endoftext
    'Inputmode', // sc_inputmode
    'Overwrite', // sc_overwrite
    'Excluído', // sc_deleted
    'Copiado', // sc_copied
    'Inserido', // sc_inserted
    'Colado', // sc_pasted
    'Retirado', // sc_withdrawn
    'Janela ativada', // sc_windowactivated
    'Menu', // sc_menu
    'Início do arquivo', // sc_bof
    'Fim do arquivo', // sc_eof
    'Saída de voz', // sc_voiceoutput
    'Fale de novo', // sc_speak novamente
    'Primeira coluna', // sc_firstcol
    'Primeira linha', // sc_firstrow
    'Última coluna', // sc_lastcol
    'Última linha', // sc_lastrow
    'Seleção', // sc_selection
    'Fale o caminho', // sc_speakpath
    'Botão desativado', // sc_disabledbutton
    'Primeiro campo', // sc_firstfield
    'Último campo', // sc_lastfield
    'Primeiro elemento', // sc_firstelement
    'Último elemento', // sc_lastelement
    'Mais lento', // sc_slower
    'Mais rápido', // sc_faster
    'Janela', // sc_window
    'Área', // sc_area
    'Área ativada', // sc_areaactivated
    'Diminuir o volume', // sc_volumedown
    'Aumentar o volume', // sc_volumeup
    'Cancelar discurso', // sc_cancelspeech
    'Alvo', // sc_target
    'Ver', // sc_view
    'Formulários', // sc_forms
    'Layout', // sc_layout
    'Sintaxe', // sc_syntax
    'Projeto', // sc_project
    'Editado', // sc_edited
    'Widgets', // sc_widgets
    'Configurações', // sc_settings
    'Sobre', // sc_about
    'Novo', // sc_newfile
    'Salvar como ...', // sc_saveas
    'Salvar tudo', // sc_saveall
    'Fechar tudo', // sc_closeall
    'Imprimir', // sc_print
    'Sair', // sc_quit
    'Linha', // sc_line
    'Pesquisar novamente', // sc_search_again
    'Pesquisar de volta', // sc_search_back
    'Localizar e substituir', // sc_find_replace
    'Encontrar em arquivos', // sc_find_infile
    'Lista de procedimentos', // sc_proclist
    'Selecionar página de edição', // sc_select_edit_Page
    'Copiar palavra no cursor', // sc_Copy_word_cursor
    'Copiar LaTeX', // sc_copy_latex
    'Indentar', // sc_ident
    'Desindentar', // sc_uident
    'Ambiente', // sc_environment
    'Processo de anexação', // sc_attachprocess
    'Anexe alvo', // sc_attachtarget
    'Desprender alvo', // sc_detachtarget
    'Descarregar', // sc_download
    'Ferramentas', // sc_tools
    'Make', // sc_make
    'Build', // sc_build
    'Abortar make', // sc_abortmake
    'Debug-Run', // sc_debugrun
    'Opções', // sc_options
    'Árvore', // sc_tree
    'Fonte', // sc_source
    'Abrir cópia', // sc_opencopy
    'Salvar cópia como', // sc_saveascopy
    'Beautifier', // sc_beautifier
    'Painéis', // sc_panels
    'Forçar ordem Z', // sc_forcezorder
    'Lista de árvores', // sc_treelist
    'Mensagens', // sc_messages
    'Encontrar resultado', // sc_findresult
    'Comandante', // sc_commander
    'Símbolos', // sc_symbols
    'Relógios', // sc_watches
    'Pilha', // sc_stack
    'Fios', // sc_threads
    'CPU', // sc_cpu
    'Assembler', // sc_assembler
    'Pontos parada', // sc_breakpoints
    'Pontos vigilância', // sc_watchpoints
    'Memória', // sc_memory
    'Console de destino', // sc_targetconsole
    'Alternar forma / unidade', // sc_toggleformunit
    'Módulos MSE', // sc_msemod
    'Fechar todos os módulos MSE', // sc_closeallmsemod
    'Configurações gerais', // sc_generalsettings
    'Configurações extras', // sc_extrasettings
    'Idiomas', // sc_lang
    'Configurar widgets', // sc_configwidgets
    'Configurar compiladores', // sc_configcompilers
    'Configurar depuradores', // sc_configdebuggers
    'Temas', // sc_themes
    'Directório', // sc_directory
    'Sem ícones', // sc_noicons
    'Sem lateral', // sc_themes
    'Compacto', // sc_compact
    'Abrir projeto', // sc_openproject
    'Abrir arquivo', // sc_openfile
    'Path', // sc_path
    'Outro', // sc_other
    'Comando de impressão', // sc_printcommand
    'Atalho', // sc_shortcut
    'Valor', // sc_value
    'Sensível a maiúsculas e minúsculas', // sc_casesensitive
    'Selecionado apenas', // sc_selectedonly
    'Palavra inteira', // sc_wholeword
    'Texto para encontrar', // sc_texttofind
    'Pesquisar no arquivo atual', // sc_searchincurrentfile
    'Pesquisar em arquivos abertos', // sc_searchininopenfiles
    'Pesquisar no diretório do projeto', // sc_searchinprojectdir
    'Pesquisar nos diretórios', // sc_searchindirectories
    'Incluir subdiretórios', // sc_includesubdir
    'Substituir', // sc_replace
    'Substituir tudo', // sc_replace tudo
    'Substituir por', // sc_replacewith
    'Solicitar ao substituir', // sc_promptonreplace
    'Paleta de componentes', // sc_componentspalette
    'Encontrar componentes', // sc_findcomponent
    'Reset', // sc_reset
    'Step', // sc_cstep
    'Instrução de etapa', // sc_stepinstruction
    'Próxima instrução', // sc_nextinstruction
    'Reiniciar o depurador', // sc_restartdebugger
    'Alternar ponto de interrupção', // sc_togglebreakpoint
    'Alternar ponto de interrupção habilitado', // sc_tooglebreakpointenable
    'Ligado / desligado a dica de linhas executadas', // sc_execlinehinton
    'Por favor, compile primeiro.', // sc_compileitfirst
    'Concluir', // sc_finish
    'Inglês', // sc_English
    'Russo', // sc_Russian
    'Francês', // sc_french
    'Alemão', // sc_german
    'Espanhol', // sc_spanish
    'Português',     //sc_portuguese
    'Definir como padrão', // sc_setasdefault
    'Anfitrião', // sc_host
    'Copyright' // sc_copyright  

  );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := 'Excluir linha selecionada?'
    else
      Result := 'Excluir ' + inttostrmse(vinteger) + ' linhas selecionadas?';
end;

const
  pt_textgenerator: defaultgeneratortextty = (
              {$ifdef FPC} @{$endif}delete_n_selected_rows //tg_delete_n_selected_rows
    );

initialization
  registerlangconsts(langnames[la_pt], @pt_mainformtext, @pt_sourceformtext, @pt_projectoptionscontext, @pt_actionsmoduletext,
   @pt_settingstext, @pt_projectoptionstext, @pt_stockcaption, @pt_modalresulttext,
    @pt_modalresulttextnoshortcut, @pt_textgenerator);
end.

