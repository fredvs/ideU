unit sourcepage;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface
{$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6060 off}
  {$warn 6018 off}
  {$endif}
{$endif}

uses
 mseconsts,
 msestockobjects,
 captionideu,
 msetextedit,msewidgetgrid,mseforms,classes,mclasses,msegdbutils, confideu,
 msegraphedits,mseevent,msehash,msebitmap,msetabs,msetypes,msedataedits,mseglob,
 mseguiglob,msegui,msesyntaxedit,mseeditglob,mseinplaceedit,msedispwidgets,
 msegraphutils,msegrids,breakpointsform,pascaldesignparser,msefilechange,
 msestrings,mserichstring,mseparser,msegridsglob,projectoptionsform,msegraphics,
 msemenus,msesimplewidgets,msewidgets,mseintegerenter;

type
 sourcepageasynctagty = (spat_showasform{,spat_checkbracket},spat_showsource);

 bookmarkty = record
  row: integer;
  bookmarknum: integer;
 end;
 bookmarkarty = array of bookmarkty;

 tsourcepage = class(ttabform)

   source_editor: twidgetgrid;
   edit: tsyntaxedit;
   dataicon: tdataicon;
   pathdisp: tstringedit;
   linedisp: tlabel;

   tfacecomp1: tfacecomp;
   tfacecomp2: tfacecomp;
   procedure ontimerhide(const Sender: TObject);
   procedure ontimerhint(const Sender: TObject);

   procedure icononcellevent(const sender: tobject; var info: celleventinfoty);
   procedure sourcefooncreate(const sender: tobject);
   procedure sourcefoondestroy(const sender: tobject);
   procedure editoncellevent(const sender: TObject; var info: celleventinfoty);
   procedure editonmodifiedchanged(const sender: tobject; const value: boolean);
   procedure editontextmouseevent(const sender: tobject;
                                              var info: textmouseeventinfoty);
   procedure editoneditnotification(const sender: tobject;
                                              var info: editnotificationinfoty);
   procedure gridonrowsdeleted(const sender: tcustomgrid;
                                              const index,count: integer);
   procedure gridonrowsinserted(const sender: tcustomgrid;
                                              const index,count: integer);
   procedure sourcefoonloaded(const sender: TObject);
   procedure textchanged(const sender: tdatacol; const aindex: integer);
   procedure sourcefoonshow(const sender: TObject);
   procedure editonfontchanged(const sender: TObject);
   procedure sourcefoondeactivate(const sender: TObject);
   procedure gridoncellevent(const sender: TObject; var info: celleventinfoty);
   procedure editonkeydown(const sender: twidget; var info: keyeventinfoty);
   procedure listonkeydown(const sender: twidget; var info: keyeventinfoty);
   
   procedure oncreated(const sender: TObject);
   procedure ondefocus(const sender: TObject);
   procedure onfocus(const sender: TObject);
   procedure onselectchange(const sender: TObject);
  private
   factiverow: integer;
   flasthint: gridcoordty;
   flasthintlength: integer;
   fbackupcreated: boolean;
   ffindpos: gridcoordty;
   ffiletag: longword;
   fsavetime: tdatetime;
   fexecstamp: integer;
   fgotoline: integer;
   ffileloading: integer;
   ffileloaderror: boolean;
   frelpath: filenamety;
   fshowsourcepos: sourceposty;
   procedure setactiverow(const Value: integer);
   procedure setgdb(agdb: tgdbmi);
   procedure setfilepath(const value: filenamety);
   function getfilename: filenamety;
   function getfilepath: filenamety;
   function getrelpath: filenamety;
   procedure replace(all: boolean);
   procedure showprocheaders(const apos: gridcoordty);
   procedure showsourceitems(const apos: gridcoordty);
   procedure showlink(const apos: gridcoordty);
   procedure setsyntaxdef(const value: filenamety);
   procedure showsourcehint(const apos: gridcoordty; const values: stringarty);
   procedure updatelinedisp;
   procedure onmouseev(const sender: twidget;
               var ainfo: mouseeventinfoty);
  protected
   finitialeditpos: gridcoordty;
   finitialbookmarks: bookmarkarty;
   fbracket1,fbracket2: gridcoordty;
   procedure doasyncevent(var atag: integer); override;
   procedure removebookmark(const bookmarknum: integer);
   procedure beginupdate;
   procedure endupdate;
   function checkfilechanged: boolean;
  public
   finitialfilepath: filenamety;
   filechanged: boolean;
   ismoduletext: boolean;
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;
   procedure loadfile(value: filenamety); overload; //no const!
   procedure loadfile; overload; //loads if needed
   function fileloaded: boolean;
   procedure setbackupcreated;
   procedure updatestatvalues;
   procedure updatecaption(const modified: boolean);
   procedure updatebreakpointicons;
   procedure updatebreakpointicon(const info: bkptlineinfoty);
   procedure togglebreakpoint(const arow: integer = -1);
   procedure togglebreakpointenabled(const arow: integer = -1);
   procedure cleardebuglines;
   procedure updatedebuglines;
   procedure hidehint;
   procedure save(newname: filenamety);
   function checksave(noconfirm,multiple: boolean): modalresultty;
   function modified: boolean;
   function source: trichstringdatalist;
   procedure doline;
   procedure dofind;
   procedure repeatfind;
    procedure findback;
   procedure doreplace;
   procedure reload;
   procedure doundo;
   procedure doredo;
   procedure inserttemplate;
   procedure copylatex;
   procedure copywordatcursor();
   procedure selectwordatcursor();
   function cancomment(): boolean;
   function canuncomment(): boolean;
   procedure commentselection();
   procedure uncommentselection();
   function canchangenotify(const info: filechangeinfoty): boolean;
   function getbreakpointstate(arow: integer = -1): bkptstatety;
                     //-1 -> current row
   procedure setbreakpointstate(astate: bkptstatety; arow: integer = -1);
                     //-1 -> acurrent row
   function findbookmark(const bookmarknum: integer): integer;
                     //returns row, -1 if not found
   procedure setbookmark(arow: integer; const bookmarknum: integer);
                     //arow -1 -> current row, bookmarknum < 1 -> clear
   procedure clearbookmark(const bookmarknum: integer);
   function getbookmarks: bookmarkarty;

   property activerow: integer read factiverow write setactiverow;
   property gdb: tgdbmi write setgdb;
   property filename: filenamety read getfilename;
   property relpath: filenamety read getrelpath write frelpath;
   property filepath: filenamety read getfilepath write setfilepath;
   property filetag: longword read ffiletag;
 end;

function getpascalvarname(const edit: tsyntaxedit; pos: gridcoordty;
                      out startpos: gridcoordty): msestring; overload;
function getpascalvarname(const edit: tsyntaxedit;
                             const pos: pointty): msestring; overload;
procedure findintextedit(const edit: tcustomtextedit; var info: findinfoty;
              var findpos: gridcoordty; const backward: boolean = false);


var
autocomplet : integer = 0;

implementation

uses
 sourcepage_mfm,msefileutils,sourceform,main, commandorform, 
 sysutils,finddialogform,replacedialogform,msekeyboard,
 sourceupdate,msefiledialog,msedesigner,mseformatstr,
 msesys,make,actionsmodule,sourcehintform,
 mseedit,msedrawtext,msebits,msearrayutils,msestream,msedesignintf,
 msesysutils,msedesignparser,msesyntaxpainter,msemacros,msecodetemplates,
 mselatex,msesystypes;

 {$ifndef mse_allwarnings}
 {$if fpc_fullversion >= 030100}
  {$warn 5089 off}
  {$warn 5090 off}
  {$warn 5093 off}
  {$warn 6058 off}
 {$endif}
 {$if fpc_fullversion >= 030300}
  {$warn 6060 off}
  {$warn 6018 off}
  {$endif}
{$endif}

const
 pascaldelims = msestring(' :;+-*/(){},=<>' + c_linefeed + c_return + c_tab);
 selectdelims = pascaldelims+'.[]''"';
 nodelimstrings: array[0..0] of msestring = ('->'); //for c
 bmbitshift = 4;
 bmbitmask = integer($3ff0);
 findshowpos = cep_rowcentered;

function getpascalvarname(const edit: tsyntaxedit; pos: gridcoordty;
                          out startpos: gridcoordty): msestring;
var
 int1: integer;
begin
 startpos:= edit.wordatpos(pos,result,pascaldelims,nodelimstrings);
 if (result = '') and (pos.col > 0) then begin
  dec(pos.col);
  startpos:= edit.wordatpos(pos,result,pascaldelims,nodelimstrings);
 end;
 if result <> '' then begin
  for int1:= pos.col - startpos.col + 1 to length(result) do begin
   if (result[int1] = '.') or (result[int1] = '-') and (result[int1+1] = '>') then begin
    setlength(result,int1-1);
    break;
   end;
  end;
 end;
