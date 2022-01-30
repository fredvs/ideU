
{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}

// Updated for dynamic loading of po files by fredvs

unit captionideu;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface

uses
  msestockobjects,
  mseglob,
  msestrings,
  mseapplication,
  msetypes;

type
  mainformty = (
    ma_unresreferences,        //0 Unresolved references in
    ma_str_to,                 //1 to
    ma_wishsearch,             //2 Do you wish to search the formfile?
    ma_formfile,               //4 Formfile for
    ma_formfiles,              //5 Formfiles
    ma_recursive,              //6 Recursive form hierarchy for "
    ma_str_classtype,          //8 Classtype
    // ma_notfound,               //9 not found.
    // ma_project,                //10 Project
    // ma_ismodified,             //11 is modified. Save?
    // ma_confirmation,           //12 Confirmation
    ma_unableopen,             //13 Unable to open file "
    ma_running,                //14 *** Running ***
    ma_str_downloading,        //15 Downloading
    ma_str_downloaded,         //16 Downloaded
    ma_startgdbservercommand,  //17 Start gdb server command "
    // ma_running2,               //18 " running.
    ma_startgdbserver,         //19 Start gdb Server
    ma_gdbserverstarterror,    //20 gdb server start error
    ma_gdbservercanceled,      //21 gdb server start canceled.
    ma_cannotrunstartgdb,      //22 Can not run start gdb command.
    ma_str_uploadcommand,      //23 Uploadcommand "
    ma_downloaderror,          //24 Download ***ERROR***
    ma_downloadfinished,       //25 Download finished.
    ma_downloadcanceled,       //26 Download canceled.
    //ma_str_file,               //27 File "
    //ma_notfound2,              //28 " not found.
    //ma_exists,                 //29 " exists.
    //ma_str_new,                //30 New
    ma_selectancestor,         //31 Select ancestor
    ma_newform,                //32 New form
    ma_pascalfiles,            //33 Pascal Files
    //ma_new2,                   //34 new
    ma_cannotloadproj,         //35 Can not load Project "
    ma_selecttemplate,         //36 Select project template
    ma_projectfiles,           //37 Project files
    ma_str_allfiles,           //38 All files
    ma_selectprogramfile,      //39 Select program file
    ma_pascalprogfiles,        //40 Pascal program files
    ma_cfiles,                 //41 C program files
    ma_str_newproject,         //42 New Project
    ma_cannotstartprocess,     //43 Can not start process
    ma_process,                //44 Process
    //ma_running3,               //45 running.
    ma_processterminated,      //46 Process terminated.
    ma_proctermnormally,       //47 Process terminated normally.
    ma_makeerror,              //48 Make ***ERROR***
    ma_makeok,                 //49 Make OK.
    ma_str_sourcechanged,      //50 Source has changed, do you wish to remake project?
    ma_str_loadwindowlayout,   //51 Load Window Layout
    ma_dockingarea             //52 Docking Area
    );

type
  sourceformty = (
    //sf_str_file,           //0 File "
    sf_haschanged,         //1 " has changed.
    sf_therearemody,       //2 There are modifications in edit buffer also.
    sf_wishreload,         //3 Do you wish to reload from disk?
    //sf_confirmation,       //4 Confirmation
    sf_none,               //5 <none>
    sf_wishreplace,        //6 Do you wish to replace:
    sf_str_with,           //7 with:
    sf_str_new,            //8 <new>
    sf_syntaxdeffile,      //9 Syntaxdeffile:
    sf_str_text,           //10 Text
    //sf_str_notfound,       //11 not found.
    sf_restartbegin,       //12 Restart from begin of file?
    sf_cancel,             //13 Cancel?
    sf_replaceoccu,        //14 Do you wish to to replace this occurence?
    sf_gotoline,           //15 Go to line number:
    sf_findline           //16 Find line
    //sf_modieditalso       //17 There are modifications in edit buffer also.

    );

