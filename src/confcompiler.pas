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
   but_ok: tbutton;
   tlabel5: tlabel;
   procedure closeapp(const sender: TObject);
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

end.