end;

function getpascalvarname(const edit: tsyntaxedit; const pos: pointty): msestring;
var
 po1,po2: gridcoordty;
begin
 if edit.mousepostotextpos(pos,po1,true) then begin
  result:= getpascalvarname(edit,po1,po2);
 end
 else begin
  result:= '';
 end;
end;

{ tsourcepage }


procedure tsourcepage.onmouseev(const sender: twidget;
               var ainfo: mouseeventinfoty);

var
txtvalue, txtvalue2: msestring;
int1 : Integer;
begin
//
       
  if ainfo.eventkind = ek_buttonrelease then
 begin
    if (autocomplet = 2) then begin
        sourcefo.thetimer.Enabled := false;
        sourcefo.thetimer.ontimer := @ontimerhide;
        sourcefo.thetimer.interval :=  15000000 ;
        sourcefo.thetimer.Enabled := true;
      end;
 
       if (autocomplet = 0) or (autocomplet = 2) then
     begin

      if ((ainfo.shiftstate = [ss_double])) and (tedit(sender).text <> '...') then
        begin
        
       pastefromclipboard(txtvalue);
       txtvalue2 := tedit(sender).text;
       int1 := system.pos('|',txtvalue2);
       txtvalue2 := trim(copy(txtvalue2,0,int1-1));
       int1 := system.pos('{',txtvalue2);
       if int1 > 0 then txtvalue2 := trim(copy(txtvalue2,0,int1-1));
       
       if autocomplet <> 2 then begin       
       int1 := system.pos('(',txtvalue2);
       if int1 > 0 then txtvalue2 := trim(copy(txtvalue2,0,int1));
       end;
            
        copytoclipboard(txtvalue2);
       //debuggerfo.statdisp.value:=  tedit(sender).text;
       selectwordatcursor();
       edit.deleteselection;
       edit.paste;
       copytoclipboard(txtvalue);
       edit.clearselection;
       application.processmessages;
       sourcefo.thetimer.Enabled := false;
       sourcefo.thetimer.ontimer := @ontimerhide;
       sourcefo.thetimer.interval :=  500000 ;
       sourcefo.thetimer.Enabled := true;
   end;
  end;
end;
end;

constructor tsourcepage.create(aowner: tcomponent);
begin
 factiverow:= -1;
 fgotoline:= 1;
 fbracket1:= invalidcell;
 fbracket2:= invalidcell;
 inherited create(aowner);
 updatestatvalues;
end;

destructor tsourcepage.destroy;
begin
 inherited;
end;

procedure tsourcepage.doasyncevent(var atag: integer);
var
 mstr1: filenamety;
 po1: pmoduleinfoty;
begin
 case sourcepageasynctagty(atag) of
  spat_showasform: begin
   mstr1:= filepath;
   if sourcefo.closepage(self) then begin
    po1:= mainfo.openformfile(mstr1,true,true,false,true,false);
    if po1 <> nil then begin
     po1^.backupcreated:= fbackupcreated;
     designer.modulechanged(po1);
    end;
   end;
  end;
{
  spat_checkbracket: begin
   dec(fbracketchecking);
   checkbrackets;
  end;
}
  spat_showsource: begin
   sourcefo.naviglist.showsource(fshowsourcepos,true);
    end;
 end;
end;

procedure tsourcepage.sourcefoonloaded(const sender: TObject);
begin
 updatestatvalues;
 source_editor.bottom:= linedisp.top - 1;
end;

procedure tsourcepage.textchanged(const sender: tdatacol;
                                      const aindex: integer);
begin
 sourcechanged(edit.filename);
end;

procedure tsourcepage.updatecaption(const modified: boolean);
var
 str1: filenamety;
begin
 if ffileloading > 0 then begin
  exit;
 end;
 pathdisp.value:= tosysfilepath(finitialfilepath);
 str1:= filename;
 if str1 = '' then begin
  str1:= lang_sourceform[ord(sf_str_new)];
 end;
 if modified then begin
  caption:= '*'+str1;
  sourcefo.textmodified(self);
 end
 else begin
  caption:= str1;
 end;
 if isactivepage then begin
  tsourcefo(tabwidget.parentofcontainer).updatecaption;
 end;
end;

procedure tsourcepage.updatebreakpointicon(const info: bkptlineinfoty);
var
 int1: integer;
begin
 with info do begin
  int1:= line-1;
  if (int1 >= 0) and (int1 <= source_editor.rowhigh) then begin
   setbreakpointstate(state,int1);
  end;
 end;
end;

procedure tsourcepage.updatebreakpointicons;
var
 int1: integer;
 ar1: bkptlineinfoarty;
begin
 ar1:= breakpointsfo.getbreakpointlines(edit.filename);
 for int1:= 0 to high(ar1) do begin
  updatebreakpointicon(ar1[int1]);
 end;
end;

procedure tsourcepage.setsyntaxdef(const value: filenamety);
begin
 try
  edit.setsyntaxdef(value);
  updatestatvalues;
 except
  on e: exception do begin
 {$ifndef darwin} 
     handleerror(e,ansistring(lang_sourceform[ord(sf_syntaxdeffile)]));
 {$endif}  
  end;
 end;
end;

procedure tsourcepage.loadfile(value: filenamety);
begin
 inc(ffileloading);
 try
  edit.loadfromfile(value);
  ismoduletext:= ismoduletext or (fileext(value) = formfileext);
  finitialfilepath:= edit.filename;
  setsyntaxdef(value);
  updatebreakpointicons;
  if mainfo.gdb.execloaded and actionsmo.bluedotsonact.checked then begin
   updatedebuglines;
  end;
 finally
  dec(ffileloading);
 end;
 updatecaption(false);
end;

function tsourcepage.fileloaded: boolean;
begin
 result:= (edit.filename = finitialfilepath) or (finitialfilepath = '');
end;

function tsourcepage.getfilepath: filenamety;
begin
 result:= finitialfilepath;
end;

function tsourcepage.getrelpath: filenamety;
begin
 if fileloaded or (frelpath = '') then begin
  result:= relativepath(finitialfilepath,projectoptions.projectdir);
 end
 else begin
  result:= frelpath;
 end;
end;

function tsourcepage.getfilename: filenamety;
begin
 result:= msefileutils.filename(finitialfilepath);
end;

procedure tsourcepage.loadfile; //loads if needed
var
 mstr1: filenamety;
 int1: integer;
begin
 if not fileloaded then begin
  mstr1:= relpath;
  if findfile(mstr1) then begin
   mstr1:= msefileutils.filepath(mstr1);
  end
  else begin
   mstr1:= finitialfilepath;
  end;
  setfilepath(mstr1);
  sourcefo.filechangenotifyer.addnotification(finitialfilepath,filetag);
  edit.editpos:= finitialeditpos;
  for int1:= 0 to high(finitialbookmarks) do begin
   with finitialbookmarks[int1] do begin
    if (row >= 0) and (bookmarknum >= 0) and (row < source_editor.rowcount) and
             (bookmarknum < 10) then begin
     setbookmark(row,bookmarknum);
    end;
   end;
  end;
 end;
end;

procedure tsourcepage.setfilepath(const value: filenamety);
begin
 if edit.filename <> value then begin
  fbackupcreated:= false;
  ffiletag:= sourcefo.newfiletag;
  loadfile(value);
 end;
end;

procedure tsourcepage.reload;
begin
 loadfile(edit.filename);
end;

procedure tsourcepage.cleardebuglines;
var
 po1: pintegeraty;
 int1: integer;
begin
 if fexecstamp <> 0 then begin
  fexecstamp:= 0;
  po1:= dataicon.datalist.datapo;
  for int1:= 0 to dataicon.datalist.count - 1 do begin
   po1^[int1]:= po1^[int1] and (bmbitmask or integer($80000000));
  end;
  dataicon.datalist.change(-1);
//  dataicon.fillcol(integer($80000000));
  updatebreakpointicons;
 end;
end;

procedure tsourcepage.updatedebuglines;
var
 ar1: integerarty;
 ar2: qwordarty;
 po1: pintegeraty;
 int1,int2: integer;