type
  projectoptionsconty = (
    c_wrongencoding,    //0 Wrong encoding can damage your source files.
    c_wishsetencoding,  //1 Do you wish to set encoding to
    c_warning,          //2 *** WARNING ***
    c_SIGHUP,           //3 Hangup
    c_SIGINT,           //4 Interrupt
    c_SIGQUIT,          //5 Quit
    c_SIGILL,           //6 Illegal instruction
    c_SIGTRAP,          //7 Trace trap
    c_SIGABRT,          //8 Abort
    c_SIGBUS,           //9 BUS error
    c_SIGFPE,           //10 Floating-point exception
    c_SIGKILL,          //11 Kill
    c_SIGUSR1,          //12 User-defined signal 1
    c_SIGSEGV,          //13 Segmentation violation
    c_SIGUSR2,          //14 User-defined signal 2
    c_SIGPIPE,          //15 Broken pipe
    c_SIGALRM,          //16 Alarm clock
    c_SIGTERM,          //17 Termination
    c_SIGSTKFLT,        //18 Stack fault
    c_SIGCHLD,          //19 Child status has changed
    c_SIGCONT,          //20 Continue
    c_SIGSTOP,          //21 Stop, unblockable
    c_SIGTSTP,          //22 Keyboard stop
    c_SIGTTIN,          //23 Background read from tty
    c_SIGTTOU,          //24 Background write to tty
    c_SIGURG,           //25 Urgent condition on socket
    c_SIGXCPU,          //26 CPU limit exceeded
    c_SIGXFSZ,          //27 File size limit exceeded
    c_SIGTALRM,         //28 Virtual alarm clock
    c_SIGPROF,          //29 Profiling alarm clock
    c_SIGWINCH,         //30 Window size change
    c_SIGIO,            //31 I/O now possible
    c_SIGPWR            //32 Power failure restart
    );

type
  actionsmodulety = (
    ac_configureideu,      //0 Configure ideU
    ac_processid,          //1 Process ID
    ac_attachtoprocess,    //2 Attach to process
    ac_unknownmodclass,    //3 Unknown moduleclass for "
    ac_inheritedcomp,      //4 Inherited component "
    ac_cannotdel,          //5 " can not be deleted.
    ac_makeaborted,        //7 Make aborted.
    ac_downloadaborted,    //8 Download aborted.
    ac_runerrorwith,       //9 Runerror with "
    ac_errortimeout,       //10 Error: Timeout.
    ac_making,             //11 Making.
    ac_makenotrunning,     //12 Make not running.
    ac_downloading,        //13 Downloading.
    ac_downloadnotrunning, //14 Download not running.
    ac_running,            //15 " running.
    ac_script,             //16 Script
    ac_recursiveforminheritance, //17 Recursive form inheritance of "
    ac_component,          //18 Component "
    ac_exists,             //19 " exists.
    ac_ancestorfor,        //20 Ancestor for "
    ac_notfound,           //21 " not found.
    ac_module,             //22 Module "
    ac_invalidname,        //23 Invalid name "
    ac_invalidmethodname,  //24 Invalid methodname
    ac_modulenotfound,     //25 Module not found
    ac_methodnotfound,     //26 Method not found
    ac_publishedmeth,      //27 Published (managed) method
    ac_doesnotexist,       //28 does not exist.
    ac_wishdelete,         //29 Do you wish to delete the event?
    //ac_warning,            //30 WARNING
    ac_method,             //31 Method
    ac_differentparams,    //32 has different parameters.
    ac_amodule,            //33 A module "
    ac_isopen,             //34 " is already open.
    ac_unresolvedref,      //35 Unresolved reference(s) to
    ac_modules,            //36 Module(s):
    ac_cannotreadform,     //37 Can not read formfile "
    ac_invalidcompname,    //38 Invalid component name.
    ac_invalidexception,   //39 Invalid exception
    ac_tools,              //40 T&ools
    //ac_forms,              //41 Forms
    //ac_source,             //42 Source
    ac_allfiles,           //43 All Files
    ac_program,            //44 Program
    ac_unit,               //45 Unit
    ac_textfile,           //46 Textfile
    ac_mainform,           //47 Mainform
    ac_simpleform,         //48 Simple Form
    ac_dockingform,        //49 Docking Form
    ac_datamodule,         //50 Datamodule
    ac_subform,            //51 Subform
    ac_scrollboxform,      //52 Scrollboxform
    ac_tabform,            //53 Tabform
    ac_dockpanel,          //54 Dockpanel
    ac_report,             //55 Report
    ac_scriptform,         //56 Scriptform
    ac_inheritedform,      //57 Inherited Form
    ac_replacesettings,    //58 Do you want to replace the settings by
    ac_wantoverwrite,      //60 Do you want to overwrite?
    ac_sr_unknown,         //61 Unknown
    ac_sr_startup,         //63 Startup
    //ac_sr_exception         //64 Exception
    ac_sr_gdbdied,         //65 GDB died
    ac_sr_breakpoint_hit,           //66 Breakpoint hit
    ac_sr_watchpointtrigger,        //67 Watchpoint triggered
    ac_sr_readwatchpointtrigger,    //68 Read Watchpoint triggered
    ac_sr_accesswatchpointtrigger,  //69 Access Watchpoint triggered
    ac_sr_end_stepping_range,       //70 End stepping range
    ac_sr_function_finished,        //71 Function finished
    ac_sr_exited_normally,          //72 Exited normally
    ac_sr_exited,                   //73 Exited
    ac_sr_detached,                 //74 Detached
    ac_sr_signal_received,          //75 Signal received
    ac_stoperror,                   //76 Stop error
    ac_cannotreadproject,           //77 Can not read project
    //ac_about,                       //78 About
    ac_objectinspector,             //79 Object Inspector
    ac_storecomponent,              //80 Store Component
    ac_attachingprocess,            //81 Attaching Process
    ac_loading                      //82 Loading
    );

