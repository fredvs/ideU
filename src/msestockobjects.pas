
{ MSEgui Copyright (c) 1999-2018 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
unit msestockobjects;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
  msetypes,
  msegraphics,
  mseglob,
  msegui,
  msebitmap,
  msegraphutils,
  mseclasses,
  msestrings,
  msedatamodules,
  mseguiglob;

const
  boxsize      = 11;      //for treelistitem expand box
  checkboxsize = 13;      //for listitem checkbox
  
type
 mainformty = (
    ma_unresreferences,        //0 Unresolved references in
    ma_str_to,                 //1 to
    ma_wishsearch,             //2 Do you wish to search the formfile?
    ma_warning,                //3 WARNING
    ma_formfile,               //4 Formfile for
    ma_formfiles,              //5 Formfiles
    ma_recursive,              //6 Recursive form hierarchy for "
    ma_error,                  //7 ERROR
    ma_str_classtype,          //8 Classtype
    ma_notfound,               //9 not found.
    ma_project,                //10 Project
    ma_ismodified,             //11 is modified. Save?
    ma_confirmation,           //12 Confirmation
    ma_unableopen,             //13 Unable to open file "
    ma_running,                //14 *** Running ***
    ma_str_downloading,        //15 Downloading
    ma_str_downloaded,         //16 Downloaded
    ma_startgdbservercommand,  //17 Start gdb server command "
    ma_running2,               //18 " running.
    ma_startgdbserver,         //19 Start gdb Server
    ma_gdbserverstarterror,    //20 gdb server start error
    ma_gdbservercanceled,      //21 gdb server start canceled.
    ma_cannotrunstartgdb,      //22 Can not run start gdb command.
    ma_str_uploadcommand,      //23 Uploadcommand "
    ma_downloaderror,          //24 Download ***ERROR***
    ma_downloadfinished,       //25 Download finished.
    ma_downloadcanceled,       //26 Download canceled.
    ma_str_file,               //27 File "
    ma_notfound2,              //28 " not found.
    ma_exists,                 //29 " exists.
    ma_str_new,                //30 New
    ma_selectancestor,         //31 Select ancestor
    ma_newform,                //32 New form
    ma_pascalfiles,            //33 Pascal Files
    ma_new2,                   //34 new
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
    ma_running3,               //45 running.
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
    sf_str_file,           //0 File "
    sf_haschanged,         //1 " has changed.
    sf_therearemody,       //2 There are modifications in edit buffer also.
    sf_wishreload,         //3 Do you wish to reload from disk?
    sf_confirmation,       //4 Confirmation
    sf_none,               //5 <none>
    sf_wishreplace,        //6 Do you wish to replace:
    sf_str_with,           //7 with:
    sf_str_new,            //8 <new>
    sf_syntaxdeffile,      //9 Syntaxdeffile:
    sf_str_text,           //10 Text
    sf_str_notfound,       //11 not found.
    sf_restartbegin,       //12 Restart from begin of file?
    sf_cancel,             //13 Cancel?
    sf_replaceoccu,        //14 Do you wish to to replace this occurence?
    sf_gotoline,           //15 Go to line number:
    sf_findline,           //16 Find line
    sf_modieditalso       //17 There are modifications in edit buffer also.
  
    );


type

  stockbitmapty = (stb_default, stb_none,
    stb_dens0, stb_dens10, stb_dens25,
    stb_dens50, stb_dens75, stb_dens90, stb_dens100,
    stb_block2, stb_block3, stb_block4,
    stb_hatchup3, stb_hatchup4, stb_hatchup5,
    stb_hatchdown3, stb_hatchdown4, stb_hatchdown5,
    stb_crosshatch3, stb_crosshatch4, stb_crosshatch5, stb_crosshatch6
    );

const
  stb_block1 = stb_dens50;

type
  stockglyphty = (        //order fix!
    //  0         1               2
    stg_none, stg_checked, stg_checkedradio,
    //   3         4               5
    stg_box, stg_boxexpanded, stg_boxexpand,
    //   6             7              8            9
    stg_arrowright, stg_arrowup, stg_arrowleft, stg_arrowdown,
    //  10
    stg_ellipse,
    //        11               12                 13                14
    stg_arrowrightsmall, stg_arrowupsmall, stg_arrowleftsmall, stg_arrowdownsmall,
    //       15                16
    stg_arrowfirstsmall, stg_arrowlastsmall,
    //       17
    stg_ellipsesmall,
    //     18         19         20         21         22
    stg_dbfirst, stg_dbprior, stg_dbnext, stg_dblast, stg_dbinsert,
    //     23          24        25         26         27
    stg_dbdelete, stg_dbedit, stg_dbpost, stg_dbcancel, stg_dbrefresh,
    //     28            29              30            31          32
    stg_dbfilter, stg_dbfiltermin, stg_dbfiltermax, stg_dbfilteron, stg_dbfind,
    //     33              34              35            36
    stg_dbfilteroff, stg_dbindbrowse, stg_dbindedit, stg_dbindinsert,
    //  37        38           39                    40
    stg_dot, stg_dotsmall, stg_arrowtopsmall, stg_arrowbottomsmall,
    //    41               42                      43               44
    stg_checkbox, stg_checkboxchecked, stg_checkboxchildchecked, stg_checkboxradio,
    //    45             46          47
    stg_circlesmall, stg_circle, stg_circlebig,
    //    48             49          50
    stg_squaresmall, stg_square, stg_squarebig,
    //    51             52          53
    stg_diamondsmall, stg_diamond, stg_diamondbig,
    //    54             55          56
    stg_crosssmall, stg_cross, stg_crossbig,
    //    57             58          59
    stg_diagsmall, stg_diag, stg_diagbig,
    //    60             61          62
    stg_triasmall, stg_tria, stg_triabig,
    //    63             64          65
    stg_triatopsmall, stg_triatop, stg_triatopbig,
    // add by Alexandre Minoshi
    //    66             67          68      69               70
    stg_mmprev, stg_mmnext, stg_mmplay, stg_mmpause, stg_mmplayandpause,
    //    71
    stg_mmclear,
    //    72         73
    stg_sound, stg_soundoff,
    //    74             75           76        77         78          79
    stg_fullscreen, stg_settings, stg_save, stg_rename, stg_list, stg_listbold,
    //    80          81                82
    stg_doublesquare, stg_dbfilterclear, stg_checkboxparentnotchecked,
    //    83
    stg_checkboxchildnotchecked, stg_nil
    );

const
  firsttracesymbol = stg_circlesmall;
  lasttracesymbol  = stg_triatopbig;

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
    ac_error,              //6 ERROR
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
    ac_warning,            //30 WARNING
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
    ac_forms,              //41 Forms
    ac_source,             //42 Source
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
    ac_file,               //59 File "
    ac_wantoverwrite,      //60 Do you want to overwrite?
    ac_sr_unknown,         //61 Unknown
    ac_sr_error,           //62 Error
    ac_sr_startup,         //63 Startup
    ac_sr_exception,       //64 Exception
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
    ac_about,                       //78 About
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
    se_groupfilechange, se_filereload, se_filenoload, se_fileaskload

    );