begin
 if mainfo.gdb.cancommand then begin
  if fexecstamp <> mainfo.execstamp then begin
   fexecstamp:= mainfo.execstamp;
   application.beginwait;
   if mainfo.gdb.listlines(edit.filename,ar1,ar2) = gdb_ok then begin
    po1:= pintegeraty(dataicon.datalist.datapo);
    for int1:= 0 to dataicon.datalist.count - 1 do begin
     po1^[int1]:= po1^[int1] and (bmbitmask or integer($80000000));
    end;
    int2:= dataicon.datalist.count;
    for int1:= 0 to high(ar1) do begin
     if (ar1[int1] > 0) and (ar1[int1] <= int2) then begin
      po1^[ar1[int1]-1]:= po1^[ar1[int1]-1] or integer($80000008);
     end;
    end;
    updatebreakpointicons;
    dataicon.datalist.change(-1);
   end
   else begin
    cleardebuglines;
   end;
   application.endwait;
  end;
 end;
end;

function tsourcepage.checkfilechanged: boolean;
var
 stream1: ttextstream;
 int1,int2: integer;
 po1: prichstringty;
 mstr1: msestring;
begin
 result:= modified;
 if not result then begin
  result:= true;
  if ttextstream.trycreate(stream1,edit.filename,fm_read) = sye_ok then begin
                            //else locked or deleted
   try
    stream1.encoding:= edit.encoding;
    int1:= 0;
    int2:= edit.datalist.count - 1;
    po1:= edit.datalist.datapo;
    for int1:= 0 to int2 do begin
     if not stream1.readln(mstr1) then begin
      if int1 <> int2 then begin
       exit;
      end;
     end;
     if mstr1 <> po1^.text then begin
      exit;
     end;
     inc(po1);
    end;
    if stream1.eof then begin
     result:= false;
    end;
   finally
    stream1.free;
   end;
  end;
 end;
end;

function tsourcepage.canchangenotify(const info: filechangeinfoty): boolean;
begin
 result:= (info.changed - [fc_force,fc_accesstime] <> []) or checkfilechanged();
 with projectoptions,o.texp do begin
  if result and making and o.copymessages and
          (filepath = msefileutils.filepath(messageoutputfile)) then begin
   result:= false;
  end;
 end;
end;

procedure tsourcepage.showsourcehint(const apos: gridcoordty;
                const values: stringarty);
var
 rect1: rectty;
 int1: integer;
 widthtot : integer =0;
begin
  if high(values) >= 0 then begin
  sourcefo.sourcehintwidget:= tsourcehintfo.create(nil);
  with tsourcehintfo(sourcefo.sourcehintwidget) do begin
   if (sourcefo.hintsize.cx <= 0) or (sourcefo.hintsize.cy <= 0) then begin
    sourcefo.hintsize:= size;
   end;
   rect1:= edit.textpostomouserect(apos,true);
   dec(rect1.y,10);
   inc(rect1.cy,40);
   setlength(dispar,length(values));
   for int1:= 0 to high(values) do begin
    dispar[int1]:= tedit.create(sourcefo.sourcehintwidget);
    with dispar[int1] do begin
     initnewcomponent(1.0);
     frame.levelo:= 0;
     frame.framewidth:= 1;
     frame.colorframe:= cl_dkgray;
      optionsedit:= optionsedit + [oe_readonly];
   //  textflags:= [tf_wordbreak,tf_noselect];
     textflags:= [tf_wordbreak];
     textflagsactive:= [tf_wordbreak];
     anchors:= [an_top];

    if mainfo.themenr = 0 then begin
      frame.colorclient := $FEFFF0;
       font.color := cl_black;
      end;

    if mainfo.themenr = 1 then begin
      frame.colorclient := cl_black;
       font.color := cl_white;
      end;

     text:= msestring(values[high(values)-int1]);
     if widthtot < length(text) then widthtot := length(text);
     onmouseevent := @onmouseev;
     onkeydown := @listonkeydown;
      end;
     end;

   for int1:= high(values) downto 0 do begin
    dispar[int1].parentwidget:= sourcefo.sourcehintwidget.container;
   end;
   
   size:= sourcefo.hintsize;
   formonresize(nil);
   widgetrect:= placepopuprect(self.window,rect1,cp_bottomleft,size);
     // fred hint
  sourcefo.fsourcehintwidget.top := sourcefo.fsourcehintwidget.top - (dispar[0].height)+ 4;
 // sourcefo.fsourcehintwidget.left := sourcefo.fsourcehintwidget.left + 30;

  if high(dispar) < 10 then
  sourcefo.fsourcehintwidget.height :=  (high(dispar) + 1) * dispar[0].height
  else sourcefo.fsourcehintwidget.height :=  10 * dispar[0].height;
  
  if round((widthtot * confideufo.fontsize.value) * 0.6) <=
  (sourcefo.left + sourcefo.width - sourcefo.fsourcehintwidget.left - 20) then
  sourcefo.fsourcehintwidget.width :=  round((widthtot * confideufo.fontsize.value) * 0.6)
  else sourcefo.fsourcehintwidget.width := 
  (sourcefo.left + sourcefo.width - sourcefo.fsourcehintwidget.left - 20);
    
   show(false,self.window) ;
  
   dispar[0].setfocus;
 end;

 end
 else begin
  sourcefo.hidesourcehint;
 end;
 activate(false,true); //get focus back
end;

procedure tsourcepage.showprocheaders(const apos: gridcoordty);
var
 ar1: procedureinfoarty;
 ar2: stringarty;
 int1: integer;
 pos1: sourceposty;
begin
 pos1.pos:= apos;

 // fred
 // pos1.pos.col := pos1.pos.col-1;

 ar1:= listprocheaders(edit.filename,pos1);
 setlength(ar2,length(ar1));
 for int1:= 0 to high(ar1) do begin
  ar2[int1]:= sourceupdater.composeprocedureheader(@ar1[int1],true);
 end;
 showsourcehint(apos,ar2);
end;

procedure tsourcepage.showsourceitems(const apos: gridcoordty);
var
 scopes: deflistarty;
 defs: definfopoarty;
 pos1: sourceposty;
 ar1: stringarty;
 int1, intpos: integer;
 noparam : boolean;
 strdefs, strscope, strname, strtmp, strtmp2, strowner : msestring;
begin
 pos1.pos:= apos;

 // fred
 //pos1.pos.col := pos1.pos.col-1;

 listsourceitems(edit.filename,pos1,scopes,defs,100);
 setlength(ar1,length(defs));
 for int1:= 0 to high(defs) do begin
 
  if defs[int1]^.kind = syk_classdef then  
    strdefs := 'CLASS' else
     if defs[int1]^.kind = syk_procdef then  
    strdefs := 'PROC' else
     if defs[int1]^.kind = syk_classprocimp then  
    strdefs := 'CLASS PROC IMP' else
     if defs[int1]^.kind = syk_procimp then  
    strdefs := 'PROC IMP' else
     if defs[int1]^.kind = syk_identuse then  
    strdefs := 'IDENT USE' else
     if defs[int1]^.kind = syk_vardef then  
    strdefs := 'VAR' else
     if defs[int1]^.kind = syk_pardef then  
    strdefs := 'PAR' else
     if defs[int1]^.kind = syk_constdef then  
    strdefs := 'CONST' else
     if defs[int1]^.kind = syk_typedef then  
    strdefs := 'TYPE' else strdefs := '???'; 
          
    if scopes[int1].kind = syk_classdef then  
    strscope := 'CLASS' else
     if scopes[int1].kind = syk_procdef then  
    strscope := 'PROC' else
     if scopes[int1].kind = syk_classprocimp then  
    strscope := 'CLASS PROC IMP' else
     if scopes[int1].kind = syk_procimp then  
    strscope := 'PROC IMP' else
     if scopes[int1].kind = syk_identuse then  
    strscope := 'IDENT USE' else
     if scopes[int1].kind = syk_vardef then  
    strscope := 'VAR' else
     if scopes[int1].kind = syk_pardef then  
    strscope := 'PAR' else
     if scopes[int1].kind = syk_constdef then  
    strscope := 'CONST' else
     if scopes[int1].kind = syk_typedef then  
    strscope := 'TYPE' else
     if scopes[int1].kind = syk_interfacedef then  
    strscope := 'INTERFACE' else
     if scopes[int1].kind = syk_root then  
    strscope := 'ROOT' else strscope := '???';
    
    
        
   
   { 
    (syk_none,syk_nopars,syk_substr,syk_deleted,syk_root,syk_classdef,
                  syk_procdef,syk_procimp,syk_classprocimp,
                  syk_vardef,syk_pardef,
                  syk_constdef,syk_typedef,syk_interfacedef,syk_identuse);
 }
 
 strname := UTF8Decode(defs[int1]^.name);
 
 strowner :=  UTF8Decode(defs[int1]^.owner.name);
 
  if strdefs = 'PROC' then
  begin
  intpos := system.pos('$',strname);
  if intpos > 1 then begin 
  delete(strname,intpos,1);
  Insert('(', strname, intpos);
  noparam := false;
  end else noparam := true;
  
   if copy(defs[int1]^.name,length(defs[int1]^.name),1) = '$' then
   begin
    strdefs := 'FUNCTION';
     delete(strname,length(strname),1);
     Insert('}', strname, length(strname)+1);
     
     strtmp := strname;
     strtmp2 := strname;
     
     if system.pos('$', strtmp) > 0 then
     begin
     
     while system.pos('$', strtmp) > 0 do
     begin
     strtmp2 := strtmp;
     intpos := system.pos('$', strtmp);
     delete(strtmp,intpos,1);
     Insert('%', strtmp, intpos);
      end;
     
    intpos := system.pos('$', strtmp2);
     delete(strtmp2,intpos,1);
     Insert('); {result : ', strtmp2, intpos);  
     
    strname := UTF8Decode(StringReplace(ansistring(strtmp2), '%', ',',  [rfReplaceAll, rfIgnoreCase]));
    
    end else strname := UTF8Decode(StringReplace(ansistring(strtmp2), '(', '(); {result : ',  [rfReplaceAll, rfIgnoreCase]));
     
   end else
   begin
   strdefs := 'PROCEDURE';
   if noparam then  Insert(';', strname, length(strname)+1) else
   Insert(');', strname, length(strname)+1);
   strname := UTF8Decode(StringReplace(ansistring(strname), '$', ',',  [rfReplaceAll, rfIgnoreCase]));
   end;
  end;
  
  ar1[int1]:= ansistring(strname + ' | '+ strdefs + ' of '+ strscope + ' ' + strowner);

 end;
 if high(ar1) >= 99 then begin
  ar1[high(ar1)]:= '...';
 end;
 showsourcehint(apos,ar1);
