{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
unit mseconsts_ide;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msestockobjects,
  mseglob,
  msestrings,
  mseapplication,
  msetypes;

type
  extendedaty =  array[extendedty] of msestring;
  pextendedaty = ^extendedaty;

  mainformaty  = array[mainformty] of msestring;
  pmainformaty = ^mainformaty;

  sourceformaty  = array[sourceformty] of msestring;
  psourceformaty = ^sourceformaty;

  actionsmoduleaty  = array[actionsmodulety] of msestring;
  pactionsmoduleaty = ^actionsmoduleaty;

  projectoptionsconaty  = array[projectoptionsconty] of msestring;
  pprojectoptionsconaty = ^projectoptionsconaty;

  projectoptionsaty  = array[projectoptionsty] of msestring;
  pprojectoptionsaty = ^projectoptionsaty;

  isettingsaty  = array[isettingsty] of msestring;
  pisettingsaty = ^isettingsaty;

  stockcaptionaty           = array[stockcaptionty] of msestring;
  pstockcaptionaty          = ^stockcaptionaty;
  defaultmodalresulttextty  = array[modalresultty] of msestring;
  pdefaultmodalresulttextty = ^defaultmodalresulttextty;
  defaultgeneratortextty    = array[textgeneratorty] of textgeneratorfuncty;
  pdefaultgeneratortextty   = ^defaultgeneratortextty;

// Language things:

  langty = (la_none, la_en, la_ru, la_fr, la_de, la_es, la_pt, la_uz, la_id, la_zh);
  langnamesaty = array[0..5] of msestring;
  plangnamesaty = ^langnamesaty;

const
  langnames: array[langty] of string = (
    '', 'en', 'ru', 'fr', 'de', 'es', 'pt', 'uz', 'id', 'zh');
  langnamesreg: array[0..5] of string = (
    'en', 'ru', 'fr', 'de', 'es', 'pt');

function langnamestext(const index: integer): msestring;
function mainformtext(const index: mainformty): msestring;
function extendedtext(const index: extendedty): msestring;
function sourceformtext(const index: sourceformty): msestring;
function settingstext(const index: isettingsty): msestring;
function actionsmoduletext(const index: actionsmodulety): msestring;
function projectoptionscontext(const index: projectoptionsconty): msestring;
function projectoptionstext(const index: projectoptionsty): msestring;
function modalresulttext(const index: modalresultty): msestring;
function modalresulttextnoshortcut(const index: modalresultty): msestring;
function stockcaptions(const index: stockcaptionty): msestring;
function stocktextgenerators(const index: textgeneratorty): textgeneratorfuncty;
function uc(const index: integer): msestring; //get user caption

procedure registeruserlangconsts(Name: string; const Caption: array of msestring);
procedure registerlangconsts(const Name: string;
    const langnamespo : plangnamesaty;
    const extendedpo : pextendedaty;
    const mainformpo : pmainformaty;
    const sourceformpo : psourceformaty;
    const projectoptionsconpo: pprojectoptionsconaty;
   const actionsmodulepo: pactionsmoduleaty; const settingspo: pisettingsaty;
  const projectoptionspo: pprojectoptionsaty; const stockcaptionpo: pstockcaptionaty; const modalresulttextpo: pdefaultmodalresulttextty; const modalresulttextnoshortcutpo: pdefaultmodalresulttextty;
  const textgeneratorpo: pdefaultgeneratortextty);
function setlangconsts(const Name: string): Boolean;
 //true if ok, no change otherwise
function getcurrentlangconstsname: string;
procedure setuserlangconsts(const Name: string);
 //called by setlangconsts automatically
type
  langchangeprocty = procedure(const langname: ansistring);

procedure registerlangchangeproc(const aproc: langchangeprocty);
procedure unregisterlangchangeproc(const aproc: langchangeprocty);

type
  langinfoty = record
    Name: string;
    langnamestext : plangnamesaty;
    extendedtext: pextendedaty;
    mainformtext : pmainformaty;
    stockcaption: pstockcaptionaty;
    sourceformtext: psourceformaty;
    settingstext: pisettingsaty;
    projectoptionstext: pprojectoptionsaty;
    projectoptionscontext: pprojectoptionsconaty;

    actionsmoduletext: pactionsmoduleaty;

    modalresulttext: pdefaultmodalresulttextty;
    modalresulttextnoshortcut: pdefaultmodalresulttextty;
    textgenerator: pdefaultgeneratortextty;
  end;

  userlanginfoty = record
    Name: string;
    Caption: msestringarty;
  end;

var
  langs: array of langinfoty;
  lang: langinfoty;
  langbefore: ansistring;
  userlangs: array of userlanginfoty;
  userlang: userlanginfoty;
  langchangeprocs: array of langchangeprocty;

const
  en_modalresulttext: defaultmodalresulttextty =
    ('',             //mr_none
    '',              //mr_canclose
    '',              //mr_windowclosed
    '',              //mr_windowdestroyed
    '',              //mr_escape
    '',              //mr_f10
    '',              //mr_exception
    '&Cancel',       //mr_cancel
    '&Abort',        //mr_abort
    '&OK',           //mr_ok
    '&Yes',          //mr_yes
    '&No',           //mr_no
    'Yes &all',      //mr_all
    'Yes &all',      //mr_yesall
    'N&o all',       //mr_noall
    '&Ignore',       //mr_ignore
    '&Skip',         //mr_skip
    'Skip a&ll',     //mr_skipall
    'Co&ntinue'      //mr_continue
    );

  en_modalresulttextnoshortcut: defaultmodalresulttextty =
    ('',            //mr_none
    '',             //mr_canclose
    '',             //mr_windowclosed
    '',             //mr_windowdestroyed
    '',             //mr_esc
    '',             //mr_f10
    '',             //mr_exception
    'Cancel',       //mr_cancel
    'Abort',        //mr_abort
    'OK',           //mr_ok
    'Yes',          //mr_yes
    'No',           //mr_no
    'Yes all',      //mr_all
    'Yes all',      //mr_yesall
    'No all',       //mr_noall
    'Ignore',       //mr_ignore
    'Skip',         //mr_skip
    'Skip all',     //mr_skipall
    'Continue'      //mr_continue
    );

  en_mainformtext: mainformaty = (
      'Unresolved references in',
      'to',
      'Do you wish to search the formfile?',
      'WARNING',
      'Formfile for',
      'Formfiles',
      'Recursive form hierarchy for "',
      'ERROR',
      'Classtype',
      'not found.',
      'Project',
      'is modified. Save?',
      'Confirmation',
      'Unable to open file "',
      '*** Running ***',
      'Downloading',
      'Downloaded',
      'Start gdb server command "',
      '" running.',
      'Start gdb Server',
      'gdb server start error',
      'gdb server start canceled.',
      'Can not run start gdb command.',
      'Uploadcommand "',
      'Download ***ERROR***',
      'Download finished.',
      'Download canceled.',
      'File "',
      '" not found.',
      '" exists.',
      'New',
      'Select ancestor',
      'New form',
      'Pascal Files',
      'new',
      'Can not load Project "',
      'Select project template',
      'Project files',
      'All files',
      'Select program file',
      'Pascal program files',
      'C program files',
      'New Project',
      'Can not start process',
      'Process',
      'running.',
      'Process terminated',
      'Process terminated normally.',
      'Make ***ERROR***',
      'Make OK.',
      'Source has changed, do you wish to remake project?',
      'Load Window Layout',
      'Docking area'
    );

  en_actionsmoduletext: actionsmoduleaty = (
    'Configure ideU',
    'Process ID',
    'Attach to process',
    'Unknown moduleclass for "',
    'Inherited component "',
    '" can not be deleted.',
    'ERROR',
    'Make aborted.',
    'Download aborted.',
    'Runerror with "',
    'Error: Timeout.',
    'Making.',
    'Make not running.',
    'Downloading.',
    'Download not running.',
    '" running.',
    'Script',
    'Recursive form inheritance of "',
    'Component "',
    '" exists.',
    'Ancestor for "',
    '" not found.',
    'Module "',
    'Invalid name "',
    'Invalid methodname',
    'Module not found',
    'Method not found',
    'Published (managed) method',
    'does not exist.',
    'Do you wish to delete the event?',
    'WARNING',
    'Method',
    'has different parameters.',
    'A module "',
    '" is already open.',
    'Unresolved reference(s) to',
    'Module(s):',
    'Can not read formfile "',
    'Invalid component name.',
    'Invalid exception',
    'T&ools',
    'Forms',
    'Source',
    'All Files',
    'MSE Program',
    'MSE Unit',
    'MSE Textfile',
    'Mainform',
    'Simple Form',
    'Docking Form',
    'Datamodule',
    'Subform',
    'Scrollboxform',
    'Tabform',
    'Dockpanel',
    'Report',
    'Scriptform',
    'Inherited Form',
    'Do you want to replace the settings by',
    'File "',
    'Do you want to overwrite?',
    'Unknown',
    'Error',
    'Startup',
    'Exception',
    'GDB died',
    'Breakpoint hit',
    'Watchpoint triggered',
    'Read Watchpoint triggered',
    'Access Watchpoint triggered',
    'End stepping range',
    'Function finished',
    'Exited normally',
    'Exited',
    'Detached',
    'Signal received',
    'Stop error',
    'Can not read project',
    'About',
    'Object Inspector',
    'Store Component',
    'Attaching Process',
    'Loading'
    );

  en_projectoptionscontext: projectoptionsconaty = (
    'Wrong encoding can damage your source files.',
    'Do you wish to set encoding to',
    '*** WARNING ***',
    'Hangup',
    'Interrupt',
    'Quit',
    'Illegal instruction',
    'Trace trap',
    'Abort',
    'BUS error',
    'Floating-point exception',
    'Kill',
    'User-defined signal 1',
    'Segmentation violation',
    'User-defined signal 2',
    'Broken pipe',
    'Alarm clock',
    'Termination',
    'Stack fault',
    'Child status has changed',
    'Continue',
    'Stop, unblockable',
    'Keyboard stop',
    'Background read from tty',
    'Background write to tty',
    'Urgent condition on socket',
    'CPU limit exceeded',
    'File size limit exceeded',
    'Virtual alarm clock',
    'Profiling alarm clock',
    'Window size change',
    'I/O now possible',
    'Power failure restart'
    );

  en_settingstext: isettingsaty = (
    'Apply',          //se_apply
    'sak voice assistive config', //se_groupassistive
    'Parent directory of sakit', //se_sakitdir
    'Enable sak assistive at loading', //se_enableassistive
    'System layout',  //se_groupsystemlayout
    'Universal path layout', //se_universalpath
    'No Z order handling', //se_nozorder
    'Use shift key to select a word', //se_doubleclic
    'Auto focus in main-menu', //se_autofocusmenu
    'Full path of project in window title', //se_fullpath
    'Set dialog-forms as modal vs as tool', //se_modaldial
    'Font height',    //se_fontsize
    'Font name',      //se_fontname
    'No confirmation to delete row', //se_confirmdel
    'Blinking caret', //se_blinkcaret
    'Repaint canvas', //se_repaintcanvas
    'Source Editor',  //se_groupsourceeditor
    'Use those options instead of project options', //se_usedefaulteditoroptions
    'Add space after comma -> auto-parsing', //se_addwhiteaftercomma
    'When a file has changed', //se_groupfilechange
    'No dialog box => reload the new one', //se_filereload
    'No dialog box => keep the old one', //se_filenoload
    'A dialog box ask what to do...', //se_fileaskload
    'Rectangle around multi-select' //se_rectanglearea
    );

  en_projectoptionstext: projectoptionsaty = (
    'Project options',                  // po_projectoptions
    'Editor',                           // po_editor
    'Right margin line',                // po_rightmarginline
    'Mark Brackets',                    //  po_markbrackets
    'Line Numbers',                     //  po_linenumbers
    'Mark Pairwords',                   //  po_markpairwords
    'Trim trailing whitespace on save', //  po_trimtrailing
    'Auto Indent',                      //  po_autoindent
    'No Source Editor',                 //  po_nosource
    'Tab indent',                       //  po_tabindent
    'Space tab',                        //  po_spacetab
    'Show tabs',                        //  po_showtabs
    'Anti aliased font',                //  po_antialiasedfont
    'Encoding',                         //  po_encoding
    'Mark Color',                       //  po_markcolor
    'Stat Color',                       // po_statcolor
    'Scr Y',                            // po_scrollbary
    'Nb char',                          // po_nbchar
    'EOL Style',                        //  po_eolstyle
    'Backup',                           //  po_backup
    'Tabstops',                         //  po_tabstops
    'Indent',                           //  po_indent
    'ExtS',                             //  po_extraspace
    'Extra space between lines',        //  po_extraspacehint
    'Width',                            //  po_width
    'Height',                           //  po_height
    'Font',                             //  po_font
    'Font Bk. color',                   //  po_fontbkcolor
    'Font color',                       //  po_fontcolor
    'File filter',                      //  po_filefilter
    'Name',                             //  po_name
    'File mask',                        //  po_filemask
    'Syntax definition file',           //  po_syntaxdeffile
    'Code Templates',                   //  po_codetemplate
    'Code template directories, file extension = .mct', //  po_fontcodetemplatedir
    'Select unit directory',            // po_selectunitdir
    '&Debugger',                        // po_debuggerpage
    'Project Debugger',                 // po_projectdebugger
    'Search &Directories',              // po_searchdirectories
    'Search path to get infos about code', // po_searchdirectorieshint
    'Select source directory',          // po_selectsourcedir
    'Object &Base Directory (empty = Make Directory)', // po_objectbasedir
    'Select source base directory',     // po_selectsourcebasedir
    'Defi&nes',                         // po_defines
    '&Signals',                         // po_signals
    '&Exception',                       // po_exception
    '&Target',                          // po_target
    'Start gdb server command attach target', // po_startgdbattachtarget
    'No wait for exit',                 // po_nogdbserverexit
    'Before connect gdb script',        // po_beforeconnect
    'Before load gdb script',           // po_beforeload
    'Before run gdb script',            // po_beforerun
    'After connect gdb script',         // po_afterconnect
    'After load gdb script',            // po_afterload
    'Start gdb server command run target', // gdbservercommand
    'Wait before connect',              // po_gdbserverwait
    'Start once',                       // po_gdbserverstartonce
    'Download command',                 // po_uploadcommand
    'Processor',                        // po_gdbprocessor
    'Simulator',                        // po_gdbsimulator
    'gdb download',                     // po_gdbdownload
    'Startup BKPT',                     // po_startupbkpt
    'Target connection',                // po_remoteconnection
    'Always download',                  // po_downloadalways
    'Always download before run',       // po_downloadalwayshint
    'Load Timeout',                     // po_gdbloadtimeout
    '&Extern Console',                  // po_externalconsole
    '&Stop on Exc',                     // po_stoponexception
    'Stop on exceptions',               // po_stoponexceptionhint
    '&Acti-Break',                      // po_activateonbreak
    'Activate on Break',                // po_activateonbreakhint
    '&Value Hints',                     // po_valuehints
    'Call GUI_DEB',                     // po_nodebugbeginend
    'Release mouse grab by target stop. gdb sometimes crashes with this option.', // po_nodebugbeginendhint
    'Set TT&Y',                         // po_settty
    '&Raise-Break',                     // po_raiseonbreak
    'Raise on break',                   // po_raiseonbreakhint
    '&FPC bugs',                        // po_fpcgdbworkaround
    'Use workarounds for FPC/gdb bugs', // po_fpcgdbworkaroundhint
    'Debug &target',                    // po_debugtarget
    'xterm command',                    // po_xtermcommand
    'Run command',                      // po_runcommand
    'Default Debugger',                 // po_debugcommand
    'Debug &options',                   // po_debugoptions
    '&Make',                            // po_makepage
    'Default make col',                 // po_defaultmake
    'Mainfile',                         // po_mainfile
    'Select mainfile',                  // po_selectmainfile
    'Targetfile name',                  // po_targetfile
    'Select target file',               // po_selecttargetfile
    'Default Compiler',                 // po_makecommand
    'Select make command',              // po_selectmakecommand
    'Show Command Line',                // po_showcommandline
    'Copy messages to file',            // po_copymessages
    'Close message',                    // po_closemessages
    'Check head',                       // po_checkmethods
    'Check method headers',             // po_checkmethodshint
    'Project Compiler',                 // po_projectcompiler
    'Command before',                   // po_commandbefore
    'Make options',                     // po_makeoptions
    'Directories',                      // po_directories
    'Select unit directory',            // po_unitdirs
    'Command after',                    // po_commandafter
    'Exe Extension',                    // po_exeextension
    'Comments',                         // po_comments
    'Make Directory',                   // po_makedir
    'Select make directory',            // po_selectmakedir
    'Error Color',                      // po_colorerror
    'Warning Color',                    // po_colorwarning
    'Note Color',                       // po_colornote
    'Strip ESC',                        // po_stripmessageesc
    'Strip ESC sequences in Messages and Terminal form', // po_stripmessageeschint
    'Show Console',                     // po_showconsole
    'Purpose',                          //po_enablepurpose
    'Message output file',              // po_messageoutputfile
    'Select target file',               // po_selectmessageoutputfile
    'Macros',                           // po_macros
    'Active group',                     // po_selectactivegroupgrid
    '&Font Alias',                      // po_fontaliaspage
    'Designers',                        // po_designers
    'User &Colors',                     // po_usercolors
    'Copy "setcolormapvalue" code to clipboard', // po_copycolor
    'F&ormat Macros',                   // po_formatmacro
    'Used by formatfloatmse() and formatdatetimemse()', // po_formatmacrohint
    'Templates',                        // po_templates
    'New project',                      // po_newproject
    'Script before copy',               // po_scriptbeforecopy
    'Script after copy',                // po_scriptaftercopy
    'New File',                         // po_newfile
    'New Form',                         // po_newform
    'Tools',                            // po_tools
    'Storage',                          // po_storage
    'Infos',                             // po_infos
    'Full name of project',             // po_projectfullname
    'Creator',                           // po_creator
    'License',                             // po_license
    'Date of creation'                             // po_projectdate

    );

   en_sourceformtext: sourceformaty = (
      'File "',
      '" has changed.',
      'There are modifications in edit buffer also.',
      'Do you wish to reload from disk?',
      'Confirmation',
      '<none>',
      'Do you wish to replace:',
      'with:',
      '<new>',
      'Syntaxdeffile:',
      'Text',
      'not found.',
      'Restart from begin of file?',
      'Cancel?',
      'Do you wish to to replace this occurence?',
      'Go to line number:',
      'Find line',
      'There are modifications in edit buffer also.'
    );

  en_stockcaption: stockcaptionaty = (
    '',                                    //sc_none
    'is invalid',                          //sc_is_invalid
    'Format error',                        //sc_Format_error
    'Value is required',                   //sc_Value_is_required
    'Error',                               //sc_Error
    'Min',                                 //sc_Min
    'Max',                                 //sc_Max
    'Range error',                         //sc_Range_error

    '&Undo',                               //sc_Undohk       ///         ///
    '&Redo',                               //sc_Redohk        //          //
    '&Copy',                               //sc_Copyhk        // hotkeys  //
    'Cu&t',                                //sc_Cuthk         //          //
    '&Paste',                              //sc_Pastehk       //          // hotkeys
    'Select &all',                         //sc_Select_allhk ///          //
    '&Insert Row',                         //sc_insert_rowhk ///          //
    '&Append Row',                         //sc_append_rowhk  // hotkeys  //
    '&Delete Row',                         //sc_delete_rowhk ///         ///

    '&Dir',                                //sc_Dirhk               ///
    '&Home',                               //sc_homehk               //
    '&Up',                                 //sc_Uphk                 //
    '&New',                                //sc_New_dirhk            // hotkeys
    '&Name',                               //sc_Namehk               //
    '&Show hidden files',                  //sc_Show_hidden_fileshk  //
    '&Filter',                             //sc_Filterhk            ///
    'Save',                                //sc_save
    'Open',                                //sc_open
    'Name',                                //sc_name
    'Create new directory',                //sc_create_new_directory
    'Back',                                //sc_back
    'Forward',                             //sc_forward
    'Up',                                  //sc_up
    'File',                                //sc_file
    'exists, do you want to overwrite?',   //sc_exists_overwrite
    'is modified. Save?',                  //sc_is_modified_save
    'WARNING',                             //sc_warningupper
    'ERROR',                               //sc_errorupper
    'Exception',                           //sc_exception
    'System',                              //sc_system
    'does not exist',                      //sc_does_not_exist
    'PASSWORD',                            //sc_passwordupper
    'Enter password',                      //sc_enterpassword
    'Invalid password!',                   //sc_invalidpassword
    'Can not read directory',              //sc_can_not_read_directory
    'Graphic format not supported',        //sc_graphic_not_supported
    'Graphic format error',                //sc_graphic_format_error
    'MS Bitmap',                           //sc_MS_Bitmap
    'MS Icon',                             //sc_MS_Icon
    'JPEG Image',                          //sc_JPEG_Image
    'PNG Image',                           //sc_PNG_Image
    'XPM Image',                           //sc_XPM_Image
    'PNM Image',                           //sc_PNM_Image
    'TARGA Image',                         //sc_TARGA_image
    'TIFF Image',                          //sc_TIFF_image
    'All',                                 //sc_All
    'Confirmation',                        //sc_Confirmation
    'Delete record?',                      //sc_Delete_record_question
    'Copy record?',                        //sc_Copy_record_question
    'Close page',                          //sc_close_page
    'First',                               //sc_first
    'Prior',                               //sc_prior
    'Next',                                //sc_next
    'Last',                                //sc_last
    'Append',                              //sc_append
    'Delete',                              //sc_delete
    'Edit',                                //sc_edit
    'Post',                                //sc_post
    'Cancel',                              //sc_cancel
    'Refresh',                             //sc_refresh
    'Edit filter',                         //sc_filter_filter
    'Edit filter minimum',                 //sc_edit_filter_min
    'Edit filter maximum',                 //sc_filter_edit_max
    'Reset filter',                        //sc_reset_filter
    'Filter on',                           //sc_filter_on
    'Search',                              //sc_search
    'Auto edit',                           //sc_auto_edit
    'Copy record',                         //sc_copy_record
    'Dialog',                              //sc_dialog
    'Insert',                              //sc_insert
    'Copy',                                //sc_copy
    'Paste',                               //sc_paste
    'Row insert',                          //sc_row_insert
    'Row append',                          //sc_row_append
    'Row delete',                          //sc_row_delete
    'Undo',                                //sc_undo
    'Redo',                                //sc_redo
    'Cut',                                 //sc_cut
    'Select all',                          //sc_select_all
    'Filter off',                          //sc_filter_off
    'Portrait',                            //sc_portrait print orientation
    'Landscape',                           //sc_landscape print orientation
    'Delete row?',                         //sc_Delete_row_question
    'selected rows?',                      //sc_selected_rows
    'Single item only',                    //sc_Single_item_only
    'Copy Cells',                          //sc_Copy_Cells
    'Paste Cells',                         //sc_Paste_Cells
    'Close',                               //sc_close
    'Maximize',                            //sc_maximize
    'Normalize',                           //sc_normalize
    'Minimize',                            //sc_minimize
    'Fix size',                            //sc_fix_size
    'Float',                               //sc_float
    'Stay on top',                         //sc_stay_on_top
    'Stay in background',                  //sc_stay_in_background
    'Lock children',                       //sc_lock_children
    'No lock',                             //sc_no_lock
    'Input',                               //sc_input
    'Button',                              //sc_button
    'On',                                  //sc_on
    'Off',                                 //sc_off
    'Left border',                         //sc_leftborder
    'Top border',                          //sc_topborder
    'Right border',                        //sc_rightborder
    'Bottom border',                       //sc_bottomborder
    'Begin of text',                       //sc_beginoftext
    'End of text',                         //sc_endoftext
    'Inputmode',                           //sc_inputmode
    'Overwrite',                           //sc_overwrite
    'Deleted',                             //sc_deleted
    'Copied',                              //sc_copied
    'Inserted',                            //sc_inserted
    'Pasted',                              //sc_pasted
    'Withdrawn',                           //sc_withdrawn
    'Window activated',                    //sc_windowactivated
    'Menu',                                //sc_menu
    'Beginning of file',                   //sc_bof
    'End of file',                         //sc_eof
    'Voice output',                        //sc_voiceoutput
    'Speak again',                         //sc_speakagain
    'First column',                        //sc_firstcol
    'First row',                           //sc_firstrow
    'Last column',                         //sc_lastcol
    'Last row',                            //sc_lastrow
    'Selection',                           //sc_selection
    'Speak path',                          //sc_speakpath
    'Disabled button',                     //sc_disabledbutton
    'First field',                         //sc_firstfield
    'Last field',                          //sc_lastfield
    'First element',                       //sc_firstelement
    'Last element',                        //sc_lastelement
    'Slower',                              //sc_slower
    'Faster',                              //sc_faster
    'Window',                              //sc_window
    'Area',                                //sc_area
    'Area activated',                      //sc_areaactivated
    'Volume down',                         //sc_volumedown
    'Volume up',                           //sc_volumeup
    'Cancel speech',                       //sc_cancelspeech
    'Target',                              //sc_target
    'View',                                //sc_view
    'Forms',                               //sc_forms
    'Layout',                              //sc_layout
    'Syntax',                              //sc_syntax
    'Project',                             //sc_project
    'Edited',                              //sc_edited
    'Widgets',                             //sc_widgets
    'Settings',                            //sc_settings
    'About',                               //sc_about
    'New',                                 //sc_newfile
    'Save as...',                          //sc_saveas
    'Save all',                            //sc_saveall
    'Close all',                           //sc_closeall
    'Print',                               //sc_print
    'Quit',                                //sc_quit
    'Line',                                //sc_line
    'Search again',                        //sc_search_again
    'Search back',                         //sc_search_back
    'Find & replace',                      //sc_find_replace
    'Find in files',                       //sc_find_infile
    'Procedures list',                     //sc_proclist
    'Select edit page',                    //sc_select_edit_Page
    'Copy word at cursor',                 //sc_Copy_word_cursor
    'Copy LaTeX',                          //sc_copy_latex
    'Indent',                              //sc_ident
    'Unindent',                            //sc_uident
    'Environment',                         //sc_environment
    'Attach process',                      //sc_attachprocess
    'Attach target',                       //sc_attachtarget
    'Detach target',                       //sc_detachtarget
    'Download',                            //sc_download
    'Tools',                               //sc_tools
    'Make',                                // sc_make
    'Build',                               // sc_build
    'Abort make',                          // sc_abortmake
    'Debug-Run',                           // sc_debugrun
    'Options',                             // sc_options
    'Tree',                                // sc_tree
    'Source',                              // sc_source
    'Open copy',                           // sc_opencopy
    'Save copy as',                        // sc_saveascopy
    'Beautifier',                          // sc_beautifier
    'Panels',                              // sc_panels
    'Force Z order',                       // sc_forcezorder
    'Tree list',                           // sc_treelist
    'Messages',                            // sc_messages
    'Find result',                         // sc_findresult
    'Commander',                           // sc_commander
    'Symbols',                             // sc_symbols
    'Watches',                             // sc_watches
    'Stack',                               // sc_stack
    'Threads',                             // sc_threads
    'CPU',                                 // sc_cpu
    'Assembler',                           // sc_assembler
    'Breakpoints',                         // sc_breakpoints
    'Watchpoints',                         // sc_watchpoints
    'Memory',                              // sc_memory
    'Target console',                      // sc_targetconsole
    'Toggle form/unit',                    // sc_toggleformunit
    'MSE modules',                         // sc_msemod
    'Close all MSE modules',               // sc_closeallmsemod
    'General settings',                    // sc_generalsettings
    'Extra settings',                      // sc_extrasettings
    'Languages',                           // sc_lang
    'Configure widgets',                   // sc_configwidgets
    'Configure compilers',                 // sc_configcompilers
    'Configure debuggers',                 // sc_configdebuggers
    'Themes',                              // sc_themes
    'Directory',                           // sc_directory
    'No icons',                            // sc_noicons
    'No lateral',                          // sc_themes
    'Compact',                             // sc_compact
    'Open project',                        // sc_openproject
    'Open file',                           // sc_openfile
    'Path',                                // sc_path
    'Other',                               // sc_other
    'Print command',                       // sc_printcommand
    'Shortcut',                            // sc_shortcut
    'Value',                               // sc_value
    'Case sensitive',                      // sc_casesensitive
    'Selected only',                       // sc_selectedonly
    'Whole word',                          // sc_wholeword
    'Text to find',                        // sc_texttofind
    'Search in current file',              // sc_searchincurrentfile
    'Search in open files',                // sc_searchininopenfiles
    'Search in project directory',         // sc_searchinprojectdir
    'Search in directories',               // sc_searchindirectories
    'Include subdirectories',               // sc_includesubdir

    'Replace',                              // sc_replace
    'Replace all',                          // sc_replace all
    'Replace with',                         // sc_replacewith
    'Prompt on replace',                    // sc_promptonreplace
    'Components palette',                    // sc_componentspalette
    'Find components',                       // sc_findcomponent
    'Reset',                                 // sc_reset
    'Step',                                 // sc_cstep
    'Step instruction',                     // sc_stepinstruction
    'Next instruction',                     // sc_nextinstruction
    'Restart debugger',                     // sc_restartdebugger
    'Toggle breakpoint',                    // sc_togglebreakpoint
    'Toggle breakpoint enabled',            // sc_tooglebreakpointenable
    'Executed lines hint on/off',            // sc_execlinehinton
    'Please compile it first.',               // sc_compileitfirst
    'Finish',                                // sc_finish
    'Set as default',                          // sc_setasdefault
    'Host',                                   // sc_host
    'Copyright'                         // sc_copyright
    );

 en_langnamestext: array[0..5] of msestring = (
    'English',                                // 0_English
    'Russian',                                // 1_Russian
    'French',                                // 2_french
    'German',                                // 3_german
    'Spanish',                                // 4_spanish
    'Portuguese'                            //5_portuguese
    );

 en_extendedtext: extendedaty =
 ('Delete selected row?',    // ex_del_row_selected
  'Delete %s selected rows?' // ex_del_rows_selected
  );

implementation

uses
  SysUtils,
  msesysintf,
  msearrayutils,
  mseformatstr;

function delete_n_selected_rows(const params: array of const): msestring;
begin
 with params[0] do begin
  if vinteger = 1 then begin
   result:= en_extendedtext[ex_del_row_selected];
  end
  else begin
   result := StringReplace(en_extendedtext[ex_del_rows_selected], #37#115, inttostrmse(vinteger), [rfReplaceAll]);
  end;
 end;
end;

const
  en_textgenerator: defaultgeneratortextty = (
              {$ifdef FPC} @{$endif}delete_n_selected_rows //tg_delete_n_selected_rows
    );

procedure setitem(var item: langinfoty; const Name: string;
const langnamespo : plangnamesaty;
const extendedpo: pextendedaty;
const mainformpo: pmainformaty;
const sourceformpo: psourceformaty;
const projectoptionsconpo: pprojectoptionsconaty; const actionsmodulepo: pactionsmoduleaty; const settingspo: pisettingsaty;
  const projectoptionspo: pprojectoptionsaty; const stockcaptionpo: pstockcaptionaty; const modalresulttextpo: pdefaultmodalresulttextty; const modalresulttextnoshortcutpo: pdefaultmodalresulttextty; const textgeneratorpo: pdefaultgeneratortextty);
begin
  item.Name          := Name;
  item.langnamestext := langnamespo;
  item.extendedtext  := extendedpo;
  item.mainformtext := mainformpo;
  item.sourceformtext := sourceformpo;
  item.projectoptionscontext := projectoptionsconpo;
  item.actionsmoduletext := actionsmodulepo;
  item.settingstext  := settingspo;
  item.projectoptionstext := projectoptionspo;
  item.stockcaption  := stockcaptionpo;
  item.modalresulttext := modalresulttextpo;
  item.modalresulttextnoshortcut := modalresulttextnoshortcutpo;
  item.textgenerator := textgeneratorpo;
end;

procedure registerlangconsts(const Name: string;
  const langnamespo : plangnamesaty;
  const extendedpo : pextendedaty;
  const mainformpo : pmainformaty;
  const sourceformpo : psourceformaty;
  const projectoptionsconpo: pprojectoptionsconaty; const actionsmodulepo: pactionsmoduleaty; const settingspo: pisettingsaty;
  const projectoptionspo: pprojectoptionsaty; const stockcaptionpo: pstockcaptionaty; const modalresulttextpo: pdefaultmodalresulttextty; const modalresulttextnoshortcutpo: pdefaultmodalresulttextty;
  const textgeneratorpo: pdefaultgeneratortextty);
var
  int1: integer;
begin
  for int1 := 0 to high(langs) do
    if langs[int1].Name = Name then
    begin
      setitem(langs[int1], Name,
      langnamespo,
       extendedpo,
       mainformpo,
       sourceformpo,
       projectoptionsconpo, actionsmodulepo, settingspo, projectoptionspo, stockcaptionpo, modalresulttextpo,
        modalresulttextnoshortcutpo, textgeneratorpo);
      Exit;
    end;
  setlength(langs, high(langs) + 2);
  setitem(langs[high(langs)], Name,
   langnamespo,
   extendedpo,
   mainformpo,
   sourceformpo,
   projectoptionsconpo, actionsmodulepo, settingspo, projectoptionspo, stockcaptionpo, modalresulttextpo,
    modalresulttextnoshortcutpo, textgeneratorpo);
end;

procedure registeruserlangconsts(Name: string; const Caption: array of msestring);

  procedure setitem(var item: userlanginfoty);
  var
    int1: integer;
  begin
    item.Name := Name;
    setlength(item.Caption, length(Caption));
    for int1  := 0 to high(Caption) do
      item.Caption[int1] := Caption[int1];
  end;

var
  int1: integer;
begin
  Name     := lowercase(Name);
  for int1 := 0 to high(userlangs) do
    if userlangs[int1].Name = Name then
    begin
      setitem(userlangs[int1]);
      Exit;
    end;
  setlength(userlangs, high(userlangs) + 2);
  setitem(userlangs[high(userlangs)]);
end;

procedure setuserlangconsts(const Name: string);
var
  int1: integer;
begin
  if Name = '' then
  begin
    if high(userlangs) >= 0 then
      userlang := userlangs[0];
  end
  else if Name <> userlang.Name then
    for int1 := 0 to high(userlangs) do
      if userlangs[int1].Name = Name then
      begin
        userlang := userlangs[int1];
        break;
      end;
end;

function getcurrentlangconstsname: string;
begin
  Result := lang.Name;
end;

function setlangconsts(const Name: string): Boolean;
var
  int1: integer;
  bo1: Boolean;
  str1: string;
begin
  if Name = '' then
  begin
    str1   := lowercase(sys_getlangname);
    if str1 = '' then
      str1 := langnames[la_en];
  end
  else
    str1 := lowercase(Name);
  setuserlangconsts(str1);
  Result := False;
  bo1    := lang.Name = '';
  if lang.Name <> str1 then
  begin
    for int1 := 0 to high(langs) do
      if langs[int1].Name = str1 then
      begin
        lang   := langs[int1];
        Result := True;
        break;
      end;
    if bo1 then
      if lang.Name = '' then
        setitem(lang, langnames[la_en], @en_langnamestext, @en_extendedtext,
        @en_mainformtext, @en_sourceformtext,
        @en_projectoptionscontext, @en_actionsmoduletext, @en_settingstext,
         @en_projectoptionstext, @en_stockcaption, @en_modalresulttext,
          @en_modalresulttextnoshortcut, @en_textgenerator);
  end;
  if lowercase(str1) <> langbefore then
  begin
    for int1 := 0 to high(langchangeprocs) do
      langchangeprocs[int1](str1);
    application.langchanged;
  end;
end;

procedure checklang;
begin
  if lang.Name = '' then
    setlangconsts('');
end;

function uc(const index: integer): msestring;
begin
  if userlang.Name = '' then
    setuserlangconsts('');
  if (index < 0) or (index > high(userlang.Caption)) then
    raise Exception.Create('Invalid user caption index: ' + IntToStr(index) + '.');
  Result := userlang.Caption[index];
end;

function settingstext(const index: isettingsty): msestring;
begin
  checklang;
  Result := lang.settingstext^[index];
end;

function actionsmoduletext(const index: actionsmodulety): msestring;
begin
  checklang;
  Result := lang.actionsmoduletext^[index];
end;

function sourceformtext(const index: sourceformty): msestring;
begin
  checklang;
  Result := lang.sourceformtext^[index];
end;

function mainformtext(const index: mainformty): msestring;
begin
  checklang;
  Result := lang.mainformtext^[index];
end;

function extendedtext(const index: extendedty): msestring;
begin
  checklang;
  Result := lang.extendedtext^[index];
end;

function langnamestext(const index: integer): msestring;
begin
  checklang;
  Result := lang.langnamestext^[index];
end;

function projectoptionstext(const index: projectoptionsty): msestring;
begin
  checklang;
  Result := lang.projectoptionstext^[index];
end;

function projectoptionscontext(const index: projectoptionsconty): msestring;
begin
  checklang;
  Result := lang.projectoptionscontext^[index];
end;

function modalresulttext(const index: modalresultty): msestring;
begin
  checklang;
  Result := lang.modalresulttext^[index];
end;

function modalresulttextnoshortcut(const index: modalresultty): msestring;
begin
  checklang;
  Result := lang.modalresulttextnoshortcut^[index];
end;

function stocktextgenerators(const index: textgeneratorty): textgeneratorfuncty;
begin
  checklang;
  Result := lang.textgenerator^[index];
end;

function stockcaptions(const index: stockcaptionty): msestring;
begin
  checklang;
  Result := lang.stockcaption^[index];
end;

procedure registerlangchangeproc(const aproc: langchangeprocty);
begin
  additem(pointerarty(langchangeprocs),
{$ifndef FPC}@{$endif}
    aproc);
end;

procedure unregisterlangchangeproc(const aproc: langchangeprocty);
begin
  removeitem(pointerarty(langchangeprocs),
{$ifndef FPC}@{$endif}
    aproc);
end;

initialization
  registerlangconsts(langnames[la_en], @en_langnamestext, @en_extendedtext, @en_mainformtext,
  @en_sourceformtext,
   @en_projectoptionscontext, @en_actionsmoduletext, @en_settingstext,
   @en_projectoptionstext, @en_stockcaption, @en_modalresulttext,
    @en_modalresulttextnoshortcut, @en_textgenerator);
  langbefore := langnames[la_en];
end.

