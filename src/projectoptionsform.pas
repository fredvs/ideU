unit projectoptionsform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

{$ifndef mse_no_ifi}
  {$define mse_with_ifi}
//MSEide needs mse_with_ifi, switch for compiling test only
{$endif}

interface

uses
 mseconsts, msestockobjects, captionideu, mseforms,msefiledialogx,mseapplication,msegui,
 msestat,msestatfile,msetabs,msesimplewidgets,msetypes,msestrings,msedataedits,
 msetextedit,msegraphedits,msewidgetgrid,msegrids,msesplitter,msemacros,
 msegdbutils,msedispwidgets,msesys,mseclasses,msegraphutils,mseevent,
 msetabsglob,msearrayutils,msegraphics,msedropdownlist,mseformatstr,
 mseinplaceedit,msedatanodes,mselistbrowser,msebitmap,msecolordialog,
 msedrawtext,msewidgets,msepointer,mseguiglob,msepipestream,msemenus,SysUtils,
 mseglob,mseedit,msedialog,msescrollbar,msememodialog,msecodetemplates,
 mseifiglob,msestream,msestringcontainer,mserttistat,mseificomp,mseificompglob,
 msedragglob,mserichstring,mseact,msecalendardatetimeedit,msegridsglob;

const
  defaultsourceprintfont = 'Courier';
  defaulttitleprintfont  = 'Helvetica';
  defaultprintfontsize   = 35.2778; //10 point
  //maxdefaultmake = $40-1;
  maxdefaultmake         = $1280 - 1;
  defaultxtermcommand    = 'xterm -S${PTSN}/${PTSH}';

type
  settinggroupty  = (sg_editor, sg_debugger);
  settinggroupsty = set of settinggroupty;

  findinfoty = record
    Text: msestring;
    options: searchoptionsty;
    selectedonly: Boolean;
    history: msestringarty;
  end;

  replaceinfoty = record
    find: findinfoty;
    replacetext: msestring;
    prompt: Boolean;
  end;

  sigsetinfoty = record
    num: integer;
    numto: integer;
    flags: sigflagsty;
  end;
  sigsetinfoarty = array of sigsetinfoty;

  ttextprojectoptions = class(toptions)
  private
    fmainfile: filenamety;
    ftargetfile: filenamety;
    fmessageoutputfile: filenamety;
    fmakecommand: filenamety;
    fmakedir: filenamety;
    funitdirs: msestringarty;
    funitpref: msestring;
    fincpref: msestring;
    flibpref: msestring;
    fobjpref: msestring;
    ftargpref: msestring;
    fbefcommand: msestringarty;
    faftcommand: msestringarty;

    // fred compiler
    fcompilerused: msestringarty;

    // fred debugger
    fdebuggerused: msestringarty;

    // fred exe ext
    fexeused: msestringarty;

    // fred comment make
    fmakeoptpurpose: msestringarty;


    fmakeoptions: msestringarty;
    ftoolmenus: msestringarty;
    ftoolfiles: msestringarty;
    ftoolparams: msestringarty;
    ffontnames: msestringarty;
    fscriptbeforecopy: msestring;
    fscriptaftercopy: msestring;
    fnewprojectfiles: filenamearty;
    fnewprojectfilesdest: filenamearty;
    fnewfinames: msestringarty;
    fnewfifilters: msestringarty;
    fnewfiexts: msestringarty;
    fnewfisources: filenamearty;
    fnewfonames: msestringarty;
    fnewfonamebases: msestringarty;
    fnewfosources: msestringarty;
    fnewfoforms: msestringarty;
  public
    fcodetemplatedirs: msestringarty;
  published
    property mainfile: filenamety read fmainfile write fmainfile;
    property targetfile: filenamety read ftargetfile write ftargetfile;
    property messageoutputfile: filenamety read fmessageoutputfile write fmessageoutputfile;
    property makecommand: filenamety read fmakecommand write fmakecommand;
    property makedir: filenamety read fmakedir write fmakedir;
    property unitdirs: msestringarty read funitdirs write funitdirs;
    property unitpref: msestring read funitpref write funitpref;
    property incpref: msestring read fincpref write fincpref;
    property libpref: msestring read flibpref write flibpref;
    property objpref: msestring read fobjpref write fobjpref;
    property targpref: msestring read ftargpref write ftargpref;

    property befcommand: msestringarty read fbefcommand write fbefcommand;
    property aftcommand: msestringarty read faftcommand write faftcommand;
    property makeoptions: msestringarty read fmakeoptions write fmakeoptions;

    // fred make comment
    property makeoptpurpose: msestringarty read fmakeoptpurpose write fmakeoptpurpose;


    // fred compiler
    property compilerused: msestringarty read fcompilerused write fcompilerused;

    // fred debugger
    property debuggerused: msestringarty read fdebuggerused write fdebuggerused;

    // fred exe ext
    property exeused: msestringarty read fexeused write fexeused;


    property codetemplatedirs: msestringarty read fcodetemplatedirs write fcodetemplatedirs;

    property toolmenus: msestringarty read ftoolmenus write ftoolmenus;
    property toolfiles: msestringarty read ftoolfiles write ftoolfiles;
    property toolparams: msestringarty read ftoolparams write ftoolparams;

    property fontnames: msestringarty read ffontnames write ffontnames;
    property scriptbeforecopy: msestring read fscriptbeforecopy write fscriptbeforecopy;
    property scriptaftercopy: msestring read fscriptaftercopy write fscriptaftercopy;
    property newprojectfiles: filenamearty read fnewprojectfiles write fnewprojectfiles;
    property newprojectfilesdest: filenamearty read fnewprojectfilesdest write fnewprojectfilesdest;
    property newfinames: msestringarty read fnewfinames write fnewfinames;
    property newfifilters: msestringarty read fnewfifilters write fnewfifilters;
    property newfiexts: msestringarty read fnewfiexts write fnewfiexts;
    property newfisources: filenamearty read fnewfisources write fnewfisources;

    property newfonames: msestringarty read fnewfonames write fnewfonames;
    property newfonamebases: msestringarty read fnewfonamebases write fnewfonamebases;
    property newfosources: msestringarty read fnewfosources write fnewfosources;
    property newfoforms: msestringarty read fnewfoforms write fnewfoforms;
  end;

  ttexteditoptions = class(toptions)
  private
    fsourcefilemasks: msestringarty;
    fsyntaxdeffiles: msestringarty;
    ffilemasknames: msestringarty;
    ffilemasks: msestringarty;
  published
    property sourcefilemasks: msestringarty read fsourcefilemasks write fsourcefilemasks;
    property syntaxdeffiles: msestringarty read fsyntaxdeffiles write fsyntaxdeffiles;
    property filemasknames: msestringarty read ffilemasknames write ffilemasknames;
    property filemasks: msestringarty read ffilemasks write ffilemasks;
  end;

  teditoptions = class(toptions)
  private
    ft: ttexteditoptions;
    ftexp: ttexteditoptions;

    fshowgrid: Boolean;
    fsnaptogrid: Boolean;
    fmoveonfirstclick: Boolean;
    fgridsizex: integer;
    fgridsizey: integer;
    fautoindent: Boolean;
    fblockindent: integer;
    flinenumberson: Boolean;
    frightmarginon: Boolean;
    frightmarginchars: integer;
    fscrollheight: integer;
    ftabstops: integer;
    fspacetabs: Boolean;
    fshowtabs: Boolean;
    ftabindent: Boolean;
    feditfontname: msestring;
    feditfontheight: integer;
    feditfontwidth: integer;
    feditfontextraspace: integer;
    feditfontcolor: integer;
    feditbkcolor: integer;
    fstatementcolor: integer;
    feditfontantialiased: Boolean;
    feditmarkbrackets: Boolean;
    feditmarkpairwords: Boolean;
    ffpgdesignerenabled: Boolean;
    fbackupfilecount: integer;
    fencoding: integer;
    feolstyle: integer;
    fnoformdesignerdocking: Boolean;
    ftrimtrailingwhitespace: Boolean;
    fpairmarkcolor: integer;
    fcomponenthints: Boolean;
    function limitgridsize(const avalue: integer): integer;
    procedure setgridsizex(const avalue: integer);
    procedure setgridsizey(const avalue: integer);
    function getcodetemplatedirs: msestringarty;
    procedure setcodetemplatedirs(const avalue: msestringarty);
  protected
    function gett: TObject; override;
    function gettexp: TObject; override;
  public
    constructor Create;
    property texp: ttexteditoptions read ftexp;
  published
    property t: ttexteditoptions read ft;

    property showgrid: Boolean read fshowgrid write fshowgrid;
    property snaptogrid: Boolean read fsnaptogrid write fsnaptogrid;
    property moveonfirstclick: Boolean read fmoveonfirstclick write fmoveonfirstclick;
    property noformdesignerdocking: Boolean read fnoformdesignerdocking write fnoformdesignerdocking;
    property componenthints: Boolean read fcomponenthints write fcomponenthints;
    property gridsizex: integer read fgridsizex write setgridsizex;
    property gridsizey: integer read fgridsizey write setgridsizey;
    property autoindent: Boolean read fautoindent write fautoindent;
    property blockindent: integer read fblockindent write fblockindent;
    property linenumberson: Boolean read flinenumberson write flinenumberson;
    property rightmarginon: Boolean read frightmarginon write frightmarginon;
    property rightmarginchars: integer read frightmarginchars write frightmarginchars;
    property scrollheight: integer read fscrollheight write fscrollheight;
    property tabstops: integer read ftabstops write ftabstops;
    property spacetabs: Boolean read fspacetabs write fspacetabs;
    property showtabs: Boolean read fshowtabs write fshowtabs;
    property tabindent: Boolean read ftabindent write ftabindent;
    property editfontname: msestring read feditfontname write feditfontname;
    property editfontheight: integer read feditfontheight write feditfontheight;
    property editfontwidth: integer read feditfontwidth write feditfontwidth;
    property editfontextraspace: integer read feditfontextraspace write feditfontextraspace;
    property editfontcolor: integer read feditfontcolor write feditfontcolor;
    property editbkcolor: integer read feditbkcolor write feditbkcolor;
    property statementcolor: integer read fstatementcolor write fstatementcolor;
    property pairmarkcolor: integer read fpairmarkcolor write fpairmarkcolor;

    property editfontantialiased: Boolean read feditfontantialiased write feditfontantialiased;
    property editmarkbrackets: Boolean read feditmarkbrackets write feditmarkbrackets;
    property editmarkpairwords: Boolean read feditmarkpairwords write feditmarkpairwords;

    property fpgdesigner: Boolean read ffpgdesignerenabled write ffpgdesignerenabled;

    property backupfilecount: integer read fbackupfilecount write fbackupfilecount;
    property encoding: integer read fencoding write fencoding;

    property eolstyle: integer read feolstyle write feolstyle;

    property trimtrailingwhitespace: Boolean read ftrimtrailingwhitespace write ftrimtrailingwhitespace;
    property codetemplatedirs: msestringarty read getcodetemplatedirs write setcodetemplatedirs;
  end;

  ttextdebugoptions = class(toptions)
  private
    fdebugcommand: filenamety;
    fdebugoptions: msestring;
    fdebugtarget: filenamety;
    fruncommand: filenamety;
    fremoteconnection: msestring;
    fuploadcommand: filenamety;
    fgdbprocessor: msestring;
    fgdbservercommand: filenamety;
    fgdbservercommandattach: filenamety;
    fbeforeload: filenamety;
    fafterload: filenamety;
    fbeforerun: filenamety;
    fsourcedirs: msestringarty;
    fdefines: msestringarty;

    fprogparameters: msestring;
    fprogworkingdirectory: filenamety;
    fenvvarnames: msestringarty;
    fenvvarvalues: msestringarty;
    fbeforeconnect: filenamety;
    fafterconnect: filenamety;
    fxtermcommand: msestring;
    fsourcebase: msestring;
  protected
  public
    constructor Create;
  published
    property debugcommand: filenamety read fdebugcommand write fdebugcommand;
    property debugoptions: msestring read fdebugoptions write fdebugoptions;
    property debugtarget: filenamety read fdebugtarget write fdebugtarget;
    property runcommand: filenamety read fruncommand write fruncommand;
    property xtermcommand: msestring read fxtermcommand write fxtermcommand;
    property remoteconnection: msestring read fremoteconnection write fremoteconnection;
    property uploadcommand: filenamety read fuploadcommand write fuploadcommand;
    property gdbprocessor: msestring read fgdbprocessor write fgdbprocessor;
    property gdbservercommand: filenamety read fgdbservercommand write fgdbservercommand;
    property gdbservercommandattach: filenamety read fgdbservercommandattach write fgdbservercommandattach;
    property beforeconnect: filenamety read fbeforeconnect write fbeforeconnect;
    property afterconnect: filenamety read fafterconnect write fafterconnect;
    property beforeload: filenamety read fbeforeload write fbeforeload;
    property afterload: filenamety read fafterload write fafterload;
    property beforerun: filenamety read fbeforerun write fbeforerun;
    property sourcebase: msestring read fsourcebase write fsourcebase;
    property sourcedirs: msestringarty read fsourcedirs write fsourcedirs;
    property defines: msestringarty read fdefines write fdefines;

    property progparameters: msestring read fprogparameters write fprogparameters;
    property progworkingdirectory: filenamety read fprogworkingdirectory write fprogworkingdirectory;
    property envvarnames: msestringarty read fenvvarnames write fenvvarnames;
    property envvarvalues: msestringarty read fenvvarvalues write fenvvarvalues;
  end;

  tdebugoptions = class(toptions)
  private
    ft: ttextdebugoptions;
    ftexp: ttextdebugoptions;
    fdefineson: longboolarty;
    fstoponexception: Boolean;
    fvaluehints: Boolean;
    factivateonbreak: Boolean;
    fshowconsole: Boolean;
    fexternalconsole: Boolean;
    fgdbdownload: Boolean;
    fdownloadalways: Boolean;
    frestartgdbbeforeload: Boolean;
    fstartupbkpt: integer;
    fstartupbkpton: Boolean;
    fgdbsimulator: Boolean;
    fgdbserverwait: real;
    fexceptclassnames: msestringarty;
    fexceptignore: booleanarty;
    fnogdbserverexit: Boolean;
    fgdbservertty: Boolean;
    fnodebugbeginend: Boolean;
    fsettty: Boolean;
    fgdbserverstartonce: Boolean;
    fraiseonbreak: Boolean;
    fgdbloadtimeout: realty;
    ffpcgdbworkaround: Boolean;
  protected
    function gett: TObject; override;
    function gettexp: TObject; override;
  public
    constructor Create;
    property texp: ttextdebugoptions read ftexp;
  published
    property t: ttextdebugoptions read ft;
    property defineson: longboolarty read fdefineson write fdefineson;
    property stoponexception: Boolean read fstoponexception write fstoponexception;
    property valuehints: Boolean read fvaluehints write fvaluehints;
    property activateonbreak: Boolean read factivateonbreak write factivateonbreak;
    property raiseonbreak: Boolean read fraiseonbreak write fraiseonbreak;
    property showconsole: Boolean read fshowconsole write fshowconsole;
    property externalconsole: Boolean read fexternalconsole write fexternalconsole;
    property settty: Boolean read fsettty write fsettty;
    property gdbdownload: Boolean read fgdbdownload write fgdbdownload;
    property downloadalways: Boolean read fdownloadalways write fdownloadalways;
    property restartgdbbeforeload: Boolean read frestartgdbbeforeload write frestartgdbbeforeload;
    property startupbkpt: integer read fstartupbkpt write fstartupbkpt;
    property startupbkpton: Boolean read fstartupbkpton write fstartupbkpton;
    property gdbsimulator: Boolean read fgdbsimulator write fgdbsimulator;
    property gdbserverstartonce: Boolean read fgdbserverstartonce write fgdbserverstartonce;
    property gdbloadtimeout: real read fgdbloadtimeout write fgdbloadtimeout;
    property gdbserverwait: real read fgdbserverwait write fgdbserverwait;
    property nogdbserverexit: Boolean read fnogdbserverexit write fnogdbserverexit;
    property gdbservertty: Boolean read fgdbservertty write fgdbservertty;
    property exceptclassnames: msestringarty read fexceptclassnames write fexceptclassnames;
    property exceptignore: booleanarty read fexceptignore write fexceptignore;
    property nodebugbeginend: Boolean read fnodebugbeginend write fnodebugbeginend;
    property fpcgdbworkaround: Boolean read ffpcgdbworkaround write ffpcgdbworkaround;
  end;

  tprojectoptions = class(toptions)
  private
    ft: ttextprojectoptions;
    ftexp: ttextprojectoptions;

    fstripmessageesc: Boolean;
    fcopymessages: Boolean;
    fcheckmethods: Boolean;
    fclosemessages: Boolean;
    fenablepurpose: Boolean;
    fenablesource: Boolean;

    fusercolors: colorarty;
    fusercolorcomment: msestringarty;
    fformatmacronames: msestringarty;
    fformatmacrovalues: msestringarty;

    fsettingsfile: filenamety;
    fsettingseditor: Boolean;
    fsettingsdebugger: Boolean;
    fsettingsstorage: Boolean;
    fsettingsprojecttree: Boolean;
    fsettingsautoload: Boolean;
    fsettingsautosave: Boolean;
    fmodulenames: msestringarty;
    fmoduletypes: msestringarty;
    fmodulefiles: filenamearty;
    // fred compiler
    fcompilerusedon: integerarty;

    // fred debugger
    fdebuggerusedon: integerarty;

    // fred debuggerexe ext
    fexeusedon: integerarty;

    // fred make comment
    //  fmakecommenton: integerarty;

    // fred comment options
    fcomment_M: msestring;
    fcomment_B: msestring;
    fcomment_1: msestring;
    fcomment_2: msestring;
    fcomment_3: msestring;
    fcomment_4: msestring;
    fcomment_5: msestring;
    fcomment_6: msestring;
    fcomment_7: msestring;
    fcomment_8: msestring;
    fcomment_9: msestring;
    fcomment_0: msestring;

    // fred infos project
    fproject_name: msestring;
    fproject_creator: msestring;
    fproject_copyright: msestring;
    fproject_license: msestring;
    fproject_time: msestring;
    fproject_date: msestring;
    fproject_comment: msestring;

    fbefcommandon: integerarty;
    fmakeoptionson: integerarty;
    faftcommandon: integerarty;
    funitdirson: integerarty;
    fmacroon: integerarty;
    fmacronames: msestringarty;
    fmacrovalues: msestringarty;
    fmacrogroup: integer;
    fgroupcomments: msestringarty;

    ftoolsave: longboolarty;
    ftoolhide: longboolarty;
    ftoolparse: longboolarty;
    ftoolmessages: longboolarty;
    ffontalias: msestringarty;
    ffontancestors: msestringarty;
    ffontheights: integerarty;
    ffontwidths: integerarty;
    ffontoptions: msestringarty;
    ffontxscales: realarty;
    fexpandprojectfilemacros: longboolarty;
    floadprojectfile: longboolarty;
    fnewinheritedforms: longboolarty;
    fcolorerror: colorty;
    fcolorwarning: colorty;
    fcolornote: colorty;
    fcolorhint: colorty;
    fuid: integer;
    fforcezorder: longbool;
    ftoolshortcuts: integerarty;
    procedure setforcezorder(const avalue: longbool);
  protected
    function gett: TObject; override;
    function gettexp: TObject; override;
  public
    constructor Create;
    property texp: ttextprojectoptions read ftexp;
  published
    property t: ttextprojectoptions read ft;

    property forcezorder: longbool read fforcezorder write setforcezorder;
    property stripmessageesc: Boolean read fstripmessageesc write fstripmessageesc;
    property copymessages: Boolean read fcopymessages write fcopymessages;
    property closemessages: Boolean read fclosemessages write fclosemessages;
    property enablepurpose: Boolean read fenablepurpose write fenablepurpose;
    property enablesource: Boolean read fenablesource write fenablesource;

    property checkmethods: Boolean read fcheckmethods write fcheckmethods;
    property colorerror: colorty read fcolorerror write fcolorerror;
    property colorwarning: colorty read fcolorwarning write fcolorwarning;
    property colornote: colorty read fcolornote write fcolornote;
    property colorhint: colorty read fcolorhint write fcolorhint;

    property usercolors: colorarty read fusercolors write fusercolors;
    property usercolorcomment: msestringarty read fusercolorcomment write fusercolorcomment;
    property formatmacronames: msestringarty read fformatmacronames write fformatmacronames;
    property formatmacrovalues: msestringarty read fformatmacrovalues write fformatmacrovalues;
    property settingsfile: filenamety read fsettingsfile write fsettingsfile;
    property settingseditor: Boolean read fsettingseditor write fsettingseditor;
    property settingsdebugger: Boolean read fsettingsdebugger write fsettingsdebugger;
    property settingsstorage: Boolean read fsettingsstorage write fsettingsstorage;
    property settingsprojecttree: Boolean read fsettingsprojecttree write fsettingsprojecttree;
    property settingsautoload: Boolean read fsettingsautoload write fsettingsautoload;
    property settingsautosave: Boolean read fsettingsautosave write fsettingsautosave;

    property modulenames: msestringarty read fmodulenames write fmodulenames;
    property moduletypes: msestringarty read fmoduletypes write fmoduletypes;
    property modulefiles: filenamearty read fmodulefiles write fmodulefiles;

    property befcommandon: integerarty read fbefcommandon write fbefcommandon;
    property makeoptionson: integerarty read fmakeoptionson write fmakeoptionson;

    // fred comment make
    //  property makecommenton: integerarty read fmakecommenton write fmakecommenton;

    // fred compiler
    property compilerusedon: integerarty read fcompilerusedon write fcompilerusedon;

    // fred debugger
    property debuggerusedon: integerarty read fdebuggerusedon write fdebuggerusedon;

    // fred exe ext
    property exeusedon: integerarty read fexeusedon write fexeusedon;

    // fred comment options
    property comment_M: msestring read fcomment_M write fcomment_M;
    property comment_B: msestring read fcomment_B write fcomment_B;
    property comment_1: msestring read fcomment_1 write fcomment_1;
    property comment_2: msestring read fcomment_2 write fcomment_2;
    property comment_3: msestring read fcomment_3 write fcomment_3;
    property comment_4: msestring read fcomment_4 write fcomment_4;
    property comment_5: msestring read fcomment_5 write fcomment_5;
    property comment_6: msestring read fcomment_6 write fcomment_6;
    property comment_7: msestring read fcomment_7 write fcomment_7;
    property comment_8: msestring read fcomment_8 write fcomment_8;
    property comment_9: msestring read fcomment_9 write fcomment_9;
    property comment_0: msestring read fcomment_0 write fcomment_0;

    // fred info project
    property project_name: msestring read fproject_name write fproject_name;
    property project_creator: msestring read fproject_creator write fproject_creator;
    property project_copyright: msestring read fproject_copyright write fproject_copyright;
    property project_license: msestring read fproject_license write fproject_license;
    property project_time: msestring read fproject_time write fproject_time;
    property project_date: msestring read fproject_date write fproject_date;
    property project_comment: msestring read fproject_comment write fproject_comment;

    property aftcommandon: integerarty read faftcommandon write faftcommandon;
    property unitdirson: integerarty read funitdirson write funitdirson;

    property macroon: integerarty read fmacroon write fmacroon;
    property macronames: msestringarty read fmacronames write fmacronames;
    property macrovalues: msestringarty read fmacrovalues write fmacrovalues;
    property macrogroup: integer read fmacrogroup write fmacrogroup;
    property groupcomments: msestringarty read fgroupcomments write fgroupcomments;

    property toolsave: longboolarty read ftoolsave write ftoolsave;
    property toolhide: longboolarty read ftoolhide write ftoolhide;
    property toolparse: longboolarty read ftoolparse write ftoolparse;
    property toolmessages: longboolarty read ftoolmessages write ftoolmessages;
    property toolshortcuts: integerarty read ftoolshortcuts write ftoolshortcuts;

    property fontalias: msestringarty read ffontalias write ffontalias;
    property fontancestors: msestringarty read ffontancestors write ffontancestors;
    property fontheights: integerarty read ffontheights write ffontheights;
    property fontwidths: integerarty read ffontwidths write ffontwidths;
    property fontoptions: msestringarty read ffontoptions write ffontoptions;
    property fontxscales: realarty read ffontxscales write ffontxscales;

    property expandprojectfilemacros: longboolarty read fexpandprojectfilemacros write fexpandprojectfilemacros;
    property loadprojectfile: longboolarty read floadprojectfile write floadprojectfile;
    property newinheritedforms: longboolarty read fnewinheritedforms write fnewinheritedforms;
    property uid: integer read fuid write fuid;
  end;