type
  projectoptionsty = (po_projectoptions, po_editor, po_rightmarginline,
    po_markbrackets, po_linenumbers, po_markpairwords, po_trimtrailing,
    po_autoindent, po_nosource, po_tabindent, po_spacetab, po_showtabs,
    po_antialiasedfont, po_encoding, po_markcolor, po_statcolor, po_scrollbary,
    po_nbchar, po_eolstyle, po_backup, po_tabstops, po_indent, po_extraspace,
    po_extraspacehint, po_width, po_height, po_font, po_fontbkcolor,
    po_fontcolor, po_filefilter, po_name, po_filemask, po_syntaxdeffile,
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
    po_directories, po_unitdirs, po_commandafter, po_exeextension,
    po_comments, po_makedir, po_selectmakedir, po_colorerror, po_colorwarning,
    po_colornote, po_stripmessageesc, po_stripmessageeschint,
    po_showconsole, po_enablepurpose, po_messageoutputfile, po_selectmessageoutputfile,
    po_macros, po_selectactivegroupgrid, po_fontaliaspage, po_designers,
    po_usercolors, po_copycolor, po_formatmacro, po_formatmacrohint,
    po_templates, po_newproject, po_scriptbeforecopy, po_scriptaftercopy,
    po_newfile, po_newform, po_tools, po_storage, po_infos

    );