end;

procedure tsourcepage.editoncellevent(const sender: TObject;
                                                    var info: celleventinfoty);

 procedure checklink;
 var
  pos2: gridcoordty;
 begin
  if info.keyeventinfopo^.shiftstate * shiftstatesmask = [ss_ctrl] then begin
   if edit.mousepostotextpos(translatewidgetpoint(application.mouse.pos,nil,edit),
                                            pos2,true) then begin
    showlink(pos2);
   end;
  end
  else begin
   edit.removelink;
  end;
 end;

var
 pos1,pos2: sourceposty;
 page1: tsourcepage;
 shiftstate1: shiftstatesty;
 bo1: boolean;
 cellpos1: cellpositionty;

begin

 if  ((confideufo.doubleclic.value = false) and ((iscellclick(info,[ccr_nokeyreturn,ccr_dblclick])) and
           (dataicon[info.cell.row] and integer($80000000) <> 0) and
           (info.mouseeventinfopo^.shiftstate*[ss_double,ss_shift,ss_left] =  [ss_double,ss_shift,ss_left])))
            or // fred double click
  ((confideufo.doubleclic.value = true) and ((iscellclick(info,[ccr_nokeyreturn,ccr_dblclick])) and
           (dataicon[info.cell.row] and integer($80000000) <> 0) and
           (info.mouseeventinfopo^.shiftstate = [ss_double])))
  then begin
  include(info.mouseeventinfopo^.eventstate,es_processed);
  breakpointsfo.showbreakpoint(filepath,info.cell.row + 1,true);
  end;

 case info.eventkind of
  cek_exit: begin
   edit.removelink;
  end;
  cek_keyup: begin
   checklink;
  end;
  cek_keydown: begin
   checklink;
   with info.keyeventinfopo^ do begin
    shiftstate1:= shiftstate * shiftstatesmask;
    if not (es_processed in eventstate) then begin
     if ((shiftstate1 = [ss_shift,ss_ctrl]) or
                         (shiftstate1 = [ss_ctrl])) then begin
      include(eventstate,es_processed);
      pos1.pos:= edit.editpos;
        
      if (shiftstate1 = [ss_shift,ss_ctrl]) then begin
          case key of
        key_up,key_down: begin

         if switchheaderimplementation(edit.filename,pos1,pos2,bo1) then begin
          cellpos1:= cep_none;
          if bo1 then begin
           cellpos1:= cep_top;
          end;
          page1:= sourcefo.showsourcepos(pos2,true,cellpos1);

          if page1 <> nil then begin
           page1.source_editor.showcell(makegridcoord(1,pos1.pos.row));
          end;
         end;
        end;
        key_space: begin
         autocomplet := 1 ;
         sourcefo.thetimer.Enabled := false;
         showprocheaders(edit.editpos);
        end;
        else begin
         exclude(eventstate,es_processed);
        end;
       end;
      end
      else begin
       case key of
        key_space: begin
        autocomplet := 0 ;
        showsourceitems(edit.editpos);
        sourcefo.thetimer.Enabled := false;
        end
        else begin
         exclude(eventstate,es_processed);
        end;
       end;
      end;
     end
     else begin
      if shiftstate1 = [] then begin
       include(eventstate,es_processed);
       case key of
        key_escape: begin
         if not sourcefo.hidesourcehint then begin
          exclude(eventstate,es_processed);
         end;
        end;
        else begin
         exclude(eventstate,es_processed);
        end;
       end;
      end;
     end;
    end;
   end;
   end;
 end;
end;

const
 convtab: array[0..7] of bkptstatety =
   //  000      001           010           011
  (bkpts_none,bkpts_normal,bkpts_disabled,bkpts_none,
   //  100      101           110           111
   bkpts_none,bkpts_error,bkpts_none,bkpts_none);

procedure tsourcepage.icononcellevent(const sender: tobject;
  var info: celleventinfoty);
var
 bpinfo: breakpointinfoty;
 astate: bkptstatety;
begin
 with dataicon do begin
  if iscellclick(info) then begin
   astate:= convtab[gridvalue[info.cell.row] and 7];
   fillchar(bpinfo,sizeof(bpinfo),0);
   bpinfo.line:= info.cell.row + 1;
   bpinfo.path:= edit.filename;
   bpinfo.bkpton:= astate in [bkpts_disabled,bkpts_none]; //for toggle
   case astate of
    bkpts_none: begin
     breakpointsfo.addbreakpoint(bpinfo);
    end;
    bkpts_normal,bkpts_disabled,bkpts_error: begin
     if iscellclick(info,[ccr_dblclick]) then begin
      breakpointsfo.deletebreakpoint(bpinfo);
     end
     else begin
      breakpointsfo.updatebreakpointon(bpinfo);
     end;
    end;
   end;
  end;
 end;
end;

function tsourcepage.getbreakpointstate(arow: integer = -1): bkptstatety;
begin
 if arow = -1 then begin
  arow:= source_editor.row;
 end;
 if (arow >= 0) and (arow < source_editor.rowcount) then begin
  result:= convtab[dataicon[arow] and 7];
 end
 else begin
  result:= bkpts_none;
 end;
end;

procedure tsourcepage.setbreakpointstate(astate: bkptstatety;
                                arow: integer = -1);
begin
 if arow = -1 then begin
  arow:= source_editor.row;
 end;
 if (arow >= 0) and (arow < source_editor.rowcount) then begin
  case astate of
   bkpts_none: dataicon[arow]:= dataicon[arow] and not integer($00000007);
   bkpts_normal: dataicon[arow]:= dataicon[arow] and not integer($00000007) or
                                     integer($80000001);
   bkpts_disabled: dataicon[arow]:= dataicon[arow] and not integer($00000007) or
                                     integer($80000002);
   bkpts_error: dataicon[arow]:= dataicon[arow] and not integer($00000007) or
                                     integer($80000005);
  end;
 end;
end;

procedure tsourcepage.togglebreakpoint(const arow: integer = -1);
var
 bpinfo: breakpointinfoty;
 astate: bkptstatety;
begin
 astate:= getbreakpointstate(source_editor.row);
 fillchar(bpinfo,sizeof(bpinfo),0);
 if arow < 0 then begin
  bpinfo.line:= source_editor.row + 1;
 end
 else begin
  bpinfo.line:= arow + 1;
 end;
 bpinfo.path:= edit.filename;
 case astate of
  bkpts_none: begin
   bpinfo.bkpton:= true;
   breakpointsfo.addbreakpoint(bpinfo);
  end
  else begin
   breakpointsfo.deletebreakpoint(bpinfo);
   setbreakpointstate(bkpts_none,source_editor.row);
         //if breakpointinfo is not synchronized
  end;
 end;
