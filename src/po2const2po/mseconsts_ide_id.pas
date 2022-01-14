{ MSEgui Copyright (c) 1999-2010 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    Indonesia translation by Wahono.

}
unit mseconsts_ide_id;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

implementation
uses
 mseconsts,msetypes{msestrings},sysutils,mseformatstr;

const
 id_modalresulttext: defaultmodalresulttextty =
 ('',            //mr_none
  '',            //mr_canclose
  '',            //mr_windowclosed
  '',            //mr_windowdestroyed
  '',            //mr_escape
  '',            //mr_f10
  '',            //mr_exception
  '&Batal',   //mr_cancel
  '&Gagalkan',    //mr_abort
  '&OK',         //mr_ok
  '&Ya',      //mr_yes
  '&Tidak',         //mr_no
  '&Semua',       //mr_all
  'Yes &all',  //mr_yesall
  'Tid&ak Semua',    //mr_noall
  '&Abaikan',     //mr_ignore
  '&Skip',    //mr_skip
  'Skip &all', //mr_skipall
  'Co&ntinue'  //mr_continue
  );

 id_modalresulttextnoshortcut: defaultmodalresulttextty =
 ('',           //mr_none
  '',           //mr_canclose
  '',           //mr_windowclosed
  '',           //mr_windowdestroyed
  '',           //mr_escape
  '',           //mr_f10
  '',           //mr_exception
  'Gagal',   //mr_cancel
  'Batal',    //mr_abort
  'OK',         //mr_ok
  'Ya',      //mr_yes
  'Tidak',         //mr_no
  'Semua',       //mr_all
  'Yes all',  //mr_yesall
  'Tidak Semua',    //mr_noall
  'Abaikan',     //mr_ignore
  'Skip',    //mr_skip
  'Skip all', //mr_skipall
  'Continue'  //mr_continue
  );