{
type
 dbnavigbuttonty = (dbnb_first,dbnb_prior,dbnb_next,dbnb_last,dbnb_insert,
           dbnb_delete,dbnb_edit,
           dbnb_post,dbnb_cancel,dbnb_refresh,
           dbnb_filter,dbnb_filtermin,dbnb_filtermax,dbnb_filteronoff,dbnb_find,
           dbnb_autoedit,dbnb_copyrecord,dbnb_dialog);
}

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
    sc_file, sc_exists_overwrite, sc_is_modified_save,
    sc_warningupper, sc_errorupper, sc_exception, sc_system,
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
    sc_append, sc_delete, sc_edit, sc_post, sc_cancel, sc_refresh,
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
    sc_volumedown, sc_volumeup, sc_cancelspeech, sc_target,
    sc_view, sc_forms, sc_layout, sc_syntax, sc_project,
    sc_edited, sc_widgets, sc_settings, sc_about, sc_newfile,
    sc_saveas, sc_saveall, sc_closeall, sc_print, sc_quit,
    sc_line, sc_search_again, sc_search_back, sc_find_replace,
    sc_find_infile, sc_proclist, sc_select_edit_Page,
    sc_Copy_word_cursor, sc_copy_latex, sc_indent, sc_unindent,
    sc_environment, sc_attachprocess, sc_attachtarget, sc_detachtarget,
    sc_download, sc_tools, sc_make, sc_build, sc_abortmake, sc_debugrun, sc_options,
    sc_tree, sc_source, sc_opencopy, sc_saveascopy, sc_beautifier,
    sc_panels, sc_forcezorder, sc_treelist, sc_messages,
    sc_findresult, sc_commander, sc_symbols, sc_watches, sc_stack,
    sc_threads, sc_cpu, sc_assembler, sc_breakpoints, sc_watchpoints,
    sc_memory, sc_targetconsole, sc_toggleformunit, sc_msemod, sc_closeallmsemod,
    sc_generalsettings, sc_extrasettings, sc_lang, sc_configwidgets, sc_configcompilers,
    sc_configdebuggers, sc_themes, sc_directory, sc_noicons, sc_nolateral, sc_compact,
    sc_openproject, sc_openfile, sc_path, sc_other, sc_printcommand, sc_shortcut, sc_value,
    sc_casesensitive, sc_selectedonly, sc_wholeword, sc_texttofind, sc_searchincurrentfile,
    sc_searchinopenfiles, sc_searchinprojectdir, sc_searchindirectories,
    sc_includesubdir,sc_replace,sc_replaceall,sc_replacewith,sc_promptonreplace,
    sc_componentspalette,sc_findcomponent,sc_reset,sc_cstep,sc_stepinstruction,
    sc_nextinstruction,sc_restartdebugger,sc_togglebreakpoint,sc_tooglebreakpointenable,
    sc_execlinehinton,sc_compileitfirst,sc_finish,sc_English,sc_Russian,sc_french,
    sc_german,sc_spanish,sc_setasdefault
  
    );

  textgeneratorfuncty = function(const params: array of const): msestring;
  textgeneratorty     = (tg_delete_n_selected_rows);

  tstockobjects = class
  private
    fbitmaps: array[stockbitmapty] of tbitmap;
    ffonts: array[stockfontty] of twidgetfont;
    //   fmodalresulttext: array[modalresultty] of msestring;
    //   fmodalresulttextnoshortcut: array[modalresultty] of msestring;
    fglyphs: timagelist;
    ffontaliasregistered: Boolean;
    function getbitmaps(index: stockbitmapty): tbitmap;
    function getfonts(index: stockfontty): twidgetfont;
    function getmodalresulttext(index: modalresultty): msestring;
    function getmodalresulttextnoshortcut(index: modalresultty): msestring;
    function getglyphs: timagelist;
    procedure fontchanged(const Sender: TObject);
    function getmseicon: tmaskedbitmap;
    function getcaptions(index: stockcaptionty): msestring;
    function gettextgenerator(index: textgeneratorty): textgeneratorfuncty;
    procedure setmseicon(const avalue: tmaskedbitmap);
  public
    constructor Create;
    destructor Destroy; override;
    procedure paintglyph(const Canvas: tcanvas; const glyph: stockglyphty; const rect: rectty; const grayed: Boolean = False; const color: colorty = cl_glyph; aalignment: alignmentsty = [al_ycentered, al_xcentered]);
    property bitmaps[index: stockbitmapty]: tbitmap read getbitmaps;
    property fonts[index: stockfontty]: twidgetfont read getfonts;
    property modalresulttext[index: modalresultty]: msestring read getmodalresulttext;
    property modalresulttextnoshortcut[index: modalresultty]: msestring read getmodalresulttextnoshortcut;
    property captions[index: stockcaptionty]: msestring read getcaptions;
    property textgenerators[index: textgeneratorty]: textgeneratorfuncty read gettextgenerator;
    property glyphs: timagelist read getglyphs;
    property mseicon: tmaskedbitmap read getmseicon write setmseicon;
  end;

