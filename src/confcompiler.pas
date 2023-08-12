unit confcompiler;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
  msestockobjects,
  mseconsts,
  captionideu,
  msetypes,
  mseglob,
  mseguiglob,
  mseguiintf,
  mseapplication,
  msegui,
  msefiledialogx,
  msegraphics,
  msegraphutils,
  mseevent,
  mseclasses,
  msewidgets,
  mseforms,
  msesimplewidgets,
  msebitmap,
  msedataedits,
  msedatanodes,
  mseedit,
  msegrids,
  mseificomp,
  mseificompglob,
  mseifiglob,
  mselistbrowser,
  msemenus,
  msestat,
  msestatfile,
  msestream,
  msestrings,
  msesys,
  SysUtils,
  msegraphedits,
  msescrollbar,
  msedragglob,
  msetabs,
  mseact;

type
  tconfcompilerfo = class(tmseform)
    tab_compilers: ttabwidget;
    tab_pascal: ttabpage;
    tab_c: ttabpage;
    tab_java: ttabpage;
    tab_python: ttabpage;
    tab_other: ttabpage;
    twinep1: tbooleanedit;
    twinep2: tbooleanedit;
    twinep3: tbooleanedit;
    twinep4: tbooleanedit;
    twinep5: tbooleanedit;
    twinep6: tbooleanedit;
    twinep7: tbooleanedit;
    twinep8: tbooleanedit;
    fpccompiler8: tfilenameeditx;
    fpccompiler7: tfilenameeditx;
    fpccompiler6: tfilenameeditx;
    fpccompiler5: tfilenameeditx;
    fpccompiler4: tfilenameeditx;
    fpccompiler3: tfilenameeditx;
    fpccompiler2: tfilenameeditx;
    tlabel2: tlabel;
    fpccompiler: tfilenameeditx;
    othercompiler3: tfilenameeditx;
    twineo2: tbooleanedit;
    twineo1: tbooleanedit;
    othercompiler: tfilenameeditx;
    othercompiler4: tfilenameeditx;
    twineo4: tbooleanedit;
    twineo3: tbooleanedit;
    othercompiler2: tfilenameeditx;
    ccompiler2: tfilenameeditx;
    ccompiler3: tfilenameeditx;
    ccompiler4: tfilenameeditx;
    ccompiler5: tfilenameeditx;
    ccompiler6: tfilenameeditx;
    ccompiler7: tfilenameeditx;
    ccompiler8: tfilenameeditx;
    twinec8: tbooleanedit;
    twinec7: tbooleanedit;
    twinec6: tbooleanedit;
    twinec5: tbooleanedit;
    twinec4: tbooleanedit;
    twinec3: tbooleanedit;
    twinec2: tbooleanedit;
    twinec1: tbooleanedit;
    tlabel7: tlabel;
    ccompiler: tfilenameeditx;
    twinej1: tbooleanedit;
    twinej2: tbooleanedit;
    twinej3: tbooleanedit;
    twinej4: tbooleanedit;
    javacompiler4: tfilenameeditx;
    javacompiler3: tfilenameeditx;
    javacompiler2: tfilenameeditx;
    javacompiler: tfilenameeditx;
    twinepy3: tbooleanedit;
    twinepy4: tbooleanedit;
    pythoncompiler4: tfilenameeditx;
    pythoncompiler3: tfilenameeditx;
    pythoncompiler2: tfilenameeditx;
    twinepy2: tbooleanedit;
    twinepy1: tbooleanedit;
    pythoncompiler: tfilenameeditx;
    tlabel3: tlabel;
    tlabel4: tlabel;
    tlabel5: tlabel;
    but_ok: TButton;
    procedure closeapp(const Sender: TObject);
    procedure oncreatedev(const Sender: TObject);
    procedure onfocus(const Sender: TObject);
    procedure setlangcompilers();

  end;

var
  confcompilerfo: tconfcompilerfo;

implementation

uses
  confcompiler_mfm;

procedure tconfcompilerfo.closeapp(const Sender: TObject);
begin
  Close;
end;

procedure tconfcompilerfo.oncreatedev(const Sender: TObject);
begin
 // setlangcompilers();

{$ifdef windows}

twinep1.enabled := false;
twinep2.enabled := false;
twinep3.enabled := false;
twinep4.enabled := false;
twinep5.enabled := false;
twinep6.enabled := false;
twinep7.enabled := false;
twinep8.enabled := false;

twinec1.enabled := false;
twinec2.enabled := false;
twinec3.enabled := false;
twinec4.enabled := false;
twinec5.enabled := false;
twinec6.enabled := false;
twinec7.enabled := false;
twinec8.enabled := false;

twinej1.enabled := false;
twinej2.enabled := false;
twinej3.enabled := false;
twinej4.enabled := false;

twinepy1.enabled := false;
twinepy2.enabled := false;
twinepy3.enabled := false;
twinepy4.enabled := false;

twineo1.enabled := false;
twineo2.enabled := false;
twineo3.enabled := false;
twineo4.enabled := false;
{$endif}
end;

procedure tconfcompilerfo.onfocus(const Sender: TObject);
begin
  //tabcloser := False;
end;

procedure tconfcompilerfo.setlangcompilers();
begin
Caption        := lang_xstockcaption[ord(sc_configcompilers)];
but_ok.Caption := lang_modalresult[ord(mr_ok)];
end;


end.