type
  isettingsty = (se_apply, se_groupassistive, se_sakitdir, se_enableassistive, se_groupsystemlayout,
    se_universalpath, se_nozorder, se_doubleclic, se_autofocusmenu, se_fullpath, se_modaldial,
    se_fontsize, se_fontname, se_confirmdel, se_blinkcaret, se_repaintcanvas,
    se_groupsourceeditor, se_usedefaulteditoroptions, se_addwhiteaftercomma,
    se_groupfilechange, se_filereload, se_filenoload, se_fileaskload, se_rectanglearea

    );

type
  projectoptionsty = (po_projectoptions, po_editor, po_rightmarginline,
    po_markbrackets, po_linenumbers, po_markpairwords, po_trimtrailing,
    po_autoindent, po_nosource, po_tabindent, po_spacetab, po_showtabs,
    po_antialiasedfont, po_encoding, po_markcolor, po_statcolor, po_scrollbary,
    po_nbchar, po_eolstyle, po_backup, po_tabstops,
    // po_indent, 
    po_extraspace, po_extraspacehint, po_width, po_height, po_font, po_fontbkcolor,
    po_fontcolor, po_filefilter,
    // po_name,
    po_filemask, po_syntaxdeffile,
    po_codetemplate, po_fontcodetemplatedir, po_selectunitdir,
    po_debuggerpage, po_projectdebugger, po_searchdirectories,
    po_searchdirectorieshint, po_selectsourcedir, po_objectbasedir,
    po_selectsourcebasedir, po_defines, po_signals, po_exception, po_target,
    po_startgdbattachtarget, po_nogdbserverexit, po_beforeconnect,
    po_beforeload, po_beforerun, po_afterconnect, po_afterload, po_gdbservercommand,
    po_gdbserverwait, po_gdbserverstartonce, po_uploadcommand, po_gdbprocessor,
    po_gdbsimulator, po_gdbdownload, po_startupbkpt, po_remoteconnection,
    po_downloadalways, po_downloadalwayshint, po_gdbloadtimeout, po_externalconsole,
    po_stoponexception, po_stoponexceptionhint, po_activateonbreak, po_activateonbreakhint,
    po_valuehints, po_nodebugbeginend, po_nodebugbeginendhint, po_settty,
    po_raiseonbreak, po_raiseonbreakhint, po_fpcgdbworkaround, po_fpcgdbworkaroundhint,
    po_debugtarget, po_xtermcommand, po_runcommand, po_debugcommand,
    po_debugoptions, po_makepage, po_defaultmake, po_mainfile, po_selectmainfile,
    po_targetfile, po_selecttargetfile, po_makecommand, po_selectmakecommand,
    po_showcommandline, po_copymessages, po_closemessages, po_checkmethods,
    po_checkmethodshint, po_projectcompiler, po_commandbefore, po_makeoptions,
    po_directories,
    // po_unitdirs,
    po_commandafter, po_exeextension,
    po_comments, po_makedir, po_selectmakedir, po_colorerror, po_colorwarning,
    po_colornote, po_stripmessageesc, po_stripmessageeschint,
    po_showconsole, po_enablepurpose, po_messageoutputfile,
    // po_selectmessageoutputfile,
    po_macros, po_selectactivegroupgrid, po_fontaliaspage, po_designers,
    po_usercolors, po_copycolor, po_formatmacro, po_formatmacrohint,
    po_templates, po_newproject, po_scriptbeforecopy, po_scriptaftercopy,
    po_newfile, po_newform,
    // po_tools,
    po_storage, po_infos, po_projectfullname,
    po_creator, po_license, po_projectdate

    );