type
  tstockdata = class(tmsedatamodule)
    glyphs: timagelist;
    mseicon: tbitmapcomp;
  end;

function stockobjects: tstockobjects;
function sc(const acaption: stockcaptionty): msestring;

procedure init;
procedure deinit;

implementation

uses
  SysUtils,
  msestockobjects_mfm,
  msesysintf1,
  mseguiintf,
  typinfo,
  mseconsts_ide,
  msefont;
 //const
 // defaultfontheight = 14;
 // defaultfontheight = 26;

type
  twidget1 = class(twidget);

var
  stockdata: tstockdata;
  stockobjs: tstockobjects;
// fontheight: integer;

const
 {$ifdef mswindows}
  b_none: array[0..0] of byte        = ($00);          //1*1
  b_0: array[0..0] of byte           = ($00);             //1*1
  b_10: array[0..3] of byte          = ($01, $00, $08, $00); //6*4
  b_25: array[0..1] of byte          = ($01, $04);         //4*2
  b_50: array[0..1] of byte          = ($01, $02);         //2*2
  b_75: array[0..1] of byte          = ($0e, $0b);         //4*2
  b_90: array[0..3] of byte          = ($3e, $3f, $37, $3f); //6*4
  b_100: array[0..0] of byte         = ($01);             //1*1
  b_block2: array[0..3] of byte      = ($03, $03, $0c, $0c); //4*4
  b_block3: array[0..5] of byte      = ($07, $07, $07, $38, $38, $38); //6*6
  b_block4: array[0..7] of byte      = ($0f, $0f, $0f, $0f, $f0, $f0, $f0, $f0); //8*8
  b_hatchup3: array[0..2] of byte    = ($04, $02, $01); //3*3
  b_hatchup4: array[0..3] of byte    = ($08, $04, $02, $01); //4*4
  b_hatchup5: array[0..4] of byte    = ($10, $08, $04, $02, $01); //5*5
  b_hatchdown3: array[0..2] of byte  = ($01, $02, $04); //3*3
  b_hatchdown4: array[0..3] of byte  = ($01, $02, $04, $08); //4*4
  b_hatchdown5: array[0..4] of byte  = ($01, $02, $04, $08, $10); //5*5
  b_crosshatch3: array[0..2] of byte = ($05, $02, $05); //3*3
  b_crosshatch4: array[0..3] of byte = ($08, $05, $02, $05); //4*4
  b_crosshatch5: array[0..4] of byte = ($11, $0a, $04, $0a, $11); //5*5
  b_crosshatch6: array[0..5] of byte = ($20, $11, $0a, $04, $0a, $11); //6*6

  //win98 can not use patternbrush < 8*8

  b_none_98: array[0..7] of byte        = ($00, $00, $00, $00, $00, $00, $00, $00);  //8*8
  b_0_98: array[0..7] of byte           = ($00, $00, $00, $00, $00, $00, $00, $00);     //8*8
  b_10_98: array[0..15] of byte         = ($41, $00, $00, $00, $08, $02, $00, $00,
    $41, $00, $00, $00, $08, $02, $00, $00); //12*8
  b_25_98: array[0..7] of byte          = ($11, $44, $11, $44, $11, $44, $11, $44);     //8*8
  b_50_98: array[0..7] of byte          = ($55, $aa, $55, $aa, $55, $aa, $55, $aa);     //8*8
  b_75_98: array[0..7] of byte          = ($ee, $bb, $ee, $bb, $ee, $bb, $ee, $bb);     //8*8
  b_90_98: array[0..15] of byte         = ($be, $0f, $ff, $0f, $f7, $0d, $ff, $0f,
    $be, $0f, $ff, $0f, $f7, $0d, $ff, $0f); //12*8
  b_100_98: array[0..7] of byte         = ($ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff);     //8*8
  b_block2_98: array[0..7] of byte      = ($33, $33, $cc, $cc, $33, $33, $cc, $cc); //8*8
  b_block3_98: array[0..23] of byte     = ($c7, $01, $c7, $01, $c7, $01,
    $38, $0e, $38, $0e, $38, $0e, //12*12
    $c7, $01, $c7, $01, $c7, $01,
    $38, $0e, $38, $0e, $38, $0e);
  b_block4_98: array[0..7] of byte      = ($0f, $0f, $0f, $0f, $f0, $f0, $f0, $f0); //8*8
  b_hatchup3_98: array[0..23] of byte   = ($24, $09, $92, $04, $49, $02,
    $24, $09, $92, $04, $49, $02,
    $24, $09, $92, $04, $49, $02,
    $24, $09, $92, $04, $49, $02); //12*12
  b_hatchup4_98: array[0..7] of byte    = ($88, $44, $22, $11, $88, $44, $22, $11); //8*8
  b_hatchup5_98: array[0..19] of byte   = ($10, $02, $08, $01, $84, $00, $42, $00, $21, $00,
    $10, $02, $08, $01, $84, $00, $42, $00, $21, $00); //10*10
  b_hatchdown3_98: array[0..17] of byte = ($49, $00, $92, $00, $24, $01,
    $49, $00, $92, $00, $24, $01,
    $49, $00, $92, $00, $24, $01); //9*9
  b_hatchdown4_98: array[0..7] of byte  = ($11, $22, $44, $88, $11, $22, $44, $88); //8*8
  b_hatchdown5_98: array[0..19] of byte = ($21, $00, $42, $00, $84, $00, $08, $01, $10, $02,
    $21, $00, $42, $00, $84, $00, $08, $01, $10, $02); //10*10
  b_crosshatch3_98: array[0..23] of byte = ($6d, $01, $92, $00, $6d, $01,
    $6d, $01, $92, $00, $6d, $01,
    $6d, $01, $92, $00, $6d, $01,
    $6d, $01, $92, $00, $6d, $01); //12*12
  b_crosshatch4_98: array[0..7] of byte = ($88, $55, $22, $55, $88, $55, $22, $55); //8*8
  b_crosshatch5_98: array[0..19] of byte = ($31, $02, $4a, $01, $84, $00, $4a, $01, $31, $02,
    $31, $02, $4a, $01, $84, $00, $4a, $01, $31, $02); //10*10
  b_crosshatch6_98: array[0..23] of byte = ($20, $08, $51, $04, $8a, $02, $04, $01, $8a, $02, $51, $04,
    $20, $08, $51, $04, $8a, $02, $04, $01, $8a, $02, $51, $04); //12*12

 {$else}
 b_none:   array[0..0] of byte = ($00);          //1*1
 b_0:   array[0..0] of byte = ($00);             //1*1
 b_10:  array[0..3] of byte = ($01,$00,$08,$00); //6*4
 b_25:  array[0..1] of byte = ($01,$04);         //4*2
 b_50:  array[0..1] of byte = ($01,$02);         //2*2
 b_75:  array[0..1] of byte = ($0e,$0b);         //4*2
 b_90:  array[0..3] of byte = ($3e,$3f,$37,$3f); //6*4
 b_100: array[0..0] of byte = ($01);             //1*1
 b_block2: array[0..3] of byte = ($03,$03,$0c,$0c); //4*4
 b_block3: array[0..5] of byte = ($07,$07,$07,$38,$38,$38); //6*6
 b_block4: array[0..7] of byte = ($0f,$0f,$0f,$0f,$f0,$f0,$f0,$f0); //8*8
 b_hatchup3: array[0..2] of byte = ($04,$02,$01); //3*3
 b_hatchup4: array[0..3] of byte = ($08,$04,$02,$01); //4*4
 b_hatchup5: array[0..4] of byte = ($10,$08,$04,$02,$01); //5*5
 b_hatchdown3: array[0..2] of byte = ($01,$02,$04); //3*3
 b_hatchdown4: array[0..3] of byte = ($01,$02,$04,$08); //4*4
 b_hatchdown5: array[0..4] of byte = ($01,$02,$04,$08,$10); //5*5
 b_crosshatch3: array[0..2] of byte = ($05,$02,$05); //3*3
 b_crosshatch4: array[0..3] of byte = ($08,$05,$02,$05); //4*4
 b_crosshatch5: array[0..4] of byte = ($11,$0a,$04,$0a,$11); //5*5
 b_crosshatch6: array[0..5] of byte = ($20,$11,$0a,$04,$0a,$11); //6*6
 {$endif}

