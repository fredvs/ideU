{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
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
  msestockobjects,
  mseformatstr;

const

es_modalresulttext: defaultmodalresulttextty =
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
  '&S#0237',   {&Yes}
  '&No',   {&No}
  '&Todo',   {Yes &all}
  '&Todo',   {Yes &all}
  'N&o todo',   {N&o all}
  '&Ignorar',   {&Ignore}
  'O&mitir',   {&Skip}
  'Omitir &todo',   {Skip a&ll}
  'Co&ntinuar'   {Co&ntinue}
 );

es_modalresulttextnoshortcut: defaultmodalresulttextty =
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
  'S#0237',   {Yes}
  'No',   {No}
  'Todo',   {Yes all}
  'Todo',   {Yes all}
  'No todo',   {No all}
  'Ignorar',   {Ignore}
  'Omitir',   {Skip}
  'Omitir todo',   {Skip all}
  'Continuar'   {Continue}
 );

es_projectoptionscontext: projectoptionsconaty =
 (
  'La codificación incorrecta puede dañar sus archivos de origen.',   {Wrong encoding can damage your source files.}
  '¿Desea establecer la codificación en',   {Do you wish to set encoding to}
  '*** ADVERTENCIA ***',   {*** WARNING ***}
  'Colgar',   {Hangup}
  'Interrumpir',   {Interrupt}
  'Dejar',   {Quit}
  'Instrucción ilegal',   {Illegal instruction}
  'Traza trampa',   {Trace trap}
  'Abortar',   {Abort}
  'Error de BUS',   {BUS error}
  'Excepción de coma flotante',   {Floating-point exception}
  'Matar',   {Kill}
  'Señal 1 definida por el usuario',   {User-defined signal 1}
  'Violación de segmentación',   {Segmentation violation}
  'Señal 2 definida por el usuario',   {User-defined signal 2}
  'Tuberia rota',   {Broken pipe}
  'Despertador',   {Alarm clock}
  'Terminación',   {Termination}
  'Fallo de pila',   {Stack fault}
  'El estado del niño ha cambiado',   {Child status has changed}
  'Continuar',   {Continue}
  'Stop imbloqueable',   {Stop, unblockable}
  'Parada del teclado',   {Keyboard stop}
  'Lectura de fondo de tty',   {Background read from tty}
  'Escritura de fondo en tty',   {Background write to tty}
  'Condición urgente en el encaje',   {Urgent condition on socket}
  'Límite de CPU excedido',   {CPU limit exceeded}
  'Excede el límite de tamaño de archivo',   {File size limit exceeded}
  'Despertador virtual',   {Virtual alarm clock}
  'Despertador de perfiles',   {Profiling alarm clock}
  'Cambio de tamaño de ventana',   {Window size change}
  'E / S ahora es posible',   {I/O now possible}
  'Reinicio por falla de energía'   {Power failure restart}
 );