end;

procedure tsourcepage.togglebreakpointenabled(const arow: integer = -1);
var
 bpinfo: breakpointinfoty;
 astate: bkptstatety;
begin
 astate:= convtab[dataicon.value and 7];
 fillchar(bpinfo,sizeof(bpinfo),0);
 if arow < 0 then begin
  bpinfo.line:= source_editor.row + 1;
 end
 else begin
  bpinfo.line:= arow + 1;
 end;
 bpinfo.path:= edit.filename;
 bpinfo.bkpton:= astate in [bkpts_disabled{,bkpts_none}]; //for toggle
 if astate = bkpts_none then begin
  breakpointsfo.addbreakpoint(bpinfo);
 end
 else begin
  breakpointsfo.updatebreakpointon(bpinfo);
 end;
end;

procedure tsourcepage.setactiverow(const Value: integer);
begin
 if factiverow <> value then begin
  if (factiverow >= 0) and (factiverow < source_editor.rowcount) then begin
   source_editor.rowcolorstate[factiverow]:= -1;
  end;
  if (value >= 0) and (value < source_editor.rowcount) then begin
   source_editor.rowcolorstate[value]:= 0;
   source_editor.showcell(makegridcoord(0,value),cep_rowcenteredif);
   edit.editpos:= makegridcoord(0,value)
  end;
 end;
 factiverow := Value;
end;

procedure tsourcepage.setgdb(agdb: tgdbmi);
begin
// breakpoints.fgdb:= agdb;
end;

// fred
procedure tsourcepage.ontimerhint(const Sender: TObject);
begin
  sourcefo.thetimer.Enabled := False;
  
//if tabcloser then begin
 
if sourcefo.tabdeleted = false then
begin
  if (edit.editpos.col > -1) and (edit.editpos.row > -1) then
  begin
  autocomplet := 2 ;
  showsourceitems(edit.editpos);
  sourcefo.thetimer.ontimer := @ontimerhide;
  sourcefo.thetimer.interval :=  15000000 ;
  sourcefo.thetimer.Enabled := true;
 //sleep(200);
   activate(false,true); //get focus back
  end;
end else sourcefo.tabdeleted := false;
//end;
end;

// fred
procedure tsourcepage.ontimerhide(const Sender: TObject);
begin
  sourcefo.thetimer.Enabled := False;
//if tabcloser then begin
  debuggerfo.statdisp.value:= '';
 sourcefo.hidesourcehint;
// end;
end;

procedure tsourcepage.sourcefooncreate(const sender: tobject);
begin
end;

procedure tsourcepage.sourcefoondestroy(const sender: tobject);
begin
end;

procedure tsourcepage.editonmodifiedchanged(const sender: tobject;
                                                         const value: boolean);
begin
 updatecaption(value);
end;

function tsourcepage.checksave(noconfirm,multiple: boolean): modalresultty;
begin
 result:= mr_none;
 if not sourcefo.allsaved then begin
  if edit.modified and (noconfirm or
              confirmsavechangedfile(edit.filename,result,multiple)) then begin
   save('');
  end;
 end;
end;

procedure tsourcepage.save(newname: filenamety);
var
 info: fileinfoty;
 po1: prichstringty;
 i1: int32;
 defaulted : boolean;
begin
 if newname = '' then begin
  if (edit.filename = '') then begin
   if filedialog(newname,[fdo_save],'',[],[]) = mr_cancel then begin
    exit;
   end;
  end
  else begin
   newname:= edit.filename;
  end;
 end;
  if confideufo.usedefaulteditoroptions.value then
  createbackupfile(newname,edit.filename,fbackupcreated,
                            confideufo.backupfilecount.value)
  else
   createbackupfile(newname,edit.filename,fbackupcreated,
                            projectoptions.e.backupfilecount);

 if newname <> '' then begin
  sourcefo.filechangenotifyer.removenotification(filepath);
 end;
 finitialfilepath:= newname;
 try
  designnotifications.beforefilesave(idesigner(designer),newname);
 except
  application.handleexception(nil);
 end;
  if confideufo.usedefaulteditoroptions.value then
  defaulted := confideufo.trimtrailingwhitespace.value
  else defaulted := projectoptions.e.trimtrailingwhitespace;

 if defaulted then begin
  edit.datalist.beginupdate();
  try
   po1:= edit.datalist.datapo;
   for i1:= 0 to edit.datalist.count - 1 do begin
    trimright1(po1^.text);
    inc(po1);
   end;
  finally
   edit.datalist.endupdate();
  end;
 end;
 edit.savetofile(newname);
 if newname <> '' then begin
  if ffiletag = 0 then begin
   ffiletag:= sourcefo.newfiletag;
  end;
  sourcefo.filechangenotifyer.addnotification(filepath,filetag,true);
 end;
 setsyntaxdef(newname);
 if getfileinfo(newname,info) then begin
  fsavetime:= info.extinfo1.modtime;
 end;
 updatecaption(false);
end;

function tsourcepage.modified: boolean;
begin
 result:= false;
 if edit <> nil then begin
  result:= edit.modified;
 end;
end;

