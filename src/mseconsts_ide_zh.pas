{ MSEgui Copyright (c) 1999-2009 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    Chinese translation by liuzg2.

}
unit mseconsts_ide_zh;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 mseconsts;

implementation
uses
 msetypes{msestrings},sysutils,mseformatstr;
const
 zh_modalresulttext: defaultmodalresulttextty =
 (
'',
'',
'',
'',
'',
'',
'',
'离开',
'取消',
'确定',
'是',
'否',
'所有',
'Yes &all',
'取消所有',
'忽略',
'&Skip',
'Skip a&ll',
'Co&ntinue'
);

 zh_modalresulttextnoshortcut: defaultmodalresulttextty =
 (
'',
'',
'',
'',
'',
'',
'',
'离开',
'取消',
'确定',
'是',
'否',
'所有',
'Yes all',
'取消所有',
'忽略',
'Skip',
'Skip all',
'继续'
 );

zh_settingstext: isettingsaty = (
    'Apply', //se_apply
    'sak voice assistive config', //se_groupassistive
    'Parent directory of sakit', //se_sakitdir
    'Enable sak assistive at loading', //se_enableassistive
    'System layout', //se_groupsystemlayout
    'Universelles Verzeichnislayout', //se_universalpath
    'No Z order handling', //se_nozorder
    'Use shift key to select a word', //se_doubleclic
    'Auto focus in main-menu', //se_autofocusmenu
    'Full path of project in window title', //se_fullpath
    'Set dialog-forms as modal vs as tool', //se_modaldial
    'Font height', //se_fontsize
    'Font name', //se_fontname
    'No confirmation to delete row', //se_confirmdel
    'Blinking caret', //se_blinkcaret
    'Repaint canvas', //se_repaintcanvas
    'Source Editor', //se_groupsourceeditor
    'Use those options instead of project options', //se_usedefaulteditoroptions
    'Add space after comma when auto-parsing', //se_addwhiteaftercomma
    'When a file has changed', //se_groupfilechange
    'No dialog box => reload the new one', //se_filereload
    'No dialog box => keep the old one', //se_filenoload
    'A dialog box ask what to do...' //se_fileaskload
     );
  
  zh_projectoptionstext: projectoptionsaty = (
    'Project options',          // po_projectoptions
    'Editor',                   // po_editor
    'Right margin line',        // po_rightmarginline
    'Mark Brackets',            //  po_markbrackets
    'Line Numbers',             //  po_linenumbers
    'Mark Pairwords',           //  po_markpairwords
    'Trim trailing'#10'whitespace'#10'on save', //  po_trimtrailing
    'Auto Indent',              //  po_autoindent
    'No Source Editor',         //  po_nosource
    'Tab indent',               //  po_tabindent
    'Space tab',                //  po_spacetab
    'Show tabs',                //  po_showtabs
    'Anti aliased font',        //  po_antialiasedfont
    'Encoding',                 //  po_encoding
    'Mark Color',               //  po_markcolor

    'Stat Color',               // po_statcolor
    'Scr Y',                    // po_scrollbary
    'Nb char',                  // po_nbchar
    'EOL Style',                //  po_eolstyle
    'Backup',                   //  po_backup
    'Tabstops',                 //  po_tabstops
    'Indent',                   //  po_indent
    'ExtS',                     //  po_extraspace
    'Extra space between lines', //  po_extraspacehint
    'Width',                    //  po_width
    'Height',                   //  po_height
    'Font',                     //  po_font
    'Font Bk. color',           //  po_fontbkcolor
    'Font color',               //  po_fontcolor
    'File filter',              //  po_filefilter
    'Name',                     //  po_name
    'File mask',                //  po_filemask
    'Syntax definition file',   //  po_syntaxdeffile
    'Code Templates',           //  po_codetemplate
    'Code template directories, file extension = .mct', //  po_fontcodetemplatedir
    'Select unit directory',    // po_selectunitdir
    '&Debugger',                // po_debuggerpage
    'Project Debugger',         // po_projectdebugger
    'Search &Directories',      // po_searchdirectories
    'Search path to get infos about code', // po_searchdirectorieshint
    'Select source directory',  // po_selectsourcedir
    'Object &Base Directory (empty = Make Directory)', // po_objectbasedir
    'Select source base directory', // po_selectsourcebasedir
    'Defi&nes',                 // po_defines
    '&Signals',                 // po_signals
    '&Exception',               // po_exception
    '&Target',                  // po_target
    'Start gdb server command attach target', // po_startgdbattachtarget
    'No wait for exit',         // po_nogdbserverexit
    'Before connect gdb script', // po_beforeconnect
    'Before load gdb script',   // po_beforeload
    'Before run gdb script',    // po_beforerun
    'After connect gdb script', // po_afterconnect
    'After load gdb script',    // po_afterload
    'Start gdb server command run target', // gdbservercommand
    'Wait before connect',      // po_gdbserverwait
    'Start once',               // po_gdbserverstartonce
    'Download command',         // po_uploadcommand
    'Processor',                // po_gdbprocessor
    'Simulator',                // po_gdbsimulator
    'gdb download',             // po_gdbdownload
    'Startup BKPT',             // po_startupbkpt
    'Target connection',        // po_remoteconnection
    'Always download',          // po_downloadalways
    'Always download before run', // po_downloadalwayshint
    'Load Timeout',             // po_gdbloadtimeout
    '&Extern Console',          // po_externalconsole
    '&Stop on Exc',             // po_stoponexception
    'Stop on exceptions',       // po_stoponexceptionhint
    '&Acti-Break',              // po_activateonbreak
    'Activate on Break',        // po_activateonbreakhint
    '&Value'#10'Hints',         // po_valuehints
    'Call GUI_DEB',             // po_nodebugbeginend
    'Release mouse grab by target stop. gdb sometimes crashes with this option.', // po_nodebugbeginendhint
    'Set TT&Y',                 // po_settty
    '&Raise-Break',             // po_raiseonbreak
    'Raise on break',           // po_raiseonbreakhint
    '&FPC bugs',                // po_fpcgdbworkaround
    'Use workarounds for FPC/gdb bugs', // po_fpcgdbworkaroundhint
    'Debug &target',            // po_debugtarget
    'xterm command',            // po_xtermcommand
    '&Run command',             // po_runcommand
    'Default Debugger',        // po_debugcommand
    'Debug &options',           // po_debugoptions
    '&Make',                    // po_makepage

    'Default make col',         // po_defaultmake
    'Mainfile',                 // po_mainfile
    'Select mainfile',          // po_selectmainfile
    'Targetfile name',          // po_targetfile
    'Select target file',       // po_selecttargetfile
    'Default Compiler',         // po_makecommand
    'Select make command',      // po_selectmakecommand
    'Show Command Line',        // po_showcommandline
    'Copy messages to file',    // po_copymessages
    'Close message',            // po_closemessages
    'Check head',               // po_checkmethods
    'Check method headers',     // po_checkmethodshint
    'Project Compiler',         // po_projectcompiler
    'Command before',           // po_commandbefore
    'Make options',             // po_makeoptions
    'Directories',              // po_directories
    'Select unit directory',    // po_unitdirs
    'Command after',            // po_commandafter
    'Exe Extension',            // po_exeextension
    'Comments',                 // po_comments
    'Make Directory',           // po_makedir
    'Select make directory',    // po_selectmakedir
    'Error Color',              // po_colorerror
    'Warning Color',            // po_colorwarning
    'Note Color',               // po_colornote
    'Strip ESC',                // po_stripmessageesc
    'Strip ESC sequences in Messages and Terminal form', // po_stripmessageeschint
    'Show Console',             // po_showconsole
    'Purpose',                  //po_enablepurpose
    'Message output file',      // po_messageoutputfile
    'Select target file',       // po_selectmessageoutputfile
    'Macros',                   // po_macros
    'Active group',             // po_selectactivegroupgrid
    '&Font Alias',              // po_fontaliaspage
    'Designers',                // po_designers
    'User &Colors',             // po_usercolors
    'Copy "setcolormapvalue" code to clipboard', // po_copycolor
    'F&ormat Macros',           // po_formatmacro
    'Used by formatfloatmse() and formatdatetimemse()', // po_formatmacrohint
    'Templates',                // po_templates
    'New project',              // po_newproject
    'Script before copy',       // po_scriptbeforecopy
    'Script after copy',        // po_scriptaftercopy
    'New File',                 // po_newfile
    'New Form',                 // po_newform
    'Tools',                    // po_tools
    'Storage',                  // po_storage
    'Infos'                     // po_infos

    );

 zh_stockcaption: stockcaptionaty = (
'',
'无效',
'格式错误',
'值不能为空',
'错误',
'最小',
'最大',
'溢出错误',
'取消',
'重做',
'复制',
'剪切',
'粘贴',
'Select &all',
'插入一行',
'增加一行',
'删除所选行',
'文件夹',
'首页',
'向上',
'新文件夹',
'文件名',
'显示隐藏文件',
'保存类型',
'保存',
'打开',
'名称',
'新建文件夹',
'Back',
'Forward',
'向上',
'文件',
'文件已经存在，是否覆盖？',
'is modified. Save?',
'警告',
'错误',
'异常',
'System',
'不存在',
'PASSWORD',
'Enter password',
'Invalid password!',
'找不到文件夹',
'图形格式不支持',
'图形格式错误',
'MS Bitmap',
'MS Icon',
'JPEG Image',
'PNG Image',
'XPM Image',
'PNM Image',
'TARGA Image',
'TIFF Image',
'所有',
'证明',
'删除记录？',
'Copy record?',
'关闭页',
'第一条',
'前一条',
'下一条',
'最后',
'增加',
'删除',
'修改',
'保存',
'离开',
'刷新',
'编辑器过滤',
'Edit filter minimum',
'Edit filter maximum',
'Reset filter',
'过滤开启',
'查找',
'Auto edit',
'Copy record',
'Dialog',
'插入',
'复制',
'粘贴',
'Row insert',
'Row append',
'Row delete',
'取消',
'重做',
'剪切',
'Select all',
'过滤关闭',
'Portrait',
'Landscape',
'确定删除此条记录吗？',
'确定删除所选记录吗？',
'Single item only',
'Copy Cells',
'Paste Cells',
'关闭',
'Maximize',
'Normalize',
'Minimize',
'Fix size',
'Float',
'Stay on top',
'Stay in background',
'Lock children',
'No lock',
'Input',
'Button',
'On',
'Off',
'Left border',
'Top border',
'Right border',
'Bottom border',
'Begin of text',
'End of text',
'Inputmode',
'Overwrite',
'Deleted',
'Copied',
'Inserted',
'Pasted',
'Withdrawn',
'Window activated',
'菜单',
'Beginning of file',                      //sc_bof
    'End of file',                        //sc_eof
    'Voice output',                       //sc_voiceoutput
    'Speak again',                        //sc_speakagain
    'First column',                       //sc_firstcol
    'First row',                          //sc_firstrow
    'Last column',                        //sc_lastcol
    'Last row',                           //sc_lastrow
    'Selection',                          //sc_selection
    'Speak path',                         //sc_speakpath
    'Disabled button',                    //sc_disabledbutton
    'First field',                        //sc_firstfield
    'Last field',                         //sc_lastfield
    'First element',                      //sc_firstelement
    'Last element',                       //sc_lastelement
    'Slower',                             //sc_slower
    'Faster',                             //sc_faster
    'Window',                             //sc_window
    'Area',                               //sc_area
    'Area activated',                     //sc_areaactivated
    'Volume down',                        //sc_volumedown
    'Volume up',                          //sc_volumeup
    'Cancel speech',                      //sc_cancelspeech
    'Target',                             //sc_target
    'View',                               //sc_view
    'Forms',                              //sc_forms
    'Layout',                             //sc_layout
    'Syntax',                             //sc_syntax
    'Project',                            //sc_project
    'Edited',                             //sc_edited
    'Widgets',                            //sc_widgets
    'Settings',                           //sc_settings
    'About',                              //sc_about
    'New',                                //sc_newfile
    'Save as...',                         //sc_saveas
    'Save all',                           //sc_saveall
    'Close all',                          //sc_closeall
    'Print',                              //sc_print
    'Quit',                               //sc_quit
    'Line',                               //sc_line
    'Search again',                       //sc_search_again
    'Search back',                        //sc_search_back
    'Find & replace',                     //sc_find_replace
    'Find in files',                      //sc_find_infile
    'Procedures list',                    //sc_proclist
    'Select edit page',                   //sc_select_edit_Page
    'Copy word at cursor',                //sc_Copy_word_cursor
    'Copy LaTeX',                         //sc_copy_latex
    'Indent',                             //sc_ident
    'Unindent',                           //sc_uident
    'Environment',                        //sc_environment
    'Attach process',                     //sc_attachprocess
    'Attach target',                      //sc_attachtarget
    'Detach target',                      //sc_detachtarget
    'Download',                           //sc_download
    'Tools',                              //sc_tools
    'Make',                               // sc_make 
    'Build',                              // sc_build 
    'Abort make',                         // sc_abortmake 
    'Debug-Run',                          // sc_debugrun 
    'Options',                            // sc_options 
    'Tree',                               // sc_tree 
    'Source',                             // sc_source 
    'Open copy',                          // sc_opencopy 
    'Save copy as',                       // sc_saveascopy 
    'Beautifier',                         // sc_beautifier
    'Panels',                             // sc_panels
    'Force Z order',                      // sc_forcezorder
    'Tree list',                          // sc_treelist
    'Messages',                           // sc_messages
    'Find result',                        // sc_findresult
    'Commander',                          // sc_commander
    'Symbols',                            // sc_symbols
    'Watches',                            // sc_watches
    'Stack',                              // sc_stack
    'Threads',                            // sc_threads
    'CPU',                                // sc_cpu
    'Assembler',                          // sc_assembler
    'Breakpoints',                        // sc_breakpoints
    'Watchpoints',                        // sc_watchpoints 
    'Memory',                             // sc_memory
    'Target console',                      // sc_targetconsole 
    'Toggle form/unit',                   // sc_toggleformunit
    'MSE modules',                        // sc_msemod 
    'Close all MSE modules',              // sc_closeallmsemod
    'General settings',                   // sc_generalsettings
    'Extra settings',                     // sc_extrasettings
    'Languages',                          // sc_lang
    'Configure widgets',                  // sc_configwidgets
    'Configure compilers',                // sc_configcompilers
    'Configure debuggers',                // sc_configdebuggers
    'Themes',                             // sc_themes
    'Directory',                          // sc_directory
    'No icons',                           // sc_noicons
    'No lateral',                         // sc_themes
    'Compact',                            // sc_compact 
    'Open project',                       // sc_openproject
    'Open file',                           // sc_openfile
    'Path',                               // sc_path
    'Other',                              // sc_other
    'Print command',                      // sc_printcommand
    'Shortcut',                           // sc_shortcut
    'Value',                              // sc_value
    'Case sensitive',                     // sc_casesensitive
    'Selected only',                     // sc_selectedonly
    'Whole word',                        // sc_wholeword
    'Text to find',                        // sc_texttofind
    'Search in current file',            // sc_searchincurrentfile
    'Search in open files',            // sc_searchininopenfiles
    'Search in project directory',     // sc_searchinprojectdir
    'Search in directories',            // sc_searchindirectories
    'Include subdirectories'            // sc_includesubdir
    
   );

function delete_n_selected_rows(const params: array of const): msestring;
begin
 with params[0] do begin
  if vinteger = 1 then begin
   result:= '确定删除此条记录吗？';
  end
  else begin
   result:=  '确定删除所选择的 ' + inttostrmse(vinteger)+ ' 行记录吗？' ;
  end;
 end;
end;

const
 zh_textgenerator: defaultgeneratortextty = (
              {$ifdef FPC}@{$endif}delete_n_selected_rows //tg_delete_n_selected_rows
                                     );
initialization
 registerlangconsts(langnames[la_zh],@zh_settingstext, @zh_projectoptionstext,@zh_stockcaption,@zh_modalresulttext,
                               @zh_modalresulttextnoshortcut, @textgenerator);
end.
