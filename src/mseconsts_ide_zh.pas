{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
} 

unit mseconsts_ide_zh;

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

zh_modalresulttext: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '离开',   {&Cancel}
  '取消',   {&Abort}
  '确定',   {&OK}
  '是',   {&Yes}
  '否',   {&No}
  '所有',   {Yes &all}
  '所有',   {Yes &all}
  '取消所有',   {N&o all}
  '忽略',   {&Ignore}
  '&Skip',   {&Skip}
  'Skip a&ll',   {Skip a&ll}
  'Co&ntinue'   {Co&ntinue}
 );

zh_modalresulttextnoshortcut: defaultmodalresulttextty =
 (
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '',   {}
  '离开',   {Cancel}
  '取消',   {Abort}
  '确定',   {OK}
  '是',   {Yes}
  '否',   {No}
  '所有',   {Yes all}
  '所有',   {Yes all}
  '取消所有',   {No all}
  '忽略',   {Ignore}
  'Skip',   {Skip}
  'Skip all',   {Skip all}
  '继续'   {Continue}
 );

zh_projectoptionscontext: projectoptionsconaty =
 (
  'Wrong encoding can damage your source files.',   {Wrong encoding can damage your source files.}
  'Do you wish to set encoding to',   {Do you wish to set encoding to}
  '*** WARNING ***',   {*** WARNING ***}
  'Hangup',   {Hangup}
  'Interrupt',   {Interrupt}
  'Quit',   {Quit}
  'Illegal instruction',   {Illegal instruction}
  'Trace trap',   {Trace trap}
  '取消',   {Abort}
  'BUS error',   {BUS error}
  'Floating-point exception',   {Floating-point exception}
  'Kill',   {Kill}
  'User-defined signal 1',   {User-defined signal 1}
  'Segmentation violation',   {Segmentation violation}
  'User-defined signal 2',   {User-defined signal 2}
  'Broken pipe',   {Broken pipe}
  'Alarm clock',   {Alarm clock}
  'Termination',   {Termination}
  'Stack fault',   {Stack fault}
  'Child status has changed',   {Child status has changed}
  '继续',   {Continue}
  'Stop unblockable',   {Stop, unblockable}
  'Keyboard stop',   {Keyboard stop}
  'Background read from tty',   {Background read from tty}
  'Background write to tty',   {Background write to tty}
  'Urgent condition on socket',   {Urgent condition on socket}
  'CPU limit exceeded',   {CPU limit exceeded}
  'File size limit exceeded',   {File size limit exceeded}
  'Virtual alarm clock',   {Virtual alarm clock}
  'Profiling alarm clock',   {Profiling alarm clock}
  'Window size change',   {Window size change}
  'I/O now possible',   {I/O now possible}
  'Power failure restart'   {Power failure restart}
 );