procedure textnotfound(const ainfo: findinfoty);
begin
 showmessage(lang_sourceform[ord(sf_str_text)]+' '''+
           ainfo.text+''' '+
           lang_actionsmodule[ord(ac_notfound)]);
end;


procedure findintextedit(const edit: tcustomtextedit; var info: findinfoty;
                                  var findpos: gridcoordty;
                                              const backward: boolean = false);
var
 pt1: gridcoordty;
 isback: boolean;
begin
 with info do begin
  if text = '' then begin
   exit;
  end;
  if backward then begin
   info.options:= info.options >< [so_backward];
  end;
  isback:= so_backward in info.options;
  if selectedonly then begin
   if edit.hasselection then begin
    if isback then begin
     normalizetextrect(edit.selectstart,edit.selectend,pt1,findpos);
    end
    else begin
     normalizetextrect(edit.selectstart,edit.selectend,findpos,pt1);
    end;
    if not edit.find(text,options,findpos,pt1,true) then begin
     textnotfound(info);
    end
    else begin
     selectedonly:= false;
    end;
   end;
  end
  else begin
   findpos:= edit.editpos;
//   dec(ffindpos.col);
   if isback then begin
    pt1:= nullcoord;
   end
   else begin
    pt1:= bigcoord;
   end;
   if not edit.find(text,options,findpos,pt1,true,findshowpos) then begin
    if (edit.linecount = 0) or
          isback and (findpos.row = edit.linecount-1) and
                  (findpos.col = length(edit.gridvalue[edit.linecount-1])) or
             not isback and (findpos.row = 0) and (findpos.col = 0) then begin
     textnotfound(info);
    end
    else begin
     if isback then begin
      if askok(lang_sourceform[ord(sf_str_text)]+' '''+text+
               ''' '+lang_actionsmodule[ord(ac_notfound)] +' '+
               lang_sourceform[ord(sf_restartbegin)]) then begin
       findpos:= bigcoord;
       if not edit.find(text,options,findpos,edit.editpos,true,
                                                  findshowpos) then begin
        textnotfound(info);
       end;
      end;
     end
     else begin
      if askok(lang_sourceform[ord(sf_str_text)]+' '''+text+
               ''' '+lang_actionsmodule[ord(ac_notfound)]+' '+
               lang_sourceform[ord(sf_restartbegin)]) then begin
       findpos:= nullcoord;
       if not edit.find(text,options,findpos,edit.editpos,true,
                                                  findshowpos) then begin
        textnotfound(info);
       end;
      end;
     end;
    end;
   end;
  end;
  if backward then begin
   info.options:= info.options >< [so_backward];
  end;
 end;
end;
{
procedure tsourcepage.find;
begin
 findintextedit(edit,projectoptions.findreplaceinfo.find,ffindpos);
end;
}
procedure tsourcepage.beginupdate;
begin
 edit.beginupdate;
 source_editor.focuslock;
 application.beginwait;
end;

procedure tsourcepage.endupdate;
begin
 application.endwait;
 source_editor.focusunlock;
 edit.endupdate;
 updatelinedisp;
end;

procedure tsourcepage.replace(all: boolean);

 function checkescape: boolean;
 begin
  result:= application.waitescaped;
  if result then begin
   endupdate;
   result:= askyesno(lang_sourceform[ord(sf_cancel)]);
   application.processmessages;
   beginupdate;
  end;
 end;

var
 pos1: gridcoordty;
 res1: modalresultty;
 rect1: rectty;
 updatedisabled: boolean;

begin
 with projectoptions.findreplaceinfo,find do begin
  updatedisabled:= false;
  edit.editor.begingroup;
  try
   if selectedonly then begin
    if not edit.hasselection then begin
     exit;
    end
    else begin
     normalizetextrect(edit.selectstart,edit.selectend,ffindpos,pos1);
    end;
   end
   else begin
    ffindpos:= edit.editpos;
    pos1:= bigcoord;
   end;
   if not edit.find(text,options,ffindpos,pos1,true,findshowpos) then begin
    textnotfound(find);
   end
   else begin
    res1:= mr_yes;
    repeat
     if prompt then begin
      rect1:= edit.textpostomouserect(ffindpos);
      res1:= showmessage(lang_sourceform[ord(sf_replaceoccu)],'',
       [mr_yes,mr_all,mr_no,mr_cancel],rect1,source_editor,cp_bottomleft,res1);
     end
     else begin
      res1:= mr_yes;
     end;
     case res1 of
      mr_no: begin
       inc(ffindpos.col,length(text));
      end;
      mr_yes,mr_all: begin
       edit.deleteselection;
       edit.inserttext(ffindpos,replacetext);
       inc(ffindpos.col,length(replacetext));
       if (res1 = mr_all) or (all and not prompt) then begin
        if not updatedisabled then begin
         application.processmessages; //remove message window
         updatedisabled:= true;
         beginupdate;
        end;
        prompt:= false;
        all:= true;
       end;
      end;
      else begin
       exit;
      end;
     end;
    until not all or
              not edit.find(text,options,ffindpos,pos1,true,findshowpos) or
              updatedisabled and checkescape;
   end;
  finally
   if updatedisabled then begin
    endupdate;
   end;
   edit.editor.endgroup;
  end;
 end;
end;

procedure tsourcepage.doline;
var
 d: gridcoordty;
begin

 //if integerenter(fgotoline,1,source_editor.rowcount,
  //    sourcefo.c[ord(gotoline)],sourcefo.c[ord(findline)]) = mr_ok then begin

  source_editor.row:= fgototheline-1;
  d.row := source_editor.row;
  d.col := 1;
   source_editor.selectcell(d, csm_select, False);
   source_editor.focuscell(d);

end;

procedure tsourcepage.dofind;
//var
// ainfo: findinfoty;
begin
 //ainfo:= projectoptions.findreplaceinfo.find;
// if not edit.hasselection then begin
//  ainfo.selectedonly:= false;
// end;
// ainfo.text:= edit.selectedtext;
// if finddialogexecute(ainfo) then begin

  projectoptions.findreplaceinfo.find:= findinfos;
  findintextedit(edit,projectoptions.findreplaceinfo.find,ffindpos);

end;

procedure tsourcepage.doreplace;
var
 ainfo: replaceinfoty;
 res1: modalresultty;
begin
 ainfo:= projectoptions.findreplaceinfo;
// ainfo.find.text:= edit.selectedtext;
 res1:= replacedialogexecute(ainfo);
 if res1 in [mr_ok,mr_all] then begin
  projectoptions.findreplaceinfo:= ainfo;
  replace(res1 = mr_all);
 end;
end;

procedure tsourcepage.repeatfind;
begin
 findintextedit(edit,projectoptions.findreplaceinfo.find,ffindpos);
 // find;
end;

procedure tsourcepage.findback;
begin
 findintextedit(edit,projectoptions.findreplaceinfo.find,ffindpos,true);
end;

procedure tsourcepage.hidehint;
begin
 flasthint:= invalidcell;
 flasthintlength:= 0;
 application.hidehint;
end;

procedure tsourcepage.copywordatcursor();
begin
 edit.selectword(edit.editpos,selectdelims);
 edit.copyselection();
end;

procedure tsourcepage.selectwordatcursor();
begin
 edit.selectword(edit.editpos,selectdelims);
end;

procedure tsourcepage.showlink(const apos: gridcoordty);
begin
 edit.showlink(apos,pascaldelims + '.[]');
end;

procedure tsourcepage.editontextmouseevent(const sender: tobject;
  var info: textmouseeventinfoty);

var
 po1: gridcoordty;
 str1,str2: msestring;
 pos1: sourceposty;
 shiftstate1: shiftstatesty;
begin
 shiftstate1:= info.mouseeventinfopo^.shiftstate * shiftstatesmask;
 if mainfo.gdb.started and projectoptions.d.valuehints then begin
  if info.eventkind = cek_mousepark then begin
   str1:= getpascalvarname(edit,info.pos,po1);
   if (po1.row <> flasthint.row) or (po1.col <> flasthint.col) or
         (length(str1) <> flasthintlength) then begin
    if str1 <> '' then begin
     if mainfo.gdb.readpascalvariable(ansistring(str1),str2) = gdb_ok then begin
      application.showhint(nil,str1 + ' = ' + str2,
       inflaterect(edit.textpostomouserect(po1,true),20),cp_bottomleft,0);
     end
     else begin
      hidehint;
     end;
     flasthint:= po1;
     flasthintlength:= length(str1);
    end
    else begin
     hidehint;
     flasthintlength:= -1;
    end;
   end;
  end;
 end;
 with info do begin
  case eventkind of
   cek_mousemove: begin
    if (shiftstate1 = [ss_ctrl]) and active then begin
     showlink(info.pos);
    end;
   end;
   cek_mouseleave: begin
    edit.removelink;
   end;
   cek_buttonpress: begin
    if (shiftstate1 = [ss_ctrl,ss_left]) {and active} then begin
//     include(info.mouseeventinfopo^.eventstate,es_processed);
     pos1.pos:= info.pos;
     pos1.filename:= designer.designfiles.find(edit.filename);
     if findlinkdest(edit,pos1,str1) then begin
      fshowsourcepos:= pos1;
      asyncevent(ord(spat_showsource));
      //writeln(inttostr(pos1.pos.row));
//      sourcefo.naviglist.showsource(pos1,true);
     end;
    end
    else begin
       if ((confideufo.doubleclic.value = true) and (edit.isdblclicked(info.mouseeventinfopo^))
     and (info.mouseeventinfopo^.shiftstate*[ss_double,ss_shift,ss_left] =  [ss_double,ss_shift,ss_left]))
     or // fred double click
     ((confideufo.doubleclic.value = false) and (edit.isdblclicked(info.mouseeventinfopo^)))
     then begin
      if ss_triple in info.mouseeventinfopo^.shiftstate then begin
       edit.setselection(makegridcoord(0,edit.row),
                            makegridcoord(bigint,edit.row),true);
                            
      end
      else begin
       edit.selectword(info.pos,selectdelims);
      end;
      copytoclipboard(edit.selectedtext,cbb_primary);
      include(info.mouseeventinfopo^.eventstate,es_processed);
     end;
    end;
   end;
  end;
 end;
end;

procedure tsourcepage.updatelinedisp;
begin
 linedisp.caption:= inttostrmse(edit.editpos.row+1) + ':'+ inttostrmse(edit.editpos.col+1);
end;

procedure tsourcepage.editoneditnotification(const sender: tobject;
                                          var info: editnotificationinfoty);
begin
// if (info.action = ea_beforechange) and not edit.syntaxchanging then begin
//  clearbrackets;
// end
// else begin
  if (info.action = ea_indexmoved) and not source_editor.updating then begin
   updatelinedisp;
  end;
//  if info.action in [ea_indexmoved,ea_delchar,ea_deleteselection,ea_pasteselection,
//                     ea_textentered] then begin
//   callcheckbrackets;
//  end;
// end;
end;

procedure tsourcepage.gridonrowsdeleted(const sender: tcustomgrid;
  const index, count: integer);
begin
 breakpointsfo.sourcelinesdeleted(filepath,index+1,count);
 if (factiverow >= 0) and (index <= factiverow) then begin
  factiverow:= factiverow - count;
  if factiverow < index then begin
   activerow:= -1; //removed
  end;
 end;
end;

procedure tsourcepage.gridonrowsinserted(const sender: tcustomgrid;
  const index, count: integer);
begin
 breakpointsfo.sourcelinesinserted(filepath,index+1,count);
 if (factiverow >= 0) and (index <= factiverow) then begin
  factiverow:= factiverow + count;
 end;
end;

procedure tsourcepage.sourcefoonshow(const sender: TObject);
begin
 if not ffileloaderror then begin
  try
   loadfile;
   mainfo.checkbluedots;
  except
   on e: exception do begin
    ffileloaderror:= true;
    application.showasyncexception(e,'');
   // hide;
   close;
 //   parentwidget:= nil;
    release;
   end;
  end;
 end;
end;

procedure tsourcepage.updatestatvalues;
var
 int1: integer;
 colors: syntaxcolorinfoty;
begin
 if edit <> nil then begin
  projectoptionstofont(edit.font);
  with projectoptions do begin
   source_editor.frame.colorclient:= e.editbkcolor;
   source_editor.rowcolors[0]:= e.statementcolor;
   source_editor.datarowheight:= edit.font.lineheight;
   int1:= edit.getcanvas.getstringwidth('oo') div 2;
   with source_editor.fixcols[-1] do begin
    visible:= e.linenumberson;
    font.height:= edit.font.height;
    font.name:= edit.font.name;
   end;
   if e.rightmarginon then begin
    edit.marginlinecolor:= cl_gray;
    edit.marginlinepos:= int1 * e.rightmarginchars;
   end
   else begin
    edit.marginlinecolor:= cl_none;
   end;
   if e.tabstops < 1 then begin
    e.tabstops:= 1;
   end;
   if e.showtabs then begin
    edit.textflags:= edit.textflags + [tf_showtabs];
    edit.textflagsactive:= edit.textflagsactive + [tf_showtabs];
   end
   else begin
    edit.textflags:= edit.textflags - [tf_showtabs];
    edit.textflagsactive:= edit.textflagsactive - [tf_showtabs];
   end;
   edit.tabulators.clear;
   edit.tabulators.defaultdist:= int1 * e.tabstops / edit.tabulators.ppmm;
//   edit.tabulators.setdefaulttabs(int1 * tabstops / edit.tabulators.ppmm);
   edit.autoindent:= e.autoindent;
   edit.markbrackets:= e.editmarkbrackets;
   edit.markpairwords:= e.editmarkpairwords;
   case e.encoding of
    1: begin
     edit.encoding:= ce_utf8;
    end;
    2: begin
     edit.encoding:= ce_iso8859_1;
    end;
    else begin
     edit.encoding:= ce_locale;
    end;
   end;
   case e.eolstyle of
    1: begin
     edit.eolstyle:= eol_system;
    end;
    2: begin
     edit.eolstyle:= eol_unix;
    end;
    3: begin
     edit.eolstyle:= eol_windows;
    end;
    else begin
     edit.eolstyle:= eol_default;
    end;
   end;
   source_editor.wheelscrollheight:= e.scrollheight;
   edit.pairmarkbkgcolor:= e.pairmarkcolor;
   if edit.syntaxpainterhandle >= 0 then begin
    colors:= edit.syntaxpainter.colors[edit.syntaxpainterhandle];

    with colors do begin
     if font <> cl_default then begin
      edit.font.color:= font;
     end;
     if background <> cl_default then begin
      source_editor.frame.colorclient:= background;
     end;
     if (statement <> cl_default) and (source_editor.rowcolors[0] <> cl_none) then begin
      source_editor.datacols[0].color:= statement;
     end else source_editor.datacols[0].color:= source_editor.frame.colorclient;
      if fontline <> cl_default then begin
      source_editor.fixcols[-1].font.color := fontline;
     end;
     if backgroundline <> cl_default then begin
      source_editor.fixcols[-1].color := backgroundline;
     end;
      if focusline <> cl_default then begin
      source_editor.fixcols[-1].colorfocused := focusline;
     end;
      if selected <> cl_default then begin
      source_editor.datacols[1].colorselect := selected;
     end;


    end;
   end;
  end;
 end;
end;

procedure tsourcepage.editonfontchanged(const sender: TObject);
begin
// updatestatvalues;
end;

procedure tsourcepage.sourcefoondeactivate(const sender: TObject);
begin
 sourcefo.hidesourcehint;
end;

procedure tsourcepage.gridoncellevent(const sender: TObject;
             var info: celleventinfoty);
//var
// shiftstate1: shiftstatesty;
begin
// fred
 if (info.eventkind = cek_buttonpress) then
 begin
 //tabcloser := true;
 sourcefo.thetimer.Enabled := false;
 sourcefo.hidesourcehint;
 end;

{
 if (info.eventkind = cek_keydown) then begin
  with info.keyeventinfopo^ do begin
   shiftstate1:= shiftstate * shiftstatesmask;
   if (shiftstate1 = [ss_ctrl]) and
        (key >= key_0) and (key <= key_9) then begin
    if sourcefo.findbookmark(ord(key) - ord(key_0)) then begin
     include(eventstate,es_processed);
    end;
   end
   else begin
    if (shiftstate1 = [ss_ctrl,ss_shift]) and
         (keynomod >= key_0) and (keynomod <= key_9) then begin
     sourcefo.setbookmark(self,info.cell.row,ord(keynomod) - ord(key_0));
     include(eventstate,es_processed);
    end;
   end;
  end;
 end;
}
end;

function tsourcepage.findbookmark(const bookmarknum: integer): integer;
var
 int1,int2,int3: integer;
 po1: pintegeraty;
begin
 result:= -1;
 for int3:= 0 to high(finitialbookmarks) do begin
  if finitialbookmarks[int3].bookmarknum = bookmarknum then begin
   loadfile;
   po1:= dataicon.griddata.datapo;
   int2:= 1 shl (bookmarknum + bmbitshift);
   for int1:= 0 to source_editor.rowcount - 1 do begin
    if po1^[int1] and bmbitmask = int2 then begin
     result:= int1;
     break;
    end;
   end;
  end;
 end;
end;

procedure tsourcepage.removebookmark(const bookmarknum: integer);
var
 int1: integer;
begin
 for int1:= high(finitialbookmarks) downto 0 do begin
  if finitialbookmarks[int1].bookmarknum = bookmarknum then begin
   deleteitem(finitialbookmarks,typeinfo(bookmarkarty),int1);
  end;
 end;
end;

procedure tsourcepage.setbookmark(arow: integer; const bookmarknum: integer);
             //arow -1 -> current row, bookmarknum < 1 -> clear
begin
 if arow < 0 then begin
  arow:= source_editor.row;
 end;
 if arow >= 0 then begin
  if bookmarknum < 0 then begin
   dataicon[arow]:= dataicon[arow] and not bmbitmask;
   removebookmark(bookmarknum);
  end
  else begin
   dataicon[arow]:= replacebits(longword(1 shl (bookmarknum + bmbitshift)),
                                longword(dataicon[arow]),longword(bmbitmask));
   setlength(finitialbookmarks,high(finitialbookmarks)+2);
   finitialbookmarks[high(finitialbookmarks)].bookmarknum:= bookmarknum;
  end;
 end;
end;

procedure tsourcepage.clearbookmark(const bookmarknum: integer);
var
 int1,int2: integer;
 po1: pintegeraty;
begin
 removebookmark(bookmarknum);
 po1:= dataicon.griddata.datapo;
 int2:= 1 shl (bookmarknum + bmbitshift);
 for int1:= 0 to source_editor.rowcount - 1 do begin
  if po1^[int1] and bmbitmask = int2 then begin
   dataicon[int1]:= po1^[int1] and not bmbitmask;
  end;
 end;
end;

function tsourcepage.getbookmarks: bookmarkarty;
var
 int1,int2: integer;
 po1: pintegeraty;
 lwo1: longword;
begin
 if not fileloaded then begin
  result:= copy(finitialbookmarks);
 end
 else begin
  po1:= dataicon.griddata.datapo;
  int2:= 0;
  result:= nil;
  for int1:= 0 to source_editor.rowcount - 1 do begin
   lwo1:= po1^[int1] and bmbitmask;
   if lwo1 <> 0 then begin
    additem(result,typeinfo(bookmarkarty),int2);
    with result[int2-1] do begin
     row:= int1;
     bookmarknum:= lowestbit(lwo1) - bmbitshift;
    end;
   end;
  end;
  setlength(result,int2);
 end;
end;

procedure tsourcepage.setbackupcreated;
begin
 fbackupcreated:= true;
end;

procedure tsourcepage.listonkeydown(const sender: twidget; var info: keyeventinfoty);
begin

 if (autocomplet = 2) then begin
        sourcefo.thetimer.Enabled := false;
        sourcefo.thetimer.ontimer := @ontimerhide;
        sourcefo.thetimer.interval :=  15000000 ;
        sourcefo.thetimer.Enabled := true;
      end;
     
end;
   

procedure tsourcepage.editonkeydown(Const sender: twidget; Var info: keyeventinfoty);
var
  shiftstate1: shiftstatesty;
begin
  with info,tsyntaxedit(sender).editor,projectoptions do
    begin
      if e.spacetabs and (e.tabstops > 0) and (shiftstate = []) and
         (key = key_tab) then
        begin
          chars := charstring(msechar(' '),
                   (curindex Div e.tabstops + 1) * e.tabstops - curindex);

        end;
    end;

  with info do
    begin
      shiftstate1 := shiftstate * shiftstatesmask;
    end;
  if ((shiftstate1 = [ss_shift,ss_ctrl]) or
     (shiftstate1 = [ss_ctrl])) then sourcefo.thetimer.Enabled := false
     else
    begin
      if debuggerfo.properties_list.tag = 1 then
        begin
          sourcefo.thetimer.Enabled := false;
          sourcefo.thetimer.ontimer := @ontimerhint;
          sourcefo.hidesourcehint;
          sourcefo.thetimer.interval :=  1600000 ;
          sourcefo.thetimer.Enabled := true;
        end
      else
        begin
          if sourcefo.thetimer.Enabled = true then
            begin
              sourcefo.thetimer.Enabled := false;
              sourcefo.hidesourcehint;
            end;
        end;
    end;

end;

function tsourcepage.source: trichstringdatalist;
begin
 result:= edit.datalist;
end;

procedure tsourcepage.doundo;
begin
 beginupdate;
 edit.undo;
 endupdate;
end;

procedure tsourcepage.doredo;
begin
 beginupdate;
 edit.redo;
 endupdate;
end;

procedure tsourcepage.inserttemplate;
var
 mstr1,mstr2: msestring;
// po1: pmsechar;
 po2: ptemplateinfoty;
 gc1,gc2: gridcoordty;
 int1: integer;
 mac1: tmacrolist;
 ar1: msestringarty;
begin
 gc1:= edit.editpos;
 if gc1.row >= 0 then begin
  mstr1:= edit.wordatpos(gc1,gc2,'',[],true);
  if gc2.col < 0 then begin
   gc2.col:= gc1.col;
  end;
  mac1:= getmacros;
  try
   po2:= codetemplates.gettemplate(mstr1,mstr2,mac1);
   if po2 <> nil then begin
    with edit,po2^ do begin
     editor.begingroup;
     gc1.col:= gc2.col+length(mstr1);
     deletetext(gc2,gc1);
     if indent then begin
      ar1:= breaklines(mstr2);
      for int1:= 1 to high(ar1) do begin
       ar1[int1]:= charstring(msechar(' '),gc2.col)+ar1[int1];
      end;
      mstr2:= concatstrings(ar1,lineend);
     end;
     inserttext(gc2,mstr2,select);
     if not select then begin
      if indent or (cursorpos.row = 0) then begin
       gc2.col:= gc2.col + cursorpos.col;
      end
      else begin
       gc2.col:= cursorpos.col;
      end;
      gc2.row:= gc2.row + cursorpos.row;
      editpos:= gc2;
     end;
    end;
    edit.editor.endgroup;
   end;
  finally
   mac1.free;
  end;
 end;
end;

procedure tsourcepage.copylatex;
begin
 copytoclipboard(richstringtolatex(edit.selectedrichtext));
end;

function tsourcepage.cancomment(): boolean;
begin
 result:= edit.hasselection and (edit.selectstart.col = 0) and
                                                  (edit.selectend.col = 0);
end;

function tsourcepage.canuncomment(): boolean;
var
 po1,pe: prichstringty;
 start,stop: int32;
begin
 result:= cancomment();
 if result then begin
  edit.getselectedrows(start,stop);
  po1:= edit.datalist.getitempo(start);
  pe:= po1 + stop - start;
  while po1 <= pe do begin
   if (length(po1^.text) < 2) or (po1^.text[1] <> '/') or
                                            (po1^.text[2] <> '/') then begin
    result:= false;
    break;
   end;
   inc(po1);
  end;
 end;
end;

procedure tsourcepage.commentselection();
var
 mstr1: msestring;
 i1: int32;
 start,stop: int32;
 gc1: gridcoordty;
begin
 if cancomment() then begin
  edit.getselectedrows(start,stop);
  edit.editor.begingroup();
  mstr1:= edit.selectedtext;
  insert('//',mstr1,1);
  i1:= 3;
  while mstr1[i1] <> #0 do begin
   if mstr1[i1] = c_return then begin
    inc(i1);
   end;
   if mstr1[i1] = c_linefeed then begin
    inc(i1);
    if mstr1[i1] = #0 then begin
     break;
    end;
    insert('//',mstr1,i1);
   end;
   inc(i1);
  end;
  source_editor.beginupdate();
  edit.deleteselection();
  edit.inserttext(mstr1,true);
  source_editor.endupdate();
  edit.editor.endgroup();
  edit.refreshsyntax(start,stop-start);
 end
   else
 begin // comment line - no selection needed
   gc1 := edit.editpos;
   mstr1 := edit.datalist.items[gc1.row];
   edit.datalist.items[gc1.row] := '//' + mstr1;
   edit.col := edit.col + 2; // advance edit cursor due to inserted text
 end;
end;

procedure tsourcepage.uncommentselection();
var
 mstr1: msestring;
 i1: int32;
 start,stop: int32;
begin
 if canuncomment() then begin
  edit.getselectedrows(start,stop);
  edit.editor.begingroup();
  mstr1:= edit.selectedtext;
  delete(mstr1,1,2);
  i1:= 1;
  while mstr1[i1] <> #0 do begin
   if mstr1[i1] = c_return then begin
    inc(i1);
   end;
   if mstr1[i1] = c_linefeed then begin
    inc(i1);
    if mstr1[i1] = #0 then begin
     break;
    end;
    delete(mstr1,i1,2);
    dec(i1);
   end;
   inc(i1);
  end;
  source_editor.beginupdate();
  edit.deleteselection();
  edit.inserttext(mstr1,true);
  source_editor.endupdate();
  edit.editor.endgroup();
  edit.refreshsyntax(start,stop-start);
 end;
end;

procedure tsourcepage.oncreated(const sender: TObject);
var
color0, color1, color2 : longword;
begin
// icon := mainfo.icon;
if mainfo.themenr = 0 then begin
pathdisp.face.template := debuggerfo.templatemain;
pathdisp.font.color := cl_black;
linedisp.face.template := debuggerfo.templatemain;
linedisp.font.color := cl_black;
color := cl_ltgray;
container.color := cl_ltgray;
color0 := cl_ltgray;
color1 := cl_dkgray;
color2 := cl_black;
end;
if mainfo.themenr = 1 then begin
pathdisp.face.template := debuggerfo.templatemaindark;
pathdisp.font.color := cl_white;
linedisp.face.template := debuggerfo.templatemaindark;
linedisp.font.color := cl_white;
color := cl_black;
container.color := cl_black;
color0 := cl_dkgray;
color1 := cl_black;
color2 := cl_white;
end;

source_editor.frame.sbhorz.facebutton.fade_color.items[1] := color0;
source_editor.frame.sbhorz.facebutton.fade_color.items[0] := color1;
source_editor.frame.sbhorz.face.fade_color.items[0] := color0;
source_editor.frame.sbhorz.face.fade_color.items[1] := color1;
source_editor.frame.sbhorz.face1.fade_color.items[0] := color0;
source_editor.frame.sbhorz.face1.fade_color.items[1] := color1;
source_editor.frame.sbhorz.face2.fade_color.items[0] := color0;
source_editor.frame.sbhorz.face2.fade_color.items[1] := color1;
source_editor.frame.sbhorz.faceendbutton.fade_color.items[0] := color0;
source_editor.frame.sbhorz.faceendbutton.fade_color.items[1] := color1;
source_editor.frame.sbhorz.colorglyph := color2;

source_editor.frame.sbvert.facebutton.fade_color.items[1] := color0;
source_editor.frame.sbvert.facebutton.fade_color.items[0] := color1;
source_editor.frame.sbvert.face.fade_color.items[0] := color0;
source_editor.frame.sbvert.face.fade_color.items[1] := color1;
source_editor.frame.sbvert.face1.fade_color.items[0] := color0;
source_editor.frame.sbvert.face1.fade_color.items[1] := color1;
source_editor.frame.sbvert.face2.fade_color.items[0] := color0;
source_editor.frame.sbvert.face2.fade_color.items[1] := color1;
source_editor.frame.sbvert.faceendbutton.fade_color.items[0] := color0;
source_editor.frame.sbvert.faceendbutton.fade_color.items[1] := color1;
source_editor.frame.sbvert.colorglyph := color2;

end;

procedure tsourcepage.ondefocus(const sender: TObject);
begin
//tabcloser := false;
end;

procedure tsourcepage.onfocus(const sender: TObject);
begin
//tabcloser := true;
end;

procedure tsourcepage.onselectchange(const sender: TObject);
begin
end;

end.