function stockobjects: tstockobjects;
begin
  if stockobjs = nil then
  begin
    stockobjs := tstockobjects.Create;
    application.Initialize; //stockdata needs initialized application
  end;
  Result := stockobjs;
end;

function sc(const acaption: stockcaptionty): msestring;
begin
  Result := stockobjects.captions[acaption];
end;

procedure init;
begin
  // deinit;
  if stockdata = nil then
    stockdata := tstockdata.Create(nil, True);
end;

procedure deinit;
begin
  FreeAndNil(stockobjs);
  FreeAndNil(stockdata);
end;

{ tstockobjects }

constructor tstockobjects.Create;
begin
  //dummy
end;

destructor tstockobjects.Destroy;
var
  bmps: stockbitmapty;
  fonts1: stockfontty;
begin
  for bmps := low(stockbitmapty) to high(stockbitmapty) do
    fbitmaps[bmps].Free;
  for fonts1 := low(stockfontty) to high(stockfontty) do
    ffonts[fonts1].Free;
  fglyphs.Free;
  inherited;
end;

function tstockobjects.getbitmaps(index: stockbitmapty): tbitmap;
begin
  if fbitmaps[index] = nil then
  begin
    fbitmaps[index] := tbitmap.Create(bmk_mono);
  {$ifdef mswindows}
    if iswin98 then
      case index of             //must be >= 8*8 for win98
        stb_default, stb_none: fbitmaps[index].loaddata(makesize(8, 8), @b_none_98);
        stb_dens0: fbitmaps[index].loaddata(makesize(8, 8), @b_0_98);
        stb_dens10: fbitmaps[index].loaddata(makesize(12, 8), @b_10_98);
        stb_dens25: fbitmaps[index].loaddata(makesize(8, 8), @b_25_98);
        stb_dens50: fbitmaps[index].loaddata(makesize(8, 8), @b_50_98);
        stb_dens75: fbitmaps[index].loaddata(makesize(8, 8), @b_75_98);
        stb_dens90: fbitmaps[index].loaddata(makesize(12, 8), @b_90_98);
        stb_dens100: fbitmaps[index].loaddata(makesize(8, 8), @b_100_98);
        stb_block2: fbitmaps[index].loaddata(makesize(8, 8), @b_block2_98);
        stb_block3: fbitmaps[index].loaddata(makesize(12, 12), @b_block3_98);
        stb_block4: fbitmaps[index].loaddata(makesize(8, 8), @b_block4_98);
        stb_hatchup3: fbitmaps[index].loaddata(makesize(12, 12), @b_hatchup3_98);
        stb_hatchup4: fbitmaps[index].loaddata(makesize(8, 8), @b_hatchup4_98);
        stb_hatchup5: fbitmaps[index].loaddata(makesize(10, 10), @b_hatchup5_98);
        stb_hatchdown3: fbitmaps[index].loaddata(makesize(9, 9), @b_hatchdown3_98);
        stb_hatchdown4: fbitmaps[index].loaddata(makesize(8, 8), @b_hatchdown4_98);
        stb_hatchdown5: fbitmaps[index].loaddata(makesize(10, 10), @b_hatchdown5_98);
        stb_crosshatch3: fbitmaps[index].loaddata(makesize(9, 9), @b_crosshatch3_98);
        stb_crosshatch4: fbitmaps[index].loaddata(makesize(8, 8), @b_crosshatch4_98);
        stb_crosshatch5: fbitmaps[index].loaddata(makesize(10, 10), @b_crosshatch5_98);
        stb_crosshatch6: fbitmaps[index].loaddata(makesize(12, 12), @b_crosshatch6_98);
      end
    else
      case index of
        stb_default, stb_none: fbitmaps[index].loaddata(makesize(1, 1), @b_none);
        stb_dens0: fbitmaps[index].loaddata(makesize(1, 1), @b_0);
        stb_dens10: fbitmaps[index].loaddata(makesize(6, 4), @b_10);
        stb_dens25: fbitmaps[index].loaddata(makesize(4, 2), @b_25);
        stb_dens50: fbitmaps[index].loaddata(makesize(2, 2), @b_50);
        stb_dens75: fbitmaps[index].loaddata(makesize(4, 2), @b_75);
        stb_dens90: fbitmaps[index].loaddata(makesize(6, 4), @b_90);
        stb_dens100: fbitmaps[index].loaddata(makesize(1, 1), @b_100);
        stb_block2: fbitmaps[index].loaddata(makesize(4, 4), @b_block2);
        stb_block3: fbitmaps[index].loaddata(makesize(6, 6), @b_block3);
        stb_block4: fbitmaps[index].loaddata(makesize(8, 8), @b_block4);
        stb_hatchup3: fbitmaps[index].loaddata(makesize(3, 3), @b_hatchup3);
        stb_hatchup4: fbitmaps[index].loaddata(makesize(4, 4), @b_hatchup4);
        stb_hatchup5: fbitmaps[index].loaddata(makesize(5, 5), @b_hatchup5);
        stb_hatchdown3: fbitmaps[index].loaddata(makesize(3, 3), @b_hatchdown3);
        stb_hatchdown4: fbitmaps[index].loaddata(makesize(4, 4), @b_hatchdown4);
        stb_hatchdown5: fbitmaps[index].loaddata(makesize(5, 5), @b_hatchdown5);
        stb_crosshatch3: fbitmaps[index].loaddata(makesize(3, 3), @b_crosshatch3);
        stb_crosshatch4: fbitmaps[index].loaddata(makesize(4, 4), @b_crosshatch4);
        stb_crosshatch5: fbitmaps[index].loaddata(makesize(5, 5), @b_crosshatch5);
        stb_crosshatch6: fbitmaps[index].loaddata(makesize(6, 6), @b_crosshatch6);
      end;
  {$else}
  case index of
   stb_default,stb_none: fbitmaps[index].loaddata(makesize(1,1),@b_none);
   stb_dens0: fbitmaps[index].loaddata(makesize(1,1),@b_0);
   stb_dens10: fbitmaps[index].loaddata(makesize(6,4),@b_10);
   stb_dens25: fbitmaps[index].loaddata(makesize(4,2),@b_25);
   stb_dens50: fbitmaps[index].loaddata(makesize(2,2),@b_50);
   stb_dens75: fbitmaps[index].loaddata(makesize(4,2),@b_75);
   stb_dens90: fbitmaps[index].loaddata(makesize(6,4),@b_90);
   stb_dens100: fbitmaps[index].loaddata(makesize(1,1),@b_100);
   stb_block2: fbitmaps[index].loaddata(makesize(4,4),@b_block2);
   stb_block3: fbitmaps[index].loaddata(makesize(6,6),@b_block3);
   stb_block4: fbitmaps[index].loaddata(makesize(8,8),@b_block4);
   stb_hatchup3: fbitmaps[index].loaddata(makesize(3,3),@b_hatchup3);
   stb_hatchup4: fbitmaps[index].loaddata(makesize(4,4),@b_hatchup4);
   stb_hatchup5: fbitmaps[index].loaddata(makesize(5,5),@b_hatchup5);
   stb_hatchdown3: fbitmaps[index].loaddata(makesize(3,3),@b_hatchdown3);
   stb_hatchdown4: fbitmaps[index].loaddata(makesize(4,4),@b_hatchdown4);
   stb_hatchdown5: fbitmaps[index].loaddata(makesize(5,5),@b_hatchdown5);
   stb_crosshatch3: fbitmaps[index].loaddata(makesize(3,3),@b_crosshatch3);
   stb_crosshatch4: fbitmaps[index].loaddata(makesize(4,4),@b_crosshatch4);
   stb_crosshatch5: fbitmaps[index].loaddata(makesize(5,5),@b_crosshatch5);
   stb_crosshatch6: fbitmaps[index].loaddata(makesize(6,6),@b_crosshatch6);
  end;
  {$endif}
  end;
  Result := fbitmaps[index];