zh_actionsmoduletext: actionsmoduleaty =
 (
  'Configure MSEide',   {Configure ideU}
  'Process ID',   {Process ID}
  'Attach to process',   {Attach to process}
  'Unknown moduleclass for "',   {Unknown moduleclass for "}
  'Inherited component "',   {Inherited component "}
  '" can not be deleted.',   {" can not be deleted.}
  'ERROR',   {ERROR}
  'Make aborted.',   {Make aborted.}
  'Download aborted.',   {Download aborted.}
  'Runerror with "',   {Runerror with "}
  'Error: Timeout.',   {Error: Timeout.}
  'Making.',   {Making.}
  'Make not running.',   {Make not running.}
  'Downloading.',   {Downloading.}
  'Download not running.',   {Download not running.}
  '" running.',   {" running.}
  'Script',   {Script}
  'Recursive form inheritance of "',   {Recursive form inheritance of "}
  'Component "',   {Component "}
  '" exists.',   {" exists.}
  'Ancestor for "',   {Ancestor for "}
  '" not found.',   {" not found.}
  'Module "',   {Module "}
  'Invalid name "',   {Invalid name "}
  'Invalid methodname',   {Invalid methodname}
  'Module not found',   {Module not found}
  'Method not found',   {Method not found}
  'Published (managed) method',   {Published (managed) method}
  'does not exist.',   {does not exist.}
  'Do you wish to delete the event?',   {Do you wish to delete the event?}
  'WARNING',   {WARNING}
  'Method',   {Method}
  'has different parameters.',   {has different parameters.}
  'A module "',   {A module "}
  '" is already open.',   {" is already open.}
  'Unresolved reference(s) to',   {Unresolved reference(s) to}
  'Module(s):',   {Module(s):}
  'Can not read formfile "',   {Can not read formfile "}
  'Invalid component name.',   {Invalid component name.}
  'Invalid exception',   {Invalid exception}
  'T&ools',   {T&ools}
  'Forms',   {Forms}
  'Source',   {Source}
  'All Files',   {All Files}
  'MSE Program',   {MSE Program}
  'MSE Unit',   {MSE Unit}
  'MSE Textfile',   {MSE Textfile}
  'Mainform',   {Mainform}
  'Simple Form',   {Simple Form}
  'Docking Form',   {Docking Form}
  'Datamodule',   {Datamodule}
  'Subform',   {Subform}
  'Scrollboxform',   {Scrollboxform}
  'Tabform',   {Tabform}
  'Dockpanel',   {Dockpanel}
  'Report',   {Report}
  'Scriptform',   {Scriptform}
  'Inherited Form',   {Inherited Form}
  'Do you want to replace the settings by',   {Do you want to replace the settings by}
  'File "',   {File "}
  'Do you want to overwrite?',   {Do you want to overwrite?}
  'Unknown',   {Unknown}
  'Error',   {Error}
  'Startup',   {Startup}
  'Exception',   {Exception}
  'GDB died',   {GDB died}
  'Breakpoint hit',   {Breakpoint hit}
  'Watchpoint triggered',   {Watchpoint triggered}
  'Read Watchpoint triggered',   {Read Watchpoint triggered}
  'Access Watchpoint triggered',   {Access Watchpoint triggered}
  'End stepping range',   {End stepping range}
  'Function finished',   {Function finished}
  'Exited normally',   {Exited normally}
  'Exited',   {Exited}
  'Detached',   {Detached}
  'Signal received',   {Signal received}
  'Stop error',   {Stop error}
  'Can not read project',   {Can not read project}
  'About',   {About}
  'Object Inspector',   {Object Inspector}
  'Store Component',   {Store Component}
  'Attaching Process',   {Attaching Process}
  'Loading'   {Loading}
 );

zh_mainformtext: mainformaty =
 (
  'Unresolved references in',   {Unresolved references in}
  'to',   {to}
  'Do you wish to search the formfile?',   {Do you wish to search the formfile?}
  'WARNING',   {WARNING}
  'Formfile for',   {Formfile for}
  'Formfiles',   {Formfiles}
  'Recursive form hierarchy for "',   {Recursive form hierarchy for "}
  'ERROR',   {ERROR}
  'Classtype',   {Classtype}
  'not found.',   {not found.}
  '继续',   {Project}
  'is modified. Save?',   {is modified. Save?}
  'Confirmation',   {Confirmation}
  'Unable to open file "',   {Unable to open file "}
  '*** Running ***',   {*** Running ***}
  'Downloading',   {Downloading}
  'Downloaded',   {Downloaded}
  'Start gdb server command "',   {Start gdb server command "}
  '" running.',   {" running.}
  'Start gdb Server',   {Start gdb Server}
  'gdb server start error',   {gdb server start error}
  'gdb server start canceled.',   {gdb server start canceled.}
  'Can not run start gdb command.',   {Can not run start gdb command.}
  'Uploadcommand "',   {Uploadcommand "}
  'Download ***ERROR***',   {Download ***ERROR***}
  'Download finished.',   {Download finished.}
  'Download canceled.',   {Download canceled.}
  'File "',   {File "}
  '" not found.',   {" not found.}
  '" exists.',   {" exists.}
  'New',   {New}
  'Select ancestor',   {Select ancestor}
  'New form',   {New form}
  'Pascal Files',   {Pascal Files}
  'new',   {new}
  'Can not load Project "',   {Can not load Project "}
  'Select project template',   {Select project template}
  'Project files',   {Project files}
  'All files',   {All files}
  'Select program file',   {Select program file}
  'Pascal program files',   {Pascal program files}
  'C program files',   {C program files}
  'New Project',   {New Project}
  'Can not start process',   {Can not start process}
  'Process',   {Process}
  'running.',   {running.}
  'Process terminated',   {Process terminated}
  'Process terminated normally.',   {Process terminated normally.}
  'Make ***ERROR***',   {Make ***ERROR***}
  'Make OK.',   {Make OK.}
  'Source has changed do you wish to remake project?',   {Source has changed, do you wish to remake project?}
  'Load Window Layout',   {Load Window Layout}
  'Docking area'   {Docking area}
 );

zh_sourceformtext: sourceformaty =
 (
  'File "',   {File "}
  '" has changed.',   {" has changed.}
  'There are modifications in edit buffer also.',   {There are modifications in edit buffer also.}
  'Do you wish to reload from disk?',   {Do you wish to reload from disk?}
  'Confirmation',   {Confirmation}
  '<none>',   {<none>}
  'Do you wish to replace:',   {Do you wish to replace:}
  'with:',   {with:}
  '<new>',   {<new>}
  'Syntaxdeffile:',   {Syntaxdeffile:}
  'Text',   {Text}
  'not found.',   {not found.}
  'Restart from begin of file?',   {Restart from begin of file?}
  'Cancel?',   {Cancel?}
  'Do you wish to to replace this occurence?',   {Do you wish to to replace this occurence?}
  'Go to line number:',   {Go to line number:}
  'Find line',   {Find line}
  'There are modifications in edit buffer also.'   {There are modifications in edit buffer also.}
 );

zh_settingstext: isettingsaty =
 (
  'Apply',   {Apply}
  'sak voice assistive config',   {sak voice assistive config}
  'Parent directory of sakit',   {Parent directory of sakit}
  'Enable sak assistive at loading',   {Enable sak assistive at loading}
  'System layout',   {System layout}
  'Universelles Verzeichnislayout',   {Universal path layout}
  'No Z order handling',   {No Z order handling}
  'Use shift key to select a word',   {Use shift key to select a word}
  'Auto focus in main-menu',   {Auto focus in main-menu}
  'Full path of project in window title',   {Full path of project in window title}
  'Set dialog-forms as modal vs as tool',   {Set dialog-forms as modal vs as tool}
  'Font height',   {Font height}
  'Font name',   {Font name}
  'No confirmation to delete row',   {No confirmation to delete row}
  'Blinking caret',   {Blinking caret}
  'Repaint canvas',   {Repaint canvas}
  'Source Editor',   {Source Editor}
  'Use those options instead of project options',   {Use those options instead of project options}
  'Add space after comma when auto-parsing',   {Add space after comma -> auto-parsing}
  'When a file has changed',   {When a file has changed}
  'No dialog box => reload the new one',   {No dialog box => reload the new one}
  'No dialog box => keep the old one',   {No dialog box => keep the old one}
  'A dialog box ask what to do...',   {A dialog box ask what to do...}
  'Rectangle around multi-select'   {Rectangle around multi-select}
 );

zh_projectoptionstext: projectoptionsaty =
 (
  'Project options',   {Project options}
  'Editor',   {Editor}
  'Right margin line',   {Right margin line}
  'Mark Brackets',   {Mark Brackets}
  'Line Numbers',   {Line Numbers}
  'Mark Pairwords',   {Mark Pairwords}
  'Trim trailing whitespace',   {Trim trailing whitespace on save}
  'Auto Indent',   {Auto Indent}
  'No Source Editor',   {No Source Editor}
  'Tab indent',   {Tab indent}
  'Space tab',   {Space tab}
  'Show tabs',   {Show tabs}
  'Anti aliased font',   {Anti aliased font}
  'Encoding',   {Encoding}
  'Mark Color',   {Mark Color}
  'Stat Color',   {Stat Color}
  'Scr Y',   {Scr Y}
  'Nb char',   {Nb char}
  'EOL Style',   {EOL Style}
  'Backup',   {Backup}
  'Tabstops',   {Tabstops}
  'Indent',   {Indent}
  'ExtS',   {ExtS}
  'Extra space between lines',   {Extra space between lines}
  'Width',   {Width}
  'Height',   {Height}
  'Font',   {Font}
  'Font Bk. color',   {Font Bk. color}
  'Font color',   {Font color}
  'File filter',   {File filter}
  'Name',   {Name}
  'File mask',   {File mask}
  'Syntax definition file',   {Syntax definition file}
  'Code Templates',   {Code Templates}
  'Code template directories file extension = .mct',   {Code template directories, file extension = .mct}
  'Select unit directory',   {Select unit directory}
  '&Debugger',   {&Debugger}
  'Project Debugger',   {Project Debugger}
  'Search &Directories',   {Search &Directories}
  'Search path to get infos about code',   {Search path to get infos about code}
  'Select source directory',   {Select source directory}
  'Object &Base Directory (empty = Make Directory)',   {Object &Base Directory (empty = Make Directory)}
  'Select source base directory',   {Select source base directory}
  'Defi&nes',   {Defi&nes}
  '&Signals',   {&Signals}
  '&Exception',   {&Exception}
  '&Target',   {&Target}
  'Start gdb server command attach target',   {Start gdb server command attach target}
  'No wait for exit',   {No wait for exit}
  'Before connect gdb script',   {Before connect gdb script}
  'Before load gdb script',   {Before load gdb script}
  'Before run gdb script',   {Before run gdb script}
  'After connect gdb script',   {After connect gdb script}
  'After load gdb script',   {After load gdb script}
  'Start gdb server command run target',   {Start gdb server command run target}
  'Wait before connect',   {Wait before connect}
  'Start once',   {Start once}
  'Download command',   {Download command}
  'Processor',   {Processor}
  'Simulator',   {Simulator}
  'gdb download',   {gdb download}
  'Startup BKPT',   {Startup BKPT}
  'Target connection',   {Target connection}
  'Always download',   {Always download}
  'Always download before run',   {Always download before run}
  'Load Timeout',   {Load Timeout}
  '&Extern Console',   {&Extern Console}
  '&Stop on Exc',   {&Stop on Exc}
  'Stop on exceptions',   {Stop on exceptions}
  '&Acti-Break',   {&Acti-Break}
  'Activate on Break',   {Activate on Break}
  '&Value#10Hints',   {&Value Hints}
  'Call GUI_DEB',   {Call GUI_DEB}
  'Release mouse grab by target stop. gdb sometimes crashes with this option.',   {Release mouse grab by target stop. gdb sometimes crashes with this option.}
  'Set TT&Y',   {Set TT&Y}
  '&Raise-Break',   {&Raise-Break}
  'Raise on break',   {Raise on break}
  '&FPC bugs',   {&FPC bugs}
  'Use workarounds for FPC/gdb bugs',   {Use workarounds for FPC/gdb bugs}
  'Debug &target',   {Debug &target}
  'xterm command',   {xterm command}
  '&Run command',   {Run command}
  'Default Debugger',   {Default Debugger}
  'Debug &options',   {Debug &options}
  '&Make',   {&Make}
  'Default make col',   {Default make col}
  'Mainfile',   {Mainfile}
  'Select mainfile',   {Select mainfile}
  'Targetfile name',   {Targetfile name}
  'Select target file',   {Select target file}
  'Default Compiler',   {Default Compiler}
  'Select make command',   {Select make command}
  'Show Command Line',   {Show Command Line}
  'Copy messages to file',   {Copy messages to file}
  'Close message',   {Close message}
  'Check head',   {Check head}
  'Check method headers',   {Check method headers}
  'Project Compiler',   {Project Compiler}
  'Command before',   {Command before}
  'Make options',   {Make options}
  'Directories',   {Directories}
  'Select unit directory',   {Select unit directory}
  'Command after',   {Command after}
  'Exe Extension',   {Exe Extension}
  'Comments',   {Comments}
  'Make Directory',   {Make Directory}
  'Select make directory',   {Select make directory}
  'Error Color',   {Error Color}
  'Warning Color',   {Warning Color}
  'Note Color',   {Note Color}
  'Strip ESC',   {Strip ESC}
  'Strip ESC sequences in Messages and Terminal form',   {Strip ESC sequences in Messages and Terminal form}
  'Show Console',   {Show Console}
  'Purpose',   {Purpose}
  'Message output file',   {Message output file}
  'Select target file',   {Select target file}
  'Macros',   {Macros}
  'Active group',   {Active group}
  '&Font Alias',   {&Font Alias}
  'Designers',   {Designers}
  'User &Colors',   {User &Colors}
  'Copy "setcolormapvalue" code to clipboard',   {Copy "setcolormapvalue" code to clipboard}
  'F&ormat Macros',   {F&ormat Macros}
  'Used by formatfloatmse() and formatdatetimemse()',   {Used by formatfloatmse() and formatdatetimemse()}
  'Templates',   {Templates}
  'New project',   {New project}
  'Script before copy',   {Script before copy}
  'Script after copy',   {Script after copy}
  'New File',   {New File}
  'New Form',   {New Form}
  'Tools',   {Tools}
  'Storage',   {Storage}
  'Infos',   {Infos}
  'Full name of project',   {Full name of project}
  'Creator',   {Creator}
  'Licence',   {License}
  'Date of creation'   {Date of creation}
 );

zh_stockcaption: stockcaptionaty =
(
  '',   {}
  '无效',   {is invalid}
  '格式错误',   {Format error}
  '值不能为空',   {Value is required}
  'Error',   {Error}
  '最小',   {Min}
  '最大',   {Max}
  '溢出错误',   {Range error}
  '取消',   {&Undo}
  '重做',   {&Redo}
  '复制',   {&Copy}
  '剪切',   {Cu&t}
  '粘贴',   {&Paste}
  'Select &all',   {Select &all}
  '插入一行',   {&Insert Row}
  '增加一行',   {&Append Row}
  '删除所选行',   {&Delete Row}
  '文件夹',   {&Dir}
  '首页',   {&Home}
  '向上',   {&Up}
  '新文件夹',   {&New}
  '文件名',   {&Name}
  '显示隐藏文件',   {&Show hidden files}
  '保存类型',   {&Filter}
  '保存',   {Save}
  '打开',   {Open}
  'Name',   {Name}
  '新建文件夹',   {Create new directory}
  'Back',   {Back}
  'Forward',   {Forward}
  '向上',   {Up}
  '文件',   {File}
  '文件已经存在，是否覆盖？',   {exists, do you want to overwrite?}
  'is modified. Save?',   {is modified. Save?}
  'WARNING',   {WARNING}
  'ERROR',   {ERROR}
  'Exception',   {Exception}
  'System',   {System}
  '不存在',   {does not exist}
  'PASSWORD',   {PASSWORD}
  'Enter password',   {Enter password}
  'Invalid password!',   {Invalid password!}
  '找不到文件夹',   {Can not read directory}
  '图形格式不支持',   {Graphic format not supported}
  '图形格式错误',   {Graphic format error}
  'MS Bitmap',   {MS Bitmap}
  'MS Icon',   {MS Icon}
  'JPEG Image',   {JPEG Image}
  'PNG Image',   {PNG Image}
  'XPM Image',   {XPM Image}
  'PNM Image',   {PNM Image}
  'TARGA Image',   {TARGA Image}
  'TIFF Image',   {TIFF Image}
  '所有',   {All}
  'Confirmation',   {Confirmation}
  '删除记录？',   {Delete record?}
  'Copy record?',   {Copy record?}
  '关闭页',   {Close page}
  '第一条',   {First}
  '前一条',   {Prior}
  '下一条',   {Next}
  '最后',   {Last}
  '增加',   {Append}
  '删除',   {Delete}
  '修改',   {Edit}
  '保存',   {Post}
  '离开',   {Cancel}
  '刷新',   {Refresh}
  '编辑器过滤',   {Edit filter}
  'Edit filter minimum',   {Edit filter minimum}
  'Edit filter maximum',   {Edit filter maximum}
  'Reset filter',   {Reset filter}
  '过滤开启',   {Filter on}
  '查找',   {Search}
  'Auto edit',   {Auto edit}
  'Copy record',   {Copy record}
  'Dialog',   {Dialog}
  '插入',   {Insert}
  '复制',   {Copy}
  '粘贴',   {Paste}
  'Row insert',   {Row insert}
  'Row append',   {Row append}
  'Row delete',   {Row delete}
  '取消',   {Undo}
  '重做',   {Redo}
  '剪切',   {Cut}
  'Select all',   {Select all}
  '过滤关闭',   {Filter off}
  'Portrait',   {Portrait}
  'Landscape',   {Landscape}
  '确定删除此条记录吗？',   {Delete row?}
  '确定删除所选记录吗？',   {selected rows?}
  'Single item only',   {Single item only}
  'Copy Cells',   {Copy Cells}
  'Paste Cells',   {Paste Cells}
  '关闭',   {Close}
  'Maximize',   {Maximize}
  'Normalize',   {Normalize}
  'Minimize',   {Minimize}
  'Fix size',   {Fix size}
  'Float',   {Float}
  'Stay on top',   {Stay on top}
  'Stay in background',   {Stay in background}
  'Lock children',   {Lock children}
  'No lock',   {No lock}
  'Input',   {Input}
  'Button',   {Button}
  'On',   {On}
  'Off',   {Off}
  'Left border',   {Left border}
  'Top border',   {Top border}
  'Right border',   {Right border}
  'Bottom border',   {Bottom border}
  'Begin of text',   {Begin of text}
  'End of text',   {End of text}
  'Inputmode',   {Inputmode}
  'Overwrite',   {Overwrite}
  'Deleted',   {Deleted}
  'Copied',   {Copied}
  'Inserted',   {Inserted}
  'Pasted',   {Pasted}
  'Withdrawn',   {Withdrawn}
  'Window activated',   {Window activated}
  '菜单',   {Menu}
  'Beginning of file',   {Beginning of file}
  'End of file',   {End of file}
  'Voice output',   {Voice output}
  'Speak again',   {Speak again}
  'First column',   {First column}
  'First row',   {First row}
  'Last column',   {Last column}
  'Last row',   {Last row}
  'Selection',   {Selection}
  'Speak path',   {Speak path}
  'Disabled button',   {Disabled button}
  'First field',   {First field}
  'Last field',   {Last field}
  'First element',   {First element}
  'Last element',   {Last element}
  'Slower',   {Slower}
  'Faster',   {Faster}
  'Window',   {Window}
  'Area',   {Area}
  'Area activated',   {Area activated}
  'Volume down',   {Volume down}
  'Volume up',   {Volume up}
  'Cancel speech',   {Cancel speech}
  'Target',   {Target}
  'View',   {View}
  'Forms',   {Forms}
  'Layout',   {Layout}
  'Syntax',   {Syntax}
  'Project',   {Project}
  'Edited',   {Edited}
  'Widgets',   {Widgets}
  'Settings',   {Settings}
  'About',   {About}
  'New',   {New}
  'Save as...',   {Save as...}
  'Save all',   {Save all}
  'Close all',   {Close all}
  'Print',   {Print}
  'Quit',   {Quit}
  'Line',   {Line}
  'Search again',   {Search again}
  'Search back',   {Search back}
  'Find & replace',   {Find & replace}
  'Find in files',   {Find in files}
  'Procedures list',   {Procedures list}
  'Select edit page',   {Select edit page}
  'Copy word at cursor',   {Copy word at cursor}
  'Copy LaTeX',   {Copy LaTeX}
  'Indent',   {Indent}
  'Unindent',   {Unindent}
  'Environment',   {Environment}
  'Attach process',   {Attach process}
  'Attach target',   {Attach target}
  'Detach target',   {Detach target}
  'Download',   {Download}
  'Tools',   {Tools}
  'Make',   {Make}
  'Build',   {Build}
  'Abort make',   {Abort make}
  'Debug-Run',   {Debug-Run}
  'Options',   {Options}
  'Tree',   {Tree}
  'Source',   {Source}
  'Open copy',   {Open copy}
  'Save copy as',   {Save copy as}
  'Beautifier',   {Beautifier}
  'Panels',   {Panels}
  'Force Z order',   {Force Z order}
  'Tree list',   {Tree list}
  'Messages',   {Messages}
  'Find result',   {Find result}
  'Commander',   {Commander}
  'Symbols',   {Symbols}
  'Watches',   {Watches}
  'Stack',   {Stack}
  'Threads',   {Threads}
  'CPU',   {CPU}
  'Assembler',   {Assembler}
  'Breakpoints',   {Breakpoints}
  'Watchpoints',   {Watchpoints}
  'Memory',   {Memory}
  'Target console',   {Target console}
  'Toggle form/unit',   {Toggle form/unit}
  'MSE modules',   {MSE modules}
  'Close all MSE modules',   {Close all MSE modules}
  'General settings',   {General settings}
  'Extra settings',   {Extra settings}
  'Languages',   {Languages}
  'Configure widgets',   {Configure widgets}
  'Configure compilers',   {Configure compilers}
  'Configure debuggers',   {Configure debuggers}
  'Themes',   {Themes}
  'Directory',   {Directory}
  'No icons',   {No icons}
  'No lateral',   {No lateral}
  'Compact',   {Compact}
  'Open project',   {Open project}
  'Open file',   {Open file}
  'Path',   {Path}
  'Other',   {Other}
  'Print command',   {Print command}
  'Shortcut',   {Shortcut}
  'Value',   {Value}
  'Case sensitive',   {Case sensitive}
  'Selected only',   {Selected only}
  'Whole word',   {Whole word}
  'Text to find',   {Text to find}
  'Search in current file',   {Search in current file}
  'Search in open files',   {Search in open files}
  'Search in project directory',   {Search in project directory}
  'Search in directories',   {Search in directories}
  'Include subdirectories',   {Include subdirectories}
  'Replace',   {Replace}
  'Replace all',   {Replace all}
  'Replace with',   {Replace with}
  'Prompt on replace',   {Prompt on replace}
  'Components palette',   {Components palette}
  'Find components',   {Find components}
  'Reset',   {Reset}
  'Step',   {Step}
  'Step instruction',   {Step instruction}
  'Next instruction',   {Next instruction}
  'Restart debugger',   {Restart debugger}
  'Toggle breakpoint',   {Toggle breakpoint}
  'Toggle breakpoint enabled',   {Toggle breakpoint enabled}
  'Executed lines hint on/off',   {Executed lines hint on/off}
  'Please compile it first.',   {Please compile it first.}
  'Finish',   {Finish}
  'Set as default',   {Set as default}
  'Host',   {Host}
  'Copyright'   {Copyright}
 );

zh_langnamestext: array[0..6] of msestring =
(
  'English',   {English}
  'Russian',   {Russian}
  'French',   {French}
  'German',   {German}
  'Spanish',   {Spanish}
  'Portuguese',   {Portuguese}
  'Chinese (not complete)'  //6_chinese
 );

zh_extendedtext: extendedaty =
(
  '确定删除此条记录吗？',   {Delete selected row?}
  '确定删除所选择的 %s 行记录吗？'   {Delete %s selected rows?}
 );

function delete_n_selected_rows(const params: array of const): msestring;
begin
  with params[0] do
    if vinteger = 1 then
      Result := zh_extendedtext[ex_del_row_selected]
    else
      Result := StringReplace(zh_extendedtext[ex_del_rows_selected], #37#115, inttostrmse(vinteger), [rfReplaceAll]);
end;

const
zh_textgenerator: defaultgeneratortextty = (
 {$ifdef FPC} @{$endif}delete_n_selected_rows);

initialization

registerlangconsts(langnames[la_zh], @zh_langnamestext, @zh_extendedtext, @zh_mainformtext, @zh_sourceformtext,
                   @zh_projectoptionscontext, @zh_actionsmoduletext, @zh_settingstext, @zh_projectoptionstext,
                   @zh_stockcaption, @zh_modalresulttext, @zh_modalresulttextnoshortcut, @zh_textgenerator);

end.