{$M-}

  projectoptionsty = record
    disabled: settinggroupsty;
    o: tprojectoptions;
    e: teditoptions;
    d: tdebugoptions;
    modified: Boolean;
    savechecked: Boolean;
    ignoreexceptionclasses: stringarty;
    projectfilename: filenamety;
    projectdir: filenamety;
    defaultmake: integer;
    sigsettings: sigsetinfoarty;
    progparamhistory: msestringarty;
    workdirparamhistory: msestringarty;
    envvarons: longboolarty;
    findreplaceinfo: replaceinfoty;
    targetconsolefindinfo: findinfoty;
  end;

  tprojectoptionsfo = class(tmseform)
    statfile1: tstatfile;
    tlayouter9: tlayouter;
    tlayouter8: tlayouter;
    cancel: TButton;
    ok: TButton;
    setting_tab: ttabwidget;
    editorpage: ttabpage;
    debuggerpage: ttabpage;
    ttabwidget1: ttabwidget;
    ttabpage6: ttabpage;
    sourcedirgrid: twidgetgrid;
    sourcedirs: tfilenameeditx;
    ttabpage9: ttabpage;
    twidgetgrid2: twidgetgrid;
    defineson: tbooleanedit;
    defines: tstringedit;
    ttabpage7: ttabpage;
    signalgrid: twidgetgrid;
    sigstop: tbooleanedit;
    sighandle: tbooleanedit;
    signum: tintegeredit;
    signumto: tintegeredit;
    signame: tselector;
    ttabpage8: ttabpage;
    exceptionsgrid: twidgetgrid;
    exceptignore: tbooleanedit;
    exceptclassnames: tstringedit;
    ttabpage16: ttabpage;
    tlayouter3: tlayouter;
    gdbprocessor: tdropdownlistedit;
    gdbsimulator: tbooleanedit;
    gdbdownload: tbooleanedit;
    tlayouter4: tlayouter;
    beforeconnect: tfilenameeditx;
    tsplitter7: tsplitter;
    beforeload: tfilenameeditx;
    tlayouter5: tlayouter;
    afterconnect: tfilenameeditx;
    tsplitter8: tsplitter;
    tlayouter1: tlayouter;
    externalconsole: tbooleanedit;
    stoponexception: tbooleanedit;
    activateonbreak: tbooleanedit;
    makepage: ttabpage;
    defaultmake: tenumedit;
    mainfile: tfilenameeditx;
    targetfile: tfilenameeditx;
    makecommand: tfilenameeditx;
    showcommandline: TButton;
    copymessages: tbooleanedit;
    closemessages: tbooleanedit;
    checkmethods: tbooleanedit;
    makegroupbox: ttabwidget;
    ttabpage12: ttabpage;
    makeoptionsgrid: twidgetgrid;
    makeon: tbooleanedit;
    extraon: tbooleanedit;
    buildon: tbooleanedit;
    make1on: tbooleanedit;
    make2on: tbooleanedit;
    make3on: tbooleanedit;
    make4on: tbooleanedit;
    make5on: tbooleanedit;
    make6on: tbooleanedit;
    make7on: tbooleanedit;
    make8on: tbooleanedit;
    make9on: tbooleanedit;
    make0on: tbooleanedit;
    makeoptions: tmemodialogedit;
    /// fred
    makeoptpurpose: tmemodialogedit;


    ttabpage11: ttabpage;
    unitdirgrid: twidgetgrid;
    dmakeon: tbooleanedit;
    dbuildon: tbooleanedit;
    dmake1on: tbooleanedit;
    dmake2on: tbooleanedit;
    dmake3on: tbooleanedit;
    dmake4on: tbooleanedit;
    dmake5on: tbooleanedit;
    dmake6on: tbooleanedit;
    dmake7on: tbooleanedit;
    dmake8on: tbooleanedit;
    dmake9on: tbooleanedit;
    dmake0on: tbooleanedit;
    duniton: tbooleanedit;
    dincludeon: tbooleanedit;
    dlibon: tbooleanedit;
    dobjon: tbooleanedit;
    unitdirs: tfilenameeditx;
    unitpref: tstringedit;
    incpref: tstringedit;
    libpref: tstringedit;
    objpref: tstringedit;
    tspacer1: tspacer;
    targpref: tstringedit;
    makedir: tfilenameeditx;
    tsplitter2: tsplitter;
    tsplitter4: tsplitter;
    ttabpage1: ttabpage;
    macrogrid: twidgetgrid;
    e0: tbooleanedit;
    e1: tbooleanedit;
    e2: tbooleanedit;
    e3: tbooleanedit;
    e4: tbooleanedit;
    e5: tbooleanedit;
    e6: tbooleanedit;
    e7: tbooleanedit;
    e8: tbooleanedit;
    e9: tbooleanedit;
    macronames: tstringedit;
    macrovalues: tmemodialogedit;
    selectactivegroupgrid: twidgetgrid;
    activemacroselect: tbooleaneditradio;
    groupcomment: tstringedit;
    macrosplitter: tsplitter;
    fontaliaspage: ttabpage;
    fontaliasgrid: twidgetgrid;
    fontalias: tstringedit;
    fontname: tstringedit;
    fontheight: tintegeredit;
    ttabpage10: ttabpage;
    tlayouter7: tlayouter;
    tbutton1: TButton;
    colgrid: twidgetgrid;
    coldi: tpointeredit;
    usercolors: tcoloredit;
    usercolorcomment: tstringedit;
    ttabpage2: ttabpage;
    newfile: ttabwidget;
    ttabpage3: ttabpage;
    copygrid: twidgetgrid;
    loadprojectfile: tbooleanedit;
    expandprojectfilemacros: tbooleanedit;
    newprojectfiles: tfilenameeditx;
    newprojectfilesdest: tstringedit;
    ttabpage4: ttabpage;
    ttabpage5: ttabpage;
    ttabpage15: ttabpage;
    twidgetgrid3: twidgetgrid;
    toolsave: tbooleanedit;
    toolparse: tbooleanedit;
    toolhide: tbooleanedit;
    toolmenus: tstringedit;
    toolfiles: tfilenameeditx;
    toolparams: tstringedit;
    tlayouter13: tlayouter;
    dispgrid: twidgetgrid;
    fontdisp: ttextedit;
    tlayouter12: tlayouter;
    tlayouter11: tlayouter;
    tlayouter10: tlayouter;
    ttabwidget2: ttabwidget;
    ttabpage13: ttabpage;
    filefiltergrid: tstringgrid;
    ttabpage14: ttabpage;
    serverla: tlayouter;
    uploadcommand: tfilenameeditx;
    gdbservercommand: tfilenameeditx;
    gdbserverwait: trealedit;
    downloadalways: tbooleanedit;
    startupbkpt: tintegeredit;
    startupbkpton: tbooleanedit;
    valuehints: tbooleanedit;
    debugtarget: tfilenameeditx;
    fontwidth: tintegeredit;
    fontoptions: tstringedit;
    fontxscale: trealedit;
    twidgetgrid4: twidgetgrid;
    newfonames: tstringedit;
    newfosources: tfilenameeditx;
    newfoforms: tfilenameeditx;
    tlayouter2: tlayouter;
    gdbservercommandattach: tfilenameeditx;
    scriptbeforecopy: tfilenameeditx;
    scriptaftercopy: tfilenameeditx;
    newinheritedforms: tbooleanedit;
    newformnamebases: tstringedit;
    twidgetgrid1: twidgetgrid;
    newfinames: tstringedit;
    newfisources: tfilenameeditx;
    newfifilters: tstringedit;
    newfiexts: tstringedit;
    fontancestors: tstringedit;
    ttabpage17: ttabpage;
    ttabpage18: ttabpage;
    befcommandgrid: twidgetgrid;
    befmakeon: tbooleanedit;
    befbuildon: tbooleanedit;
    befmake1on: tbooleanedit;
    befmake2on: tbooleanedit;
    befmake3on: tbooleanedit;
    befmake4on: tbooleanedit;
    befmake5on: tbooleanedit;
    befmake6on: tbooleanedit;
    befmake7on: tbooleanedit;
    befmake8on: tbooleanedit;
    befmake9on: tbooleanedit;
    befmake0on: tbooleanedit;
    befcommand: tmemodialogedit;

    // fred compiler
    ttabpage66: ttabpage;
    compilerusedgrid: twidgetgrid;
    compmakeon: tbooleanedit;
    compbuildon: tbooleanedit;
    compmake1on: tbooleanedit;
    compmake2on: tbooleanedit;
    compmake3on: tbooleanedit;
    compmake4on: tbooleanedit;
    compmake5on: tbooleanedit;
    compmake6on: tbooleanedit;
    compmake7on: tbooleanedit;
    compmake8on: tbooleanedit;
    compmake9on: tbooleanedit;
    compmake0on: tbooleanedit;
    compcommand: tmemodialogedit;


    // fred debugger
    ttabpage77: ttabpage;
    debuggerusedgrid: twidgetgrid;
    debmakeon: tbooleanedit;
    debbuildon: tbooleanedit;
    debmake1on: tbooleanedit;
    debmake2on: tbooleanedit;
    debmake3on: tbooleanedit;
    debmake4on: tbooleanedit;
    debmake5on: tbooleanedit;
    debmake6on: tbooleanedit;
    debmake7on: tbooleanedit;
    debmake8on: tbooleanedit;
    debmake9on: tbooleanedit;
    debmake0on: tbooleanedit;
    debcommand: tmemodialogedit;

    // fred exe extension
    ttabpage88: ttabpage;
    exeextgrid: twidgetgrid;
    exemakeon: tbooleanedit;
    exebuildon: tbooleanedit;
    exemake1on: tbooleanedit;
    exemake2on: tbooleanedit;
    exemake3on: tbooleanedit;
    exemake4on: tbooleanedit;
    exemake5on: tbooleanedit;
    exemake6on: tbooleanedit;
    exemake7on: tbooleanedit;
    exemake8on: tbooleanedit;
    exemake9on: tbooleanedit;
    exemake0on: tbooleanedit;
    exeused: tmemodialogedit;

    aftcommandgrid: twidgetgrid;
    aftmakeon: tbooleanedit;
    aftbuildon: tbooleanedit;
    aftmake1on: tbooleanedit;
    aftmake2on: tbooleanedit;
    aftmake3on: tbooleanedit;
    aftmake4on: tbooleanedit;
    aftmake5on: tbooleanedit;
    aftmake6on: tbooleanedit;
    aftmake7on: tbooleanedit;
    aftmake8on: tbooleanedit;
    aftmake9on: tbooleanedit;
    aftmake0on: tbooleanedit;
    aftcommand: tmemodialogedit;
    ttabpage19: ttabpage;
    twidgetgrid5: twidgetgrid;
    codetemplatedirs: tfilenameeditx;
    nogdbserverexit: tbooleanedit;
    ttabpage20: ttabpage;
    settingseditor: tbooleanedit;
    settingsautoload: tbooleanedit;
    settingsautosave: tbooleanedit;
    tlayouter6: tlayouter;
    savebu: TButton;
    loadbu: TButton;
    settingsfile: tfilenameeditx;
    settingsdebugger: tbooleanedit;
    settingsstorage: tbooleanedit;
    settingsprojecttree: tbooleanedit;
    nodebugbeginend: tbooleanedit;
    toolmessages: tbooleanedit;
    settty: tbooleanedit;
    gdbservertty: tbooleanedit;
    tsplitter9: tsplitter;
    beforerun: tfilenameeditx;
    afterload: tfilenameeditx;
    gdbserverstartonce: tbooleanedit;
    ttabpage21: ttabpage;
    formatmacrogrid: twidgetgrid;
    formatmacronames: tstringedit;
    formatmacrovalues: tstringedit;
    colorerror: tcoloredit;
    colorwarning: tcoloredit;
    colornote: tcoloredit;
    xtermcommand: tmemodialogedit;
    tlayouter14: tlayouter;
    rightmarginon: tbooleanedit;
    linenumberson: tbooleanedit;
    stripmessageesc: tbooleanedit;
    raiseonbreak: tbooleanedit;
    runcommand: tfilenameeditx;
    sourcebase: tfilenameeditx;
    tspacer7: tspacer;
    gdbloadtimeout: trealedit;
    toolshortcuts: tenumedit;
    toolsc: tstringedit;
    toolscalt: tstringedit;
    editmarkbrackets: tbooleanedit;
    fpcgdbworkaround: tbooleanedit;
    twidgetgrid6: twidgetgrid;
    syntaxdeffile: tfilenameeditx;
    syntaxdeffilemask: tmemodialogedit;
    editmarkpairwords: tbooleanedit;
    tlayouter15: tlayouter;
    encoding: tenumedit;
    pairmarkcolor: tcoloredit;
    statementcolor: tcoloredit;
    scrollheight: tintegeredit;
    rightmarginchars: tintegeredit;
    componenthints: tbooleanedit;
    tgroupbox1: tgroupbox;
    noformdesignerdocking: tbooleanedit;
    moveonfirstclick: tbooleanedit;
    gridsizey: tintegeredit;
    gridsizex: tintegeredit;
    tintegeredit2: tintegeredit;
    snaptogrid: tbooleanedit;
    showgrid: tbooleanedit;
    tgroupbox2: tgroupbox;
    fpgdesignerenabled: tbooleanedit;

    ttabpage22: ttabpage;
    comment_M: tmemodialogedit;
    comment_B: tmemodialogedit;
    comment_1: tmemodialogedit;
    comment_2: tmemodialogedit;
    comment_3: tmemodialogedit;
    comment_4: tmemodialogedit;
    comment_5: tmemodialogedit;
    comment_6: tmemodialogedit;
    comment_7: tmemodialogedit;
    comment_8: tmemodialogedit;
    comment_0: tmemodialogedit;
    comment_9: tmemodialogedit;

    ///////////////

    ttabpage23: ttabpage;
    tabdesigners: ttabpage;
    project_comment: tmemoedit;
    project_creator: tstringedit;
    project_copyright: tstringedit;
    project_license: tstringedit;
    project_name: tstringedit;
    project_date: tstringedit;
    eolstyle: tenumtypeedit;

    showconsole: tbooleanedit;
    enablepurpose: tbooleanedit;
    messageoutputfile: tfilenameeditx;
    trimtrailingwhitespace: tbooleanedit;
    autoindent: tbooleanedit;
    enablesource: tbooleanedit;
    tabindent: tbooleanedit;
    spacetabs: tbooleanedit;
    showtabs: tbooleanedit;
    editfontantialiased: tbooleanedit;
    backupfilecount: tintegeredit;
    tabstops: tintegeredit;
    blockindent: tintegeredit;
    editfontextraspace: tintegeredit;
    editfontwidth: tintegeredit;
    editfontheight: tintegeredit;
    editfontname: tstringedit;
    editbkcolor: tcoloredit;
    editfontcolor: tcoloredit;
    debugcommand: tfilenameeditx;
    debugoptions: tmemodialogedit;
    remoteconnection: tstringedit;
   colorhint: tcoloredit;
    procedure acttiveselectondataentered(const Sender: TObject);
    procedure colonshowhint(const Sender: tdatacol; const arow: integer; var info: hintinfoty);
    procedure hintexpandedmacros(const Sender: TObject; var info: hintinfoty);
    procedure selectactiveonrowsmoved(const Sender: tcustomgrid; const fromindex: integer; const toindex: integer; const acount: integer);
    procedure expandfilename(const Sender: TObject; var avalue: mseString; var accept: Boolean);
    procedure showcommandlineonexecute(const Sender: TObject);
    procedure signameonsetvalue(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure signumonsetvalue(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure signumtoonsetvalue(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure fontondataentered(const Sender: TObject);
    procedure makepageonchildscaled(const Sender: TObject);
    procedure debuggerlayoutexe(const Sender: TObject);
    procedure macronchildscaled(const Sender: TObject);
    procedure formtemplateonchildscaled(const Sender: TObject);
    procedure encodingsetvalue(const Sender: TObject; var avalue: integer; var accept: Boolean);
    procedure createexe(const Sender: TObject);
    procedure drawcol(const Sender: tpointeredit; const acanvas: tcanvas; const avalue: Pointer; const arow: integer);
    procedure colsetvalue(const Sender: TObject; var avalue: colorty; var accept: Boolean);
    procedure copycolorcode(const Sender: TObject);
    procedure downloadchange(const Sender: TObject);
    procedure processorchange(const Sender: TObject);
    procedure copymessagechanged(const Sender: TObject);
    procedure updatedebugenabled(const Sender: TObject);
    procedure newprojectchildscaled(const Sender: TObject);
    procedure saveexe(const Sender: TObject);
    procedure settingsdataent(const Sender: TObject);
    procedure loadexe(const Sender: TObject);
    //   procedure extconschangeexe(const sender: TObject);
    procedure setxtermcommandexe(const Sender: TObject; var avalue: msestring; var accept: Boolean);
    procedure activateonbreakset(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
    procedure sourcedirhint(const Sender: TObject; var info: hintinfoty);
    procedure toolshortcutdropdown(const Sender: TObject);
    procedure toolsrowdatachanged(const Sender: tcustomgrid; const acell: gridcoordty);
    procedure bracketbkcolhint(const Sender: TObject; var info: hintinfoty);
    procedure initeolstyleexe(const Sender: tenumtypeedit);

    procedure onshowpurpose(const Sender: TObject; var avalue: Boolean; var accept: Boolean);

    procedure onsource(const Sender: TObject; var avalue: Boolean; var accept: Boolean);

    procedure oncellevext(const Sender: TObject; var info: celleventinfoty);
    procedure oncellevcomp(const Sender: TObject; var info: celleventinfoty);
    procedure oncellevdeb(const Sender: TObject; var info: celleventinfoty);

    procedure onfocus(const Sender: TObject);
    procedure oncreated(const Sender: TObject);
    procedure setlangprojectoptions();

  private
    procedure activegroupchanged;
  end;

function readprojectoptions(const filename: filenamety): Boolean;
//true if ok
procedure saveprojectoptions(filename: filenamety = '');
procedure initprojectoptions;
function editprojectoptions: Boolean;
//true if not aborted
function getprojectmacros: macroinfoarty;
procedure expandprojectmacros;
function expandprmacros(const atext: msestring): msestring;
procedure expandprmacros1(var atext: msestring);
function projecttemplatedir: filenamety;
function languagedir: filenamety;
function projectfiledialog(var aname: filenamety; save: Boolean): modalresultty;
procedure projectoptionsmodified;
function checkprojectloadabort: Boolean; //true on load abort

function getsigname(const anum: integer): string;
procedure projectoptionstofont(const afont: tfont);
function objpath(const aname: filenamety): filenamety;
function sourcepath(const aname: filenamety): filenamety;
function gettargetfile: filenamety;
function getmacros: tmacrolist;
procedure hintmacros(const Sender: tcustomedit; var info: hintinfoty);

var
  projectoptions: projectoptionsty;
  projecthistory: filenamearty;
  windowlayoutfile: filenamety;
  windowlayouthistory: filenamearty;
  codetemplates: tcodetemplates;
  isloaded: Boolean = False;

implementation

uses
  confideu,
  dialogfiles,
  commandorform,
  projectoptionsform_mfm,
  breakpointsform,
  sourceform,
  msereal,
  objectinspector,
  msebits,
  msefileutils,
  msedesignintf,
  guitemplates,
  watchform,
  stackform,
  main,
  projecttreeform,
  findinfileform,
  selecteditpageform,
  programparametersform,
  sourceupdate,
  mseimagelisteditor,
  msesysenvmanagereditor,
  targetconsole,
  actionsmodule,
  mseactions,
  msefilemacros,
  mseenvmacros,
  msemacmacros,
  mseexecmacros,
  msestrmacros,
  msedesigner,
  panelform,
  watchpointsform,
  commandlineform,
  messageform,
  componentpaletteform,
  ideusettings,
  formdesigner,
  msestringlisteditor,
  msetexteditor,
  msepropertyeditors,
  mseshapes,
  componentstore,
  cpuform,
  msesysutils,
  msecomptree,
  msefont,
  typinfo
 {$ifndef mse_no_db}{$ifdef FPC},
  msedbfieldeditor{$endif}{$endif}
 {$ifndef mse_no_ifi}{$ifdef FPC},
  mseificomponenteditors,
  mseififieldeditor{$endif}{$endif};

var
  projectoptionsfo: tprojectoptionsfo;
  fo: tprojectoptionsfo;

const
  firstsiginfocomment = c_sighup;
  lastsiginfocomment  = c_sigpwr;

type
  signalinfoty = record
    num: integer;
    flags: sigflagsty;
    Name: string;
    comment: string;
  end;

const
  findinfiledialogstatname = 'findinfiledialogfo.sta';
  finddialogstatname = 'finddialogfo.sta';
  replacedialogstatname = 'replacedialogfo.sta';
  optionsstatname = 'optionsfo.sta';
  settaborderstatname = 'settaborderfo.sta';
  setcreateorderstatname = 'setcreateorderfo.sta';
  programparametersstatname = 'programparametersfo.sta';
  settingsstatname = 'settingsfo.sta';
  printerstatname = 'printer.sta';
  imageselectorstatname = 'imageselector.sta';
  fadeeditorstatname = 'fadeeditor.sta';
  codetemplateselectstatname = 'templselect.sta';
  codetemplateparamstatname = 'templparam.sta';
  codetemplateeditstatname = 'templedit.sta';

  siginfocount = 30;

var
  siginfos: array[0..siginfocount - 1] of signalinfoty = ((num: 1; flags: [sfl_stop]; Name: 'SIGHUP'; comment: 'Hangup'), (num: 2; flags: [sfl_stop, sfl_internal, sfl_handle]; Name: 'SIGINT';
    comment: 'Interrupt'), (num: 3; flags: [sfl_stop]; Name: 'SIGQUIT'; comment: 'Quit'), (num: 4; flags: [sfl_stop]; Name: 'SIGILL'; comment: 'Illegal instruction'), (num: 5;
    flags: [sfl_stop, sfl_internal, sfl_handle]; Name: 'SIGTRAP'; comment: 'Trace trap'), (num: 6; flags: [sfl_stop]; Name: 'SIGABRT'; comment: 'Abort'), (num: 7; flags: [sfl_stop]; Name: 'SIGBUS';
    comment: 'BUS error'), (num: 8; flags: [sfl_stop]; Name: 'SIGFPE'; comment: 'Floating-point exception'), (num: 9; flags: [sfl_stop]; Name: 'SIGKILL'; comment: 'Kill, unblockable'), (num: 10;
    flags: [sfl_stop]; Name: 'SIGUSR1'; comment: 'User-defined signal 1'), (num: 11; flags: [sfl_stop]; Name: 'SIGSEGV'; comment: 'Segmentation violation'), (num: 12; flags: [sfl_stop]; Name: 'SIGUSR2';
    comment: 'User-defined signal 2'), (num: 13; flags: [sfl_stop]; Name: 'SIGPIPE'; comment: 'Broken pipe'), (num: 14; flags: [sfl_internal]; Name: 'SIGALRM'; comment: 'Alarm clock'), (num: 15;
    flags: [sfl_stop]; Name: 'SIGTERM'; comment: 'Termination'), (num: 16; flags: [sfl_stop]; Name: 'SIGSTKFLT'; comment: 'Stack fault'), (num: 17; flags: [{sfl_stop}]; Name: 'SIGCHLD';
    comment: 'Child status has changed'), (num: 18; flags: [sfl_stop]; Name: 'SIGCONT'; comment: 'Continue'), (num: 19; flags: [sfl_stop]; Name: 'SIGSTOP'; comment: 'Stop, unblockable'), (num: 20;
    flags: [sfl_stop]; Name: 'SIGTSTP'; comment: 'Keyboard stop'), (num: 21; flags: [sfl_stop]; Name: 'SIGTTIN'; comment: 'Background read from tty'), (num: 22; flags: [sfl_stop]; Name: 'SIGTTOU';
    comment: 'Background write to tty'), (num: 23; flags: [sfl_stop]; Name: 'SIGURG'; comment: 'Urgent condition on socket'), (num: 24; flags: [sfl_stop]; Name: 'SIGXCPU'; comment: 'CPU limit exceeded'), (num: 25;
    flags: [sfl_stop]; Name: 'SIGXFSZ'; comment: 'File size limit exceeded'), (num: 26; flags: [sfl_stop]; Name: 'SIGTALRM'; comment: 'Virtual alarm clock'), (num: 27; flags: [sfl_stop];
    Name: 'SIGPROF'; comment: 'Profiling alarm clock'), (num: 28; flags: [sfl_stop]; Name: 'SIGWINCH'; comment: 'Window size change'), (num: 29; flags: [sfl_stop]; Name: 'SIGIO';
    comment: 'I/O now possible'), (num: 30; flags: [sfl_stop]; Name: 'SIGPWR'; comment: 'Power failure restart'));

function getsigname(const anum: integer): string;
var
  int1: integer;
begin
  Result   := '';
  for int1 := 0 to high(siginfos) do
    if siginfos[int1].num = anum then
    begin
      Result := siginfos[int1].Name;
      break;
    end;
  if Result = '' then
    Result := 'SIG' + IntToStr(anum);
end;

function objpath(const aname: filenamety): filenamety;
begin
  Result   := '';
  if aname <> '' then
    Result := filepath(projectoptions.o.texp.makedir, aname);
end;

function sourcepath(const aname: filenamety): filenamety;
begin
  Result := '';
  if aname <> '' then
    if projectoptions.d.t.sourcebase <> '' then
      Result := filepath(projectoptions.d.texp.sourcebase, aname)
    else
      Result := objpath(aname);
end;

function getprojectmacros: macroinfoarty;
var
  int1, int2: integer;
begin
  Result := nil;
  setlength(Result, 6);
  with projectoptions, o do
  begin
    with Result[0] do
    begin
      Name  := 'PROJECTNAME';
      Value := removefileext(filename(projectfilename));
    end;
    with Result[1] do
    begin
      Name  := 'PROJECTDIR';
      Value := tosysfilepath(getcurrentdirmse) + pathdelim;
    end;
    with Result[2] do
    begin
      Name    := 'MAINFILE';
      if projectoptionsfo = nil then
        Value := t.mainfile
      else
        Value := projectoptionsfo.mainfile.Value;
    end;
    with Result[3] do
    begin
      Name    := 'TARGETFILE';
      if projectoptionsfo = nil then
        Value := t.targetfile
      else
        Value := projectoptionsfo.targetfile.Value;
    end;
    with Result[4] do
    begin
      Name := 'TARGETENV';
      int2 := high(envvarons);
      if int2 > high(d.t.envvarnames) then
        int2 := high(d.t.envvarnames);
      if int2 > high(d.t.envvarvalues) then
        int2   := high(d.t.envvarvalues);
      for int1 := 0 to int2 do
        if envvarons[int1] then
          Value := Value + d.t.envvarnames[int1] + '=' + d.t.envvarvalues[int1] + ' '
        else
          Value := Value + '--unset=' + d.t.envvarnames[int1] + ' ';
    end;
    with Result[5] do
    begin
      Name  := 'TARGETPARAMS';
      Value := d.t.progparameters;
    end;
  end;
  Result := initmacros([Result, macmacros, filemacros, envmacros, execmacros,
    strmacros]);
end;

procedure hintmacros(const Sender: tcustomedit; var info: hintinfoty);
begin
  info.Caption := tcustomedit(Sender).Text;
  expandprmacros1(info.Caption);
  include(info.flags, hfl_show); //show empty caption
end;

function gettargetfile: filenamety;
var
  strtarget, strexecext: msestring;
  int1, inttypecomp: integer;
begin

  with projectoptions, o, texp do
    for int1 := 0 to high(compilerused) do
      if (mainfo.thetag and compilerusedon[int1] <> 0) then
        if system.pos('Default', compilerused[int1]) > 0 then
          inttypecomp := 1
        else if system.pos('Pascal', compilerused[int1]) > 0 then
          inttypecomp := 1
        else if system.pos('Java', compilerused[int1]) > 0 then
          inttypecomp := 2
        else if system.pos('C ', compilerused[int1]) > 0 then
          inttypecomp := 3
        else if system.pos('Python', compilerused[int1]) > 0 then
          inttypecomp := 4;

  strexecext := '${EXEEXT}';
  expandprmacros1(strexecext);

  strtarget := (projectoptions.o.texp.targetfile);
  int1      := system.pos('${EXEEXT}', uppercase(strtarget));
  if int1 > 0 then
    strtarget := system.copy(strtarget, 0, int1 - 1);

  if int1 = 0 then
    int1      := system.pos(uppercase(strexecext), uppercase(strtarget));
  if int1 > 0 then
    strtarget := system.copy(strtarget, 0, int1 - 1);

  // writeln(projectoptions.o.texp.targetfile);

  strexecext := '';

  if (inttypecomp = 2) then
    strexecext := '.java'
  else if (inttypecomp = 4) then
    strexecext := '.pyw'
  else
    with projectoptions, o, texp do
      for int1 := 0 to high(exeused) do
        if (mainfo.thetag and exeusedon[int1] <> 0) then
          if (pos('Default', exeused[int1]) > 0) or
            (trim(exeused[int1]) = '${EXEEXT}') then
          begin
            strexecext := '${EXEEXT}';
            expandprmacros1(strexecext);
          end
          else if (trim(exeused[int1]) = 'No Extension') or
            (trim(exeused[int1]) = '') then
            strexecext := ''
          else
            strexecext := trim(exeused[int1]);


  with projectoptions, d.texp do
    if trim(debugtarget) <> '' then
      Result := objpath(debugtarget)
    else
      Result := objpath(strtarget + strexecext)//o.texp.targetfile
  ;
end;

procedure projectoptionstofont(const afont: tfont);
begin
  with projectoptions, afont do
  begin
    Name       := ansistring(e.editfontname);
    Height     := e.editfontheight;
    Width      := e.editfontwidth;
    extraspace := e.editfontextraspace;
    if e.editfontantialiased then
      options := options + [foo_antialiased2]
    else
      options := options + [foo_nonantialiased];
    color     := e.editfontcolor;
  end;
end;

function checkprojectloadabort: Boolean;
begin
  Result := False;
  if exceptobject is Exception then
  begin
    if ShowMessage(msestring(Exception(exceptobject).Message),
      uppercase(lang_stockcaption[ord(sc_Error)]), [mr_skip, mr_cancel]) <> mr_skip then
      Result := True;
  end
  else
    raise Exception.Create(ansistring(lang_actionsmodule[ord(ac_invalidexception)]));
end;

function projectfiledialog(var aname: filenamety; save: Boolean): modalresultty;
begin
  with mainfo.projectfiledia.controller do
  begin
    showoptions := True;
    icon        := mainfo.icon;
    captionopen := lang_xstockcaption[ord(sc_openproject)];
    captionsave := lang_xstockcaption[ord(sc_saveas)];
    fontheight := mainfo.font.Height;   // font height of dialogfile
    fontname   := msestring(mainfo.font.Name);       // font name of dialogfile
    fontcolor  := mainfo.font.color;    // font color of dialogfile
    filename   := projectoptions.projectfilename;
    history    := projecthistory;
    if save then
      Result := Execute(fdk_save, [fdo_save, fdo_checkexist])
    else
      Result       := Execute(fdk_open, [fdo_checkexist]);
    aname          := filename;
    projecthistory := history;
  end;
end;

function getmacros: tmacrolist;
var
  ar1: macroinfoarty;
  int1, int2: integer;
  mask: integer;
begin
  with projectoptions.o do
  begin
    Result := tmacrolist.Create([mao_caseinsensitive]);
    Result.add(getsettingsmacros);
    Result.add(getcommandlinemacros);
    Result.add(getprojectmacros);
    mask := bits[macrogroup];
    setlength(fmacrovalues, length(macronames));
    setlength(ar1, length(macronames)); //max
    int2 := 0;
    for int1 := 0 to high(ar1) do
      if macroon[int1] and mask <> 0 then
      begin
        ar1[int2].Name  := macronames[int1];
        ar1[int2].Value := macrovalues[int1];
        Inc(int2);
      end;
    setlength(ar1, int2);
    Result.add(ar1);
  end;
end;


procedure expandprmacros1(var atext: msestring);
var
  li: tmacrolist;
begin
  li := getmacros;
  li.expandmacros1(atext);
  li.Free;
end;

function projecttemplatedir: filenamety;
begin
  Result := expandprmacros('${TEMPLATEDIR}');
end;

function languagedir: filenamety;
begin
  Result := expandprmacros('${LANGDIR}');
end;


function expandprmacros(const atext: msestring): msestring;
begin
  Result := atext;
  expandprmacros1(Result);
end;

var
  initfontaliascount: integer;

procedure expandprojectmacros;
var
  li: tmacrolist;
  int1, int2: integer;
  bo1: Boolean;
  item1: tmenuitem;
  act1: taction;
begin
  li := getmacros;
  with projectoptions do
  begin
    o.expandmacros(li);
    e.expandmacros(li);
    d.expandmacros(li);
    with o, texp do
    begin
      if initfontaliascount = 0 then
        initfontaliascount := fontaliascount;
      setfontaliascount(initfontaliascount);
      int2 := high(fontalias);
      int1 := high(fontancestors);
      setlength(ffontancestors, int2 + 1); //additional field
      for int1 := int1 + 1 to int2 do
        fontancestors[int1] := 'sft_default';
      if int2 > high(fontnames) then
        int2   := high(fontnames);
      if int2 > high(fontheights) then
        int2   := high(fontheights);
      if int2 > high(fontwidths) then
        int2   := high(fontwidths);
      if int2 > high(fontoptions) then
        int2   := high(fontoptions);
      if int2 > high(fontxscales) then
        int2   := high(fontxscales);
      for int1 := 0 to int2 do
        try
          registerfontalias(ansistring(fontalias[int1]),
            ansistring(fontnames[int1]), fam_overwrite,
            fontheights[int1], fontwidths[int1],
            fontoptioncharstooptions(ansistring(fontoptions[int1])),
            fontxscales[int1], ansistring(fontancestors[int1]));
        except
          application.handleexception;
        end;
      if sourceupdater <> nil then
        sourceupdater.maxlinelength := e.rightmarginchars;
      fontaliasnames := fontalias;
      with sourcefo.syntaxpainter do
      begin
        bo1 := not cmparray(defdefs.asarraya, e.texp.sourcefilemasks) or not cmparray(defdefs.asarrayb, e.texp.syntaxdeffiles);
        defdefs.asarraya := e.texp.sourcefilemasks;
        defdefs.asarrayb := e.texp.syntaxdeffiles;
        if bo1 then
        begin
          sourcefo.syntaxpainter.Clear;
          try
            for int1 := 0 to sourcefo.Count - 1 do
              sourcefo.items[int1].edit.setsyntaxdef(sourcefo.items[int1].edit.filename);
          except
            application.handleexception;
          end;
        end;
      end;
      for int1 := 0 to sourcefo.Count - 1 do
        sourcefo.items[int1].updatestatvalues;
      with mainfo.openfile.controller.filterlist do
      begin
        asarraya := e.texp.filemasknames;
        asarrayb := e.texp.filemasks;
      end;
      mainfo.openfile.controller.icon := mainfo.icon;
      item1 := mainfo.mainmenu1.menu.itembynames(['file', 'new', 'msegui']);
      //  item1:= mainfo.mainmenu1.menu.itembynames(['file','new']);
      item1.submenu.Count := 1;
      item1.submenu.Count := length(newfinames) + 1;
      for int1 := 0 to high(newfinames) do
        with item1.submenu[int1 + 1] do
        begin
          Caption   := newfinames[int1];
          tag       := int1;
          onexecute :=
{$ifdef FPC}
            @
{$endif}
            mainfo.newfileonexecute;
        end;

      item1 := mainfo.mainmenu1.menu.itembynames(['file', 'new', 'msegui', 'form']);
      item1.submenu.Count := 0;
      item1.submenu.Count := length(newfonames) + 1;
      int2  := 0;
      for int1 := 0 to high(newfonames) do
        if not newinheritedforms[int1] then
        begin
          with item1.submenu[int2] do
          begin
            Caption   := newfonames[int1];
            tag       := int1;
            onexecute :=
{$ifdef FPC}
              @
{$endif}
              mainfo.newformonexecute;
          end;
          Inc(int2);
        end;
      item1.submenu[int2].options := [mao_separator];
      Inc(int2);
      for int1 := 0 to high(newfonames) do
        if newinheritedforms[int1] then
        begin
          with item1.submenu[int2] do
          begin
            Caption   := newfonames[int1];
            tag       := int1;
            onexecute :=
{$ifdef FPC}
              @
{$endif}
              mainfo.newformonexecute;
          end;
          Inc(int2);
        end;
      with mainfo.mainmenu1.menu.submenu do
      begin
        item1 := itembyname('tools');
        if toolmenus <> nil then
        begin
          if item1 = nil then
          begin
            item1         := tmenuitem.Create;
            item1.Name    := 'tools';
            item1.Caption := lang_actionsmodule[ord(ac_tools)];
            insert(itemindexbyname('settings'), item1);
          end;
          with item1.submenu do
          begin
            Clear;
            for int1 := 0 to high(toolmenus) do
            begin
              if (int1 > high(toolfiles)) or (int1 > high(toolparams)) then
                break;
              int2 := insert(bigint, [toolmenus[int1]],
                [[mao_asyncexecute, mao_shortcutcaption]],
                [], [
{$ifdef FPC}
                @
{$endif}
                mainfo.runtool]);
              if (int1 <= high(toolshortcuts)) and
                actionsmo.gettoolshortcutaction(toolshortcuts[int1], act1) then
                with items[int2] do
                begin
                  shortcuts  := act1.shortcuts;
                  shortcuts1 := act1.shortcuts1;
                end;
            end;
          end;
        end
        else if item1 <> nil then
          Delete(item1.index);
      end;
    end;
    ignoreexceptionclasses := nil;
    for int1 := 0 to high(d.exceptignore) do
    begin
      if int1 > high(d.exceptclassnames) then
        break;
      if d.exceptignore[int1] then
        additem(ignoreexceptionclasses, ansistring(d.exceptclassnames[int1]));
    end;
    for int1 := 0 to usercolorcount - 1 do
    begin
      if int1 > high(o.usercolors) then
        break;
      setcolormapvalue(cl_user + longword(int1), o.usercolors[int1]);
    end;
    clearformatmacros;
    for int1 := 0 to high(o.formatmacronames) do
    begin
      if int1 > high(o.formatmacrovalues) then
        break;
      formatmacros.add(o.formatmacronames[int1], o.formatmacrovalues[int1], []);
    end;

    codetemplates.scan(o.texp.codetemplatedirs);
  end;
  li.Free;
  mainfo.updatesigsettings;
end;

function defaultsigsettings: sigsetinfoarty;
var
  int1, int2: integer;
begin
  Result := nil;
  setlength(Result, siginfocount);
  int2   := 0;
  for int1 := 0 to siginfocount - 1 do
    with Result[int2] do
      if not (sfl_internal in siginfos[int1].flags) then
      begin
        num   := siginfos[int1].num;
        numto := num;
        flags := siginfos[int1].flags;
        Inc(int2);
      end;
  setlength(Result, int2);
end;

procedure initpr(const expand: Boolean);
const
  alloptionson = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048;
  unitson      = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + $10000;
  compileron   = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + $10000;
  debuggeron   = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + $10000;
  exeon        = 1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256 + 512 + 1024 + 2048 + $10000;
  allon        = unitson + $20000 + $40000;
var
  int1: integer;
begin
  projectoptions.o.Free;
  projectoptions.e.Free;
  projectoptions.d.Free;
  codetemplates.Clear;
  finalize(projectoptions);
  fillchar(projectoptions, sizeof(projectoptions), 0);
  projectoptions.o := tprojectoptions.Create;
  projectoptions.e := teditoptions.Create;
  projectoptions.d := tdebugoptions.Create;
  with projectoptions, o, t do
  begin
    if expand then
    begin
      deletememorystatstream(findinfiledialogstatname);
      deletememorystatstream(finddialogstatname);
      deletememorystatstream(replacedialogstatname);
      deletememorystatstream(optionsstatname);
      deletememorystatstream(settaborderstatname);
      deletememorystatstream(setcreateorderstatname);
      deletememorystatstream(programparametersstatname);
      deletememorystatstream(printerstatname);
      deletememorystatstream(imageselectorstatname);
      deletememorystatstream(stringlisteditorstatname);
      deletememorystatstream(texteditorstatname);
      deletememorystatstream(colordialogstatname);
      deletememorystatstream(compnamedialogstatname);
      deletememorystatstream(bmpfiledialogstatname);
      deletememorystatstream(fadeeditorstatname);
      deletememorystatstream(codetemplateselectstatname);
      deletememorystatstream(codetemplateparamstatname);
      deletememorystatstream(codetemplateeditstatname);
   {$ifndef mse_no_db}{$ifdef FPC}
      deletememorystatstream(dbfieldeditorstatname);
   {$endif}{$endif}
   {$ifndef mse_no_ifi}{$ifdef FPC}
      deletememorystatstream(ificlienteditorstatname);
      deletememorystatstream(ififieldeditorstatname);
   {$endif}{$endif}
      modified    := False;
      savechecked := False;
      findreplaceinfo.find.options := [so_caseinsensitive];
      targetconsolefindinfo.options := [so_caseinsensitive];
    end;
    sigsettings := defaultsigsettings;
    ignoreexceptionclasses := nil;

    // fred compiler
    with projectoptions, o, t do
    begin
      additem(fcompilerused, '${COMPILER} (Default)');
      additem(fcompilerused, 'Pascal 1');
      additem(fcompilerused, 'Pascal 2');
      additem(fcompilerused, 'Pascal 3');
      additem(fcompilerused, 'Pascal 4');
      additem(fcompilerused, 'Pascal 5');
      additem(fcompilerused, 'Pascal 6');
      additem(fcompilerused, 'Pascal 7');
      additem(fcompilerused, 'Pascal 8');
      additem(fcompilerused, 'C 1');
      additem(fcompilerused, 'C 2');
      additem(fcompilerused, 'C 3');
      additem(fcompilerused, 'C 4');
      additem(fcompilerused, 'C 5');
      additem(fcompilerused, 'C 6');
      additem(fcompilerused, 'C 7');
      additem(fcompilerused, 'C 8');
      additem(fcompilerused, 'Java 1');
      additem(fcompilerused, 'Java 2');
      additem(fcompilerused, 'Java 3');
      additem(fcompilerused, 'Java 4');
      additem(fcompilerused, 'Python 1');
      additem(fcompilerused, 'Python 2');
      additem(fcompilerused, 'Python 3');
      additem(fcompilerused, 'Python 4');
      additem(fcompilerused, 'Other 1');
      additem(fcompilerused, 'Other 2');
      additem(fcompilerused, 'Other 3');
      additem(fcompilerused, 'Other 4');
      setlength(fcompilerusedon, length(fcompilerused));
    end;
    fcompilerusedon[0] := compileron;

    // fred debugger
    with projectoptions, o, t do
    begin
      additem(fdebuggerused, '${DEBUGGER} (Default)');
      additem(fdebuggerused, 'Debugger 1');
      additem(fdebuggerused, 'Debugger 2');
      additem(fdebuggerused, 'Debugger 3');
      additem(fdebuggerused, 'Debugger 4');
      additem(fdebuggerused, 'None');

      setlength(fdebuggerusedon, length(fdebuggerused));
    end;
    fdebuggerusedon[0] := debuggeron;


    // fred exe ext
    //{
    with projectoptions, o, t do
    begin
      additem(fexeused, '${EXEEXT} (Default)');
      additem(fexeused, 'No Extension');
      additem(fexeused, '.exe');
      additem(fexeused, '.com');
      additem(fexeused, '.bin');
      additem(fexeused, '.prog');
      additem(fexeused, '.pyc');
      additem(fexeused, '.class');
      additem(fexeused, '.java');
      additem(fexeused, '.so');
      additem(fexeused, '.dll');
      additem(fexeused, '.lib');
      additem(fexeused, '.o');
      additem(fexeused, '.res');
      additem(fexeused, '.inf');
      setlength(fexeusedon, length(fexeused));
    end;
    fexeusedon[0] := exeon;
    //}

    additem(fmakeoptions, '-l -Mobjfpc -Sh -Fcutf8');
    additem(fmakeoptions, '-gl -O-');
    additem(fmakeoptions, '-B');
    additem(fmakeoptions, '-FUunits');
    additem(fmakeoptions, '-O2 -XX -CX -Xs');
    setlength(fmakeoptionson, length(fmakeoptions));
    for int1 := 0 to high(fmakeoptionson) do
      fmakeoptionson[int1] := alloptionson;
    fmakeoptionson[2] := alloptionson and not bits[5];
    //all but make 4
    fmakeoptionson[3] := bits[1] or bits[5]; //build + make 4
    fmakeoptionson[4] := bits[5]; //make 4
    // fmakeoptionson[4]:= bits[6]; //make 5
    // fmakeoptionson[5]:= bits[7]; //make 6
    // fmakeoptionson[6]:= bits[8]; //make 7
    // fmakeoptionson[7]:= bits[9]; //make 8
    // fmakeoptionson[8]:= bits[10]; //make 9
    defaultmake := 1; //make
    additem(funitdirs, '${MSELIBDIR}*/');
    //  additem(funitdirs,'${MSELIBDIR}kernel/');
    additem(funitdirs, '${MSELIBDIR}kernel/$TARGETOSDIR/');
    setlength(funitdirson, length(unitdirs));
    for int1 := 0 to high(funitdirson) do
      funitdirson[int1] := unitson;
    //  funitdirson[1]:= unitson + $20000; //kernel include
    unitdirs    := reversearray(unitdirs);
    unitdirson  := reversearray(unitdirson);
    unitpref    := '-Fu';
    incpref     := '-Fi';
    libpref     := '-Fl';
    objpref     := '-Fo';
    targpref    := '-o';
    makecommand := '${COMPILER}';
    setlength(fnewfinames, 3);
    setlength(fnewfifilters, 3);
    setlength(fnewfiexts, 3);
    setlength(fnewfisources, 3);
    
    
    if length(lang_actionsmodule) > 0 then
    newfinames[0]   := lang_actionsmodule[ord(ac_program)] 
    else
    newfinames[0]   := 'program';
 
    newfifilters[0] := '"*.pas" "*.pp"';
    newfiexts[0]    := 'pas';
    newfisources[0] := '${TEMPLATEDIR}/fpc_mse/default/program.pas';
    
    if length(lang_actionsmodule) > 0 then
    newfinames[1]   := lang_actionsmodule[ord(ac_unit)] 
    else
    newfinames[1]   := 'unit';
 
    newfifilters[1] := '"*.pas" "*.pp"';
    newfiexts[1]    := 'pas';
    newfisources[1] := '${TEMPLATEDIR}/fpc_mse/default/unit.pas';
    
    if length(lang_actionsmodule) > 0 then
    newfinames[2]   := lang_actionsmodule[ord(ac_textfile)] 
    else
    newfinames[2]   := 'textfile';
 
    newfifilters[2] := '';
    newfiexts[2]    := '';
    newfisources[2] := '';

    setlength(fnewfonames, 11);
    setlength(fnewfonamebases, 11);
    setlength(fnewinheritedforms, 11);
    setlength(fnewfosources, 11);
    setlength(fnewfoforms, 11);
    
    if length(lang_actionsmodule) > 0 then
    newfonames[0]        := lang_actionsmodule[ord(ac_mainform)]
    else
    newfonames[0]   := 'mainform';
   
    newfonamebases[0]    := 'form';
    newinheritedforms[0] := False;
    newfosources[0]      := '${TEMPLATEDIR}fpc_mse/default/mainform.pas';
    newfoforms[0]        := '${TEMPLATEDIR}fpc_mse/default/mainform.mfm';

    if length(lang_actionsmodule) > 0 then
    newfonames[1]        := lang_actionsmodule[ord(ac_simpleform)]
    else
    newfonames[1]   := 'simpleform';
   
    newfonamebases[1]    := 'form';
    newinheritedforms[1] := False;
    newfosources[1]      := '${TEMPLATEDIR}fpc_mse/default/simpleform.pas';
    newfoforms[1]        := '${TEMPLATEDIR}fpc_mse/default/simpleform.mfm';

    if length(lang_actionsmodule) > 0 then
    newfonames[2]        := lang_actionsmodule[ord(ac_dockingform)]
    else
    newfonames[2]   := 'dockingform';
   
    newfonamebases[2]    := 'form';
    newinheritedforms[2] := False;
    newfosources[2]      := '${TEMPLATEDIR}fpc_mse/default/dockingform.pas';
    newfoforms[2]        := '${TEMPLATEDIR}fpc_mse/default/dockingform.mfm';

    if length(lang_actionsmodule) > 0 then
    newfonames[3]        := lang_actionsmodule[ord(ac_datamodule)]
    else
    newfonames[3]   := 'datamodule';
  
    newfonamebases[3]    := 'module';
    newinheritedforms[3] := False;
    newfosources[3]      := '${TEMPLATEDIR}fpc_mse/default/datamodule.pas';
    newfoforms[3]        := '${TEMPLATEDIR}fpc_mse/default/datamodule.mfm';

    if length(lang_actionsmodule) > 0 then
    newfonames[4]        := lang_actionsmodule[ord(ac_subform)]
    else
    newfonames[4]   := 'subform';
     
    newfonamebases[4]    := 'form';
    newinheritedforms[4] := False;
    newfosources[4]      := '${TEMPLATEDIR}fpc_mse/default/subform.pas';
    newfoforms[4]        := '${TEMPLATEDIR}fpc_mse/default/subform.mfm';

   if length(lang_actionsmodule) > 0 then
    newfonames[5]        := lang_actionsmodule[ord(ac_scrollboxform)]
    else
    newfonames[5]   := 'scrollboxform';
  
    newfonamebases[5]    := 'form';
    newinheritedforms[5] := False;
    newfosources[5]      := '${TEMPLATEDIR}fpc_mse/default/scrollboxform.pas';
    newfoforms[5]        := '${TEMPLATEDIR}fpc_mse/default/scrollboxform.mfm';

   if length(lang_actionsmodule) > 0 then
    newfonames[6]        := lang_actionsmodule[ord(ac_tabform)]
    else
    newfonames[6]   := 'tabform';
  
    newfonamebases[6]    := 'form';
    newinheritedforms[6] := False;
    newfosources[6]      := '${TEMPLATEDIR}fpc_mse/default/tabform.pas';
    newfoforms[6]        := '${TEMPLATEDIR}fpc_mse/default/tabform.mfm';

  if length(lang_actionsmodule) > 0 then
    newfonames[7]        := lang_actionsmodule[ord(ac_dockpanel)]
    else
    newfonames[7]   := 'dockpanel';
  
    newfonamebases[7]    := 'form';
    newinheritedforms[7] := False;
    newfosources[7]      := '${TEMPLATEDIR}fpc_mse/default/dockpanelform.pas';
    newfoforms[7]        := '${TEMPLATEDIR}fpc_mse/default/dockpanelform.mfm';

   if length(lang_actionsmodule) > 0 then
    newfonames[8]        := lang_actionsmodule[ord(ac_report)]
    else
    newfonames[8]   := 'report';
  
    newfonamebases[8]    := 'report';
    newinheritedforms[8] := False;
    newfosources[8]      := '${TEMPLATEDIR}fpc_mse/default/report.pas';
    newfoforms[8]        := '${TEMPLATEDIR}fpc_mse/default/report.mfm';

    if length(lang_actionsmodule) > 0 then
    newfonames[9]        := lang_actionsmodule[ord(ac_scriptform)]
    else
    newfonames[9]   := 'scriptform';
  
    newfonamebases[9]    := 'script';
    newinheritedforms[9] := False;
    newfosources[9]      := '${TEMPLATEDIR}fpc_mse/default/pascform.pas';
    newfoforms[9]        := '${TEMPLATEDIR}fpc_mse/default/pascform.mfm';

   if length(lang_actionsmodule) > 0 then
    newfonames[10]        := lang_actionsmodule[ord(ac_inheritedform)]
    else
    newfonames[10]   := 'inheritedform';
  
    newfonamebases[10]    := 'form';
    newinheritedforms[10] := True;
    newfosources[10]      := '${TEMPLATEDIR}fpc_mse/default/inheritedform.pas';
    newfoforms[10]        := '${TEMPLATEDIR}fpc_mse/default/inheritedform.mfm';

  end;
  with projectoptions, e, t do
  begin

    additem(fsourcefilemasks, '"*.pas" "*.dpr" "*.lpr" "*.pp" "*.inc"');
    additem(fsyntaxdeffiles, '${SYNTAXDEFDIR}pascal.sdef');
    additem(fsourcefilemasks, '"*.c" "*.cc" "*.h"');
    additem(fsyntaxdeffiles, '${SYNTAXDEFDIR}cpp.sdef');
    additem(fsourcefilemasks, '"*.java"');
    additem(fsyntaxdeffiles, '${SYNTAXDEFDIR}java.sdef');
    additem(fsourcefilemasks, '"*.pyw"');
    additem(fsyntaxdeffiles, '${SYNTAXDEFDIR}python.sdef');
    additem(fsourcefilemasks, '"*.mfm"');
    additem(fsyntaxdeffiles, '${SYNTAXDEFDIR}objecttext.sdef');

    if length(lang_actionsmodule) > 0 then
    additem(ffilemasknames, lang_xstockcaption[ord(sc_source)])
    else
    additem(ffilemasknames, 'source');
 
   
    additem(ffilemasks, '"*.pp" "*.pas" "*.inc" "*.dpr" "*.lpr"');
    if length(lang_actionsmodule) > 0 then
    additem(ffilemasknames, lang_xstockcaption[ord(sc_forms)])
    else
    additem(ffilemasknames, 'forms');
    
    additem(ffilemasks, '*.mfm');
  
    if length(lang_actionsmodule) > 0 then
    additem(ffilemasknames, lang_actionsmodule[ord(ac_allfiles)])
    else
    additem(ffilemasknames, 'all files');
   
    additem(ffilemasks, '*');

  end;
  with projectoptions, d, t do
  begin
    debugcommand := '${DEBUGGER}';
    gdbprocessor := 'auto';
    additem(fsourcedirs, './');
    additem(fsourcedirs, '${MSELIBDIR}*/');
    additem(fsourcedirs, '${MSELIBDIR}kernel/$TARGETOSDIR/');
    sourcedirs := reversearray(sourcedirs);
  end;
  if expand then
    expandprojectmacros;
end;

procedure initprojectoptions;
begin
  initpr(True);
end;

procedure projectoptionsmodified;
begin
  projectoptions.modified    := True;
  projectoptions.savechecked := False;
end;

procedure setsignalinfocount(const Count: integer);
begin
  if Count = 0 then
    projectoptions.sigsettings := defaultsigsettings
  else
    setlength(projectoptions.sigsettings, Count);
end;

procedure storesignalinforec(const index: integer; const avalue: msestring);
var
  stop, handle: Boolean;
begin
  with projectoptions.sigsettings[index] do
  begin
    decoderecord(avalue, [@num, @numto, @stop, @handle], 'iibb');
    updatebit(
{$ifdef FPC}
      longword
{$else}byte{$endif}
      (flags), Ord(sfl_stop), stop);
    updatebit(
{$ifdef FPC}
      longword
{$else}byte{$endif}
      (flags), Ord(sfl_handle), handle);
  end;
end;

function getsignalinforec(const index: integer): msestring;
var
  stop, handle: Boolean;
begin
  with projectoptions.sigsettings[index] do
  begin
    stop   := sfl_stop in flags;
    handle := sfl_handle in flags;
    Result := encoderecord([num, numto, stop, handle]);
  end;
end;

procedure updateprojectsettings(const statfiler: tstatfiler);
var
  int1: integer;
begin
  with statfiler, projectoptions, o, t do
  begin

    if iswriter then
    begin
      mainfo.statoptions.writestat(tstatwriter(statfiler));
      with tstatwriter(statfiler) do
        writerecordarray('sigsettings', length(sigsettings),
                     {$ifdef FPC}
          @
{$endif}
          getsignalinforec);
    end
    else
    begin
      mainfo.statoptions.readstat(tstatreader(statfiler));
      setlength(ftoolmessages, length(ftoolsave));
      with tstatreader(statfiler) do
        readrecordarray('sigsettings',
{$ifdef FPC}
          @
{$endif}
          setsignalinfocount,
             {$ifdef FPC}
          @
{$endif}
          storesignalinforec);
    end;
    updatevalue('defaultmake', defaultmake, 1, maxdefaultmake + 1);

    // updatevalue('defaultmake',defaultmake,1,maxdefaultmake+6);

    if not iswriter then
    begin
      int1   := length(newfinames);
      if int1 > length(newfifilters) then
        int1 := length(newfifilters);
      if int1 > length(newfiexts) then
        int1 := length(newfiexts);
      if int1 > length(newfisources) then
        int1 := length(newfisources);
      setlength(fnewfinames, int1);
      setlength(fnewfifilters, int1);
      setlength(fnewfiexts, int1);
      setlength(fnewfisources, int1);
    end;

    if not iswriter then
    begin
      int1   := length(newfonames);
      if int1 > length(newfonamebases) then
        int1 := length(newfonamebases);
      if int1 > length(newinheritedforms) then
        int1 := length(newinheritedforms);
      if int1 > length(newfosources) then
        int1 := length(newfosources);
      if int1 > length(newfoforms) then
        int1 := length(newfoforms);
      setlength(fnewfonames, int1);
      setlength(fnewfonamebases, int1);
      setlength(fnewinheritedforms, int1);
      setlength(fnewfosources, int1);
      setlength(fnewfoforms, int1);
    end;
  end;
end;

procedure doloadexe(const Sender: tprojectoptionsfo); forward;
procedure dosaveexe(const Sender: tprojectoptionsfo); forward;

procedure updateprojectoptions(const statfiler: tstatfiler; const afilename: filenamety);
var
  int1, int2, int3: integer;
  modulenames1: msestringarty;
  moduletypes1: msestringarty;
  modulefiles1: filenamearty;
  // moduledock1: msestringarty;
begin
  with statfiler, projectoptions do
  begin
    if iswriter then
    begin
      //  e.fpgdesigner := projectoptionsfo.fpgdesignerenabled.value;
      projectdir := getcurrentdirmse;
      with mainfo, mainmenu1.menu.itembynames(['widgets', 'msegui', 'msemod']) do
      begin
        int3 := formmenuitemstart;
        int2 := Count - int3;
        setlength(modulenames1, int2);
        setlength(moduletypes1, int2);
        setlength(modulefiles1, int2);
        //    setlength(moduledock1,int2);


        for int1 := 0 to high(modulenames1) do
          with pmoduleinfoty(submenu[int1 + int3].tagpo)^ do
          begin
            modulenames1[int1] := msestring(struppercase(instance.Name));
            moduletypes1[int1] := msestring(struppercase(string(moduleclassname)));
            modulefiles1[int1] := filename;
          end;
        o.modulenames := modulenames1;
        o.moduletypes := moduletypes1;
        o.modulefiles := modulefiles1;
      end;
    end;
    registeredcomponents.updatestat(statfiler);
    setsection('projectoptions');
    updatevalue('projectdir', projectdir);
    updatevalue('projectfilename', projectfilename);
    projectfilename := afilename;
    updatememorystatstream('findinfiledialog', findinfiledialogstatname);
    updatememorystatstream('finddialog', finddialogstatname);
    updatememorystatstream('replacedialog', replacedialogstatname);
    updatememorystatstream('options', optionsstatname);
    updatememorystatstream('settaborder', settaborderstatname);
    updatememorystatstream('setcreateorder', setcreateorderstatname);
    updatememorystatstream('programparameters', programparametersstatname);
    updatememorystatstream('settings', settingsstatname);
    updatememorystatstream('printer', printerstatname);
    updatememorystatstream('imageselector', imageselectorstatname);
    updatememorystatstream('fadeeditor', fadeeditorstatname);
    updatememorystatstream('stringlisteditor', stringlisteditorstatname);
    updatememorystatstream('imagelisteditor', imagelisteditorstatname);
    updatememorystatstream('sysenvmanagereditor', sysenvmanagereditorstatname);
    updatememorystatstream('texteditor', texteditorstatname);
    updatememorystatstream('colordialog', colordialogstatname);
    updatememorystatstream('compnamedialog', compnamedialogstatname);
    updatememorystatstream('bmpfiledialog', bmpfiledialogstatname);
    updatememorystatstream('codetemplateselect', codetemplateselectstatname);
    updatememorystatstream('codetemplateparam', codetemplateparamstatname);
    updatememorystatstream('codetemplateedit', codetemplateeditstatname);
{$ifndef mse_no_db}{$ifdef FPC}
    updatememorystatstream('dbfieldeditor', dbfieldeditorstatname);
{$endif}{$endif}
{$ifndef mse_no_ifi}{$ifdef FPC}
    updatememorystatstream('ificlienteditor', ificlienteditorstatname);
    updatememorystatstream('ififieldeditor', ififieldeditorstatname);
{$endif}{$endif}

    updateprojectsettings(statfiler);
    breakpointsfo.updatestat(statfiler);
    panelform.updatestat(statfiler); //uses section breakpoints!

    projecttree.updatestat(statfiler);
    componentstorefo.updatestat(statfiler);

    setsection('components');
    selecteditpageform.updatestat(statfiler);
    programparametersform.updatestat(statfiler);
    projectoptionstofont(textpropertyfont);

    if not iswriter then
    begin
      if guitemplatesmo.sysenv.getintegervalue(int1,
        Ord(env_vargroup), 1, 6) then
        o.macrogroup := int1 - 1;
      expandprojectmacros;
      projecttree.updatelist;
    end;

    beginpanelplacement();
    try
      sourcefo.updatestat(statfiler);   //needs actual fontalias
      setsection('layout');
      mainfo.projectstatfile.updatestat('windowlayout', statfiler);
    finally
      endpanelplacement();
    end;
    setsection('targetconsole');
    targetconsole.updatestat(statfiler);

    modified    := False;
    savechecked := False;

    if iswriter then
    begin
      if o.settingsautosave then
        dosaveexe(nil);
    end
    else if o.settingsautoload then
      doloadexe(nil);
  end;

end;


procedure projectoptionstoform(fo: tprojectoptionsfo);
var
  int1, int2: integer;
begin
  with projectoptions do
  begin

    //  fo.fpgdesignerenabled.value := e.fpgdesigner;

    int1     := length(o.toolshortcuts);
    setlength(o.ftoolshortcuts, length(o.t.toolmenus));
    for int2 := int1 to high(o.toolshortcuts) do
      o.toolshortcuts[int2] := -1//init for backward compatibility
    ;
  end;
 {$ifdef mse_with_ifi}
  mainfo.statoptions.objtovalues(fo);
 {$endif}
  fo.colgrid.rowcount := usercolorcount;
  fo.colgrid.fixcols[-1].captions.Count := usercolorcount;
  with fo, projectoptions do
    for int1 := 0 to colgrid.rowhigh do
      colgrid.fixcols[-1].captions[int1] :=
        msestring(colortostring(cl_user + longword(int1)));
  with fo.signame do
  begin
    setlength(enums, siginfocount);
    int2     := 0;
    for int1 := 0 to siginfocount - 1 do
      with siginfos[int1] do
        if not (sfl_internal in flags) then
        begin
          enums[int2] := num;
          dropdownitems.addrow([msestring(Name), msestring(comment)]);
          dropdown.cols.addrow([msestring(comment) + ' (' + msestring(Name) + ')']);
          Inc(int2);
        end;
    setlength(enums, int2);
  end;
  with projectoptions{,t} do
  begin
    fo.signalgrid.rowcount := length(sigsettings);
    for int1 := 0 to high(sigsettings) do
      with sigsettings[int1] do
      begin
        fo.signum[int1]   := num;
        fo.signumto[int1] := numto;
        if num = numto then
          fo.signame[int1] := num
        else
          fo.signame[int1] := -1;
        fo.sigstop[int1]   := sfl_stop in flags;
        fo.sighandle[int1] := sfl_handle in flags;
      end;
    fo.fontondataentered(nil);
    fo.defaultmake.Value := lowestbit(defaultmake);

    // fred compiler

    fo.compcommand.gridvalues := o.t.compilerused;

    with projectoptions, o, t do
      for int1 := 0 to fo.compilerusedgrid.rowhigh do
      begin
        if int1 > high(o.compilerusedon) then
          break;
        fo.compmakeon.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compbuildon.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake1on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake2on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake3on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake4on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake5on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake6on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake7on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake8on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake9on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
        fo.compmake0on.gridupdatetagvalue(int1, o.compilerusedon[int1]);
      end;

    // fred debugger

    fo.debcommand.gridvalues := o.t.debuggerused;

    with projectoptions, o, t do
      for int1 := 0 to fo.debuggerusedgrid.rowhigh do
      begin
        if int1 > high(o.debuggerusedon) then
          break;
        fo.debmakeon.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debbuildon.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake1on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake2on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake3on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake4on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake5on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake6on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake7on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake8on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake9on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
        fo.debmake0on.gridupdatetagvalue(int1, o.debuggerusedon[int1]);
      end;

    /// fred options comment
    fo.comment_M.Value := o.comment_M;
    fo.comment_B.Value := o.comment_B;
    fo.comment_1.Value := o.comment_1;
    fo.comment_2.Value := o.comment_2;
    fo.comment_3.Value := o.comment_3;
    fo.comment_4.Value := o.comment_4;
    fo.comment_5.Value := o.comment_5;
    fo.comment_6.Value := o.comment_6;
    fo.comment_7.Value := o.comment_7;
    fo.comment_8.Value := o.comment_8;
    fo.comment_9.Value := o.comment_9;
    fo.comment_0.Value := o.comment_0;

    /// fred info project
    fo.project_name.Value      := o.project_name;
    fo.project_creator.Value   := o.project_creator;
    fo.project_copyright.Value := o.project_copyright;
    fo.project_license.Value   := o.project_license;

    if trim(o.project_date) <> '' then
      fo.project_date.Value := o.project_date
    else
      fo.project_date.Value := UTF8Decode(timetostr(now) + ' ' + datetostr(now));

    fo.project_comment.Value := o.project_comment;


    /// fred exe ext

    with projectoptions, o, t do
      setlength(fexeusedon, length(fexeused));

    fo.exeused.gridvalues := o.t.exeused;

    with projectoptions, o, t do
      for int1 := 0 to fo.exeextgrid.rowhigh do
      begin
        if int1 > high(o.exeusedon) then
          break;

        fo.exemakeon.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exebuildon.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake1on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake2on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake3on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake4on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake5on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake6on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake7on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake8on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake9on.gridupdatetagvalue(int1, o.exeusedon[int1]);
        fo.exemake0on.gridupdatetagvalue(int1, o.exeusedon[int1]);

      end;

    for int1 := 0 to fo.makeoptionsgrid.rowhigh do
    begin
      if int1 > high(o.makeoptionson) then
        break;
      fo.extraon.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.makeon.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.buildon.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make1on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make2on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make3on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make4on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make5on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make6on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make7on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make8on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make9on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
      fo.make0on.gridupdatetagvalue(int1, o.makeoptionson[int1]);
    end;

    for int1 := 0 to fo.befcommandgrid.rowhigh do
    begin
      if int1 > high(o.befcommandon) then
        break;
      fo.befmakeon.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befbuildon.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake1on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake2on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake3on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake4on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake5on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake6on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake7on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake8on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake9on.gridupdatetagvalue(int1, o.befcommandon[int1]);
      fo.befmake0on.gridupdatetagvalue(int1, o.befcommandon[int1]);
    end;

    for int1 := 0 to fo.aftcommandgrid.rowhigh do
    begin
      if int1 > high(o.aftcommandon) then
        break;
      fo.aftmakeon.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftbuildon.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake1on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake2on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake3on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake4on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake5on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake6on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake7on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake8on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake9on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
      fo.aftmake0on.gridupdatetagvalue(int1, o.aftcommandon[int1]);
    end;

    fo.unitdirs.gridvalues := reversearray(o.t.unitdirs);
    int2 := high(o.t.unitdirs);
    for int1 := 0 to int2 do
    begin
      if int1 > high(o.unitdirson) then
        break;
      fo.dmakeon.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dbuildon.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake1on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake2on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake3on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake4on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake5on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake6on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake7on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake8on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake9on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dmake0on.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.duniton.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dincludeon.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dlibon.gridupdatetagvalue(int2, o.unitdirson[int1]);
      fo.dobjon.gridupdatetagvalue(int2, o.unitdirson[int1]);
      Dec(int2);
    end;

    // for int1:= 0 to fo.unitdirgrid.rowhigh do begin
    //  fo.duniton.color:= cl_ltblue
    //   fo.unitdirgrid.datacols[int1].color:= cl_ltyellow;
    //   end;

    fo.activemacroselect[o.macrogroup] := True;
    fo.activegroupchanged;
    setlength(o.fgroupcomments, 10); // ici !
    fo.groupcomment.gridvalues         := o.groupcomments;

    for int1 := 0 to fo.macrogrid.rowhigh do
    begin
      if int1 > high(o.macroon) then
        break;
      fo.e0.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e1.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e2.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e3.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e4.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e5.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e6.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e7.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e8.gridupdatetagvalue(int1, o.macroon[int1]);
      fo.e9.gridupdatetagvalue(int1, o.macroon[int1]);
    end;

    fo.sourcedirs.gridvalues        := reversearray(d.t.sourcedirs);
    fo.syntaxdeffile.gridvalues     := e.t.syntaxdeffiles;
    fo.syntaxdeffilemask.gridvalues := e.t.sourcefilemasks;
    //  fo.grid[0].datalist.asarray:= e.t.syntaxdeffiles;
    //  fo.grid[1].datalist.asarray:= e.t.sourcefilemasks;
    fo.filefiltergrid[0].datalist.asarray := e.t.filemasknames;
    fo.filefiltergrid[1].datalist.asarray := e.t.filemasks;
    fo.settingsdataent(nil);

  end;
  if fo.enablepurpose.Value = True then
    fo.makeoptionsgrid.datacols[0].Visible := True
  else

    fo.makeoptionsgrid.datacols[0].Visible := False;

  //   if fo.enablesource.value = true then  actionsmo.projectsourceexe(nil);

end;

procedure storemacros(fo: tprojectoptionsfo);
var
  int1: integer;
begin
  with projectoptions, o do
  begin
    macronames  := fo.macronames.gridvalues;
    macrovalues := fo.macrovalues.gridvalues;
    setlength(fmacroon, fo.macrogrid.rowcount);
    for int1 := 0 to high(macroon) do
      macroon[int1] := fo.e0.gridvaluetag(int1, 0) or fo.e1.gridvaluetag(int1, 0) or
        fo.e2.gridvaluetag(int1, 0) or fo.e3.gridvaluetag(int1, 0) or
        fo.e4.gridvaluetag(int1, 0) or fo.e5.gridvaluetag(int1, 0) or
        fo.e6.gridvaluetag(int1, 0) or fo.e7.gridvaluetag(int1, 0) or
        fo.e8.gridvaluetag(int1, 0) or fo.e9.gridvaluetag(int1, 0);
    groupcomments   := fo.groupcomment.gridvalues;
  end;
end;

procedure formtoprojectoptions(fo: tprojectoptionsfo);
var
  int1: integer;
begin
{$ifdef mse_with_ifi}
  mainfo.statoptions.valuestoobj(fo);
{$endif}
  with projectoptions do
  begin
    setlength(sigsettings, fo.signalgrid.rowcount);
    for int1 := 0 to high(sigsettings) do
      with sigsettings[int1] do
      begin
        num   := fo.signum[int1];
        numto := fo.signumto[int1];
        updatebit(
{$ifdef FPC}
          longword
{$else}byte{$endif}
          (flags), Ord(sfl_stop),
          fo.sigstop[int1]);
        updatebit(
{$ifdef FPC}
          longword
{$else}byte{$endif}
          (flags), Ord(sfl_handle),
          fo.sighandle[int1]);
      end;

    for int1 := high(o.fontxscales) downto 0 do
      if o.fontxscales[int1] = emptyreal then
        o.fontxscales[int1] := 1.0;

    defaultmake := 1 shl fo.defaultmake.Value;
    setlength(o.fmakeoptionson, fo.makeoptionsgrid.rowcount);
    for int1    := 0 to high(o.fmakeoptionson) do
      o.fmakeoptionson[int1] :=
        fo.extraon.gridvaluetag(int1, 0) or fo.makeon.gridvaluetag(int1, 0) or fo.buildon.gridvaluetag(int1, 0) or
        fo.make1on.gridvaluetag(int1, 0) or fo.make2on.gridvaluetag(int1, 0) or
        fo.make3on.gridvaluetag(int1, 0) or fo.make4on.gridvaluetag(int1, 0) or
        fo.make5on.gridvaluetag(int1, 0) or fo.make6on.gridvaluetag(int1, 0) or
        fo.make7on.gridvaluetag(int1, 0) or fo.make8on.gridvaluetag(int1, 0) or
        fo.make9on.gridvaluetag(int1, 0) or fo.make0on.gridvaluetag(int1, 0);

    /// fred compiler
    // setlength(o.fmakeoptionson,fo.makeoptionsgrid.rowcount);
    for int1 := 0 to high(o.fcompilerusedon) do
      o.fcompilerusedon[int1] :=
        fo.compmakeon.gridvaluetag(int1, 0) or fo.compbuildon.gridvaluetag(int1, 0) or
        fo.compmake1on.gridvaluetag(int1, 0) or fo.compmake2on.gridvaluetag(int1, 0) or
        fo.compmake3on.gridvaluetag(int1, 0) or fo.compmake4on.gridvaluetag(int1, 0) or
        fo.compmake5on.gridvaluetag(int1, 0) or fo.compmake6on.gridvaluetag(int1, 0) or
        fo.compmake7on.gridvaluetag(int1, 0) or fo.compmake8on.gridvaluetag(int1, 0) or
        fo.compmake9on.gridvaluetag(int1, 0) or fo.compmake0on.gridvaluetag(int1, 0);
    ///

    // fred debugger

    for int1 := 0 to high(o.fdebuggerusedon) do
      o.fdebuggerusedon[int1] :=
        fo.debmakeon.gridvaluetag(int1, 0) or fo.debbuildon.gridvaluetag(int1, 0) or
        fo.debmake1on.gridvaluetag(int1, 0) or fo.debmake2on.gridvaluetag(int1, 0) or
        fo.debmake3on.gridvaluetag(int1, 0) or fo.debmake4on.gridvaluetag(int1, 0) or
        fo.debmake5on.gridvaluetag(int1, 0) or fo.debmake6on.gridvaluetag(int1, 0) or
        fo.debmake7on.gridvaluetag(int1, 0) or fo.debmake8on.gridvaluetag(int1, 0) or
        fo.debmake9on.gridvaluetag(int1, 0) or fo.debmake0on.gridvaluetag(int1, 0);


    // fred exe ext

    setlength(o.fexeusedon, fo.exeextgrid.rowcount);
    for int1 := 0 to high(o.fexeusedon) do
      o.exeusedon[int1] :=
        fo.exemakeon.gridvaluetag(int1, 0) or fo.exebuildon.gridvaluetag(int1, 0) or
        fo.exemake1on.gridvaluetag(int1, 0) or fo.exemake2on.gridvaluetag(int1, 0) or
        fo.exemake3on.gridvaluetag(int1, 0) or fo.exemake4on.gridvaluetag(int1, 0) or
        fo.exemake5on.gridvaluetag(int1, 0) or fo.exemake6on.gridvaluetag(int1, 0) or
        fo.exemake7on.gridvaluetag(int1, 0) or fo.exemake8on.gridvaluetag(int1, 0) or
        fo.exemake9on.gridvaluetag(int1, 0) or fo.exemake0on.gridvaluetag(int1, 0);

    /// fred options comment
    o.comment_M := fo.comment_M.Value;
    o.comment_B := fo.comment_B.Value;
    o.comment_1 := fo.comment_1.Value;
    o.comment_2 := fo.comment_2.Value;
    o.comment_3 := fo.comment_3.Value;
    o.comment_4 := fo.comment_4.Value;
    o.comment_5 := fo.comment_5.Value;
    o.comment_6 := fo.comment_6.Value;
    o.comment_7 := fo.comment_7.Value;
    o.comment_8 := fo.comment_8.Value;
    o.comment_9 := fo.comment_9.Value;
    o.comment_0 := fo.comment_0.Value;

    /// fred info project
    o.project_name      := fo.project_name.Value;
    o.project_creator   := fo.project_creator.Value;
    o.project_copyright := fo.project_copyright.Value;
    o.project_license   := fo.project_license.Value;
    o.project_date      := fo.project_date.Value;
    o.project_comment   := fo.project_comment.Value;


    setlength(o.fbefcommandon, fo.befcommandgrid.rowcount);
    for int1 := 0 to high(o.fbefcommandon) do
      o.fbefcommandon[int1] :=
        fo.befmakeon.gridvaluetag(int1, 0) or fo.befbuildon.gridvaluetag(int1, 0) or
        fo.befmake1on.gridvaluetag(int1, 0) or fo.befmake2on.gridvaluetag(int1, 0) or
        fo.befmake3on.gridvaluetag(int1, 0) or fo.befmake4on.gridvaluetag(int1, 0) or
        fo.befmake5on.gridvaluetag(int1, 0) or fo.befmake6on.gridvaluetag(int1, 0) or
        fo.befmake7on.gridvaluetag(int1, 0) or fo.befmake8on.gridvaluetag(int1, 0) or
        fo.befmake9on.gridvaluetag(int1, 0) or fo.befmake0on.gridvaluetag(int1, 0);

    setlength(o.faftcommandon, fo.aftcommandgrid.rowcount);
    for int1 := 0 to high(o.faftcommandon) do
      o.faftcommandon[int1] :=
        fo.aftmakeon.gridvaluetag(int1, 0) or fo.aftbuildon.gridvaluetag(int1, 0) or
        fo.aftmake1on.gridvaluetag(int1, 0) or fo.aftmake2on.gridvaluetag(int1, 0) or
        fo.aftmake3on.gridvaluetag(int1, 0) or fo.aftmake4on.gridvaluetag(int1, 0) or
        fo.aftmake5on.gridvaluetag(int1, 0) or fo.aftmake6on.gridvaluetag(int1, 0) or
        fo.aftmake7on.gridvaluetag(int1, 0) or fo.aftmake8on.gridvaluetag(int1, 0) or
        fo.aftmake9on.gridvaluetag(int1, 0) or fo.aftmake0on.gridvaluetag(int1, 0);

    o.t.unitdirs := reversearray(fo.unitdirs.gridvalues);
    setlength(o.funitdirson, length(o.t.unitdirs));
    for int1     := 0 to high(o.funitdirson) do
      o.funitdirson[high(o.funitdirson) - int1] :=
        fo.dmakeon.gridvaluetag(int1, 0) or fo.dbuildon.gridvaluetag(int1, 0) or
        fo.dmake1on.gridvaluetag(int1, 0) or fo.dmake2on.gridvaluetag(int1, 0) or
        fo.dmake3on.gridvaluetag(int1, 0) or fo.dmake4on.gridvaluetag(int1, 0) or
        fo.dmake5on.gridvaluetag(int1, 0) or fo.dmake6on.gridvaluetag(int1, 0) or
        fo.dmake7on.gridvaluetag(int1, 0) or fo.dmake8on.gridvaluetag(int1, 0) or
        fo.dmake9on.gridvaluetag(int1, 0) or fo.dmake0on.gridvaluetag(int1, 0) or
        fo.duniton.gridvaluetag(int1, 0) or fo.dincludeon.gridvaluetag(int1, 0) or
        fo.dlibon.gridvaluetag(int1, 0) or fo.dobjon.gridvaluetag(int1, 0);
    storemacros(fo);
    d.t.sourcedirs := reversearray(fo.sourcedirs.gridvalues);
    e.t.syntaxdeffiles := fo.syntaxdeffile.gridvalues;
    e.t.sourcefilemasks := fo.syntaxdeffilemask.gridvalues;
    //  e.t.syntaxdeffiles:= fo.grid[0].datalist.asarray;
    //  e.t.sourcefilemasks:= fo.grid[1].datalist.asarray;
    e.t.filemasknames   := fo.filefiltergrid[0].datalist.asarray;
    e.t.filemasks       := fo.filefiltergrid[1].datalist.asarray;
  end;
  expandprojectmacros;

end;

procedure projectoptionschanged;
var
  int1: integer;
begin
  projecttree.updatelist;
  createcpufo;
  mainfo.gdb.fpcworkaround := projectoptions.d.fpcgdbworkaround;
  sourceupdater.unitchanged;
  for int1 := 0 to designer.modules.Count - 1 do
    tformdesignerfo(designer.modules[int1]^.designform).updateprojectoptions();
  messagefo.updateprojectoptions;
end;

function readprojectoptions(const filename: filenamety): Boolean;
var
  statreader: tstatreader;
begin
  Result       := False;
  try
    statreader := tstatreader.Create(filename, ce_utf8);
    try
      application.beginwait;
      updateprojectoptions(statreader, filename);
    finally
      statreader.Free;
      application.endwait;
      projectoptionschanged;
    end;
    Result := True;
  except
    on e: Exception do
    begin
      showerror(lang_actionsmodule[ord(ac_cannotreadproject)] + ' "' + filename + '".' +
        lineend + msestring(e.message), uppercase(lang_stockcaption[ord(sc_Error)]));
    end;
  end;
end;

procedure saveprojectoptions(filename: filenamety = '');
var
  statwriter: tstatwriter;
begin
  if filename = '' then
    filename := projectoptions.projectfilename;
  statwriter := tstatwriter.Create(filename, ce_utf8, True);
  try
    updateprojectoptions(statwriter, filename);
  finally
    statwriter.Free;
  end;
end;

procedure dofontsize;
begin
  fo.font.Height := confideufo.fontsize.Value;
  fo.font.Name   := ansistring(confideufo.fontname.Value);

  fo.container.frame.font.Height := confideufo.fontsize.Value;
end;

function editprojectoptions: Boolean;
begin
  fo       := tprojectoptionsfo.Create(nil);
  projectoptionstoform(fo);
  try
    projectoptionsfo := fo;
    dofontsize;
    Result := fo.Show(True, nil) = mr_ok;
    projectoptionsfo := nil;
    if Result then
    begin
      with mainfo.gdb do
        if not started then
          closegdb;
      fo.window.nofocus; //remove empty grid lines
      formtoprojectoptions(fo);
      projectoptionsmodified;
      projectoptionschanged;
    end;
  finally
    projectoptionsfo := nil;
    fo.Free;
  end;
end;

procedure tprojectoptionsfo.activegroupchanged;
var
  int1, int2: integer;
begin
  int2     := 0;
  for int1 := 0 to selectactivegroupgrid.rowcount - 1 do
    if activemacroselect[int1] then
    begin
      int2 := int1;
      break;
    end;
  // fred macros
  for int1 := 0 to selectactivegroupgrid.rowcount - 1 do
    if int1 = int2 then
      macrogrid.datacols[int1].color := cl_infobackground
    else
      macrogrid.datacols[int1].color := cl_default;
  projectoptions.o.macrogroup := int2;
end;

procedure tprojectoptionsfo.acttiveselectondataentered(const Sender: TObject);
var
  int1: integer;
begin
  for int1 := 0 to selectactivegroupgrid.rowcount - 1 do
    activemacroselect[int1]       := False;
  tbooleaneditradio(Sender).Value := True;
  activegroupchanged;
  projectoptions.o.macrogroup     := selectactivegroupgrid.row;
end;

procedure tprojectoptionsfo.colonshowhint(const Sender: tdatacol; const arow: integer; var info: hintinfoty);
begin
  storemacros(self);
  if Sender is twidgetcol then
    info.Caption := tcustomstringedit(twidgetcol(Sender).editwidget).gridvalue[arow]
  else
    info.Caption := tstringcol(Sender)[arow];
  expandprmacros1(info.Caption);
  include(info.flags, hfl_show); //show empty caption
end;

procedure tprojectoptionsfo.hintexpandedmacros(const Sender: TObject; var info: hintinfoty);
begin
  storemacros(self);
  hintmacros(tcustomedit(Sender), info);
end;

procedure tprojectoptionsfo.selectactiveonrowsmoved(const Sender: tcustomgrid; const fromindex: integer; const toindex: integer; const acount: integer);
var
  ar1: array of longboolarty;
  int1: integer;
begin

  setlength(ar1, selectactivegroupgrid.rowcount);
  with macrogrid do
  begin
    beginupdate;
    for int1 := 0 to high(ar1) do
      ar1[int1] := tbooleanedit(datacols[int1].editwidget).gridvalues;
    moveitem(pointerarty(ar1), fromindex, toindex);
    for int1    := 0 to high(ar1) do
      tbooleanedit(datacols[int1].editwidget).gridvalues := ar1[int1];
    endupdate;
  end;
  activegroupchanged;
end;

procedure tprojectoptionsfo.expandfilename(const Sender: TObject; var avalue: mseString; var accept: Boolean);
begin
  expandprmacros1(avalue);
end;

procedure tprojectoptionsfo.showcommandlineonexecute(const Sender: TObject);
var
  info1: projectoptionsty;
begin
  info1          := projectoptions;
  formtoprojectoptions(self);
  commandlineform.showcommandline;
  projectoptions := info1;
end;

procedure tprojectoptionsfo.signameonsetvalue(const Sender: TObject; var avalue: longint; var accept: Boolean);
begin
  signum.Value   := avalue;
  signumto.Value := avalue;
end;

procedure tprojectoptionsfo.signumonsetvalue(const Sender: TObject; var avalue: longint; var accept: Boolean);
begin
  signame.Value  := avalue;
  signumto.Value := avalue;
end;

procedure tprojectoptionsfo.signumtoonsetvalue(const Sender: TObject; var avalue: integer; var accept: Boolean);
begin
  if avalue <= signum.Value then
  begin
    signum.Value  := avalue;
    signame.Value := avalue;
  end
  else
    signame.Value := -1;
end;

procedure tprojectoptionsfo.fontondataentered(const Sender: TObject);
const
  teststring = 'ABCDEFGabcdefgy0123WWWiii ';
var
  format1: formatinfoarty;
begin
  with fontdisp.font do
  begin
    Name       := ansistring(editfontname.Value);
    Height     := editfontheight.Value;
    Width      := editfontwidth.Value;
    extraspace := editfontextraspace.Value;
    color      := editfontcolor.Value;
    dispgrid.frame.colorclient := editbkcolor.Value;
    if editfontantialiased.Value then
      options := options + [foo_antialiased2]
    else
      options   := options + [foo_nonantialiased];
    dispgrid.datarowheight := lineheight;
    fontdisp[0] := teststring + teststring + teststring + teststring;
    format1     := nil;
    updatefontstyle1(format1, length(teststring), length(teststring), fs_bold, True);
    updatefontstyle1(format1, 2 * length(teststring), 2 * length(teststring), fs_italic, True);
    updatefontstyle1(format1, 3 * length(teststring), length(teststring), fs_bold, True);
    fontdisp.richformats[0] := format1;
    fontdisp[1] :=
      'Ascent: ' + inttostrmse(ascent) + ' Descent: ' + inttostrmse(descent) +
      ' Linespacing: ' + inttostrmse(lineheight);
  end;
  dispgrid.rowcolorstate[1] := 0;
  dispgrid.rowcolors[0] := statementcolor.Value;
end;

procedure tprojectoptionsfo.makepageonchildscaled(const Sender: TObject);
 //var
 // int1: integer;
begin
{

 placeyorder(0,[0,0,0,15],[mainfile,makecommand,colorerror,
                    defaultmake,makegroupbox],0);
 aligny(wam_center,[mainfile,targetfile,targpref]);
 aligny(wam_center,[makecommand,makedir,messageoutputfile]);
 int1:= aligny(wam_center,[colorerror,colorwarning,colornote,copymessages]);
 with stripmessageesc do begin
  bounds_y:= int1 - bounds_cy - 2;
 end;
 with copymessages do begin
  pos:= makepoint(stripmessageesc.bounds_x,int1);
 end;

 placexorder(defaultmake.bounds_x,[10-defaultmake.frame.outerframe.right,10],
             [defaultmake,showcommandline,checkmethods]);
 int1:= aligny(wam_center,[defaultmake,showcommandline]);
 with checkmethods do begin
  bounds_y:= int1 - bounds_cy - 2;
 end;
 with closemessages do begin
  pos:= makepoint(checkmethods.bounds_x,int1);
 end;
}
end;

procedure tprojectoptionsfo.debuggerlayoutexe(const Sender: TObject);
begin
  //{$ifdef mswindows}
  //placeyorder(2,[0,0,10],[runcommand,debugcommand,debugtarget,tlayouter1]);
  //{$else}
  // placeyorder(0,[0,0,2],[debugcommand,debugoptions,debugtarget,tlayouter1]);
  //{$endif}
  //aligny(wam_center,[debugcommand,debugoptions]);
  //aligny(wam_center,[debugtarget,xtermcommand]);
end;

procedure tprojectoptionsfo.macronchildscaled(const Sender: TObject);
var
  int1: integer;
begin
  int1 := macrosplitter.bounds_y;
  placeyorder(0, [0], [selectactivegroupgrid, macrosplitter, macrogrid], 0);
  macrosplitter.move(makepoint(0, int1 - macrosplitter.bounds_y));
end;


procedure tprojectoptionsfo.formtemplateonchildscaled(const Sender: TObject);
begin
{
 placeyorder(0,[0],[mainfosource,mainfoform,simplefosource,simplefoform,
       dockingfosource,dockingfoform,datamodsource,datamodform,
       subfosource,subfoform,reportsource,reportform,
       inheritedsource,inheritedform]);
}
end;

procedure tprojectoptionsfo.encodingsetvalue(const Sender: TObject; var avalue: longint; var accept: Boolean);
var
  mstr1: msestring;
begin
  mstr1  := encoding.dropdown.valuelist[avalue];
  accept := askyesno(lang_projectoptionscon[Ord(c_wrongencoding)] + lineend +
    lang_projectoptionscon[Ord(c_wishsetencoding)] + ' ' + mstr1 + '?', 
    lang_projectoptionscon[Ord(c_warning)]);
end;

procedure tprojectoptionsfo.createexe(const Sender: TObject);
var
  int1: integer;
  sigstring: string = '';
begin
  icon     := mainfo.icon;
 {$ifdef mswindows}
  // externalconsole.visible:= true;
 {$else}
 settty.visible:= true;
// xtermoptions.visible:= true;
 {$endif}
  // sigstring := lang_projectoptionscon[Ord(c_SIGHUP);
  for int1 := Ord(firstsiginfocomment) to Ord(lastsiginfocomment) do
  begin
    case int1 of
      3: sigstring  := lang_projectoptionscon[Ord(c_SIGHUP)];
      5: sigstring  := lang_projectoptionscon[Ord(c_SIGQUIT)];
      6: sigstring  := lang_projectoptionscon[Ord(c_SIGILL)];
      7: sigstring  := lang_projectoptionscon[Ord(c_SIGABRT)];
      8: sigstring  := lang_projectoptionscon[Ord(c_SIGBUS)];
      9: sigstring  := lang_projectoptionscon[Ord(c_SIGFPE)];
      10: sigstring := lang_projectoptionscon[Ord(c_SIGILL)];
      11: sigstring := lang_projectoptionscon[Ord(c_SIGKILL)];
      12: sigstring := lang_projectoptionscon[Ord(c_SIGUSR1)];
      13: sigstring := lang_projectoptionscon[Ord(c_SIGSEGV)];
      14: sigstring := lang_projectoptionscon[Ord(c_SIGUSR2)];
      15: sigstring := lang_projectoptionscon[Ord(c_SIGPIPE)];
      16: sigstring := lang_projectoptionscon[Ord(c_SIGALRM)];
      17: sigstring := lang_projectoptionscon[Ord(c_SIGTERM)];
      18: sigstring := lang_projectoptionscon[Ord(c_SIGSTKFLT)];
      19: sigstring := lang_projectoptionscon[Ord(c_SIGCHLD)];
      20: sigstring := lang_projectoptionscon[Ord(c_SIGCONT)];
      21: sigstring := lang_projectoptionscon[Ord(c_SIGSTOP)];
      22: sigstring := lang_projectoptionscon[Ord(c_SIGTSTP)];
      23: sigstring := lang_projectoptionscon[Ord(c_SIGTTIN)];
      24: sigstring := lang_projectoptionscon[Ord(c_SIGTTOU)];
      25: sigstring := lang_projectoptionscon[Ord(c_SIGURG)];
      26: sigstring := lang_projectoptionscon[Ord(c_SIGXCPU)];
      27: sigstring := lang_projectoptionscon[Ord(c_SIGXFSZ)];
      28: sigstring := lang_projectoptionscon[Ord(c_SIGTALRM)];
      29: sigstring := lang_projectoptionscon[Ord(c_SIGPROF)];
      30: sigstring := lang_projectoptionscon[Ord(c_SIGWINCH)];
      31: sigstring := lang_projectoptionscon[Ord(c_SIGIO)];
      32: sigstring := lang_projectoptionscon[Ord(c_SIGPWR)];
    end;

    siginfos[int1 - Ord(firstsiginfocomment)].comment := ansistring(sigstring);

  end;
end;

procedure tprojectoptionsfo.drawcol(const Sender: tpointeredit; const acanvas: tcanvas; const avalue: Pointer; const arow: integer);
begin
  with pcellinfoty(acanvas.drawinfopo)^ do
    acanvas.fillrect(innerrect, usercolors[arow]);
end;

procedure tprojectoptionsfo.colsetvalue(const Sender: TObject; var avalue: colorty; var accept: Boolean);
begin
  colgrid.invalidaterow(colgrid.row);
end;

procedure tprojectoptionsfo.copycolorcode(const Sender: TObject);
var
  str1: msestring;
  int1: integer;
begin
  str1     := '';
  for int1 := 0 to colgrid.rowhigh do
    if usercolors[int1] <> 0 then
    begin
      str1   := str1 + ' setcolormapvalue(' +
        msestring(colortostring(cl_user + longword(int1))) + ',' +
        msestring(colortostring(usercolors[int1])) + ');';
      if usercolorcomment[int1] <> '' then
        str1 := str1 + ' //' + usercolorcomment[int1];
      str1 := str1 + lineend;
    end;
  copytoclipboard(str1);
end;

procedure tprojectoptionsfo.downloadchange(const Sender: TObject);
begin
  uploadcommand.Enabled    := not gdbdownload.Value and not gdbsimulator.Value;
  beforeload.Enabled       := gdbdownload.Value and not gdbsimulator.Value;
  afterload.Enabled        := gdbdownload.Value and not gdbsimulator.Value;
  gdbservercommand.Enabled := not gdbsimulator.Value;
  gdbservercommandattach.Enabled := not gdbsimulator.Value;
  gdbserverwait.Enabled    := not gdbsimulator.Value;
  nogdbserverexit.Enabled  := gdbserverwait.Enabled;
  gdbservertty.Enabled     := not gdbsimulator.Value;
  remoteconnection.Enabled := not gdbsimulator.Value;
  gdbdownload.Enabled      := not gdbsimulator.Value;
  downloadalways.Enabled   := not gdbsimulator.Value;
  startupbkpt.Enabled      := startupbkpton.Value;
end;

procedure tprojectoptionsfo.processorchange(const Sender: TObject);
begin
  mainfo.gdb.processorname := ansistring(gdbprocessor.Value);
  if not (mainfo.gdb.processor in simulatorprocessors) then
  begin
    gdbsimulator.Value   := False;
    gdbsimulator.Enabled := False;
  end
  else
    gdbsimulator.Enabled := True;
end;

procedure tprojectoptionsfo.copymessagechanged(const Sender: TObject);
begin
  messageoutputfile.Enabled := copymessages.Value;
 {
 if copymessages.value then
  messageoutputfile.frame.captiontextflags := [tf_bottom]
 else
  messageoutputfile.frame.captiontextflags := [tf_bottom,tf_grayed];
  }
end;

procedure tprojectoptionsfo.updatedebugenabled(const Sender: TObject);
var
  bo1: Boolean;
begin
  bo1 := runcommand.Value = '';
  debugcommand.Enabled := bo1;
  debugoptions.Enabled := bo1;
  debugtarget.Enabled := bo1;
{$ifndef mswindows}
 xtermcommand.enabled:= bo1 and externalconsole.value;
{$endif}
  activateonbreak.Enabled := bo1;
  raiseonbreak.Enabled := bo1;
  nodebugbeginend.Enabled := bo1;
  stoponexception.Enabled := bo1;
  stoponexception.Enabled := bo1;
  showconsole.Enabled := not externalconsole.Value;
  settty.Enabled := bo1;
end;

procedure tprojectoptionsfo.newprojectchildscaled(const Sender: TObject);
begin
  placeyorder(4, [4, 4], [scriptbeforecopy, scriptaftercopy, copygrid], 0);
end;

type
  valuebufferty = record
    settingsfile: filenamety;
    settingseditor: Boolean;
    settingsdebugger: Boolean;
    settingsstorage: Boolean;
    settingsprojecttree: Boolean;
    settingsautoload: Boolean;
    settingsautosave: Boolean;
    projectfilename: filenamety;
    projectdir: filenamety;
  end;

procedure savevalues(fo: tprojectoptionsfo; out buffer: valuebufferty);
begin
  with buffer do
  begin
    projectfilename := projectoptions.projectfilename;
    projectdir      := projectoptions.projectdir;

    if fo <> nil then
    begin
      settingsfile        := fo.settingsfile.Value;
      settingseditor      := fo.settingseditor.Value;
      settingsdebugger    := fo.settingsdebugger.Value;
      settingsstorage     := fo.settingsstorage.Value;
      settingsprojecttree := fo.settingsprojecttree.Value;
      settingsautoload    := fo.settingsautoload.Value;
      settingsautosave    := fo.settingsautosave.Value;
    end
    else
    begin
      settingsfile        := projectoptions.o.settingsfile;
      settingseditor      := projectoptions.o.settingseditor;
      settingsdebugger    := projectoptions.o.settingsdebugger;
      settingsstorage     := projectoptions.o.settingsstorage;
      settingsprojecttree := projectoptions.o.settingsprojecttree;
      settingsautoload    := projectoptions.o.settingsautoload;
      settingsautosave    := projectoptions.o.settingsautosave;
    end;
  end;
end;

procedure restorevalues(fo: tprojectoptionsfo; const buffer: valuebufferty);
begin
  with buffer do
  begin
    projectoptions.projectfilename := projectfilename;
    projectoptions.projectdir      := projectdir;
    if fo <> nil then
    begin
      if not settingsstorage then
      begin
        fo.settingsfile.Value        := settingsfile;
        fo.settingseditor.Value      := settingseditor;
        fo.settingsdebugger.Value    := settingsdebugger;
        fo.settingsstorage.Value     := settingsstorage;
        fo.settingsprojecttree.Value := settingsprojecttree;
        fo.settingsautoload.Value    := settingsautoload;
        fo.settingsautosave.Value    := settingsautosave;
      end;
      fo.fontondataentered(nil);
      fo.settingsdataent(nil);
    end
    else if not settingsstorage then
    begin
      projectoptions.o.settingsfile        := settingsfile;
      projectoptions.o.settingseditor      := settingseditor;
      projectoptions.o.settingsdebugger    := settingsdebugger;
      projectoptions.o.settingsstorage     := settingsstorage;
      projectoptions.o.settingsprojecttree := settingsprojecttree;
      projectoptions.o.settingsautoload    := settingsautoload;
      projectoptions.o.settingsautosave    := settingsautosave;
    end;
  end;
end;

procedure savestat(out astream: ttextstream);
var
  write1: tstatwriter;
begin
  astream := ttextstream.Create; //memory stream
  write1  := tstatwriter.Create(astream, ce_utf8);
  try
    write1.setsection('projectoptions');
    updateprojectsettings(write1); //save projectoptions state
  finally
    write1.Free;
  end;
end;

procedure restorestat(var astream: ttextstream);
var
  read1: tstatreader;
begin
  astream.position := 0;
  read1 := tstatreader.Create(astream, ce_utf8);
  try
    read1.setsection('projectoptions');
    updateprojectsettings(read1); //restore projectoptions state
  finally
    read1.Free;
    astream.Free;
  end;
end;

function getdisabledoptions: settinggroupsty;
begin
  Result := [];
  with projectoptions do
  begin
    if not o.settingseditor then
      include(Result, sg_editor);
    if not o.settingsdebugger then
      include(Result, sg_debugger);
  end;
end;

procedure doloadexe(const Sender: tprojectoptionsfo);
var
  read1: tstatreader;
  buffer: valuebufferty;
  stream1: ttextstream;
  fname1: filenamety;
begin
  if (Sender <> nil) then
  begin
    storemacros(Sender);
    fname1 := Sender.settingsfile.Value;
    expandprmacros1(fname1);
    if not askyesno(lang_actionsmodule[ord(ac_replacesettings)] + lineend +
      '"' + fname1 + '"?',
      lang_stockcaption[Ord(sc_warningupper)]) then
      Exit;
  end
  else
  begin
    fname1 := projectoptions.o.settingsfile;
    expandprmacros1(fname1);
  end;
  if fname1 <> '' then
  begin
    savevalues(Sender, buffer);
    savestat(stream1);
    if Sender <> nil then
      formtoprojectoptions(Sender);
    projectoptions.disabled := getdisabledoptions;
    try
      read1 := tstatreader.Create(fname1, ce_utf8);
      try
        read1.setsection('projectoptions');
        if projectoptions.o.settingsprojecttree then
        begin
          projecttree.updatestat(read1);
          projecttree.updatelist;
        end;
        updateprojectsettings(read1);
      finally
        read1.Free;
      end;
      if Sender <> nil then
        projectoptionstoform(Sender);
      restorevalues(Sender, buffer);
    except
      application.handleexception;
    end;
    projectoptions.disabled := [];
    if Sender <> nil then
      restorestat(stream1)
    else
    begin
      stream1.Free;
      expandprojectmacros;
    end;
  end;
end;

procedure tprojectoptionsfo.loadexe(const Sender: TObject);
begin
  doloadexe(self);
end;

procedure dosaveexe(const Sender: tprojectoptionsfo);
var
  stat1: tstatwriter;
  stream1: ttextstream;
  fname1: filenamety;
begin
  if Sender <> nil then
  begin
    storemacros(Sender);
    fname1 := Sender.settingsfile.Value;
    expandprmacros1(fname1);
    if findfile(fname1) and not askyesno(lang_stockcaption[ord(sc_file)] + fname1 + ' '+
      lang_actionsmodule[ord(ac_exists)] + lineend +
      lang_actionsmodule[ord(ac_wantoverwrite)], lang_stockcaption[Ord(sc_warningupper)]) then
      Exit;
  end
  else
  begin
    fname1 := projectoptions.o.settingsfile;
    expandprmacros1(fname1);
  end;
  if fname1 <> '' then
  begin
    stat1 := tstatwriter.Create(fname1, ce_utf8, True);
    with projectoptions do
      try
        savestat(stream1);
        if Sender <> nil then
          formtoprojectoptions(Sender);

        //    e.fpgdesigner := projectoptionsfo.fpgdesignerenabled.value;
        disabled := getdisabledoptions;
        stat1.setsection('projectoptions');
        if o.settingsprojecttree then
          projecttree.updatestat(stat1);
        if not o.settingsstorage then
        begin
          o.settingsfile        := '';
          o.settingseditor      := False;
          o.settingsdebugger    := False;
          o.settingsstorage     := False;
          o.settingsprojecttree := False;
          o.settingsautoload    := False;
          o.settingsautosave    := False;
        end;
        updateprojectsettings(stat1);
      finally
        disabled := [];
        stat1.Free;
        restorestat(stream1);
      end;
  end;
end;

procedure tprojectoptionsfo.saveexe(const Sender: TObject);
begin
  dosaveexe(self);
end;

procedure tprojectoptionsfo.settingsdataent(const Sender: TObject);
var
  bo1: Boolean;
begin
  bo1 := settingsfile.Value <> '';
  savebu.Enabled := bo1;
  loadbu.Enabled := bo1;
end;

(*
procedure tprojectoptionsfo.extconschangeexe(const sender: TObject);
begin
{$ifndef mswindows}
 xtermcommand.enabled:= externalconsole.value;
{$endif}
end;
*)
procedure tprojectoptionsfo.setxtermcommandexe(const Sender: TObject; var avalue: msestring; var accept: Boolean);
begin
  if avalue = '' then
    avalue := defaultxtermcommand;
end;

procedure tprojectoptionsfo.activateonbreakset(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  raiseonbreak.Enabled := avalue;
end;

procedure tprojectoptionsfo.sourcedirhint(const Sender: TObject; var info: hintinfoty);
begin
  if tcustomedit(Sender).Text = '' then
    hintexpandedmacros(makedir, info)
  else
    hintexpandedmacros(Sender, info);
end;

procedure tprojectoptionsfo.toolshortcutdropdown(const Sender: TObject);
var
  i1: int32;
  act1: taction;
begin
  with toolshortcuts.dropdown do
    for i1 := 0 to valuelist.Count - 1 do
      if actionsmo.gettoolshortcutaction(i1, act1) then
        with act1 do
        begin
          cols[1][i1] := encodeshortcutname(shortcuts);
          cols[2][i1] := encodeshortcutname(shortcuts1);
        end;
end;

procedure tprojectoptionsfo.toolsrowdatachanged(const Sender: tcustomgrid; const acell: gridcoordty);
var
  act1: taction;
begin
  if actionsmo.gettoolshortcutaction(toolshortcuts[acell.row], act1) then
    with act1 do
    begin
      toolsc[acell.row]    := encodeshortcutname(shortcuts);
      toolscalt[acell.row] := encodeshortcutname(shortcuts1);
    end;
end;

procedure tprojectoptionsfo.bracketbkcolhint(const Sender: TObject; var info: hintinfoty);
begin
  info.Caption := tcustomedit(Sender).Text + lineend + info.Caption;
end;

procedure tprojectoptionsfo.initeolstyleexe(const Sender: tenumtypeedit);
begin
  Sender.typeinfopo := typeinfo(eolstylety);
end;

procedure tprojectoptionsfo.onshowpurpose(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin
  // if avalue then makeoptpurpose.visible := true else makeoptpurpose.visible := false;

  if avalue then
    makeoptionsgrid.datacols[0].Visible := True
  else

    makeoptionsgrid.datacols[0].Visible := False;

  //   datacols.items   item[makeoptpurpose]
end;

procedure tprojectoptionsfo.onsource(const Sender: TObject; var avalue: Boolean; var accept: Boolean);
begin

  if avalue then
    actionsmo.projectsourceexe(nil);

end;

procedure tprojectoptionsfo.oncellevext(const Sender: TObject; var info: celleventinfoty);
var
  int1: integer;
begin
  if (info.eventkind = cek_buttonrelease) then
    for int1 := 0 to fo.exeextgrid.rowhigh do
      tbooleanedit(exeextgrid.datacols[info.cell.col].editwidget).gridvalue[int1] := False//tbooleanedit(exeextgrid.datacols[info.cell.col].editwidget).gridvalue[info.cell.row] := true;
  ;
end;

procedure tprojectoptionsfo.oncellevcomp(const Sender: TObject; var info: celleventinfoty);
var
  int1: integer;
begin
  if (info.eventkind = cek_buttonrelease) then
    for int1 := 0 to fo.compilerusedgrid.rowhigh do
      tbooleanedit(compilerusedgrid.datacols[info.cell.col].editwidget).gridvalue[int1] := False//tbooleanedit(exeextgrid.datacols[info.cell.col].editwidget).gridvalue[info.cell.row] := true;
  ;
end;

procedure tprojectoptionsfo.oncellevdeb(const Sender: TObject; var info: celleventinfoty);
var
  int1: integer;
begin
  if (info.eventkind = cek_buttonrelease) then
    for int1 := 0 to fo.debuggerusedgrid.rowhigh do
      tbooleanedit(debuggerusedgrid.datacols[info.cell.col].editwidget).gridvalue[int1] := False//tbooleanedit(exeextgrid.datacols[info.cell.col].editwidget).gridvalue[info.cell.row] := true;
  ;

end;

procedure tprojectoptionsfo.onfocus(const Sender: TObject);
begin
  //tabcloser := False;
end;


{ tprojectoptions }

constructor tprojectoptions.Create;
begin
  ft    := ttextprojectoptions.Create;
  ftexp := ttextprojectoptions.Create;

  closemessages := True;
  checkmethods  := True;
  fcolorerror   := cl_ltred;
  fcolorwarning := cl_ltyellow;
  fcolornote    := cl_ltgreen;
  fcolorhint    := $E6EDFF;
  //showcommandline.color := $F7C6E4 ;
  inherited;
end;

{
destructor tprojectoptions.destroy;
begin
 ft.free;
 ftexp.free;
 inherited;
end;
}
function tprojectoptions.gett: TObject;
begin
  Result := ft;
end;

function tprojectoptions.gettexp: TObject;
begin
  Result := ftexp;
end;

procedure tprojectoptions.setforcezorder(const avalue: longbool);
begin
  fforcezorder := avalue;
  application.forcezorder := avalue;
end;

{ ttextprojectoptions }

constructor teditoptions.Create;
var
  ar1: msestringarty;
begin
  ft    := ttexteditoptions.Create;
  ftexp := ttexteditoptions.Create;

  showgrid         := True;
  snaptogrid       := True;
  moveonfirstclick := True;
  componenthints   := True;
  gridsizex        := defaultgridsizex;
  gridsizey        := defaultgridsizey;
  encoding         := 1; //utf8n
  eolstyle         := 1; //eol_system
  autoindent       := True;
  blockindent      := 1;
  rightmarginon    := True;
  rightmarginchars := 80;
  tabstops         := 4;
  editfontname     := 'mseide_source';
  editfontcolor    := integer(cl_text);
  editbkcolor      := integer(cl_foreground);
  statementcolor   := $E0FFFF;
  pairmarkcolor    := int32(cl_ltyellow);
  editfontantialiased := True;
  editmarkbrackets := True;
  editmarkpairwords := True;
  fpgdesigner      := True;
  backupfilecount  := 2;
  setlength(ar1, 1);
  ar1[0]           := '${TEMPLATEDIR}';
  codetemplatedirs := ar1;
  inherited;
end;

function teditoptions.limitgridsize(const avalue: integer): integer;
begin
  Result   := avalue;
  if Result < 1 then
    Result := 1;
  if Result > 1000 then
    Result := 1000;
end;

procedure teditoptions.setgridsizex(const avalue: integer);
begin
  fgridsizex := limitgridsize(avalue);
end;

procedure teditoptions.setgridsizey(const avalue: integer);
begin
  fgridsizey := limitgridsize(avalue);
end;

function teditoptions.getcodetemplatedirs: msestringarty;
begin
  Result := projectoptions.o.t.codetemplatedirs;
end;

procedure teditoptions.setcodetemplatedirs(const avalue: msestringarty);
begin
  projectoptions.o.t.codetemplatedirs := avalue;
end;

function teditoptions.gett: TObject;
begin
  Result := ft;
end;

function teditoptions.gettexp: TObject;
begin
  Result := ftexp;
end;

{ tdebugoptions }

constructor tdebugoptions.Create;
begin
  ft    := ttextdebugoptions.Create;
  ftexp := ttextdebugoptions.Create;

  valuehints       := True;
  activateonbreak  := True;
  raiseonbreak     := True;
  settty           := True;
  additem(fexceptclassnames, 'EconvertError');
  additem(fexceptignore, False);
  fgdbloadtimeout  := emptyreal;
  fpcgdbworkaround := True;
  inherited;
end;

function tdebugoptions.gett: TObject;
begin
  Result := ft;
end;

function tdebugoptions.gettexp: TObject;
begin
  Result := ftexp;
end;

{ ttextdebugoptions }

constructor ttextdebugoptions.Create;
begin
  fxtermcommand := defaultxtermcommand;
end;

procedure tprojectoptionsfo.setlangprojectoptions();
var
strz : string = '';
begin
  if MSEFallbackLang = 'zh' then strz := '             ';

  Caption := lang_projectoptions[Ord(po_projectoptions)]; // 'Project Options';

  ok.Caption     := lang_modalresult[Ord(mr_ok)];
  cancel.Caption := lang_modalresult[Ord(mr_cancel)];

  editorpage.Caption          := lang_projectoptions[Ord(po_editor)] + strz ; // '&Editor';
  rightmarginon.frame.Caption := lang_projectoptions[Ord(po_rightmarginline)] + strz ; // 'Right Margin Line';
  editmarkbrackets.frame.Caption := lang_projectoptions[Ord(po_markbrackets)] + strz ;
  linenumberson.frame.Caption := lang_projectoptions[Ord(po_linenumbers)] + strz ;
  editmarkpairwords.frame.Caption := lang_projectoptions[Ord(po_markpairwords)] + strz ;
  trimtrailingwhitespace.frame.Caption := lang_projectoptions[Ord(po_trimtrailing)] + strz ;
  autoindent.frame.Caption    := lang_projectoptions[Ord(po_autoindent)] + strz ;
  enablesource.frame.Caption  := lang_projectoptions[Ord(po_nosource)] + strz ;
  tabindent.frame.Caption     := lang_projectoptions[Ord(po_tabindent)] + strz ;
  spacetabs.frame.Caption     := lang_projectoptions[Ord(po_spacetab)] + strz ;
  showtabs.frame.Caption      := lang_projectoptions[Ord(po_showtabs)] + strz ;
  editfontantialiased.frame.Caption := lang_projectoptions[Ord(po_antialiasedfont)] + strz ;
  encoding.frame.Caption      := lang_projectoptions[Ord(po_encoding)] + strz ;
  pairmarkcolor.frame.Caption := lang_projectoptions[Ord(po_markcolor)] + strz ;

  statementcolor.frame.Caption     := lang_projectoptions[Ord(po_statcolor)] + strz ;
  scrollheight.frame.Caption       := lang_projectoptions[Ord(po_scrollbary)] + strz ;
  rightmarginchars.frame.Caption   := lang_projectoptions[Ord(po_nbchar)] + strz ;
  eolstyle.frame.Caption           := lang_projectoptions[Ord(po_eolstyle)] + strz ;
  backupfilecount.frame.Caption    := lang_projectoptions[Ord(po_backup)] + strz ;
  tabstops.frame.Caption           := lang_projectoptions[Ord(po_tabstops)] + strz ;
  blockindent.frame.Caption        := lang_stockcaption[Ord(sc_indent)] + strz ;
  editfontextraspace.frame.Caption := lang_projectoptions[Ord(po_extraspace)] + strz ;
  editfontextraspace.hint          := lang_projectoptions[Ord(po_extraspacehint)] + strz ;
  editfontwidth.frame.Caption      := lang_projectoptions[Ord(po_width)] + strz ;
  editfontheight.frame.Caption     := lang_projectoptions[Ord(po_height)] + strz ;
  editfontname.frame.Caption       := lang_projectoptions[Ord(po_font)] + strz ;
  editbkcolor.frame.Caption        := lang_projectoptions[Ord(po_fontbkcolor)] + strz ;
  editfontcolor.frame.Caption      := lang_projectoptions[Ord(po_fontcolor)] + strz ;

  ttabpage13.Caption := lang_projectoptions[Ord(po_filefilter)] + strz ;
  filefiltergrid.fixrows[-1].captions.Count := 2;
  filefiltergrid.fixrows[-1].captions[0].Caption := lang_stockcaption[ord(sc_name)] + strz ;
  filefiltergrid.fixrows[-1].captions[1].Caption := lang_projectoptions[Ord(po_filemask)] + strz ;

  ttabpage14.Caption := lang_projectoptions[Ord(po_syntaxdeffile)] + strz ;
  twidgetgrid6.fixrows[-1].captions.Count := 2;
  twidgetgrid6.fixrows[-1].captions[0].Caption := lang_stockcaption[ord(sc_name)] + strz ;
  twidgetgrid6.fixrows[-1].captions[1].Caption := lang_projectoptions[Ord(po_filemask)] + strz ;

  ttabpage19.Caption         := lang_projectoptions[Ord(po_codetemplate)] + strz ;
  twidgetgrid5.frame.Caption := lang_projectoptions[Ord(po_fontcodetemplatedir)] + strz ;

  codetemplatedirs.controller.captionopen := lang_projectoptions[Ord(po_selectunitdir)] + strz ;
  debuggerpage.Caption     := lang_projectoptions[Ord(po_debuggerpage)] + strz ;
  ttabpage77.Caption       := lang_projectoptions[Ord(po_projectdebugger)] + strz ;
  ttabpage6.Caption        := lang_projectoptions[Ord(po_searchdirectories)] + strz ;
  ttabpage6.hint           := lang_projectoptions[Ord(po_searchdirectorieshint)] + strz ;
  sourcedirs.controller.captionopen := lang_projectoptions[Ord(po_selectsourcedir)] + strz ;
  sourcebase.frame.Caption := lang_projectoptions[Ord(po_objectbasedir)] + strz ;
  sourcebase.controller.captionopen := lang_projectoptions[Ord(po_selectsourcebasedir)] + strz ;
  ttabpage9.Caption        := lang_projectoptions[Ord(po_defines)] + strz ;
  ttabpage7.Caption        := lang_projectoptions[Ord(po_signals)] + strz ;
  ttabpage8.Caption        := lang_projectoptions[Ord(po_exception)] + strz ;
  ttabpage16.Caption       := lang_projectoptions[Ord(po_target)] + strz ;
  gdbservercommandattach.frame.Caption := lang_projectoptions[Ord(po_startgdbattachtarget)] + strz ;
  nogdbserverexit.frame.Caption := lang_projectoptions[Ord(po_nogdbserverexit)] + strz ;
  beforeconnect.frame.Caption := lang_projectoptions[Ord(po_beforeconnect)] + strz ;
  beforeload.frame.Caption := lang_projectoptions[Ord(po_beforeload)] + strz ;
  beforerun.frame.Caption := lang_projectoptions[Ord(po_beforerun)] + strz ;
  afterconnect.frame.Caption := lang_projectoptions[Ord(po_afterconnect)] + strz ;
  afterload.frame.Caption  := lang_projectoptions[Ord(po_afterload)] + strz ;
  gdbservercommand.frame.Caption := lang_projectoptions[Ord(po_gdbservercommand)] + strz ;
  gdbserverwait.frame.Caption := lang_projectoptions[Ord(po_gdbserverwait)] + strz ;
  gdbserverstartonce.frame.Caption := lang_projectoptions[Ord(po_gdbserverstartonce)] + strz ;
  uploadcommand.frame.Caption := lang_projectoptions[Ord(po_uploadcommand)] + strz ;
  gdbprocessor.frame.Caption := lang_projectoptions[Ord(po_gdbprocessor)] + strz ;
  gdbsimulator.frame.Caption := lang_projectoptions[Ord(po_gdbsimulator)] + strz ;
  gdbdownload.frame.Caption := lang_projectoptions[Ord(po_gdbdownload)] + strz ;
  startupbkpt.frame.Caption := lang_projectoptions[Ord(po_startupbkpt)] + strz ;
  remoteconnection.frame.Caption := lang_projectoptions[Ord(po_remoteconnection)] + strz ;
  downloadalways.frame.Caption := lang_projectoptions[Ord(po_downloadalways)] + strz ;
  downloadalways.hint      := lang_projectoptions[Ord(po_downloadalwayshint)] + strz ;
  gdbloadtimeout.frame.Caption := lang_projectoptions[Ord(po_gdbloadtimeout)] + strz ;
  externalconsole.frame.Caption := lang_projectoptions[Ord(po_externalconsole)] + strz ;
  stoponexception.frame.Caption := lang_projectoptions[Ord(po_stoponexception)] + strz ;
  stoponexception.hint     := lang_projectoptions[Ord(po_stoponexceptionhint)] + strz ;
  activateonbreak.frame.Caption := lang_projectoptions[Ord(po_activateonbreak)] + strz ;
  activateonbreak.hint     := lang_projectoptions[Ord(po_activateonbreakhint)] + strz ;
  valuehints.frame.Caption := lang_projectoptions[Ord(po_valuehints)] + strz ;
  nodebugbeginend.frame.Caption := lang_projectoptions[Ord(po_nodebugbeginend)] + strz ;
  nodebugbeginend.hint     := lang_projectoptions[Ord(po_nodebugbeginendhint)] + strz ;
  settty.frame.Caption     := lang_projectoptions[Ord(po_settty)] + strz ;
  raiseonbreak.frame.Caption := lang_projectoptions[Ord(po_raiseonbreak)] + strz ;
  raiseonbreak.hint        := lang_projectoptions[Ord(po_raiseonbreakhint)] + strz ;
  fpcgdbworkaround.frame.Caption := lang_projectoptions[Ord(po_fpcgdbworkaround)] + strz ;
  fpcgdbworkaround.hint    := lang_projectoptions[Ord(po_fpcgdbworkaroundhint)] + strz ;

  debugtarget.frame.Caption  := lang_projectoptions[Ord(po_debugtarget)] + strz ;
  xtermcommand.frame.Caption := lang_projectoptions[Ord(po_xtermcommand)] + strz ;
  runcommand.frame.Caption   := lang_projectoptions[Ord(po_runcommand)] + strz ;
  debugcommand.frame.Caption := lang_projectoptions[Ord(po_debugcommand)] + strz ;
  debugoptions.frame.Caption := lang_projectoptions[Ord(po_debugoptions)] + strz ;
  makepage.Caption           := lang_projectoptions[Ord(po_makepage)] + strz ;

  defaultmake.frame.Caption       := lang_projectoptions[Ord(po_defaultmake)] + strz ;
  mainfile.frame.Caption          := lang_projectoptions[Ord(po_mainfile)] + strz ;
  mainfile.controller.captionopen := lang_projectoptions[Ord(po_selectmainfile)] + strz ;
  targetfile.frame.Caption        := lang_projectoptions[Ord(po_targetfile)] + strz ;
  targetfile.controller.captionopen := lang_projectoptions[Ord(po_selecttargetfile)] + strz ;
  makecommand.frame.Caption       := lang_projectoptions[Ord(po_makecommand)] + strz ;
  makecommand.controller.captionopen := lang_projectoptions[Ord(po_selectmakecommand)] + strz ;

  showcommandline.Caption    := lang_projectoptions[Ord(po_showcommandline)] + strz ;
  copymessages.frame.Caption := lang_projectoptions[Ord(po_copymessages)] + strz ;

  closemessages.frame.Caption := lang_projectoptions[Ord(po_closemessages)] + strz ;
  checkmethods.frame.Caption  := lang_projectoptions[Ord(po_checkmethods)] + strz ;
  checkmethods.hint           := lang_projectoptions[Ord(po_checkmethodshint)] + strz ;
  ttabpage66.Caption          := lang_projectoptions[Ord(po_projectcompiler)] + strz ;
  ttabpage17.Caption          := lang_projectoptions[Ord(po_commandbefore)] + strz ;
  ttabpage12.Caption          := lang_projectoptions[Ord(po_makeoptions)] + strz ;
  ttabpage11.Caption          := lang_projectoptions[Ord(po_directories)] + strz ;
  unitdirs.controller.captionopen := lang_projectoptions[Ord(po_selectunitdir)] + strz ;
  ttabpage18.Caption          := lang_projectoptions[Ord(po_commandafter)] + strz ;
  ttabpage88.Caption          := lang_projectoptions[Ord(po_exeextension)] + strz ;

  ttabpage22.Caption := lang_projectoptions[Ord(po_comments)] + strz ;
  makedir.frame.Caption := lang_projectoptions[Ord(po_makedir)] + strz ;
  makedir.controller.captionopen := lang_projectoptions[Ord(po_selectmakedir)] + strz ;
  colorerror.frame.Caption := lang_projectoptions[Ord(po_colorerror)] + strz ;
  colorwarning.frame.Caption := lang_projectoptions[Ord(po_colorwarning)] + strz ;
  colornote.frame.Caption := lang_projectoptions[Ord(po_colornote)] + strz ;
  colorhint.frame.Caption := lang_projectoptions[Ord(po_colorhint)] + strz ;
  stripmessageesc.frame.Caption := lang_projectoptions[Ord(po_stripmessageesc)] + strz ;
  stripmessageesc.hint := lang_projectoptions[Ord(po_stripmessageeschint)] + strz ;
  showconsole.frame.Caption := lang_projectoptions[Ord(po_showconsole)] + strz ;
  enablepurpose.frame.Caption := lang_projectoptions[Ord(po_enablepurpose)] + strz ;
  messageoutputfile.frame.Caption := lang_projectoptions[Ord(po_messageoutputfile)] + strz ;
  messageoutputfile.controller.captionopen := lang_projectoptions[Ord(po_selecttargetfile)] + strz ;
  ttabpage1.Caption  := lang_projectoptions[Ord(po_macros)] + strz ;
  selectactivegroupgrid.frame.Caption := lang_projectoptions[Ord(po_selectactivegroupgrid)] + strz ;
  fontaliaspage.Caption := lang_projectoptions[Ord(po_fontaliaspage)] + strz ;
  tabdesigners.Caption := lang_projectoptions[Ord(po_designers)] + strz ;
  ttabpage10.Caption := lang_projectoptions[Ord(po_usercolors)] + strz ;
  tbutton1.Caption   := lang_projectoptions[Ord(po_copycolor)] + strz ;
  ttabpage21.Caption := lang_projectoptions[Ord(po_formatmacro)] + strz ;
  ttabpage21.tabhint := lang_projectoptions[Ord(po_formatmacrohint)] + strz ;
  ttabpage2.Caption  := lang_projectoptions[Ord(po_templates)] + strz ;
  ttabpage3.Caption  := lang_projectoptions[Ord(po_newproject)] + strz ;
  scriptbeforecopy.frame.Caption := lang_projectoptions[Ord(po_scriptbeforecopy)] + strz ;
  scriptaftercopy.frame.Caption := lang_projectoptions[Ord(po_scriptaftercopy)] + strz ;
  ttabpage4.Caption  := lang_projectoptions[Ord(po_newfile)] + strz ;
  ttabpage5.Caption  := lang_projectoptions[Ord(po_newform)] + strz ;
  ttabpage15.Caption := lang_stockcaption[Ord(sc_tools)] + strz ;
  ttabpage20.Caption := lang_projectoptions[Ord(po_storage)] + strz ;
  ttabpage23.Caption := lang_projectoptions[Ord(po_infos)] + strz ;
  
  project_name.frame.Caption := lang_projectoptions[Ord(po_projectfullname)] + strz ;
  project_creator.frame.Caption := lang_projectoptions[Ord(po_creator)] + strz ;
  project_license.frame.Caption := lang_projectoptions[Ord(po_license)] + strz ;
  project_date.frame.Caption := lang_projectoptions[Ord(po_projectdate)] + strz ;
 
  project_copyright.frame.Caption := lang_xstockcaption[ord(sc_copyright)] ;
  project_comment.frame.Caption := lang_projectoptions[Ord(po_comments)] + strz ;

end;

procedure tprojectoptionsfo.oncreated(const Sender: TObject);
begin
  setlangprojectoptions();
end;


initialization
  codetemplates := tcodetemplates.Create;

finalization
  projectoptions.o.Free;
  projectoptions.e.Free;
  projectoptions.d.Free;
  FreeAndNil(codetemplates);
end.