id_settingstext: isettingsaty = (
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
    
 id_actionsmoduletext: actionsmoduleaty = (
      'Configure MSEide',
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

id_projectoptionstext: projectoptionsaty = (
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

 id_stockcaption: stockcaptionaty = (
  '',                      //sc_none
  'adalah salah',          //sc_is_invalid
  'Format salah',          //sc_Format_error
  'Nilai dibutuhkan',      //sc_Value_is_required
  'Salah',                 //sc_Error
  'Min',                   //sc_Min
  'Max',                   //sc_Max
  'Range salah',           //sc_Range_error
  '&Batal',                //sc_Undohk       ///
  '&Redo',                 //sc_Redohk        //          //
  '&Salin',                //sc_Copyhk        // hotkeys
  'Po&tong',               //sc_Cuthk         //
  '&Tempel',               //sc_Pastehk       //
  '&Select all',           //sc_Select_allhk ///         //
  '&Sisipkan Baris',       //sc_insert_rowhk
  '&Tambah Baris',         //sc_append_rowhk
  '&Hapus Baris',          //sc_delete_rowhk
  '&Direktori',            //sc_Dirhk               ///
  '&Home',                 //sc_homehk               //
  '&Naik',                 //sc_Uphk                 //
  'Dir &Baru',             //sc_New_dirhk            // hotkeys
  '&Nama File',            //sc_Namehk               //
  '&File tersembunyi',     //sc_Show_hidden_fileshk  //
  '&Filter',               //sc_Filterhk            ///
  'Simpan',                //sc_save
  'Buka',                  //sc_open
  'Nama',                  //sc_name
  'Buat Direktori Baru',   //sc_create_new_directory
  'Back',                  //sc_back
  'Forward',               //sc_forward
  'Up',                    //sc_up
  'File',                  //sc_file
  'sudah ada, akan ditimpa?', //sc_exists_overwrite
  'is modified. Save?',  //sc_is_modified_save
  'PERINGATAN',            //sc_warningupper
  'SALAH',                 //sc_errorupper
  'Exception',             //sc_exception
  'System',                //sc_system
  'tidak ada',             //sc_does_not_exist
  'PASSWORD',              //sc_passwordupper
  'Enter password',        //sc_enterpassword
  'Invalid password!',     //sc_invalidpassword
  'tidak dapat membaca direktori', //sc_can_not_read_directory
  'Format grafik tidak didukung', //sc_graphic_not_supported
  'Format grafik salah',  //sc_graphic_format_error
  'MS Bitmap',            //sc_MS_Bitmap
  'MS Icon',              //sc_MS_Icon
  'JPEG Image',           //sc_JPEG_Image
  'PNG Image',            //sc_PNG_Image
  'XPM Image',            //sc_XPM_Image
  'PNM Image',            //sc_PNM_Image
  'TARGA Image',          //sc_TARGA_image
  'TIFF Image',           //sc_TIFF_image
  'Semua',                //sc_All
  'Konfirmasi',           //sc_Confirmation
  'Hapus Rekaman?',       //sc_Delete_record_question
  'Salin record?',         //sc_Copy_record_question
  'Tutup',                //sc_close_page
  'Awal',                 //sc_first
  'Sebelum',              //sc_prior
  'Sesudah',              //sc_next
  'Akhir',                //sc_last
  'Tambah',               //sc_append
  'Hapus',                //sc_delete
  'Rubah',                //sc_edit
  'Simpan',               //sc_post
  'Batal',                //sc_cancel
  'Refresh',              //sc_refresh
  'Rubah filter',         //sc_filter_filter
  'Rubah filter minimum', //sc_edit_filter_min
  'Rubah filter maximum', //sc_filter_edit_max
  'Reset filter',       //sc_reset_filter
  'Filter hidup',         //sc_filter_on
  'Cari',                 //sc_search
  'Rubah Otomatis',          //sc_autoedit
  'Salin record',          //sc_copy_record
  'Dialog',             //sc_dialog
  'Sisipkan',             //sc_insert
  'Salin',                 //sc_copy
  'Paste',              //sc_paste
  'Row insert',         //sc_row_insert
  'Row append',         //sc_row_append
  'Row delete',         //sc_row_delete
  'Undo',               //sc_undo
  'Redo',               //sc_redo
  'Cut',                //sc_cut
  'Select all',         //sc_select_all
  'Filter mati',          //sc_filter_off
  'Berdiri',              //sc_portrait print orientation
  'Rebah',                //sc_landscape print orientation
  'Hapus baris?',          //sc_Delete_row_question
  'baris yang terpilih?',        //sc_selected_rows
  'Hanya satu item',     //sc_Single_item_only,
  'Salin Cell',          //sc_Copy_Cells
  'Tempel Cell',         //sc_Paste_Cells
  'Tutup',               //sc_close
  'Maximize',            //sc_maximize
  'Normalize',           //sc_normalize
  'Minimize',            //sc_minimize
  'Fix size',            //sc_fix_size
  'Float',               //sc_float
  'Stay on top',         //sc_stay_on_top
  'Stay in background',  //sc_stay_in_background
  'Lock children',       //sc_lock_children
  'No lock',             //sc_no_lock
  'Input',               //sc_input
  'Button',              //sc_button
  'On',                  //sc_on
  'Off',                 //sc_off
  'Left border',         //sc_leftborder
  'Top border',          //sc_topborder
  'Right border',        //sc_rightborder
  'Bottom border',       //sc_bottomborder
  'Begin of text',       //sc_beginoftext
  'End of text',         //sc_endoftext
  'Inputmode',           //sc_inputmode
  'Overwrite',           //sc_overwrite
  'Deleted',             //sc_deleted
  'Copied',              //sc_copied
  'Inserted',            //sc_inserted
  'Pasted',              //sc_pasted
  'Withdrawn',           //sc_withdrawn
  'Window activated',    //sc_windowactivated
  'Menu',                //sc_menu
  'Beginning of file',   //sc_bof
  'End of file',         //sc_eof
  'Voice output',        //sc_voiceoutput
  'Speak again',         //sc_speakagain
  'First column',        //sc_firstcol
  'First row',           //sc_firstrow
  'Last column',         //sc_lastcol
  'Last row',            //sc_lastrow
  'Selection',           //sc_selection
  'Speak path',          //sc_speakpath
  'Disabled button',     //sc_disabledbutton
  'First field',         //sc_firstfield
  'Last field',          //sc_lastfield
  'First element',       //sc_firstelement
  'Last element',        //sc_lastelement
  'Slower',              //sc_slower
  'Faster',              //sc_faster
  'Window',              //sc_window
  'Area',                //sc_area
  'Area activated',      //sc_areaactivated
  'Volume down',         //sc_volumedown
  'Volume up',           //sc_volumeup
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
   result:= 'Delete selected row?'
  end
  else begin
   result:= 'Delete '+inttostrmse(vinteger)+' selected rows?';
  end;
 end;
end;

const
 id_textgenerator: defaultgeneratortextty = (
              {$ifdef FPC}@{$endif}delete_n_selected_rows //tg_delete_n_selected_rows
                                     );
initialization
 registerlangconsts(langnames[la_id],@id_actionsmoduletext, @id_settingstext, @id_projectoptionstext, @id_stockcaption,@id_modalresulttext,
                               @id_modalresulttextnoshortcut,@id_textgenerator);
end.
