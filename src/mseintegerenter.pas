{ MSEgui Copyright (c) 1999-2008 by Martin Schreiber

    See the file COPYING.MSE, included in this distribution,
    for details about the copyright.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
}
unit mseintegerenter;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface
uses
 msestockobjects,
 mseconsts_ide,
  mseconsts_ide_ru,
  mseconsts_ide_pt,
  mseconsts_ide_de,
  mseconsts_ide_es,
  mseconsts_ide_fr,

 mseforms,msedataedits,msesimplewidgets,msetypes,mseglob,mseguiglob,msegui,
 msedialog,msestrings;

type
 tintegerenterfo = class(tdialogform)
   lab: tlabel;
   ok: tbutton;
   value: tintegeredit;
   procedure ondoline(const sender: TObject);
   procedure oncloseev(const sender: TObject);
   procedure setlangsearchline();
 end;

var
 linefo: tintegerenterfo;
 lineformcreated : boolean = false;
 fgototheline : integer;

function integerenter(var avalue: integer; const amin,amax: integer;
         const text: msestring = ''; const acaption: msestring = ''): modalresultty;
//threadsave
implementation
uses
 mseintegerenter_mfm, sourceform, main;

function integerenter(var avalue: integer; const amin,amax: integer; const text: msestring = '';
                               const acaption: msestring = ''): modalresultty;
begin
 //application.lock;
 result := mr_none;
 try
  linefo:= tintegerenterfo.create(nil);
  lineformcreated := true;
  try
   with linefo do begin
    value.value:= avalue;
    value.valuemin:= amin;
    value.valuemax:= amax;
    caption:= acaption;
    lab.caption:= text;
    linefo.show;
    {
    result:= fo.show(true,nil);
    if result = mr_ok then begin
     avalue:= value.value;
    end;
    }
   end;
  finally
   //linefo.Free;
   //lineformcreated:= false;
  end;
 finally
 // application.unlock;
 end;
end;

procedure tintegerenterfo.ondoline(const sender: TObject);
begin
fgototheline := value.value;
 sourcefo.activepage.doline;
end;

procedure tintegerenterfo.oncloseev(const sender: TObject);
begin
 lineformcreated:= false;
end;

procedure tintegerenterfo.setlangsearchline();
begin
  Caption        := stockobjects.captions[sc_line];
  ok.Caption := stockobjects.modalresulttext[mr_ok];

end;

end.