end;

procedure tstockobjects.fontchanged(const Sender: TObject);
var
  int1: integer;
begin
  with application do
    for int1 := 0 to windowcount - 1 do
      with twidget1(Windows[int1].owner) do
        fontchanged;
end;

function tstockobjects.getfonts(index: stockfontty): twidgetfont;
var
  fo1: stockfontty;
  str1: string;
begin
  if not ffontaliasregistered then
  begin
    for fo1 := low(stockfontty) to high(stockfontty) do
    begin
      case fo1 of
        stf_default: str1 := '';
        else str1         := 'stf_default';
      end;
      registerfontalias(getenumname(typeinfo(stockfontty), Ord(fo1)),
        gui_getdefaultfontnames[fo1], fam_nooverwrite, 0, 0, [], 1.0, str1);
    end;
    ffontaliasregistered := True;
  end;
  if ffonts[index] = nil then
  begin
    ffonts[index]          := twidgetfont.Create;
    ffonts[index].Name     := getenumname(typeinfo(stockfontty), Ord(index));
    ffonts[index].onchange :=
{$ifdef FPC}
      @
{$endif}
      fontchanged;
  end;
  Result := ffonts[index];
end;

function tstockobjects.getglyphs: timagelist;
begin
  Result := stockdata.glyphs;
