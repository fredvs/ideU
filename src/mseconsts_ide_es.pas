{ MSEgui Copyright (c) 1999-2006 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    Spanish translation by Julio Jimenez Borreguero.

}
unit mseconsts_ide_es;

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
  es_modalresulttext: defaultmodalresulttextty =
    ('',                  //mr_none
    '',                   //mr_canclose
    '',                   //mr_windowclosed
    '',                   //mr_windowdestroyed
    '',                   //mr_escape
    '',                   //mr_f10
    '',                   //mr_exception
    '&Cancelar',          //mr_cancel
    '&Abortar',           //mr_abort
    '&OK',                //mr_ok
    '&S'#0237,            //mr_yes
    '&No',                //mr_no
    '&Todo',              //mr_all
    '&S'#0237' &todo',    //mr_yesall
    'N&o todo',           //mr_noall
    '&Ignorar',           //mr_ignore
    'O&mitir',            //mr_skip
    'Omitir &todo',       //mr_skipall
    'Co&ntinuar'          //mr_continue
    );

  es_modalresulttextnoshortcut: defaultmodalresulttextty =
    ('',                 //mr_none
    '',                  //mr_canclose
    '',                  //mr_windowclosed
    '',                  //mr_windowdestroyed
    '',                  //mr_escape
    '',                  //mr_f10
    '',                  //mr_exception
    'Cancelar',          //mr_cancel
    'Abortar',           //mr_abort
    'OK',                //mr_ok
    'S'#0237,            //mr_yes
    'No',                //mr_no
    'Todo',              //mr_all
    'S'#$00ED' todo',    //mr_yesall
    'No todo',           //mr_noall
    'Ignorar',           //mr_ignore
    'Omitir',            //mr_skip
    'Omitir todo',       //mr_skipall
    'Continuar'          //mr_continue
    );

  es_settingstext: isettingsaty          = (
    'Aplicar',                     //se_apply
    'Configuración asistencia-voz sak', //se_groupassistive
    'Directorio principal de sakit', //se_sakitdir
    'Habilitar sak al cargar',     //se_enableassistive
    'Disposición del sistema',    //se_groupsystemlayout
    'Directorios universales',     //se_universalpath
    'Sin manejo de pedidos Z',     //se_nozorder
    'Mayús para seleccionar palabra', //se_doubleclic
    'Enfoque automático en menú', //se_autofocusmenu
    'Ruta completa en título-proyecto', //se_fullpath
    'Establecer diálogos como modales', //se_modaldial
    'Altura fuente',               //se_fontsize
    'Nombre fuente',               //se_fontname
    'No confirmación para eliminar fila', //se_confirmdel
    'Intercalación intermitente', //se_blinkcaret
    'Repintar canvas',             //se_repaintcanvas
    'Editor de fuente',            //se_groupsourceeditor
    'Usa esas opciones',           //se_usedefaulteditoroptions
    'Espacio tras coma al auto-parsing', //se_addwhiteaftercomma
    'Cuando un archivo ha cambiado:', //se_groupfilechange
    'Sin diálogo => cargar el nuevo', //se_filereload
    'Sin diálogo => mantener el viejo', //se_filenoload
    'Un diálogo pregunta qué hacer ...', //se_fileaskload
    'Rectángulo alrededor selección' //se_rectanglearea
    );

  es_actionsmoduletext: actionsmoduleaty = (
    'Configurar ideU',
    'Identificacion de proceso',
    'Adjuntar al proceso',
    'Clase de módulo desconocida para "',
    'Componente heredado "',
    '"no se puede eliminar.',
    'ERROR',
    'Hacer abortado.',
    'Descarga abortada.',
    'Runerror con "',
    'Error: Timeout.',
    'Haciendo.',
    'Haz que no corras.',
    'Descargando.',
    'La descarga no se está ejecutando',
    '" corriendo.',
    'Texto',
    'Herencia de forma recursiva de "',
    'Componente "',
    '"existe.',
    'Ancestro de "',
    '" extraviado.',
    'Módulo "',
    'Nombre inválido "',
    'Nombre de método no válido',
    'Módulo no encontrado',
    'Método no encontrado',
    'Método publicado (gestionado)',
    'no existe.',
    '¿Desea eliminar el evento?',
    'ADVERTENCIA',
    'Método',
    'tiene diferentes parámetros.',
    'Un módulo "',
    '"ya está abierto.',
    'Referencias no resueltas a',
    'Módulo (s):',
    'No se puede leer el archivo de formulario "',
    'Nombre de componente no válido.',
    'Excepción no válida',
    'Instrumentos',
    'Formularios',
    'Fuente',
    'Todos los archivos',
    'Programa MSE',
    'Unidad MSE',
    'Archivo de texto MSE',
    'Forma principal',
    'Forma simple',
    'Forma de acoplamiento',
    'Módulo de datos',
    'Subformulario',
    'Scrollboxform',
    'Tabform',
    'Dockpanel',
    'Reporte',
    'Scriptform',
    'Forma heredada',
    '¿Desea reemplazar la configuración por',
    'El archivo "',
    '¿Quieres sobrescribir?',
    'Desconocido',
    'Error',
    'Puesta en marcha',
    'Excepción',
    'GDB murió',
    'Breakpoint hit',
    'Watchpoint activado',
    'Leer Watchpoint activado',
    'Access Watchpoint activado',
    'Rango de escalonamiento final',
    'Función terminada',
    'Salió normalmente',
    'Salido',
    'Separado',
    'Señal recibida',
    'Detener error',
    'No se puede leer el proyecto',
    'Sobre',
    'Inspector de objetos',
    'Almacén de componentes',
    'Proceso de conexión',
    'Cargando'
    );

  es_mainformtext: mainformaty           = (
    'Referencias no resueltas en',
    'para',
    '¿Desea buscar en el archivo de formulario?',
    'ADVERTENCIA',
    'Formfile para',
    'Formfiles',
    'Jerarquía de formas recursivas para "',
    'ERROR',
    'Tipo de clase',
    'extraviado.',
    'Proyecto',
    'es modificado. ¿Ahorrar?',
    'Confirmación',
    'No es posible abrir el archivo "',
    '*** Corriendo ***',
    'Descargando',
    'Descargado',
    'Iniciar comando del servidor gdb "',
    '" corriendo.',
    'Iniciar el servidor gdb',
    'error de inicio del servidor gdb',
    'inicio del servidor gdb cancelado.',
    'No se puede ejecutar el comando start gdb.',
    'Uploadcommand "',
    'Error de descarga***',
    'Descarga finalizada.',
    'Descarga cancelada.',
    'Expediente "',
    '" extraviado.',
    '"existe.',
    'Nuevo',
    'Seleccionar antepasado',
    'Nueva forma',
    'Archivos Pascal',
    'nuevo',
    'No se puede cargar el proyecto "',
    'Seleccionar plantilla de proyecto',
    'Archivos de proyecto',
    'Todos los archivos',
    'Seleccionar archivo de programa',
    'Archivos de programa Pascal',
    'Archivos de programa C',
    'Nuevo proyecto',
    'No se puede iniciar el proceso',
    'Proceso',
    'corriendo.',
    'Proceso terminado',
    'El proceso terminó normalmente.',
    'Hacer *** ERROR ***',
    'Hacer OK.',
    'La fuente ha cambiado, ¿deseas rehacer el proyecto?',
    'Cargar diseño de ventana',
    'Área de atraque'
    );

  es_sourceformtext: sourceformaty       = (
    'El archivo "',
    '" ha cambiado.',
    'También hay modificaciones en el búfer de edición.',
    '¿Desea recargar desde el disco?',
    'Confirmación',
    '<ninguno>',
    '¿Desea reemplazar:',
    'con:',
    '<nuevo>',
    'Syntaxdeffile:',
    'Texto',
    'extraviado.',
    '¿Reiniciar desde el principio del archivo?',
    '¿Cancelar?',
    '¿Desea reemplazar esta ocurrencia?',
    'Ir al número de línea:',
    'Buscar línea',
    'También hay modificaciones en el búfer de edición.'
    );

  es_projectoptionscontext: projectoptionsconaty = (
    'La codificación incorrecta puede dañar sus archivos de origen.',
    '¿Desea establecer la codificación en',
    '*** ADVERTENCIA ***',
    'Colgar',
    'Interrumpir',
    'Dejar',
    'Instrucción ilegal',
    'Traza trampa',
    'Abortar',
    'Error de BUS',
    'Excepción de coma flotante',
    'Matar',
    'Señal 1 definida por el usuario',
    'Violación de segmentación',
    'Señal 2 definida por el usuario',
    'Tuberia rota',
    'Despertador',
    'Terminación',
    'Fallo de pila',
    'El estado del niño ha cambiado',
    'Continuar',
    'Stop, imbloqueable',
    'Parada del teclado',
    'Lectura de fondo de tty',
    'Escritura de fondo en tty',
    'Condición urgente en el encaje',
    'Límite de CPU excedido',
    'Excede el límite de tamaño de archivo',
    'Despertador virtual',
    'Despertador de perfiles',
    'Cambio de tamaño de ventana',
    'E / S ahora es posible',
    'Reinicio por falla de energía'
    );

  es_projectoptionstext: projectoptionsaty = (
    'Opciones de proyecto', // project options
    'Editor',          // po_editor
    'Margen derecho',  // po_rightmarginline
    'Soportes de marca', //  po_markbrackets
    'Números de línea', //  po_linenumbers
    'Marcar pares de palabras', //  po_markpairwords
    'Recorte los espacios en blanco'#10'finales al guardar', //  po_trimtrailing
    'Sangría automática', //  po_autoindent
    'Sin editor de fuentes', //  po_nosource
    'Sangría de tabulación', //  po_tabindent
    'Pestaña de'#10'espacio', //  po_spacetab
    'Mostrar pestañas', //  po_showtabs
    'Fuente anti aliased', //  po_antialiasedfont
    'Codificación',   //  po_encoding
    'Color de la marca', //  po_markcolor 
    'Color de estad.', // po_statcolor
    'Desp. Y',         // po_scrollbary
    'Núm. cara.',     // po_nbchar
    'Estilo EOL',      //  po_eolstyle
    'Respaldo',        //  po_backup
    'Tabstops',        //  po_tabstops
    'Sangrar',         //  po_indent
    'Esp.X',           //  po_extraspace
    'Espacio extra entre líneas', //  po_extraspacehint
    'Ancho',           //  po_width
    'Altura',          //  po_height
    'Fuente',          //  po_font
    'Color fondo de fuente', //  po_fontbkcolor
    'Color de fuente', //  po_fontcolor
    'Filtro archivos', //  po_filefilter
    'Nombre',          //  po_name
    'Máscara archivo', //  po_filemask
    'Archivo definición sintaxis', //  po_syntaxdeffile
    'Plantillas de código', //  po_codetemplate
    'Directorios plantillas de código, extensión de archivo = .mct', //  po_fontcodetemplatedir
    'Seleccionar directorio', // po_selectunitdir
    '&Depurador', // po_debuggerpage
    'Project Debugger', // po_projectdebugger
    '&Directorios de búsqueda', // po_searchdirectories
    'Ruta de búsqueda para obtener información sobre el código', // po_searchdirectorieshint
    'Seleccionar directorio de origen', // po_selectsourcedir
    'Directorio base de objetos (vacío = Crear directorio)', // po_objectbasedir
    'Seleccionar directorio de origen', // po_selectsourcebasedir
    'Defi&ne',  // po_defines
    '&Señales', // po_signals
    '&Excepción', // po_exception
    '&Objetivo', // po_target
    'Iniciar comando del servidor gdb adjuntar destino', // po_startgdbattachtarget
    'No espere a salir', // po_nogdbserverexit
    'Script gdb de antes de conectar', // po_beforeconnect
    'Script gdb de antes de la carga', // po_beforeload
    'Script gdb de antes de ejecutar', // po_beforerun
    'Script gdb de después de conectar', // po_afterconnect
    'Script gdb de después de la carga', // po_afterload
    'Inicie comando servidor gdb destino ejecución', // gdbservercommand
    'Espere antes conectarse', // po_gdbserverwait
    'Empezar una vez', // po_gdbserverstartonce
    'Comando de descarga', // po_uploadcommand
    'Procesador', // po_gdbprocessor
    'Simulador', // po_gdbsimulator
    'gdb-descargar', // po_gdbdownload
    'Inicio BKPT', // po_startupbkpt
    'Conexión de destino', // po_remoteconnection
    'Descargar siempre', // po_downloadalways
    'Descargar siempre antes de ejecutar', // po_downloadalwayshint
    'Tiempo espera de carga', // po_gdbloadtimeout
    '&Consola externa', // po_externalconsole
    '&Det.exc.', // po_stoponexception
    'Deténgase en caso de excepción', // po_stoponexceptionhint
    '&Act.desc.', // po_activateonbreak
    'Activar en descanso', // po_activateonbreakhint
    '&Valor'#10'pistas',  // po_valuehints
    'Llame GUI_DEB', // po_nodebugbeginend
    'Suelte el agarre del mouse al detener el objetivo. gdb a veces falla con esta opción.', // po_nodebugbeginendhint
    'Establecer TT&Y', // po_settty
    '&Leva/desc', // po_raiseonbreak
    'Levantar en descanso', // po_raiseonbreakhint
    '&Errores FPC', // po_fpcgdbworkaround
    'Utilice soluciones alternativas para errores de FPC / gdb', // po_fpcgdbworkaroundhint
    'Objetivo &depuración', // po_debugtarget
    'Comando xterm', // po_xtermcommand
    '&Ejecutar comando', // po_runcommand
    '&Depurador predeterminado', // po_debugcommand
    'Opciones depuración', // po_debugoptions
    '&Hacer',   // po_makepage

    'Hacer predeterminado', // po_defaultmake
    'Archivo principal', // po_mainfile
    'Seleccionar archivo principal', // po_selectmainfile
    'Nombre de destino', // po_targetfile
    'Seleccionar destino', // po_selecttargetfile
    'Compilador predeterminado', // po_makecommand
    'Seleccionar comando Hacer', // po_selectmakecommand
    'Mostrar línea comando', // po_showcommandline
    'Copiar mensajes al archivo', // po_copymessages
    'Cerrar mensajes', // po_closemessages
    'Comprobar encabezados', // po_checkmethods
    'Comprobar los encabezados de los métodos', // po_checkmethodshint
    'Compilador proyecto', // po_projectcompiler
    'Comando antes', // po_commandbefore
    'Hacer opciones', // po_makeoptions
    'Directorios', // po_directories
    'Seleccionar directorio', // po_unitdirs
    'Comando después', // po_commandafter
    'Extensión Exe', // po_exeextension
    'Comentarios', // po_comments
    'Directorio Hacer', // po_makedir
    'Directorio Hacer', // po_selectmakedir
    'Color error', // po_colorerror
    'Color advertencia', // po_colorwarning
    'Color nota', // po_colornote
    'Eliminar ESC', // po_stripmessageesc
    'Eliminar secuencias ESC en Mensajes y Terminal', // po_stripmessageeschint
    'Muestra Consola', // po_showconsole
    'Objetivo', //po_enablepurpose
    'Archivo mensajes', // po_messageoutputfile
    'Archivo mensajes', // po_selectmessageoutputfile
    'Macros',   // po_macros
    'Grupo activo', // po_selectactivegroupgrid
    '&Alias fuente', // po_fontaliaspage
    'Diseñadores', // po_designers
    'Colores usuario', // po_usercolors
    'Copiar el código "setcolormapvalue" al portapapeles', // po_copycolor
    'F&ormat Macros', // po_formatmacro
    'Usado por formatfloatmse() y formatdatetimemse()', // po_formatmacrohint
    'Plantillas', // po_templates
    'Nuevo proyecto', // po_newproject
    'Guión antes copiar', // po_scriptbeforecopy
    'Guión tras copiar', // po_scriptaftercopy
    'Archivo nuevo', // po_newfile
    'Nueva forma', // po_newform
    'Instrumentos', // po_tools
    'Almacen',  // po_storage
    'Infos',    // po_infos
    'Nombre completo del proyecto', // po_projectfullname
    'Creador',  // po_creator
    'Licencia', // po_license
    'Fecha de creación' // po_projectdate
    );

  es_stockcaption: stockcaptionaty       = (
    '',                                              //sc_none
    'es inv'#0225'lido',                             //sc_is_invalid
    'Error de formato',                              //sc_Format_error
    'Debe introducir un valor',                      //sc_Value_is_required
    'Error',                                         //sc_Error
    'M'#0237'n.',                                    //sc_Min
    'M'#0225'x.',                                    //sc_Max
    'Error de rango',                                //sc_Range_error

    '&Deshacer',                                     //sc_Undohk        ///         ///
    '&Rehacer',                                      //sc_Redohk         //          //
    '&Copiar',                                       //sc_Copyhk         // hotkeys  //
    'C&ortar',                                       //sc_Cuthk          //          //
    '&Pegar',                                        //sc_Pastehk        //          // hotkeys
    '&Select all',                                   //sc_Select_allhk  ///          //
    '&Insertar fila',                                //sc_insert_rowhk  ///          //
    '&A'#0241'adir fila',                            //sc_append_rowhk  // hotkeys  //
    '&Borrar fila',                                  //sc_delete_rowhk  ///         ///

    '&Carpetas',                                     //sc_Dir               ///
    '&Principal',                                    //sc_home               //
    '&Subir un nivel',                               //sc_Up                 //
    'Crear carpeta',                                 //sc_New_dir            // hotkeys
    'N&ombre',                                       //sc_Name               //
    '&Mostrar archivos ocultos',                     //sc_Show_hidden_files  //
    '&Filtro',                                       //sc_Filter            ///
    'Guardar',                                       //sc_save
    'Abrir',                                         //sc_open
    'Nombre',                                        //sc_name1
    'Crear una carpeta nueva',                       //sc_create_new_directory
    'Atr'#0225's',                                   //sc_back
    'Adelante',                                      //sc_forward
    'Arriba',                                        //sc_up
    'Archivo',                                       //sc_file
    'existe, '#0191'quiere sobreescribirlo?',        //sc_exists_overwrite
    'ha sido modificado. '#0191'Guardar?',           //sc_is_modified_save
    'ADVERTENCIA',                                   //sc_warningupper
    'ERROR',                                         //sc_errorupper
    'Excepci'#0243'n',                               //sc_exception
    'Sistema',                                       //sc_system
    'no existe',                                     //sc_does_not_exist
    'CONTRASE'#0209'A',                              //sc_passwordupper
    'Introduzca contrase'#0241'a',                   //sc_enterpassword
    #0161'contrase'#0241'a incorrecta!',             //sc_invalidpassword
    'No puedo leer la carpeta',                      //sc_can_not_read_directory
    'Formato gr'#0225'fico no soportado',            //sc_graphic_not_supported
    'Error de formato gr'#0225'fico',                //sc_graphic_format_error
    'Bitmap MS',                                     //sc_MS_Icon
    'Icono MS',                                      //sc_MS_Icon
    'Imagen JPEG',                                   //sc_JPEG_Image
    'Imagen PNG',                                    //sc_PNG_Image
    'Imagen XPM',                                    //sc_XPM_Image
    'Imagen PNM',                                    //sc_PNM_Image
    'Imagen TARGA',                                  //sc_TARGA_image
    'Imagen TIFF',                                   //sc_TIFF_image
    'Todo',                                          //sc_All
    'Confirme',                                      //sc_Confirmation
    #0191'Borrar el registro?',                      //sc_Delete_record_question
    #0191'Copiar el registro?',                      //sc_Copy_record_question
    'Cerrar p'#0225'gina',                           //sc_close_page
    'Primero',                                       //sc_first
    'Anterior',                                      //sc_prior
    'Siguiente',                                     //sc_next
    #0218'ltimo',                                    //sc_last
    'A'#0241'adir',                                  //sc_append
    'Borrar',                                        //sc_delete
    'Editar',                                        //sc_edit
    'Guardar',                                       //sc_post
    'Cancelar',                                      //sc_cancel
    'Refrescar',                                     //sc_refresh
    'Filtro edici'#0243'n',                          //sc_filter_filter
    'Filtro edici'#0243'n m'#0237'nimo',             //sc_edit_filter_min
    'Filtro edici'#0243'n m'#0225'ximo',             //sc_filter_edit_max
    'Reiniciar filtro',                              //sc_reset_filter
    'Filtro activo',                                 //sc_filter_on
    'Buscar',                                        //sc_search
    'Edici'#0243'n autom'#0225'tica',                //sc_autoedit
    'Copiar registro',                               //sc_copy_record
    'Di'#0225'logo',                                 //sc_dialog
    'Insertar',                                      //sc_insert
    'Copiar',                                        //sc_copy
    'Pegar',                                         //sc_paste
    'Insertar fila',                                 //sc_row_insert
    'A'#0241'adir fila',                             //sc_row_append
    'Borrar fila',                                   //sc_row_delete
    'Deshacer',                                      //sc_undo
    'Rehacer',                                       //sc_redo
    'Cortar',                                        //sc_cut
    'Seleccionar todo',                              //sc_select_all
    'Filtro apagado',                                //sc_filter_off
    'Vertical',                                      //sc_portrait print orientation
    'Apaisado',                                      //sc_landscape print orientation
    #0191'Borrar fila?',                             //sc_Delete_row_question
    'filas seleccionadas?',                          //sc_selected_rows
    'un elemento solamente',                         //sc_Single_item_only
    'Copiar Celdas',                                 //sc_Copy_Cells
    'Pegar Celdas',                                  //sc_Paste_Cells
    'Cerrar',                                        //sc_close
    'Maximizar',                                     //sc_maximize
    'Restaurar',                                     //sc_normalize
    'Minimizar',                                     //sc_minimize
    'Ajustar tama'#0241'o',                          //sc_fix_size
    'Flotar',                                        //sc_float
    'Permanecer en el primer plano',                 //sc_stay_on_top
    'Permanecer en el fondo',                        //sc_stay_in_background
    'Bloquear hijas',                                //sc_lock_children
    'Sin bloquear',                                  //sc_no_lock
    'Entrada',                                       //sc_input
    'Bot'#0243'n',                                   //sc_button
    'Encendido',                                     //sc_on
    'Apagado',                                       //sc_off
    'Borde izquierdo',                               //sc_leftborder
    'Borde superior',                                //sc_topborder
    'Borde derecho',                                 //sc_rightborder
    'Borde inferior',                                //sc_bottomborder
    'Principio del texto',                           //sc_beginoftext
    'Fin del texto',                                 //sc_endoftext
    'Modo entrada',                                  //sc_inputmode
    'Sobrescribir',                                  //sc_overwrite
    'Borrado',                                       //sc_deleted
    'Copiado',                                       //sc_copied
    'Insertado',                                     //sc_inserted
    'Pegado',                                        //sc_pasted
    'Retirado',                                      //sc_withdrawn
    'Ventana activada',                              //sc_windowactivated
    'Men'#0250,                                      //sc_menu
    'Principio del archivo',                         //sc_bof
    'Fin del archivo',                               //sc_eof
    'Salida de voz',                                 //sc_voiceoutput
    'Hablar de nuevo',                               //sc_speakagain
    'Primera columna',                               //sc_firstcol
    'Primera fila',                                  //sc_firstrow
    #0218'ltima columna',                            //sc_lastcol
    #0218'ltima fila',                               //sc_lastrow
    'Selecci'#0243'n',                               //sc_selection
    'Ruta de hablar',                                //sc_speakpath
    'Deshabilitar bot'#0243'n',                      //sc_disabledbutton
    'Primer campo',                                  //sc_firstfield
    #$00DA'ltimo campo',                             //sc_lastfield
    'Primer elemento',                               //sc_firstelement
    #$00DA'ltimo elemento',                          //sc_lastelement
    'M'#$00E1's lento',                              //sc_slower
    'M'#$00E1's r'#$00E1'pido',                      //sc_faster
    'Ventana',                                       //sc_window
    #$00C1'rea',                                     //sc_area
    #$00C1'rea activada',                            //sc_areaactivated
    'Bajar volumen',                                 //sc_volumedown
    'Subir volumen',                                 //sc_volumeup
    'Cancelar habla',                                //sc_cancelspeech
    'Objetivo',                                      //sc_target
    'Mirar',                                         //sc_view
    'Formas',                                        //sc_forms
    'Diseño',                                       //sc_layout
    'Sintaxis',                                      //sc_syntax
    'Proyecto',                                      //sc_project
    'Editado',                                       //sc_edited
    'Widgets',                                       //sc_widgets
    'Ajustes',                                       //sc_settings
    'Acerca de',                                     //sc_about
    'Nuevo',                                         //sc_newfile
    'Guardar como ...',                              //sc_saveas
    'Salvar a todos',                                //sc_saveall
    'Cierra todo',                                   //sc_closeall
    'Imprimir',                                      //sc_print
    'Dejar',                                         //sc_quit 
    'Línea',                                        //sc_line
    'Busca de nuevo',                                //sc_search_again
    'Buscar atrás',                                 //sc_search_back
    'Buscar y reemplazar',                           //sc_find_replace
    'Buscar en archivos',                            //sc_find_infile
    'Lista de procedimientos',                       //sc_proclist
    'Seleccionar página de edición',               //sc_select_edit_Page
    'Copiar palabra en el cursor ',                  //sc_Copy_word_cursor
    'Copiar LaTeX',                                  //sc_copy_latex
    'Sangrar',                                       //sc_indent
    'Sin sangría',                                  //sc_unindent
    'Entorno',                                       //sc_environment
    'Adjuntar proceso',                              //sc_attachprocess
    'Adjuntar objetivo',                             //sc_attachtarget
    'Separar objetivo',                              //sc_detachtarget
    'Descargar',                                     //sc_download
    'Instrumentos',                                  //sc_tools
    'Hacer',                                         // sc_make 
    'Construir',                                     // sc_build 
    'Cancelar hacer',                                // sc_abortmake 
    'Depurar/Ejecutar',                              // sc_debugrun 
    'Opciones',                                      // sc_options 
    'Árbol',                                        // sc_tree 
    'Fuente',                                        // sc_source 
    'Abrir copia',                                   // sc_opencopy 
    'Guardar copia como ...',                        // sc_saveascopy 
    'Embellecedor',                                  // sc_beautifier
    'Paneles',                                       // sc_panels
    'Forzar orden Z',                                // sc_forcezorder
    'Lista de árboles',                             // sc_treelist
    'Mensajes',                                      // sc_messages
    'Resultado de encontrar',                        // sc_findresult
    'Comandante',                                    // sc_commander
    'Simbolos',                                      // sc_symbols
    'Vigilia',                                       // sc_watches
    'Apilar',                                        // sc_stack
    'Hilos',                                         // sc_threads
    'CPU',                                           // sc_cpu
    'Assembler',                                     // sc_assembler
    'Puntos de interrupción',                       // sc_breakpoints
    'Puntos de observación',                        // sc_watchpoints 
    'Memoria',                                       // sc_memory
    'Consola de destino',                            // sc_targetconsole 
    'Alternar forma/unidad',                         // sc_toggleformunit
    'Módulos MSE',                                  // sc_msemod 
    'Cerrar todos los módulos MSE',                 // sc_closeallmsemod
    'Configuración general',                        // sc_generalsettings
    'Configuraciones extra',                         // sc_extrasettings
    'Idiomas',                                       // sc_lang
    'Configurar widgets',                            // sc_configwidgets
    'Configurar compiladores',                       // sc_configcompilers
    'Configurar depuradores',                        // sc_configdebuggers
    'Temas',                                         // sc_themes
    'Directorio',                                    // sc_directory
    'Sin iconos',                                    // sc_noicons
    'Sin lateral',                                   // sc_themes
    'Compacto',                                      // sc_compact 
    'Abre el proyecto',                              // sc_openproject
    'Abre el archivo',                               // sc_openfile
    'Ruta',                                          // sc_path
    'Otro',                                          // sc_other
    'Comando de impresión',                         // sc_printcommand
    'Atajo',                                         // sc_shortcut
    'Valor',                                      // sc_value
    'Case sensitive',                             // sc_casesensitive
    'Solo seleccionado',                          // sc_selectedonly
    'Toda palabra',                               // sc_wholeword
    'Texto para buscar',                          // sc_texttofind
    'Buscar en archivo actual',                   // sc_searchincurrentfile
    'Buscar en archivos abiertos',                // sc_searchinopenfiles 
    'Buscar en directorio proyecto',              // sc_searchinprojectdir
    'Buscar en directorios',                      // sc_searchindirectories
    'Incluir subdirectorios',                     // sc_includesubdir

    'Reemplazar',                                 // sc_replace
    'Reemplaza todo',                             // sc_replace all
    'Reemplazar con',                             // sc_replacewith
    'Preguntar al reemplazar',                    // sc_promptonreplace
    'Paleta de componentes',                      // sc_componentspalette
    'Encuentra componentes',                       // sc_findcomponent
    'Restablecer',                                // sc_reset
    'Paso',                                       // sc_cstep
    'Instrucción de paso',                       // sc_stepinstruction
    'Siguiente instrucción',                     // sc_nextinstruction
    'Reiniciar depurador',                        // sc_restartdebugger
    'Toggle breakpoint',                          // sc_togglebreakpoint
    'Alternar punto de interrupción habilitado', // sc_tooglebreakpointenable
    'Indicación de líneas ejecutadas activada / desactivada', // sc_execlinehinton
    'Por favor, compílelo primero.',               // sc_compileitfirst
    'Finalizar',                                  // sc_finish
    'Establecido predeterminado',                 // sc_setasdefault
    'Anfitrión',                                   // sc_host
    'Derechos de autor'                           // sc_copyright
    );

const
  es_langnamestext: array[0..5] of msestring = (
    'Inglés',                                // 0_English
    'Ruso',                                // 1_Russian
    'Francés',                                 // 2_french
    'Alemán',                                 // 3_german
    'Español',                                // 4_spanish
    'Portugués'                              //5_portuguese
    );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := #0191'Borrar la fila seleccionada?'
    else
      Result := #0191'Borrar ' + inttostrmse(vinteger) + ' filas seleccionadas?';
end;

const
  es_textgenerator: defaultgeneratortextty = (
              {$ifdef FPC} @{$endif}delete_n_selected_rows //tg_delete_n_selected_rows
    );

initialization
  registerlangconsts(langnames[la_es], @es_langnamestext, @es_mainformtext, @es_sourceformtext, @es_projectoptionscontext, @es_actionsmoduletext, @es_settingstext, @es_projectoptionstext,
    @es_stockcaption, @es_modalresulttext, @es_modalresulttextnoshortcut, @es_textgenerator);
end.

