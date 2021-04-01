unit confcompiler;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}
interface
uses
 msetypes,mseglob,mseguiglob,mseguiintf,mseapplication,msegui,msefiledialog,
 msegraphics,msegraphutils,mseevent,mseclasses,msewidgets,mseforms,
 msesimplewidgets,msebitmap,msedataedits,msedatanodes,mseedit,msegrids,
 mseificomp,mseificompglob,mseifiglob,mselistbrowser,msemenus,msestat,
 msestatfile,msestream,msestrings,msesys,sysutils,msegraphedits,msescrollbar,
 msedragglob,msetabs,mseact;
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
   fpccompiler8: tfilenameedit;
   fpccompiler7: tfilenameedit;
   fpccompiler6: tfilenameedit;
   fpccompiler5: tfilenameedit;
   fpccompiler4: tfilenameedit;
   fpccompiler3: tfilenameedit;
   fpccompiler2: tfilenameedit;
   tlabel2: tlabel;
   fpccompiler: tfilenameedit;
   othercompiler3: tfilenameedit;
   twineo2: tbooleanedit;
   twineo1: tbooleanedit;
   othercompiler: tfilenameedit;
   othercompiler4: tfilenameedit;
   twineo4: tbooleanedit;
   twineo3: tbooleanedit;
   othercompiler2: tfilenameedit;
   ccompiler2: tfilenameedit;
   ccompiler3: tfilenameedit;
   ccompiler4: tfilenameedit;
   ccompiler5: tfilenameedit;
   ccompiler6: tfilenameedit;
   ccompiler7: tfilenameedit;
   ccompiler8: tfilenameedit;
   twinec8: tbooleanedit;
   twinec7: tbooleanedit;
   twinec6: tbooleanedit;
   twinec5: tbooleanedit;
   twinec4: tbooleanedit;
   twinec3: tbooleanedit;
   twinec2: tbooleanedit;
   twinec1: tbooleanedit;
   tlabel7: tlabel;
   ccompiler: tfilenameedit;
   twinej1: tbooleanedit;
   twinej2: tbooleanedit;
   twinej3: tbooleanedit;
   twinej4: tbooleanedit;
   javacompiler4: tfilenameedit;
   javacompiler3: tfilenameedit;
   javacompiler2: tfilenameedit;
   javacompiler: tfilenameedit;
   twinepy3: tbooleanedit;
   twinepy4: tbooleanedit;
   pythoncompiler4: tfilenameedit;
   pythoncompiler3: tfilenameedit;
   pythoncompiler2: tfilenameedit;
   twinepy2: tbooleanedit;
   twinepy1: tbooleanedit;
   pythoncompiler: tfilenameedit;
   tlabel3: tlabel;
   tlabel4: tlabel;
   tlabel5: tlabel;
   but_ok: tbutton;
   procedure closeapp(const sender: TObject);
   procedure oncreatedev(const sender: TObject);
   procedure onfocus(const sender: TObject);
 end;
var
 confcompilerfo: tconfcompilerfo;
implementation
uses
 confcompiler_mfm;
procedure tconfcompilerfo.closeapp(const sender: TObject);
begin
close;
end;

procedure tconfcompilerfo.oncreatedev(const sender: TObject);
begin
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

procedure tconfcompilerfo.onfocus(const sender: TObject);
begin
tabcloser:= false;
end;

end.