{
type
  stockcaptionty = (sc_none, sc_is_invalid, sc_Format_error, sc_Value_is_required,
    sc_Error, sc_Min, sc_Max, sc_Range_error,
    sc_Undohk, sc_Redohk, sc_copyhk, sc_cuthk, sc_pastehk,
    sc_select_allhk,
    sc_insert_rowhk, sc_append_rowhk, sc_delete_rowhk,
    sc_Dirhk, sc_Homehk, sc_Uphk, sc_New_dirhk, sc_Namehk,
    sc_Show_hidden_fileshk, sc_Filterhk,
    sc_Save, sc_Open,
    sc_name, sc_create_new_directory,
    sc_back, sc_forward, sc_up,
    // sc_file, 
    sc_exists_overwrite, sc_is_modified_save,
    sc_warningupper, sc_exception, sc_system,
    sc_does_not_exist,
    sc_passwordupper, sc_enterpassword, sc_invalidpassword,
    sc_can_not_read_directory,
    sc_graphic_format_not_supported, sc_graphic_format_error,
    sc_MS_Bitmap, sc_MS_Icon, sc_JPEG_Image, sc_PNG_Image,
    sc_XPM_Image, sc_PNM_Image, sc_TARGA_image, sc_TIFF_image,
    sc_All,
    sc_Confirmation, sc_Delete_record_question,
    sc_Copy_record_question,
    sc_close_page,
    sc_first, sc_prior, sc_next, sc_last,
    sc_append, sc_delete, sc_edit, sc_post,
    sc_cancel,
    sc_refresh,
    sc_edit_filter, sc_edit_filter_min, sc_edit_filter_max,
    sc_reset_filter,
    sc_filter_on, sc_search, sc_auto_edit, sc_copy_record,
    sc_dialog,
    sc_insert, sc_copy, sc_paste,
    sc_row_insert, sc_row_append, sc_row_delete,
    sc_undo, sc_redo, sc_cut, sc_select_all,
    sc_filter_off,
    sc_portrait, sc_landscape,
    sc_Delete_row_question, sc_selected_rows,
    sc_Single_item_only, sc_Copy_Cells, sc_Paste_Cells,
    sc_close, sc_maximize, sc_normalize, sc_minimize, sc_fix_size,
    sc_float, sc_stay_on_top, sc_stay_in_background,
    sc_lock_children, sc_no_lock,
    sc_input, sc_button, sc_on, sc_off,
    sc_leftborder, sc_topborder, sc_rightborder, sc_bottomborder,
    sc_beginoftext, sc_endoftext, sc_inputmode, sc_overwrite,
    sc_deleted, sc_copied, sc_inserted, sc_pasted, sc_withdrawn,
    sc_windowactivated, sc_menu,
    sc_bof, sc_eof,
    sc_voiceoutput, sc_speakagain,
    sc_firstcol, sc_firstrow, sc_lastcol, sc_lastrow,
    sc_selection, sc_speakpath, sc_disabledbutton,
    sc_firstfield, sc_lastfield,
    sc_firstelement, sc_lastelement, sc_slower, sc_faster,
    sc_window, sc_area, sc_areaactivated,
    sc_volumedown, sc_volumeup, sc_cancelspeech, 
}

{ this are the ext from dynpo
sc_newfile, sc_tools, sc_lang,
    sc_directory, sc_noicons, sc_nolateral, sc_compact,
    sc_path, sc_file
}

type
  xstockcaptionty = (
    sc_target, sc_view, sc_forms, sc_layout, sc_syntax, sc_project,
    sc_edited, sc_widgets, sc_settings, sc_about, 
    sc_saveas, sc_saveall, sc_closeall, sc_print, sc_quit,
    sc_line, sc_search_again, sc_search_back, sc_find_replace,
    sc_find_infile, sc_proclist, sc_select_edit_Page,
    sc_Copy_word_cursor, sc_copy_latex, sc_indent, sc_unindent,
    sc_environment, sc_attachprocess, sc_attachtarget, sc_detachtarget,
    sc_download, sc_make, sc_build, sc_abortmake, sc_debugrun, sc_options,
    sc_tree, sc_source, sc_opencopy, sc_saveascopy, sc_beautifier,
    sc_panels, sc_forcezorder, sc_treelist, sc_messages,
    sc_findresult, sc_commander, sc_symbols, sc_watches, sc_stack,
    sc_threads, sc_cpu, sc_assembler, sc_breakpoints, sc_watchpoints,
    sc_memory, sc_targetconsole, sc_toggleformunit, sc_msemod, sc_closeallmsemod,
    sc_generalsettings, sc_extrasettings,  sc_configwidgets, sc_configcompilers,
    sc_configdebuggers, sc_themes,  sc_openproject, sc_openfile, sc_other, sc_printcommand,
    sc_shortcut, sc_value,
    sc_casesensitive, sc_selectedonly, sc_wholeword, sc_texttofind, sc_searchincurrentfile,
    sc_searchinopenfiles, sc_searchinprojectdir, sc_searchindirectories,
    sc_includesubdir, sc_replace, sc_replaceall, sc_replacewith, sc_promptonreplace,
    sc_componentspalette, sc_findcomponent, sc_reset, sc_cstep, sc_stepinstruction,
    sc_nextinstruction, sc_restartdebugger, sc_togglebreakpoint, sc_tooglebreakpointenable,
    sc_execlinehinton, sc_compileitfirst, sc_finish, sc_setasdefault, sc_host, sc_copyright
    );
    
type
  mainformaty  = array[mainformty] of msestring;
  
  sourceformaty  = array[sourceformty] of msestring;
  
  actionsmoduleaty  = array[actionsmodulety] of msestring;
 
  projectoptionsconaty  = array[projectoptionsconty] of msestring;
 
  projectoptionsaty  = array[projectoptionsty] of msestring;
  
  isettingsaty  = array[isettingsty] of msestring;
   
  xstockcaptionaty = array[xstockcaptionty] of msestring;
 
var
   lang_xstockcaption, lang_mainform, lang_settings, lang_actionsmodule, lang_projectoptionscon,
     lang_projectoptions, lang_sourceform, lang_langnames: array of msestring;  

const
  en_mainformtext: mainformaty           = (
    'Unresolved references in',
    'to',
    'Do you wish to search the formfile?',
    'Formfile for',
    'Formfiles',
    'Recursive form hierarchy for',
    'Classtype',
    'Unable to open file',
    '*** Running ***',
    'Downloading',
    'Downloaded',
    'Start gdb server command',
    'Start gdb Server',
    'gdb server start error',
    'gdb server start canceled.',
    'Can not run start gdb command.',
    'Uploadcommand',
    'Download ***ERROR***',
    'Download finished.',
    'Download canceled.',
    'Select ancestor',
    'New form',
    'Pascal Files',
    'Can not load Project',
    'Select project template',
    'Project files',
    'All files',
    'Select program file',
    'Pascal program files',
    'C program files',
    'New Project',
    'Can not start process',
    'Process',
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
    'Unknown moduleclass for',
    'Inherited component',
    'can not be deleted.',
    'Make aborted.',
    'Download aborted.',
    'Runerror with',
    'Error: Timeout.',
    'Making.',
    'Make not running.',
    'Downloading.',
    'Download not running.',
    'running.',
    'Script',
    'Recursive form inheritance of',
    'Component',
    'exists.',
    'Ancestor for',
    'not found.',
    'Module',
    'Invalid name',
    'Invalid methodname',
    'Module not found',
    'Method not found',
    'Published (managed) method',
    'does not exist.',
    'Do you wish to delete the event?',
    'Method',
    'has different parameters.',
    'A module',
    'is already open.',
    'Unresolved reference(s) to',
    'Module(s):',
    'Can not read formfile',
    'Invalid component name.',
    'Invalid exception',
    'T&ools',
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
    'Do you want to overwrite?',
    'Unknown',
    'Startup',
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
    'Leave',
    'Illegal instruction',
    'Trace trap',
    'Abort process',
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
    'Proceed',
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

  en_settingstext: isettingsaty          = (
    'Apply',                   //se_apply
    'sak voice assistive config', //se_groupassistive
    'Parent directory of sakit', //se_sakitdir
    'Enable sak assistive at loading', //se_enableassistive
    'System layout',           //se_groupsystemlayout
    'Universal path layout',   //se_universalpath
    'No Z order handling',     //se_nozorder
    'Use shift key to select a word', //se_doubleclic
    'Auto focus in main-menu', //se_autofocusmenu
    'Full path of project in window title', //se_fullpath
    'Set dialog-forms as modal vs as tool', //se_modaldial
    'Font height',             //se_fontsize
    'Font name',               //se_fontname
    'No confirmation to delete row', //se_confirmdel
    'Blinking caret',          //se_blinkcaret
    'Repaint canvas',          //se_repaintcanvas
    'Source Editor',           //se_groupsourceeditor
    'Use those options instead of project options', //se_usedefaulteditoroptions
    'Add space after comma -> auto-parsing', //se_addwhiteaftercomma
    'When a file has changed', //se_groupfilechange
    'No dialog box => reload the new one', //se_filereload
    'No dialog box => keep the old one', //se_filenoload
    'A dialog box ask what to do...', //se_fileaskload
    'Rectangle around multi-select' //se_rectanglearea
    );

  en_projectoptionstext: projectoptionsaty = (
    'Project options',                           // po_projectoptions
    'Editor',                                    // po_editor
    'Right margin line',                         // po_rightmarginline
    'Mark Brackets',                             //  po_markbrackets
    'Line Numbers',                              //  po_linenumbers
    'Mark Pairwords',                            //  po_markpairwords
    'Trim trailing whitespace',                  //  po_trimtrailing on save
    'Auto Indent',                               //  po_autoindent
    'No Source Editor',                          //  po_nosource
    'Tab indent',                                //  po_tabindent
    'Space tab',                                 //  po_spacetab
    'Show tabs',                                 //  po_showtabs
    'Anti aliased font',                         //  po_antialiasedfont
    'Encoding',                                  //  po_encoding
    'Mark Color',                                //  po_markcolor
    'Stat Color',                                // po_statcolor
    'Scr Y',                                     // po_scrollbary
    'Nb char',                                   // po_nbchar
    'EOL Style',                                 //  po_eolstyle
    'Backup',                                    //  po_backup
    'Tabstops',                                  //  po_tabstops
    'ExtS',                                      //  po_extraspace
    'Extra space between lines',                 //  po_extraspacehint
    'Width',                                     //  po_width
    'Height',                                    //  po_height
    'Font',                                      //  po_font
    'Font Bk. color',                            //  po_fontbkcolor
    'Font color',                                //  po_fontcolor
    'File filter',                               //  po_filefilter
    'File mask',                                 //  po_filemask
    'Syntax definition file',                    //  po_syntaxdeffile
    'Code Templates',                            //  po_codetemplate
    'Code template directories, file extension = .mct', //  po_fontcodetemplatedir
    'Select unit directory',                     // po_selectunitdir
    '&Debugger',                                 // po_debuggerpage
    'Project Debugger',                          // po_projectdebugger
    'Search &Directories',                       // po_searchdirectories
    'Search path to get infos about code',       // po_searchdirectorieshint
    'Select source directory',                   // po_selectsourcedir
    'Object &Base Directory (empty = Make Directory)', // po_objectbasedir
    'Select source base directory',              // po_selectsourcebasedir
    'Defi&nes',                                  // po_defines
    '&Signals',                                  // po_signals
    '&Exception',                                // po_exception
    '&Target',                                   // po_target
    'Start gdb server command attach target',    // po_startgdbattachtarget
    'No wait for exit',                          // po_nogdbserverexit
    'Before connect gdb script',                 // po_beforeconnect
    'Before load gdb script',                    // po_beforeload
    'Before run gdb script',                     // po_beforerun
    'After connect gdb script',                  // po_afterconnect
    'After load gdb script',                     // po_afterload
    'Start gdb server command run target',       // gdbservercommand
    'Wait before connect',                       // po_gdbserverwait
    'Start once',                                // po_gdbserverstartonce
    'Download command',                          // po_uploadcommand
    'Processor',                                 // po_gdbprocessor
    'Simulator',                                 // po_gdbsimulator
    'gdb download',                              // po_gdbdownload
    'Startup BKPT',                              // po_startupbkpt
    'Target connection',                         // po_remoteconnection
    'Always download',                           // po_downloadalways
    'Always download before run',                // po_downloadalwayshint
    'Load Timeout',                              // po_gdbloadtimeout
    '&Extern Console',                           // po_externalconsole
    '&Stop on Exc',                              // po_stoponexception
    'Stop on exceptions',                        // po_stoponexceptionhint
    '&Acti-Break',                               // po_activateonbreak
    'Activate on Break',                         // po_activateonbreakhint
    '&Value Hints',                              // po_valuehints
    'Call GUI_DEB',                              // po_nodebugbeginend
    'Release mouse grab by target stop. gdb sometimes crashes with this option.', // po_nodebugbeginendhint
    'Set TT&Y',                                  // po_settty
    '&Raise-Break',                              // po_raiseonbreak
    'Raise on break',                            // po_raiseonbreakhint
    '&FPC bugs',                                 // po_fpcgdbworkaround
    'Use workarounds for FPC/gdb bugs',          // po_fpcgdbworkaroundhint
    'Debug &target',                             // po_debugtarget
    'xterm command',                             // po_xtermcommand
    'Run command',                               // po_runcommand
    'Default Debugger',                          // po_debugcommand
    'Debug &options',                            // po_debugoptions
    '&Make',                                     // po_makepage
    'Default make col',                          // po_defaultmake
    'Mainfile',                                  // po_mainfile
    'Select mainfile',                           // po_selectmainfile
    'Targetfile name',                           // po_targetfile
    'Select target file',                        // po_selecttargetfile
    'Default Compiler',                          // po_makecommand
    'Select make command',                       // po_selectmakecommand
    'Show Command Line',                         // po_showcommandline
    'Copy messages to file',                     // po_copymessages
    'Close message',                             // po_closemessages
    'Check head',                                // po_checkmethods
    'Check method headers',                      // po_checkmethodshint
    'Project Compiler',                          // po_projectcompiler
    'Command before',                            // po_commandbefore
    'Make options',                              // po_makeoptions
    'Directories',                               // po_directories
    'Command after',                             // po_commandafter
    'Exe Extension',                             // po_exeextension
    'Comments',                                  // po_comments
    'Make Directory',                            // po_makedir
    'Select make directory',                     // po_selectmakedir
    'Error Color',                               // po_colorerror
    'Warning Color',                             // po_colorwarning
    'Note Color',                                // po_colornote
    'Strip ESC',                                 // po_stripmessageesc
    'Strip ESC sequences in Messages and Terminal form', // po_stripmessageeschint
    'Show Console',                              // po_showconsole
    'Purpose',                                   //po_enablepurpose
    'Message output file',                       // po_messageoutputfile
    'Macros',                                    // po_macros
    'Active group',                              // po_selectactivegroupgrid
    '&Font Alias',                               // po_fontaliaspage
    'Designers',                                 // po_designers
    'User &Colors',                              // po_usercolors
    'Copy "setcolormapvalue" code to clipboard', // po_copycolor
    'F&ormat Macros',                            // po_formatmacro
    'Used by formatfloatmse() and formatdatetimemse()', // po_formatmacrohint
    'Templates',                                 // po_templates
    'New project',                               // po_newproject
    'Script before copy',                        // po_scriptbeforecopy
    'Script after copy',                         // po_scriptaftercopy
    'New File',                                  // po_newfile
    'New Form',                                  // po_newform
    'Storage',                                   // po_storage
    'Infos',                                     // po_infos
    'Full name of project',                      // po_projectfullname
    'Creator',                                   // po_creator
    'License',                                   // po_license
    'Date of creation'                             // po_projectdate

    );

  en_sourceformtext: sourceformaty       = (
    'has changed.',
    'There are modifications in edit buffer also.',
    'Do you wish to reload from disk?',
    '<none>',
    'Do you wish to replace:',
    'with:',
    '<new>',
    'Syntaxdeffile:',
    'Text',
    'Restart from begin of file?',
    'Cancel?',
    'Do you wish to to replace this occurence?',
    'Go to line number:',
    'Find line'
    );
    
  en_xstockcaption: xstockcaptionaty       = (
    'Target',                                  //sc_target
    'View',                                    //sc_view
    'Forms',                                   //sc_forms
    'Layout',                                  //sc_layout
    'Syntax',                                  //sc_syntax
    'Project',                                 //sc_project
    'Edited',                                  //sc_edited
    'Widgets',                                 //sc_widgets
    'Settings',                                //sc_settings
    'About',                                   //sc_about
    'Save as...',                              //sc_saveas
    'Save all',                                //sc_saveall
    'Close all',                               //sc_closeall
    'Print',                                   //sc_print
    'Quit',                                    //sc_quit
    'Line',                                    //sc_line
    'Search again',                            //sc_search_again
    'Search back',                             //sc_search_back
    'Find & replace',                          //sc_find_replace
    'Find in files',                           //sc_find_infile
    'Procedures list',                         //sc_proclist
    'Select edit page',                        //sc_select_edit_Page
    'Copy word at cursor',                     //sc_Copy_word_cursor
    'Copy LaTeX',                              //sc_copy_latex
    'Indent',                                  //sc_ident
    'Unindent',                                //sc_uident
    'Environment',                             //sc_environment
    'Attach process',                          //sc_attachprocess
    'Attach target',                           //sc_attachtarget
    'Detach target',                           //sc_detachtarget
    'Download',                                //sc_download
    'Make',                                    // sc_make
    'Build',                                   // sc_build
    'Abort make',                              // sc_abortmake
    'Debug-Run',                               // sc_debugrun
    'Options',                                 // sc_options
    'Tree',                                    // sc_tree
    'Source',                                  // sc_source
    'Open copy',                               // sc_opencopy
    'Save copy as',                            // sc_saveascopy
    'Beautifier',                              // sc_beautifier
    'Panels',                                  // sc_panels
    'Force Z order',                           // sc_forcezorder
    'Tree list',                               // sc_treelist
    'Messages',                                // sc_messages
    'Find result',                             // sc_findresult
    'Commander',                               // sc_commander
    'Symbols',                                 // sc_symbols
    'Watches',                                 // sc_watches
    'Stack',                                   // sc_stack
    'Threads',                                 // sc_threads
    'CPU',                                     // sc_cpu
    'Assembler',                               // sc_assembler
    'Breakpoints',                             // sc_breakpoints
    'Watchpoints',                             // sc_watchpoints
    'Memory',                                  // sc_memory
    'Target console',                          // sc_targetconsole
    'Toggle form/unit',                        // sc_toggleformunit
    'MSE modules',                             // sc_msemod
    'Close all MSE modules',                   // sc_closeallmsemod
    'General settings',                        // sc_generalsettings
    'Extra settings',                          // sc_extrasettings
    'Configure widgets',                       // sc_configwidgets
    'Configure compilers',                     // sc_configcompilers
    'Configure debuggers',                     // sc_configdebuggers
    'Themes',                                  // sc_themes
    'Open project',                            // sc_openproject
    'Open file',                               // sc_openfile
    'Other',                                   // sc_other
    'Print command',                           // sc_printcommand
    'Shortcut',                                // sc_shortcut
    'Value',                                   // sc_value
    'Case sensitive',                          // sc_casesensitive
    'Selected only',                           // sc_selectedonly
    'Whole word',                              // sc_wholeword
    'Text to find',                            // sc_texttofind
    'Search in current file',                  // sc_searchincurrentfile
    'Search in open files',                    // sc_searchininopenfiles
    'Search in project directory',             // sc_searchinprojectdir
    'Search in directories',                   // sc_searchindirectories
    'Include subdirectories',                  // sc_includesubdir
    'Replace',                                 // sc_replace
    'Replace all',                             // sc_replace all
    'Replace with',                            // sc_replacewith
    'Prompt on replace',                       // sc_promptonreplace
    'Components palette',                      // sc_componentspalette
    'Find components',                         // sc_findcomponent
    'Reset',                                   // sc_reset
    'Step',                                    // sc_cstep
    'Step instruction',                        // sc_stepinstruction
    'Next instruction',                        // sc_nextinstruction
    'Restart debugger',                        // sc_restartdebugger
    'Toggle breakpoint',                       // sc_togglebreakpoint
    'Toggle breakpoint enabled',               // sc_tooglebreakpointenable
    'Executed lines hint on/off',              // sc_execlinehinton
    'Please compile it first.',                // sc_compileitfirst
    'Finish',                                  // sc_finish
    'Set as default',                          // sc_setasdefault
    'Host',                                    // sc_host
    'Copyright'                                // sc_copyright
    );

   en_langnamestext: array[0..14] of msestring = (
    'English [en]',
    'Russian [ru]',
    'French [fr]',
    'German [de]',
    'Spanish [es]',
    'Portuguese [pt]',
    'Chinese [zh]',
    'Italian [it]',
    'Dutch [nl]',
    'Hebrew [he]',
    'Indonesian [id]',
    'Polish [pl]',
    'Esperanto [eo]',
    'Greek [el]',
    'Arabic [ar]'
    );

implementation

uses
  SysUtils,
  msesysintf,
  msearrayutils,
  mseformatstr;

initialization

end.