es_actionsmoduletext: actionsmoduleaty =
 (
  'Configurar ideU',   {Configure ideU}
  'Identificacion de proceso',   {Process ID}
  'Adjuntar al proceso',   {Attach to process}
  'Clase de módulo desconocida para "',   {Unknown moduleclass for "}
  'Componente heredado "',   {Inherited component "}
  '"no se puede eliminar.',   {" can not be deleted.}
  'ERROR',   {ERROR}
  'Hacer abortado.',   {Make aborted.}
  'Descarga abortada.',   {Download aborted.}
  'Runerror con "',   {Runerror with "}
  'Error: Timeout.',   {Error: Timeout.}
  'Haciendo.',   {Making.}
  'Haz que no corras.',   {Make not running.}
  'Descargando.',   {Downloading.}
  'La descarga no se está ejecutando',   {Download not running.}
  '" corriendo.',   {" running.}
  'Texto',   {Script}
  'Herencia de forma recursiva de "',   {Recursive form inheritance of "}
  'Componente "',   {Component "}
  '"existe.',   {" exists.}
  'Ancestro de "',   {Ancestor for "}
  '" extraviado.',   {" not found.}
  'Módulo "',   {Module "}
  'Nombre inválido "',   {Invalid name "}
  'Nombre de método no válido',   {Invalid methodname}
  'Módulo no encontrado',   {Module not found}
  'Método no encontrado',   {Method not found}
  'Método publicado (gestionado)',   {Published (managed) method}
  'no existe.',   {does not exist.}
  '¿Desea eliminar el evento?',   {Do you wish to delete the event?}
  'ADVERTENCIA',   {WARNING}
  'Método',   {Method}
  'tiene diferentes parámetros.',   {has different parameters.}
  'Un módulo "',   {A module "}
  '"ya está abierto.',   {" is already open.}
  'Referencias no resueltas a',   {Unresolved reference(s) to}
  'Módulo (s):',   {Module(s):}
  'No se puede leer el archivo de formulario "',   {Can not read formfile "}
  'Nombre de componente no válido.',   {Invalid component name.}
  'Excepción no válida',   {Invalid exception}
  'Instrumentos',   {T&ools}
  'Formularios',   {Forms}
  'Fuente',   {Source}
  'Todos los archivos',   {All Files}
  'Programa MSE',   {MSE Program}
  'Unidad MSE',   {MSE Unit}
  'Archivo de texto MSE',   {MSE Textfile}
  'Forma principal',   {Mainform}
  'Forma simple',   {Simple Form}
  'Forma de acoplamiento',   {Docking Form}
  'Módulo de datos',   {Datamodule}
  'Subformulario',   {Subform}
  'Scrollboxform',   {Scrollboxform}
  'Tabform',   {Tabform}
  'Dockpanel',   {Dockpanel}
  'Reporte',   {Report}
  'Scriptform',   {Scriptform}
  'Forma heredada',   {Inherited Form}
  '¿Desea reemplazar la configuración por',   {Do you want to replace the settings by}
  'El archivo "',   {File "}
  '¿Quieres sobrescribir?',   {Do you want to overwrite?}
  'Desconocido',   {Unknown}
  'Error',   {Error}
  'Puesta en marcha',   {Startup}
  'Excepción',   {Exception}
  'GDB murió',   {GDB died}
  'Breakpoint hit',   {Breakpoint hit}
  'Watchpoint activado',   {Watchpoint triggered}
  'Leer Watchpoint activado',   {Read Watchpoint triggered}
  'Access Watchpoint activado',   {Access Watchpoint triggered}
  'Rango de escalonamiento final',   {End stepping range}
  'Función terminada',   {Function finished}
  'Salió normalmente',   {Exited normally}
  'Salido',   {Exited}
  'Separado',   {Detached}
  'Señal recibida',   {Signal received}
  'Detener error',   {Stop error}
  'No se puede leer el proyecto',   {Can not read project}
  'Sobre',   {About}
  'Inspector de objetos',   {Object Inspector}
  'Almacén de componentes',   {Store Component}
  'Proceso de conexión',   {Attaching Process}
  'Cargando'   {Loading}
 );

es_mainformtext: mainformaty =
 (
  'Referencias no resueltas en',   {Unresolved references in}
  'para',   {to}
  '¿Desea buscar en el archivo de formulario?',   {Do you wish to search the formfile?}
  'ADVERTENCIA',   {WARNING}
  'Formfile para',   {Formfile for}
  'Formfiles',   {Formfiles}
  'Jerarquía de formas recursivas para "',   {Recursive form hierarchy for "}
  'ERROR',   {ERROR}
  'Tipo de clase',   {Classtype}
  'extraviado.',   {not found.}
  'Proyecto',   {Project}
  'es modificado. ¿Ahorrar?',   {is modified. Save?}
  'Confirmación',   {Confirmation}
  'No es posible abrir el archivo "',   {Unable to open file "}
  '*** Corriendo ***',   {*** Running ***}
  'Descargando',   {Downloading}
  'Descargado',   {Downloaded}
  'Iniciar comando del servidor gdb "',   {Start gdb server command "}
  '" corriendo.',   {" running.}
  'Iniciar el servidor gdb',   {Start gdb Server}
  'error de inicio del servidor gdb',   {gdb server start error}
  'inicio del servidor gdb cancelado.',   {gdb server start canceled.}
  'No se puede ejecutar el comando start gdb.',   {Can not run start gdb command.}
  'Uploadcommand "',   {Uploadcommand "}
  'Error de descarga***',   {Download ***ERROR***}
  'Descarga finalizada.',   {Download finished.}
  'Descarga cancelada.',   {Download canceled.}
  'El archivo "',   {File "}
  '" extraviado.',   {" not found.}
  '"existe.',   {" exists.}
  'Nuevo',   {New}
  'Seleccionar antepasado',   {Select ancestor}
  'Nueva forma',   {New form}
  'Archivos Pascal',   {Pascal Files}
  'nuevo',   {new}
  'No se puede cargar el proyecto "',   {Can not load Project "}
  'Seleccionar plantilla de proyecto',   {Select project template}
  'Archivos de proyecto',   {Project files}
  'Todos los archivos',   {All files}
  'Seleccionar archivo de programa',   {Select program file}
  'Archivos de programa Pascal',   {Pascal program files}
  'Archivos de programa C',   {C program files}
  'Nuevo proyecto',   {New Project}
  'No se puede iniciar el proceso',   {Can not start process}
  'Proceso',   {Process}
  'corriendo.',   {running.}
  'Proceso terminado',   {Process terminated}
  'El proceso terminó normalmente.',   {Process terminated normally.}
  'Hacer *** ERROR ***',   {Make ***ERROR***}
  'Hacer OK.',   {Make OK.}
  'La fuente ha cambiado ¿deseas rehacer el proyecto?',   {Source has changed, do you wish to remake project?}
  'Cargar diseño de ventana',   {Load Window Layout}
  'Área de atraque'   {Docking area}
 );

es_sourceformtext: sourceformaty =
 (
  'El archivo "',   {File "}
  '" ha cambiado.',   {" has changed.}
  'También hay modificaciones en el búfer de edición.',   {There are modifications in edit buffer also.}
  '¿Desea recargar desde el disco?',   {Do you wish to reload from disk?}
  'Confirmación',   {Confirmation}
  '<ninguno>',   {<none>}
  '¿Desea reemplazar:',   {Do you wish to replace:}
  'con:',   {with:}
  '<nuevo>',   {<new>}
  'Syntaxdeffile:',   {Syntaxdeffile:}
  'Texto',   {Text}
  'extraviado.',   {not found.}
  '¿Reiniciar desde el principio del archivo?',   {Restart from begin of file?}
  '¿Cancelar?',   {Cancel?}
  '¿Desea reemplazar esta ocurrencia?',   {Do you wish to to replace this occurence?}
  'Ir al número de línea:',   {Go to line number:}
  'Buscar línea',   {Find line}
  'También hay modificaciones en el búfer de edición.'   {There are modifications in edit buffer also.}
 );

es_settingstext: isettingsaty =
 (
  'Aplicar',   {Apply}
  'Configuración asistencia-voz sak',   {sak voice assistive config}
  'Directorio principal de sakit',   {Parent directory of sakit}
  'Habilitar sak al cargar',   {Enable sak assistive at loading}
  'Disposición del sistema',   {System layout}
  'Directorios universales',   {Universal path layout}
  'Sin manejo de pedidos Z',   {No Z order handling}
  'Mayús para seleccionar palabra',   {Use shift key to select a word}
  'Enfoque automático en menú',   {Auto focus in main-menu}
  'Ruta completa en título-proyecto',   {Full path of project in window title}
  'Establecer diálogos como modales',   {Set dialog-forms as modal vs as tool}
  'Altura fuente',   {Font height}
  'Nombre fuente',   {Font name}
  'No confirmación para eliminar fila',   {No confirmation to delete row}
  'Intercalación intermitente',   {Blinking caret}
  'Repintar canvas',   {Repaint canvas}
  'Editor de fuente',   {Source Editor}
  'Usa esas opciones',   {Use those options instead of project options}
  'Espacio tras coma al auto-parsing',   {Add space after comma -> auto-parsing}
  'Cuando un archivo ha cambiado:',   {When a file has changed}
  'Sin diálogo => cargar el nuevo',   {No dialog box => reload the new one}
  'Sin diálogo => mantener el viejo',   {No dialog box => keep the old one}
  'Un diálogo pregunta qué hacer ...',   {A dialog box ask what to do...}
  'Rectángulo alrededor selección'   {Rectangle around multi-select}
 );

es_projectoptionstext: projectoptionsaty =
 (
  'Opciones de proyecto',   {Project options}
  'Editor',   {Editor}
  'Margen derecho',   {Right margin line}
  'Soportes de marca',   {Mark Brackets}
  'Números de línea',   {Line Numbers}
  'Marcar pares de palabras',   {Mark Pairwords}
  'Recorte los espacios en blanco#10finales al guardar',   {Trim trailing whitespace on save}
  'Sangría automática',   {Auto Indent}
  'Sin editor de fuentes',   {No Source Editor}
  'Sangría de tabulación',   {Tab indent}
  'Pestaña de#10espacio',   {Space tab}
  'Mostrar pestañas',   {Show tabs}
  'Fuente anti aliased',   {Anti aliased font}
  'Codificación',   {Encoding}
  'Color de la marca',   {Mark Color}
  'Color de estad.',   {Stat Color}
  'Desp. Y',   {Scr Y}
  'Núm. cara.',   {Nb char}
  'Estilo EOL',   {EOL Style}
  'Respaldo',   {Backup}
  'Tabstops',   {Tabstops}
  'Sangrar',   {Indent}
  'Esp.X',   {ExtS}
  'Espacio extra entre líneas',   {Extra space between lines}
  'Ancho',   {Width}
  'Altura',   {Height}
  'Fuente',   {Font}
  'Color fondo de fuente',   {Font Bk. color}
  'Color de fuente',   {Font color}
  'Filtro archivos',   {File filter}
  'Nombre',   {Name}
  'Máscara archivo',   {File mask}
  'Archivo definición sintaxis',   {Syntax definition file}
  'Plantillas de código',   {Code Templates}
  'Directorios plantillas de código extensión de archivo = .mct',   {Code template directories, file extension = .mct}
  'Seleccionar directorio',   {Select unit directory}
  '&Depurador',   {&Debugger}
  'Project Debugger',   {Project Debugger}
  '&Directorios de búsqueda',   {Search &Directories}
  'Ruta de búsqueda para obtener información sobre el código',   {Search path to get infos about code}
  'Seleccionar directorio de origen',   {Select source directory}
  'Directorio base de objetos (vacío = Crear directorio)',   {Object &Base Directory (empty = Make Directory)}
  'Seleccionar directorio de origen',   {Select source base directory}
  'Defi&ne',   {Defi&nes}
  '&Señales',   {&Signals}
  '&Excepción',   {&Exception}
  '&Objetivo',   {&Target}
  'Iniciar comando del servidor gdb adjuntar destino',   {Start gdb server command attach target}
  'No espere a salir',   {No wait for exit}
  'Script gdb de antes de conectar',   {Before connect gdb script}
  'Script gdb de antes de la carga',   {Before load gdb script}
  'Script gdb de antes de ejecutar',   {Before run gdb script}
  'Script gdb de después de conectar',   {After connect gdb script}
  'Script gdb de después de la carga',   {After load gdb script}
  'Inicie comando servidor gdb destino ejecución',   {Start gdb server command run target}
  'Espere antes conectarse',   {Wait before connect}
  'Empezar una vez',   {Start once}
  'Comando de descarga',   {Download command}
  'Procesador',   {Processor}
  'Simulador',   {Simulator}
  'gdb-descargar',   {gdb download}
  'Inicio BKPT',   {Startup BKPT}
  'Conexión de destino',   {Target connection}
  'Descargar siempre',   {Always download}
  'Descargar siempre antes de ejecutar',   {Always download before run}
  'Tiempo espera de carga',   {Load Timeout}
  '&Consola externa',   {&Extern Console}
  '&Det.exc.',   {&Stop on Exc}
  'Deténgase en caso de excepción',   {Stop on exceptions}
  '&Act.desc.',   {&Acti-Break}
  'Activar en descanso',   {Activate on Break}
  '&Valor#10pistas',   {&Value Hints}
  'Llame GUI_DEB',   {Call GUI_DEB}
  'Suelte el agarre del mouse al detener el objetivo. gdb a veces falla con esta opción.',   {Release mouse grab by target stop. gdb sometimes crashes with this option.}
  'Establecer TT&Y',   {Set TT&Y}
  '&Leva/desc',   {&Raise-Break}
  'Levantar en descanso',   {Raise on break}
  '&Errores FPC',   {&FPC bugs}
  'Utilice soluciones alternativas para errores de FPC / gdb',   {Use workarounds for FPC/gdb bugs}
  'Objetivo &depuración',   {Debug &target}
  'Comando xterm',   {xterm command}
  '&Ejecutar comando',   {Run command}
  '&Depurador predeterminado',   {Default Debugger}
  'Opciones depuración',   {Debug &options}
  '&Hacer',   {&Make}
  'Hacer predeterminado',   {Default make col}
  'Archivo principal',   {Mainfile}
  'Seleccionar archivo principal',   {Select mainfile}
  'Nombre de destino',   {Targetfile name}
  'Seleccionar destino',   {Select target file}
  'Compilador predeterminado',   {Default Compiler}
  'Seleccionar comando Hacer',   {Select make command}
  'Mostrar línea comando',   {Show Command Line}
  'Copiar mensajes al archivo',   {Copy messages to file}
  'Cerrar mensajes',   {Close message}
  'Comprobar encabezados',   {Check head}
  'Comprobar los encabezados de los métodos',   {Check method headers}
  'Compilador proyecto',   {Project Compiler}
  'Comando antes',   {Command before}
  'Hacer opciones',   {Make options}
  'Directorios',   {Directories}
  'Seleccionar directorio',   {Select unit directory}
  'Comando después',   {Command after}
  'Extensión Exe',   {Exe Extension}
  'Comentarios',   {Comments}
  'Directorio Hacer',   {Make Directory}
  'Directorio Hacer',   {Select make directory}
  'Color error',   {Error Color}
  'Color advertencia',   {Warning Color}
  'Color nota',   {Note Color}
  'Eliminar ESC',   {Strip ESC}
  'Eliminar secuencias ESC en Mensajes y Terminal',   {Strip ESC sequences in Messages and Terminal form}
  'Muestra Consola',   {Show Console}
  'Objetivo',   {Purpose}
  'Archivo mensajes',   {Message output file}
  'Seleccionar destino',   {Select target file}
  'Macros',   {Macros}
  'Grupo activo',   {Active group}
  '&Alias fuente',   {&Font Alias}
  'Diseñadores',   {Designers}
  'Colores usuario',   {User &Colors}
  'Copiar el código "setcolormapvalue" al portapapeles',   {Copy "setcolormapvalue" code to clipboard}
  'F&ormat Macros',   {F&ormat Macros}
  'Usado por formatfloatmse() y formatdatetimemse()',   {Used by formatfloatmse() and formatdatetimemse()}
  'Plantillas',   {Templates}
  'Nuevo proyecto',   {New project}
  'Guión antes copiar',   {Script before copy}
  'Guión tras copiar',   {Script after copy}
  'Archivo nuevo',   {New File}
  'Nueva forma',   {New Form}
  'Instrumentos',   {Tools}
  'Almacen',   {Storage}
  'Infos',   {Infos}
  'Nombre completo del proyecto',   {Full name of project}
  'Creador',   {Creator}
  'Licencia',   {License}
  'Fecha de creación'   {Date of creation}
 );

es_stockcaption: stockcaptionaty =
(
  '',   {}
  'es inv#0225lido',   {is invalid}
  'Error de formato',   {Format error}
  'Debe introducir un valor',   {Value is required}
  'Error',   {Error}
  'M#0237n.',   {Min}
  'M#0225x.',   {Max}
  'Error de rango',   {Range error}
  '&Deshacer',   {&Undo}
  '&Rehacer',   {&Redo}
  '&Copiar',   {&Copy}
  'C&ortar',   {Cu&t}
  '&Pegar',   {&Paste}
  '&Select all',   {Select &all}
  '&Insertar fila',   {&Insert Row}
  '&A#0241adir fila',   {&Append Row}
  '&Borrar fila',   {&Delete Row}
  '&Carpetas',   {&Dir}
  '&Principal',   {&Home}
  '&Subir un nivel',   {&Up}
  'Crear carpeta',   {&New}
  'N&ombre',   {&Name}
  '&Mostrar archivos ocultos',   {&Show hidden files}
  '&Filtro',   {&Filter}
  'Guardar',   {Save}
  'Abrir',   {Open}
  'Nombre',   {Name}
  'Crear una carpeta nueva',   {Create new directory}
  'Atr#0225s',   {Back}
  'Adelante',   {Forward}
  'Arriba',   {Up}
  'Archivo',   {File}
  'existe #0191quiere sobreescribirlo?',   {exists, do you want to overwrite?}
  'es modificado. ¿Ahorrar?',   {is modified. Save?}
  'ADVERTENCIA',   {WARNING}
  'ERROR',   {ERROR}
  'Excepción',   {Exception}
  'Sistema',   {System}
  'no existe',   {does not exist}
  'CONTRASE#0209A',   {PASSWORD}
  'Introduzca contrase#0241a',   {Enter password}
  '#0161contrase#0241a incorrecta!',   {Invalid password!}
  'No puedo leer la carpeta',   {Can not read directory}
  'Formato gr#0225fico no soportado',   {Graphic format not supported}
  'Error de formato gr#0225fico',   {Graphic format error}
  'Bitmap MS',   {MS Bitmap}
  'Icono MS',   {MS Icon}
  'Imagen JPEG',   {JPEG Image}
  'Imagen PNG',   {PNG Image}
  'Imagen XPM',   {XPM Image}
  'Imagen PNM',   {PNM Image}
  'Imagen TARGA',   {TARGA Image}
  'Imagen TIFF',   {TIFF Image}
  'Todo',   {All}
  'Confirmación',   {Confirmation}
  '#0191Borrar el registro?',   {Delete record?}
  '#0191Copiar el registro?',   {Copy record?}
  'Cerrar p#0225gina',   {Close page}
  'Primero',   {First}
  'Anterior',   {Prior}
  'Siguiente',   {Next}
  '#0218ltimo',   {Last}
  'A#0241adir',   {Append}
  'Borrar',   {Delete}
  'Editar',   {Edit}
  'Guardar',   {Post}
  'Cancelar',   {Cancel}
  'Refrescar',   {Refresh}
  'Filtro edici#0243n',   {Edit filter}
  'Filtro edici#0243n m#0237nimo',   {Edit filter minimum}
  'Filtro edici#0243n m#0225ximo',   {Edit filter maximum}
  'Reiniciar filtro',   {Reset filter}
  'Filtro activo',   {Filter on}
  'Buscar',   {Search}
  'Edici#0243n autom#0225tica',   {Auto edit}
  'Copiar registro',   {Copy record}
  'Di#0225logo',   {Dialog}
  'Insertar',   {Insert}
  'Copiar',   {Copy}
  'Pegar',   {Paste}
  'Insertar fila',   {Row insert}
  'A#0241adir fila',   {Row append}
  'Borrar fila',   {Row delete}
  'Deshacer',   {Undo}
  'Rehacer',   {Redo}
  'Cortar',   {Cut}
  'Seleccionar todo',   {Select all}
  'Filtro apagado',   {Filter off}
  'Vertical',   {Portrait}
  'Apaisado',   {Landscape}
  '#0191Borrar fila?',   {Delete row?}
  'filas seleccionadas?',   {selected rows?}
  'un elemento solamente',   {Single item only}
  'Copiar Celdas',   {Copy Cells}
  'Pegar Celdas',   {Paste Cells}
  'Cerrar',   {Close}
  'Maximizar',   {Maximize}
  'Restaurar',   {Normalize}
  'Minimizar',   {Minimize}
  'Ajustar tama#0241o',   {Fix size}
  'Flotar',   {Float}
  'Permanecer en el primer plano',   {Stay on top}
  'Permanecer en el fondo',   {Stay in background}
  'Bloquear hijas',   {Lock children}
  'Sin bloquear',   {No lock}
  'Entrada',   {Input}
  'Bot#0243n',   {Button}
  'Encendido',   {On}
  'Apagado',   {Off}
  'Borde izquierdo',   {Left border}
  'Borde superior',   {Top border}
  'Borde derecho',   {Right border}
  'Borde inferior',   {Bottom border}
  'Principio del texto',   {Begin of text}
  'Fin del texto',   {End of text}
  'Modo entrada',   {Inputmode}
  'Sobrescribir',   {Overwrite}
  'Borrado',   {Deleted}
  'Copiado',   {Copied}
  'Insertado',   {Inserted}
  'Pegado',   {Pasted}
  'Retirado',   {Withdrawn}
  'Ventana activada',   {Window activated}
  'Men#0250',   {Menu}
  'Principio del archivo',   {Beginning of file}
  'Fin del archivo',   {End of file}
  'Salida de voz',   {Voice output}
  'Hablar de nuevo',   {Speak again}
  'Primera columna',   {First column}
  'Primera fila',   {First row}
  '#0218ltima columna',   {Last column}
  '#0218ltima fila',   {Last row}
  'Selecci#0243n',   {Selection}
  'Ruta de hablar',   {Speak path}
  'Deshabilitar bot#0243n',   {Disabled button}
  'Primer campo',   {First field}
  '#$00DAltimo campo',   {Last field}
  'Primer elemento',   {First element}
  '#$00DAltimo elemento',   {Last element}
  'M#$00E1s lento',   {Slower}
  'M#$00E1s r#$00E1pido',   {Faster}
  'Ventana',   {Window}
  '#$00C1rea',   {Area}
  '#$00C1rea activada',   {Area activated}
  'Bajar volumen',   {Volume down}
  'Subir volumen',   {Volume up}
  'Cancelar habla',   {Cancel speech}
  'Objetivo',   {Target}
  'Mirar',   {View}
  'Formularios',   {Forms}
  'Diseño',   {Layout}
  'Sintaxis',   {Syntax}
  'Proyecto',   {Project}
  'Editado',   {Edited}
  'Widgets',   {Widgets}
  'Ajustes',   {Settings}
  'Sobre',   {About}
  'Nuevo',   {New}
  'Guardar como ...',   {Save as...}
  'Salvar a todos',   {Save all}
  'Cierra todo',   {Close all}
  'Imprimir',   {Print}
  'Dejar',   {Quit}
  'Línea',   {Line}
  'Busca de nuevo',   {Search again}
  'Buscar atrás',   {Search back}
  'Buscar y reemplazar',   {Find & replace}
  'Buscar en archivos',   {Find in files}
  'Lista de procedimientos',   {Procedures list}
  'Seleccionar página de edición',   {Select edit page}
  'Copiar palabra en el cursor',   {Copy word at cursor}
  'Copiar LaTeX',   {Copy LaTeX}
  'Sangrar',   {Indent}
  'Sin sangría',   {Unindent}
  'Entorno',   {Environment}
  'Adjuntar proceso',   {Attach process}
  'Adjuntar objetivo',   {Attach target}
  'Separar objetivo',   {Detach target}
  'Descargar',   {Download}
  'Instrumentos',   {Tools}
  'Hacer',   {Make}
  'Construir',   {Build}
  'Cancelar hacer',   {Abort make}
  'Depurar/Ejecutar',   {Debug-Run}
  'Opciones',   {Options}
  'Árbol',   {Tree}
  'Fuente',   {Source}
  'Abrir copia',   {Open copy}
  'Guardar copia como ...',   {Save copy as}
  'Embellecedor',   {Beautifier}
  'Paneles',   {Panels}
  'Forzar orden Z',   {Force Z order}
  'Lista de árboles',   {Tree list}
  'Mensajes',   {Messages}
  'Resultado de encontrar',   {Find result}
  'Comandante',   {Commander}
  'Simbolos',   {Symbols}
  'Vigilia',   {Watches}
  'Apilar',   {Stack}
  'Hilos',   {Threads}
  'CPU',   {CPU}
  'Assembler',   {Assembler}
  'Puntos de interrupción',   {Breakpoints}
  'Puntos de observación',   {Watchpoints}
  'Memoria',   {Memory}
  'Consola de destino',   {Target console}
  'Alternar forma/unidad',   {Toggle form/unit}
  'Módulos MSE',   {MSE modules}
  'Cerrar todos los módulos MSE',   {Close all MSE modules}
  'Configuración general',   {General settings}
  'Configuraciones extra',   {Extra settings}
  'Idiomas',   {Languages}
  'Configurar widgets',   {Configure widgets}
  'Configurar compiladores',   {Configure compilers}
  'Configurar depuradores',   {Configure debuggers}
  'Temas',   {Themes}
  'Directorio',   {Directory}
  'Sin iconos',   {No icons}
  'Sin lateral',   {No lateral}
  'Compacto',   {Compact}
  'Abre el proyecto',   {Open project}
  'Abre el archivo',   {Open file}
  'Ruta',   {Path}
  'Otro',   {Other}
  'Comando de impresión',   {Print command}
  'Atajo',   {Shortcut}
  'Valor',   {Value}
  'Case sensitive',   {Case sensitive}
  'Solo seleccionado',   {Selected only}
  'Toda palabra',   {Whole word}
  'Texto para buscar',   {Text to find}
  'Buscar en archivo actual',   {Search in current file}
  'Buscar en archivos abiertos',   {Search in open files}
  'Buscar en directorio proyecto',   {Search in project directory}
  'Buscar en directorios',   {Search in directories}
  'Incluir subdirectorios',   {Include subdirectories}
  'Reemplazar',   {Replace}
  'Reemplaza todo',   {Replace all}
  'Reemplazar con',   {Replace with}
  'Preguntar al reemplazar',   {Prompt on replace}
  'Paleta de componentes',   {Components palette}
  'Encuentra componentes',   {Find components}
  'Restablecer',   {Reset}
  'Paso',   {Step}
  'Instrucción de paso',   {Step instruction}
  'Siguiente instrucción',   {Next instruction}
  'Reiniciar depurador',   {Restart debugger}
  'Toggle breakpoint',   {Toggle breakpoint}
  'Alternar punto de interrupción habilitado',   {Toggle breakpoint enabled}
  'Indicación de líneas ejecutadas activada / desactivada',   {Executed lines hint on/off}
  'Por favor compílelo primero.',   {Please compile it first.}
  'Finalizar',   {Finish}
  'Establecido predeterminado',   {Set as default}
  'Anfitrión',   {Host}
  'Derechos de autor'   {Copyright}
 );

es_langnamestext: array[0..6] of msestring =
(
  'Inglés',   {English}
  'Ruso',   {Russian}
  'Francés',   {French}
  'Alemán',   {German}
  'Español',   {Spanish}
  'Portugués',   {Portuguese}
  'Chinese (not complete)' //6_chinese
 );

es_extendedtext: extendedaty =
(
  '#0191Borrar la fila seleccionada?',   {Delete selected row?}
  '#0191Borrar %s filas seleccionadas?'   {Delete %s selected rows?}
 );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := es_extendedtext[ex_del_row_selected]
    else
      Result := StringReplace(es_extendedtext[ex_del_rows_selected], #37#115, inttostrmse(vinteger), [rfReplaceAll]);
end;

const
es_textgenerator: defaultgeneratortextty = (
 {$ifdef FPC} @{$endif}delete_n_selected_rows);

initialization

registerlangconsts(langnames[la_es], @es_langnamestext, @es_extendedtext, @es_mainformtext, @es_sourceformtext,
                   @es_projectoptionscontext, @es_actionsmoduletext, @es_settingstext, @es_projectoptionstext,
                   @es_stockcaption, @es_modalresulttext, @es_modalresulttextnoshortcut, @es_textgenerator);

end.