end;

function tstockobjects.getmseicon: tmaskedbitmap;
begin
  Result := stockdata.mseicon.bitmap;
end;

procedure tstockobjects.setmseicon(const avalue: tmaskedbitmap);
begin
  stockdata.mseicon.bitmap.Assign(avalue);
end;

function tstockobjects.getmodalresulttext(index: modalresultty): msestring;
begin
  Result := mseconsts_ide.modalresulttext(index);
  // result:= fmodalresulttext[index];
end;

function tstockobjects.getmodalresulttextnoshortcut(index: modalresultty): msestring;
begin
  Result := mseconsts_ide.modalresulttextnoshortcut(index);
  // result:= fmodalresulttextnoshortcut[index];
end;

function tstockobjects.getcaptions(index: stockcaptionty): msestring;
begin
  Result := stockcaptions(index);
end;

function tstockobjects.gettextgenerator(index: textgeneratorty): textgeneratorfuncty;
begin
  Result := stocktextgenerators(index);
end;

procedure tstockobjects.paintglyph(const Canvas: tcanvas; const glyph: stockglyphty; const rect: rectty; const grayed: Boolean = False; const color: colorty = cl_glyph; aalignment: alignmentsty = [al_ycentered, al_xcentered]);
var
  colorbefore: colorty;
begin
  colorbefore  := Canvas.color;
  Canvas.color := color;
  if grayed then
    aalignment := aalignment + [al_grayed];
  glyphs.paint(Canvas, integer(glyph), rect, aalignment, color);
  Canvas.color := colorbefore;
end;

end.

