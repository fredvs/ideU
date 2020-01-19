unit sourceform;

{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

uses
 confideu, ideusettings, commandorform, sysutils, msetimer,msetextedit,
 msewidgetgrid,mseforms,classes,mclasses,msegdbutils,msebitmap,msetabs,
 sourcepage,mseglob,msetypes,msestrings,mseguiglob,msegui,msesyntaxpainter,
 msemenus,mseactions,msestat,finddialogform,msestream,msefilechange, dateutils,
 breakpointsform,mseparser,msesimplewidgets,msegrids,msegraphutils,msegridsglob,
 msestringcontainer,msedragglob,msegraphics,msescrollbar,msewidgets;

type
 stringconsts = (
  str_file,          //0 File "
  haschanged,        //1 " has changed.
  therearemody,      //2 There are modifications in edit buffer also.
  wishreload,        //3 Do you wish to reload from disk?
  confirmation,      //4 Confirmation
  none,              //5 <none>
  wishreplace,       //6 Do you wish to replace:
  str_with,          //7 with:
  str_new,           //8 <new>
  syntaxdeffile,     //9 Syntaxdeffile:
  str_text,          //10 Text
  str_notfound,      //11 not found.
  restartbegin,      //12 Restart from begin of file?
  cancel,            //13 Cancel?
  replaceoccu,       //14 Do you wish to to replace this occurence?
  gotoline,          //15 Go to line number:
  findline,          //16 Find line
  modieditalso,       //17 There are modifications in edit buffer also.
  restartend         //18 Restart from end of file?
 );

 tsourcefo = class;

 tnaviglist = class(tsourceposlist)
  private
   fsourcefo: tsourcefo;
   findex: integer;
   procedure updateshowpos(const acellpos: cellpositionty = cep_rowcenteredif);
  public
   constructor create;
   procedure showsource(const apos: sourceposty; 
                               const asetfocus: boolean = false);
   function back: boolean;
   function forward: boolean;
 end;

 tsourcefo = class(tdockform)
 
     // fred
   TheTimer: TTimer;
   completeclassact: taction;
   tpopupmenu1: tpopupmenu;
   files_tab: ttabwidget;
   syntaxpainter: tsyntaxpainter;
   imagelist: timagelist;
   filechangenotifyer: tfilechangenotifyer;
   navigforwardact: taction;
   navigbackact: taction;
   step_back: tstockglyphbutton;
   step_forward: tstockglyphbutton;
   c: tstringcontainer;
   timagelist2: timagelist;
   tfacecomp1: tfacecomp;
   tfacecomp2: tfacecomp;
   imagelistcopy: timagelist;
   timagelist3: timagelist;
   procedure formonidle(var again: boolean);
   procedure doselectpage(const sender: TObject);

   procedure navigback(const sender: TObject);
   procedure navigforward(const sender: TObject);
   procedure onfilechanged(const sender: tfilechangenotifyer; 
                     const info: filechangeinfoty);
   procedure sourcefoonclosequery(const sender: tcustommseform; 
                    var modalresult: modalresultty);
   procedure tabwidgetpageremoved(const sender: TObject; const awidget: twidget);
   procedure tabwidgetonactivepagechanged(const sender: tobject);
   procedure addwatchactonexecute(const sender: tobject);
   procedure enterexe(const sender: tobject);
   procedure editbreakpointexec(const sender: TObject);
   procedure popupmonupdate(const sender: tcustommenu);
   procedure completeclassexecute(const sender: TObject);
   procedure showasformexe(const sender: TObject);
   procedure setbmexec(const sender: TObject);
   procedure findbmexec(const sender: TObject);
   procedure insguiexec(const sender: TObject);
   procedure convpasex(const sender: TObject);
   procedure insuidexec(const sender: TObject);
   procedure stephintev(const sender: TObject; var info: hintinfoty);
   procedure onpageadd(const sender: TObject; const awidget: twidget);
  private
   fasking: boolean;
   fgdbpage: tsourcepage;
   ffileloading: boolean;
   ffiletag: longword;
   fnaviglist: tnaviglist;
   feditposar: gridcoordarty;
   factbookmark: integer;
   fbookmarkar: array of bookmarkarty;
   fpagedestroying: integer;
   popuprow: integer;
   fallsaved: boolean;
   function geteditpositem(const index: integer): msestring;
   procedure seteditposcount(const count: integer);
   procedure  seteditpositem(const index: integer; const avalue: msestring);
   function getbookmarkitem(const index: integer): msestring;
   procedure setbookmarkcount(const count: integer);
   procedure  setbookmarkitem(const index: integer; const avalue: msestring);
   function getitems(const index: integer): tsourcepage;
   function createnewpage(const afilename: filenamety): tsourcepage;
   function getsourcepos: sourceposty;
   procedure setsourcehintwidget(const avalue: twidget);
  public
   // fred
   tabdeleted : boolean;
   hintsize: sizety;
   fsourcehintwidget: twidget;
   constructor create(aowner: tcomponent); override;
   destructor destroy; override;

   procedure updatestat(const statfiler: tstatfiler);

   function hidesourcehint: boolean;    //false if no action;
   procedure updatebreakpointicon(const path: filenamety; 
                 const info: bkptlineinfoty);
   procedure textmodified(const sender: tsourcepage);
   function openfile(const filename: filenamety;
           aactivate: boolean = false): tsourcepage; //nil if not ok
   function showsourceline(const filename: filenamety;
            line: integer; col: integer = 0; asetfocus: boolean = false;
             const aposition: cellpositionty = cep_rowcentered): tsourcepage;
   function showsourcepos(const apos: sourceposty;
                asetfocus: boolean = false;
                const aposition: cellpositionty = cep_top): tsourcepage;
   procedure resetactiverow;
   function locate(const info: stopinfoty): tsourcepage;
   function count: integer;
   function activepage: tsourcepage;
   function currentselection: msestring;
   function currentfilename: filenamety;
   function currentwordatcursor: msestring;
   procedure updatecaption;
   procedure updatehinttab;
   function newpage: tsourcepage;
   function findsourcepage(afilename: filenamety; wholepath: boolean = true;
                              onlyifloaded: boolean = false): tsourcepage;
   procedure saveactivepage(const newname: filenamety = '');
   function saveall(noconfirm: boolean): modalresultty; //false if canceled
   procedure savecanceled; //resets fallsaved
   property allsaved: boolean read fallsaved;
   function closeactivepage: boolean;
   function closepage(const apage: tsourcepage;
                        noclosecheck: boolean = false): boolean; overload;
   function closepage(const aname: filenamety): boolean; overload;
   function closeall(const nosave: boolean): boolean; //false on cancel
   function gdbpage: tsourcepage;
   function modified: boolean;
   function newfiletag: longword;
   property items[const index: integer]: tsourcepage read getitems; default;
   property naviglist: tnaviglist read fnaviglist;
   function findbookmark(const bookmarknum: integer): boolean;
                                                 //true if found
   procedure setbookmark(const apage: tsourcepage; const arow: integer;
                            const bookmarknum: integer);

   function gettextstream(const filename: filenamety;
                                           forwrite: boolean): ttextstream;
   function getfiletext(const filename: filenamety;
                   const startpos,endpos: gridcoordty): string;
   procedure replacefiletext(const filename: filenamety;
                   const startpos,endpos: gridcoordty; const newtext: string);
   property sourcepos: sourceposty read getsourcepos;
   property sourcehintwidget: twidget read fsourcehintwidget 
                                                    write setsourcehintwidget;
 end;

  errorlevelty = (el_none,el_all,el_hint,el_note,el_warning,el_error);

var
 sourcefo: tsourcefo;

function checkerrormessage(const text: msestring; out alevel: errorlevelty;
           out afilename: filenamety; out col,row: integer): boolean;
function locateerrormessage(const text: msestring; var apage: tsourcepage;
                   minlevel: errorlevelty = el_all): boolean;
         //true if valid errormessage

implementation
uses
 sourceform_mfm,msefileutils,mseformatstr, dialogfiles, 
 projectoptionsform,main,mseeditglob,watchform,msesys,msedesigner,
 selecteditpageform,sourceupdate,mseclasses,msearrayutils,
 msebits,msesysutils,mseintegerenter,panelform;

type
 tsourcepage1 = class(tsourcepage);

function checkerrormessage(const text: msestring; out alevel: errorlevelty;
           out afilename: filenamety; out col,row: integer): boolean;
var
 ar1,ar2,ar3: msestringarty;
 int1: integer;
begin
 result:= false;
 col:= 0;
 row:= 0;
 alevel:= el_none;
 splitstring(text,ar1,msechar('('));
 if length(ar1) > 1 then begin         //try FPC
  splitstring(ar1[1],ar2,msechar(')'));
  if length(ar2) > 1 then begin
   splitstring(ar2[0],ar3,msechar(','));
   if (high(ar3) >= 0) then begin
    if msestartsstr(' Error:',ar2[1]) or 
                    msestartsstr(' Fatal:',ar2[1]) then begin
     alevel:= el_error;
    end
    else begin
     if msestartsstr(' Warning:',ar2[1]) then begin
      alevel:= el_warning;
     end
     else begin
      if msestartsstr(' Note:',ar2[1]) then begin
       alevel:= el_note;
      end
      else begin
       if msestartsstr(' Hint:',ar2[1]) then begin
        alevel:= el_hint;
       end;
      end;
     end;
    end;
    if trystrtoint(ar3[0],row) then begin
     dec(row);
     if high(ar3) >= 1 then begin
      if trystrtoint(ar3[1],col) then begin
       dec(col);
       result:= true;
      end;
     end
     else begin
      result:= true;
     end;
     if result then begin
      afilename:= ar1[0];
     end;
    end;
    if result and (alevel = el_none) then begin
     alevel:= el_all;
    end;
   end;
  end;
 end;
 if (alevel = el_none) and not result then begin
  ar1:= nil;
  ar2:= nil;
  splitstring(text,ar1,msechar(':'));
  if high(ar1) > 2 then begin
   for int1:= 2 to 3 do begin
    ar1[int1]:= struppercase(ar1[int1]);
   end;
   if (ar1[2] = ' ERROR') or (ar1[3] = ' ERROR') then begin
    alevel:= el_error;
   end
   else begin
    if (ar1[2] = ' WARNING') or (ar1[3] = ' WARNING') then begin
     alevel:= el_warning;
    end
    else begin
     if (ar1[2] = ' HINT') or (ar1[3] = ' HINT') then begin
      alevel:= el_hint;
     end
     else begin
      alevel:= el_all;
     end;
    end;
   end;
   if alevel <> el_none then begin
    if trystrtoint(ar1[1],row) then begin
     dec(row);
     if trystrtoint(ar1[2],col) then begin
      dec(col);
     end
     else begin
      col:= 0;
     end;
     afilename:= ar1[0];
     result:= true;
    end;
   end;
  end; 
 end;
end;

function locateerrormessage(const text: msestring; var apage: tsourcepage;
              minlevel: errorlevelty = el_all): boolean;
var
 lev1: errorlevelty;
 col1,row1: integer;
 fna1: filenamety;
begin
 apage:= nil;
 result:= false;
 if checkerrormessage(text,lev1,fna1,col1,row1) and (fna1 <> '') and 
                                                (lev1 >= minlevel) then begin
  apage:= sourcefo.showsourceline(objpath(fna1),row1,col1,true);
  result:= true;
 end;
end;

(*
function locateerrormessage(const text: msestring; var apage: tsourcepage;
              minlevel: errorlevelty = el_all): boolean;
var
 ar1,ar2,ar3: msestringarty;
 col,row: integer;
 alevel: errorlevelty;
 int1: integer;
begin
 apage:= nil;
 result:= false;
 col:= 0;
 row:= 0;
 alevel:= el_all;
 splitstring(text,ar1,msechar('('));
 if length(ar1) > 1 then begin         //try FPC
  splitstring(ar1[1],ar2,msechar(')'));
  if length(ar2) > 1 then begin
   splitstring(ar2[0],ar3,msechar(','));
   if (high(ar3) >= 0) then begin
    if startsstr(' Error:',ar2[1]) or startsstr(' Fatal:',ar2[1]) then begin
     alevel:= el_error;
    end
    else begin
     if startsstr(' Warning:',ar2[1]) then begin
      alevel:= el_warning;
     end
     else begin
      if startsstr(' Hint:',ar2[1]) then begin
       alevel:= el_hint;
      end
      else begin
       if startsstr(' Note:',ar2[1]) then begin
        alevel:= el_hint;
       end;
      end;
     end;
    end;
    if alevel >= minlevel then begin
     if trystrtointmse(ar3[0],row) then begin
      dec(row);
      if high(ar3) >= 1 then begin
       if trystrtointmse(ar3[1],col) then begin
        dec(col);
        result:= true;
       end;
      end
      else begin
       result:= true;
      end;
      if result then begin
       apage:= sourcefo.showsourceline(objpath(ar1[0]),row,col,true);
      end;
     end;
    end;
   end;
  end;
 end;
 if (alevel = el_all) and not result then begin
  ar1:= nil;
  ar2:= nil;
  splitstring(text,ar1,msechar(':'));
  if high(ar1) > 2 then begin
   for int1:= 2 to 3 do begin
    ar1[int1]:= struppercase(ar1[int1]);
   end;
   if (ar1[2] = ' ERROR') or (ar1[3] = ' ERROR') then begin
    alevel:= el_error;
   end
   else begin
    if (ar1[2] = ' WARNING') or (ar1[3] = ' WARNING') then begin
     alevel:= el_warning;
    end
    else begin
     if (ar1[2] = ' HINT') or (ar1[3] = ' HINT') then begin
      alevel:= el_hint;
     end
     else begin
      alevel:= el_all;
     end;
    end;
   end;
   if alevel >= minlevel then begin
    if trystrtointmse(ar1[1],row) then begin
     dec(row);
     if trystrtointmse(ar1[2],col) then begin
      dec(col);
     end
     else begin
      col:= 0;
     end;
     apage:= sourcefo.showsourceline(objpath(ar1[0]),row,col,true);
     result:= true;
    end;
   end;
  end; 
 end;
end;
*)

{ tnaviglist }

constructor tnaviglist.create;
begin
 findex:= -1;
 inherited;
end;

procedure tnaviglist.updateshowpos(
                         const acellpos: cellpositionty = cep_rowcenteredif);
begin
 with fsourcefo do begin
  showsourcepos(self.items[findex]^,true,acellpos);
  navigforwardact.enabled:= findex < fcount - 1;
  navigbackact.enabled:= findex > 0;
 end;
end;

function tnaviglist.back: boolean;
begin
 if findex > 0 then begin
  result:= true;
  dec(findex);
  updateshowpos;
 end
 else begin
  result:= false;
 end;
end;

function tnaviglist.forward: boolean;
begin
 if (findex < count - 1) then begin
  result:= true;
  inc(findex);
  updateshowpos;
 end
 else begin
  result:= false;
 end;
end;

procedure tnaviglist.showsource(const apos: sourceposty;
                                       const asetfocus: boolean = false);
begin
 count:= findex + 1;
 if count = 0 then begin
  add(fsourcefo.sourcepos);
 end
 else begin
  items[findex]^:= fsourcefo.sourcepos;
 end;
 findex:= add(apos);
 updateshowpos(cep_top);
end;

{ tsourcefo }

constructor tsourcefo.create(aowner: tcomponent);
begin
 fnaviglist:= tnaviglist.create;
 fnaviglist.fsourcefo:= self;
 // fred  
       tabdeleted := false;
          thetimer := ttimer.Create(nil);
        thetimer.interval :=  1500000 ;
        thetimer.tag := 0;
        thetimer.Enabled := False;
  inherited create(aowner);
end;

destructor tsourcefo.destroy;
begin
thetimer.Enabled := False;
thetimer.Free;
if han <> -1 then syntaxpainter.freedeffile(han);
 //hidesourcehint;
 inherited;
 fnaviglist.Free;
end;

function tsourcefo.hidesourcehint: boolean;
begin
 if fsourcehintwidget <> nil then begin
  result:= true;
  freeandnil(fsourcehintwidget);
 end
 else begin
  result:= false;
 end;
end;

procedure tsourcefo.tabwidgetpageremoved(const sender: TObject; const awidget: twidget);
begin
tabdeleted := true;
 if awidget = fgdbpage then begin
  fgdbpage:= nil;
 end;
end;
{
function encodemoduledock(const ainfo: moduledockinfoty): string;
begin
 with ainfo do begin
  if panelname <> '' then begin
   result:= encoderecord([panelname,rect.x,rect.y,rect.cx,rect.cy]);
  end
  else begin
   result:= '';
  end;
 end;
end;

function decodemoduledock(const atext: string; 
                                    var ainfo: moduledockinfoty): boolean;
                                        //true if ok
begin
 with ainfo do begin
  result:= decoderecord(atext,[@panelname,@rect.x,@rect.y,
                             @rect.cx,@rect.cy],'siiii');
  if not result then begin
   panelname:= '';
   rect:= nullrect;
  end;
 end;
end;
}
procedure tsourcefo.updatestat(const statfiler: tstatfiler);
var
 int1: integer;
 filenames,relpaths,modulenames: filenamearty;
 moduleoptions: integerarty;
// moduledock: stringarty;
 ismod: longboolarty;
 ar1,ar2: longboolarty;
 page1: tsourcepage1;
 intar1,intar2: integerarty;
 mstr1: filenamety;
 bo1: boolean;
 po1: pmoduleinfoty;
 
 // fred
 strtmp : unicodestring ;
 pos1, len1, len2, i : integer;
// ar3: msestringarty;
// pt1: pointty;
 
begin

 with statfiler do begin
  setsection('edit');
  updatevalue('hintwidth',hintsize.cx);
  updatevalue('hintheight',hintsize.cy);
  updatefindvalues(statfiler,projectoptions.findreplaceinfo.find);
  if iswriter then begin
   intar1:= files_tab.idents;
   sortarray(intar1,intar2);
   setlength(filenames,count);  
   setlength(relpaths,count);  
   setlength(feditposar,count); 
   setlength(fbookmarkar,count); 
   setlength(ismod,count); 
   for int1:= 0 to high(filenames) do begin
    with items[intar2[int1]] do begin
     filenames[int1]:= filepath;
     relpaths[int1]:= relpath;
     feditposar[int1]:= edit.editpos;
     fbookmarkar[int1]:= getbookmarks;
     ismod[int1]:= ismoduletext;
    end;
   end;
   setlength(modulenames,designer.modules.count);
   setlength(moduleoptions,length(modulenames));
//   setlength(moduledock,length(modulenames));
   setlength(ar1,length(modulenames));
   setlength(ar2,length(modulenames));
   for int1:= 0 to designer.modules.count - 1 do begin
    with designer.modules[int1]^ do begin
         
     modulenames[int1]:= filename;
     
       moduleoptions[int1]:=
         {$ifdef FPC}longword{$else}byte{$endif}(designformintf.moduleoptions);
     ar1[int1]:= designform.visible;
     ar2[int1]:= not hasmenuitem;
//     moduledock[int1]:= encodemoduledock(dockinfo);
    end;
   end;
   tstatwriter(statfiler).writerecordarray('editpos',length(feditposar),
               {$ifdef FPC}@{$endif}geteditpositem);
   for int1:= 0 to high(fbookmarkar) do begin
    factbookmark:= int1;
    tstatwriter(statfiler).writerecordarray('bookmarks'+inttostr(int1),
                length(fbookmarkar[int1]),
                {$ifdef FPC}@{$endif}getbookmarkitem);
   end;
  end
  else begin
   tstatreader(statfiler).readrecordarray('editpos',
            {$ifdef FPC}@{$endif}seteditposcount,
            {$ifdef FPC}@{$endif}seteditpositem);
   setlength(fbookmarkar,length(feditposar));
   for int1:= 0 to high(fbookmarkar) do begin
    factbookmark:= int1;
    tstatreader(statfiler).readrecordarray('bookmarks'+inttostr(int1),
            {$ifdef FPC}@{$endif}setbookmarkcount,
            {$ifdef FPC}@{$endif}setbookmarkitem);
   end;
  end;
  
   //// fred => insert marcro ${PROJECTDIR}
     for i := 0 to high(filenames) do 
     begin
      if msePosEx(TheProjectDirectory,filenames[i]) > 0 then
    begin
    // for clarity => used variables...
    pos1 := msePosEx(TheProjectDirectory,filenames[i]) ; 
    len1 := length(TheProjectDirectory) ;
    len2 := length(filenames[i]) ;
    strtmp := trim(copy(filenames[i],pos1 + len1, len2 - len1)) ; // all after
    filenames[i] := '${PROJECTDIR}/' + strtmp ;
    end;
   end;
     
   updatevalue('sourcefiles',filenames);
   
    for i := 0 to high(relpaths) do 
     begin
     relpaths[i] := trim(relpaths[i]);
      if msePosEx(TheProjectDirectory,relpaths[i]) > 0 then
    begin
    pos1 := msePosEx(TheProjectDirectory,relpaths[i]) ; 
    len1 := length(TheProjectDirectory) ;
    len2 := length(relpaths[i]) ;
    strtmp := trim(copy(relpaths[i],pos1 + len1, len2 - len1)) ; // all after
    relpaths[i] := strtmp ;
    end;
  
     if msePosEx( '../',relpaths[i]) > 0 then
    begin
    len2 := length(relpaths[i]) ;
    strtmp := trim(copy(relpaths[i],4, len2 - 3)) ; // all after
    relpaths[i] := strtmp ;
    end;
    
   end;
   
   updatevalue('relpaths',relpaths); 
     
  updatevalue('ismoduletexts',ismod);
  updatevalue('modules',modulenames);
  updatevalue('moduleoptions',moduleoptions);
//  updatevalue('moduledock',moduledock);
  updatevalue('visiblemodules',ar1);
  updatevalue('nomenumodules',ar2);
  if not iswriter then begin
   files_tab.window.nofocus;
   files_tab.clear;
   files_tab.beginupdate;
   try
    for int1:= 0 to high(filenames) do begin
     page1:= tsourcepage1(createnewpage(''));
     if (page1 <> nil) then begin
      page1.finitialfilepath:= filenames[int1];
      if int1 <= high(relpaths) then begin
       page1.relpath:= relpaths[int1];
      end;
      if int1 <= high(ismod) then begin
       page1.ismoduletext:= ismod[int1];
      end;
      if int1 <= high(feditposar) then begin
       page1.finitialeditpos:= feditposar[int1];
       if page1.finitialeditpos.col < 0 then begin
        page1.finitialeditpos.col:= 0;
       end;
       if page1.finitialeditpos.row < 0 then begin
        page1.finitialeditpos.row:= 0;
       end;
      end;
      if int1 <= high(fbookmarkar) then begin
       page1.finitialbookmarks:= fbookmarkar[int1];
      end;
      page1.updatecaption(false);
     end;
    end;
    mainfo.errorformfilename:= '';
    setlength(ar2,length(modulenames));
    setlength(moduleoptions,length(modulenames));
//    setlength(moduledock,length(modulenames));
    designer.beginskipall;
    for int1:= 0 to high(modulenames) do begin
     try
      if int1 > high(ar1) then begin
       bo1:= true;
      end
      else begin
       bo1:= ar1[int1];
      end;
      mstr1:= relativepath(modulenames[int1],projectoptions.projectdir);
      if findfile(mstr1) then begin
       po1:= mainfo.openformfile(filepath(mstr1),bo1,false,false,
                                                         not ar2[int1],true);
      end
      else begin
       po1:= mainfo.openformfile(modulenames[int1],bo1,false,false,
                                                         not ar2[int1],true);
      end;
      if (po1 <> nil) then begin
       with po1^ do begin
        designformintf.moduleoptions:= 
             moduleoptionsty({$ifdef FPC}longword{$else}byte{$endif}
                         (moduleoptions[int1])) * [mo_hidewidgets,mo_hidecomp];
//        if decodemoduledock(moduledock[int1],dockinfo) then begin
//         docktopanel(designformintf.getdockcontroller(),dockinfo.panelname,
//                                                     dockinfo.rect);
//        end;
       end;
      end;
     except
      if checkprojectloadabort then begin
       break; //do not load more modules
      end;
     end;
    end;
    designer.endskipall;
    files_tab.activepageindex:= -1; //do not load source
//    updatestat(istatfile(tabwidget));
   finally
    files_tab.endupdate;
   end; 
  end;
//  if visible and (activepage <> nil) then begin
//   activepage.sourcefoonshow(nil);
//  end;
  feditposar:= nil; //no longer used
  fbookmarkar:= nil;
  updatestat(istatfile(files_tab));
  if mainfo.errorformfilename <> '' then begin
   showsourceline(mainfo.errorformfilename,0,0,true);
  end;
  if (files_tab.activepageindex < 0) and (files_tab.count > 0) then begin
   files_tab.activepageindex:= 0; //default
  end;
 end;
end;

procedure tsourcefo.doselectpage(const sender: TObject);
begin
 selecteditpage;
end;

procedure tsourcefo.navigback(const sender: TObject);
begin
 fnaviglist.back;
end;

procedure tsourcefo.navigforward(const sender: TObject);
begin
 fnaviglist.forward;
end;

procedure tsourcefo.formonidle(var again: boolean);
var
 int1: integer;
 wstr1: msestring;
 
begin
 if (application.activewindow <> nil) and not fasking then begin
  fasking:= true;
  try
   for int1:= 0 to count - 1 do begin
    with items[int1] do begin
     if filechanged then begin
      filechanged:= false;
      wstr1:= c[ord(str_file)]+filepath+c[ord(haschanged)];
      if modified then begin
       wstr1:= wstr1 + ' '+ c[ord(modieditalso)];
      end;
      
      
      wstr1:= wstr1 + ' '+c[ord(wishreload)];
      
        //// fred
        
   if confideufo.tbfilereload.value = true then
  begin
  mainfo.setstattext(filepath + ' was changed by external program and reloaded at '+ timetostr(now) ,mtk_warning);
  filechanged:= false;
  reload;
  mainfo.sourcechanged(items[int1]);
  end 
  else
  if confideufo.tbfilenoload.value = true then
  begin
  mainfo.setstattext(filepath + ' was changed by external program and not reloaded at '+ timetostr(now) ,mtk_warning); 
  end else
  if askok(wstr1,c[ord(confirmation)]) then 
  begin
  mainfo.setstattext(filepath + ' was changed by external program and reloaded at '+ timetostr(now) ,mtk_warning);  filechanged:= false;
  reload;
  mainfo.sourcechanged(items[int1]);
  end else  mainfo.setstattext(filepath + ' was changed by external program and not reloaded at '+ timetostr(now) ,mtk_warning);  
  
   end;
    end;
   end;
  finally
   fasking:= false;
  end;
 end;
end;

procedure tsourcefo.onfilechanged(const sender: tfilechangenotifyer; 
                                          const info: filechangeinfoty);
var
 int1: integer;
begin
 for int1:= 0 to count - 1 do begin
  with items[int1] do begin
   if (longword(info.tag) = filetag) and canchangenotify(info) then begin
    filechanged:= true;
    application.wakeupmainthread;
   end;
  end;
 end;
end;

function tsourcefo.count: integer;
begin
 result:= files_tab.count;
end;

function tsourcefo.getitems(const index: integer): tsourcepage;
begin
 result:= tsourcepage(files_tab[index]);
end;

function tsourcefo.findsourcepage(afilename: filenamety;
                   wholepath: boolean = true; 
                   onlyifloaded: boolean = false): tsourcepage;
var
 int1: integer;
begin
 result:= nil;
 if wholepath then begin
  for int1:= 0 to count - 1 do begin
   if issamefilename(items[int1].filepath,afilename) then begin
    result:= items[int1];
    break;
   end;
  end;
 end
 else begin
  for int1:= 0 to count - 1 do begin
   if issamefilename(items[int1].filename,afilename) then begin
    result:= items[int1];
    break;
   end;
  end
 end;
 if result <> nil then begin
  if onlyifloaded then begin
   if not result.fileloaded then begin
    result:= nil;
   end;
  end
  else begin
   result.loadfile;
  end;
 end;
end;

function tsourcefo.createnewpage(const afilename: filenamety): tsourcepage;
begin
 result:= tsourcepage.create(nil);
 try
  result.edit.syntaxpainter:= syntaxpainter;
  result.dataicon.imagelist:= imagelist;
  result.filepath:= afilename;
   
  files_tab.add(result,files_tab.activepageindex+1);
  
  if afilename <> '' then begin
   filechangenotifyer.addnotification(result.filepath,result.filetag);
   designer.designfiles.add(afilename);
     end;
  updatehinttab; 
 except
  result.Free;
  result:= nil;
  application.handleexception(self);
 end;
end;

function tsourcefo.newpage: tsourcepage;
begin
 result:= createnewpage('');               
 result.updatecaption(false);
 result.show;
 result.setfocus(true);
end;

function tsourcefo.openfile(const filename: filenamety;
             aactivate: boolean = false): tsourcepage;
              //nil if not ok

 function loadfile(aname: filenamety): tsourcepage;
 var
  po1: pmoduleinfoty;
 begin
  po1:= designer.modules.findmodule(filepath(aname));
  if not mainfo.closemodule(po1,true) then begin
   sysutils.abort;
  end;
  ffileloading:= true;
  try
   result:= createnewpage(aname);
   if result <> nil then begin
    result.ismoduletext:= (po1 <> nil);
    mainfo.loadformbysource(aname);
   end;
  finally
   ffileloading:= false;
  end;
 end;

var
 str1: filenamety;
 bo1: boolean;
begin
 result:= nil;
 if filename = '' then begin
  exit;
 end;
 application.beginwait;
 try
  bo1:= isrootpath(filename);
  if bo1 then begin
   result:= findsourcepage(filename);
   if result = nil then begin
    if findfile(filename) then begin
     result:= loadfile(filename);
    end;
   end;
  end;
  if result = nil then begin
   if bo1 and findfile(msefileutils.filename(filename),
                       projectoptions.d.texp.sourcedirs,str1) or
      not bo1 and 
         findfile(filename,projectoptions.d.texp.sourcedirs,str1) then begin
    result:= findsourcepage(str1);
    if result = nil then begin
     result:= loadfile(str1);
    end;
   end;
  end;
  if (result <> nil) and aactivate then begin
   result.activate(true);
  end;
 finally
  application.endwait;
 end;
end;

function tsourcefo.showsourceline(const filename: filenamety;
            line: integer; col: integer = 0; asetfocus: boolean = false;
             const aposition: cellpositionty = cep_rowcentered): tsourcepage;
begin
 result:= openfile(filename);
 if result <> nil then begin
  result.show;
  if line >= 0 then begin
   result.source_editor.showcell(makegridcoord(0,line),aposition);
   if asetfocus then begin
    result.edit.editpos:= makegridcoord(col,line);
    result.source_editor.setfocus;
    result.window.bringtofront;
   end;
  end;
 end;
end;

function tsourcefo.showsourcepos(const apos: sourceposty;
          asetfocus: boolean = false;
           const aposition: cellpositionty = cep_top): tsourcepage;
var
 str1: filenamety;
begin
 result:= nil;
 str1:= designer.designfiles.getname(apos.filename);
 if str1 <> '' then begin
  result:= showsourceline(str1,apos.pos.row,apos.pos.col,asetfocus,aposition);
 end;
end;

procedure tsourcefo.resetactiverow;
begin
 if fgdbpage <> nil then begin
  fgdbpage.activerow:= -1;
 end;
end;

function tsourcefo.locate(const info: stopinfoty): tsourcepage;
begin
 resetactiverow;
 if info.filename <> '' then begin
  result:= openfile(filepath(projectoptions.o.texp.makedir,info.filename));
  if result <> nil then begin
   result.activerow:= info.line-1;
   result.show;
  end;
 end
 else begin
  result:= nil;
 end;
 fgdbpage:= result;
end;

function tsourcefo.saveall(noconfirm: boolean): modalresultty;
var
 int1,int2: integer;
begin
 result:= mr_none;
 for int1:= 0 to files_tab.count - 1 do begin
  result:= mainfo.checksavecancel(
           tsourcepage(files_tab[int1]).checksave(noconfirm,true));
  case result of
   mr_cancel: begin
    exit;
   end;
   mr_noall: begin
    break;
   end;
   mr_all: begin
    for int2:= int1 to files_tab.count - 1 do begin
     tsourcepage(files_tab[int2]).checksave(true,true);
    end;
    break;
   end;
  end;
 end;
  updatehinttab;
 fallsaved:= fallsaved or not noconfirm;
end;

function tsourcefo.modified: boolean;
var
 int1: integer;
begin
 result:= false;
 if fpagedestroying = 0 then begin
  for int1:= 0 to count - 1 do begin
   if items[int1].modified then begin
    result:= true;
    break;
   end;
  end;
 end;
end;

function tsourcefo.newfiletag: longword;
begin
 inc(ffiletag);
 if ffiletag = 0 then begin
  ffiletag:= 1;
 end;
 result:= ffiletag;
end;

procedure tsourcefo.sourcefoonclosequery(const sender: tcustommseform;
  var modalresult: modalresultty);
begin
{
 if saveall(false) = mr_cancel then begin
  modalresult:= mr_none;
 end;
}
end;


procedure tsourcefo.updatehinttab;
var
x : integer;
ainfo: fileinfoty;

//modtime: tdatetime;
//accesstime: tdatetime;
//ctime: tdatetime;

begin
for x:= 0 to files_tab.count-1
do 
begin

  getfileinfo(expandprmacros(tsourcepage(files_tab[x]).pathdisp.value), ainfo);
tsourcepage(files_tab[x]).tabhint := tsourcepage(files_tab[x]).pathdisp.value + lineend + 'Last modification: '
+ formatdatetime('YYYY-MM-DD HH:mm:ss', UniversalTimeToLocal(ainfo.extinfo1.modtime)) +
  ' | Size: ' + IntToStr( ainfo.extinfo1.size div 1000) + ' Kb.'
end;
end;

procedure tsourcefo.updatecaption;
var
 page: tsourcepage;

begin

 page:= tsourcepage(files_tab.activepage);
 if page <> nil then begin
  caption:= page.caption;
   
  if  assigned(activepage) then
  begin
  if fileexists(activepage.pathdisp.value) then
  if assigned(mainfo) then if assigned(mainfo.openfile) then mainfo.openfile.controller.lastdir
  := ExtractFilePath(activepage.pathdisp.value);
  
 if assigned(debuggerfo) then
 begin
  debuggerfo.file_history.value :=  activepage.pathdisp.value;
  debuggerfo.edited_make.hint :=  ' Compile ' + caption + ' ';
  debuggerfo.edited_run.hint :=  ' Run ' + caption + ' ';
  debuggerfo.edit_compiler.hint :=  ' Compiler Type for ' + caption  + ' ';
  debuggerfo.edit_compilernum.hint :=  ' Compiler Number for ' + caption  + ' ';
  debuggerfo.edit_options.hint :=  ' Option Number for ' + caption  + '. X --> No parameters.';
  debuggerfo.toggle_form_unit.hint := '  Toggle form/unit for ' + caption  + ' '; 
  end;
 end;
 end
 else begin
  caption:= c[ord(none)];
  
 end;
end;

procedure tsourcefo.tabwidgetonactivepagechanged(const sender: tobject);
begin
 updatecaption;
end;

procedure tsourcefo.saveactivepage(const newname: filenamety = '');
begin
 if activepage <> nil then begin
//  if newname <> '' then begin
//   filechangenotifyer.removenotification(activepage.filepath);
//  end;
  activepage.save(newname);
//  if newname <> '' then begin
//   filechangenotifyer.addnotification(activepage.filepath,activepage.filetag);
 
//  end;
 end;
 updatehinttab;
end;

function tsourcefo.closepage(const apage: tsourcepage;
                        noclosecheck: boolean = false): boolean;
var
 str1: filenamety;
 bo1: boolean;
begin
 result:= apage = nil;
 if not result then begin
  if apage.checksave(false,false) <> mr_cancel then begin
   str1:= apage.filepath;
   if not noclosecheck and (fileext(str1) = pasfileext) then begin
    if not mainfo.closemodule(
       designer.modules.findmodule(replacefileext(str1,formfileext)),true,
                     noclosecheck) then begin
     exit;
    end;
   end;
   filechangenotifyer.removenotification(str1);
   inc(fpagedestroying);
   try
    bo1:= files_tab.entered;
    apage.free;
    if bo1 then begin
     files_tab.setfocus;
    end;
   finally
    dec(fpagedestroying);
   end;
   result:= true;
  end;
 end;
end;

function tsourcefo.closepage(const aname: filenamety): boolean;
begin
 result:= closepage(findsourcepage(aname));
end;

function tsourcefo.closeactivepage: boolean;
begin
 result:= closepage(activepage);
end;

function tsourcefo.closeall(const nosave: boolean): boolean; //false on cancel
var
 int1: integer;
begin
 result:= nosave or (saveall(false) <> mr_cancel);
 if result then begin
  for int1:= count - 1 downto 0 do begin
   items[int1].enabled:= false; //avoid showing
  end;
  for int1:= count - 1 downto 0 do begin
   closepage(items[int1],true);
  end;
 end;
end;

function tsourcefo.activepage: tsourcepage;
begin
 if fpagedestroying > 0 then begin
  result:= nil;
 end
 else begin
  result:= tsourcepage(files_tab.activepage);
 end;
end;

procedure tsourcefo.textmodified(const sender: tsourcepage);
begin
 fallsaved:= false;
 if not ffileloading then begin
  mainfo.sourcechanged(sender);
 end;
end;

function tsourcefo.gdbpage: tsourcepage;
begin
 result:= fgdbpage;
end;

procedure tsourcefo.addwatchactonexecute(const sender: tobject);
begin
 with sender as tmenuitem do begin
  watchfo.addwatch(getpascalvarname(activepage.edit,
                      translateclientpoint(owner.mouseinfopo^.pos,
                           owner.transientfor,activepage.edit)));
 end;
end;

procedure tsourcefo.updatebreakpointicon(const path: filenamety; const info: bkptlineinfoty);
var
 int1: integer;
 wstr1: msestring;
begin
 wstr1:= filename(path);
 for int1:= 0 to count - 1 do begin
  with tsourcepage(files_tab[int1]) do begin
   if issamefilename(filename,wstr1) then begin
    try
     updatebreakpointicon(info);
    except
    end;
   end;
  end;
 end;
end;

function tsourcefo.geteditpositem(const index: integer): msestring;
begin
 result:= encoderecord([feditposar[index].col,feditposar[index].row]);
end;

procedure tsourcefo.seteditposcount(const count: integer);
begin
 setlength(feditposar,count);
end;

procedure  tsourcefo.seteditpositem(const index: integer; const avalue: msestring);
begin
 decoderecord(avalue,[@feditposar[index].col,@feditposar[index].row],'ii');
end;

function tsourcefo.getbookmarkitem(const index: integer): msestring;
begin
 result:= encoderecord([fbookmarkar[factbookmark][index].row,
                        fbookmarkar[factbookmark][index].bookmarknum]);
end;

procedure tsourcefo.setbookmarkcount(const count: integer);
begin
 setlength(fbookmarkar[factbookmark],count);
end;

procedure  tsourcefo.setbookmarkitem(const index: integer; const avalue: msestring);
begin
 decoderecord(avalue,[@fbookmarkar[factbookmark][index].row,
                      @fbookmarkar[factbookmark][index].bookmarknum],'ii');
end;

procedure tsourcefo.enterexe(const sender: tobject);
begin
 mainfo.designformactivated(self);
end;

function tsourcefo.gettextstream(const filename: filenamety;
                 forwrite: boolean): ttextstream;
var
 page1: tsourcepage;
begin
 page1:= findsourcepage(filename,true,true);
 if forwrite then begin
  if page1 = nil then begin
   page1:= openfile(filename);
  end;
 end;
 if page1 <> nil then begin
  result:= page1.edit.datalist.dataastextstream;
 end
 else begin
  if not forwrite then begin
   result:= ttextstream.create(filename,fm_read);
  end
  else begin
   result:= nil;
  end;
 end;
end;

function tsourcefo.getfiletext(const filename: filenamety;
                   const startpos,endpos: gridcoordty): string;
var
 apage: tsourcepage;
begin
 apage:= openfile(filename);
 if apage <> nil then begin
  result:= apage.edit.gettext(startpos,endpos);
 end
 else begin
  result:= '';
 end;
end;

procedure tsourcefo.replacefiletext(const filename: filenamety;
                   const startpos,endpos: gridcoordty; const newtext: string);
var
 apage: tsourcepage;
begin
 apage:= openfile(filename);
 if apage <> nil then begin
  apage.edit.deletetext(startpos,endpos);
  apage.edit.inserttext(startpos,newtext);
 end;
end;

function tsourcefo.getsourcepos: sourceposty;
begin
 finalize(result);
 fillchar(result,sizeof(result),0);
 if activepage <> nil then begin
  result.filename:= designer.designfiles.find(activepage.filepath);
  result.pos:= activepage.edit.editpos;
 end;
end;

procedure tsourcefo.setsourcehintwidget(const avalue: twidget);
begin
 fsourcehintwidget.free;
 setlinkedvar(avalue,tmsecomponent(fsourcehintwidget));
end;

procedure tsourcefo.editbreakpointexec(const sender: TObject);
begin
 breakpointsfo.showbreakpoint(activepage.filepath,popuprow+1,true);
end;
{
procedure tsourcefo.togglebreakpointexe(const sender: TObject);
begin
 activepage.togglebreakpoint(popuprow);
end;
}
procedure tsourcefo.popupmonupdate(const sender: tcustommenu);
//var
// gc1: gridcoordty;
begin
 if (activepage <> nil) and (sender.mouseinfopo <> nil) then begin
  popuprow:= activepage.source_editor.cellatpos(translateclientpoint(
                   sender.mouseinfopo^.pos,activepage,activepage.source_editor)).row;
 end
 else begin
  popuprow:= invalidaxis;
 end;
 sender.menu.itembyname('editbreakpoint').enabled:= 
        (activepage <> nil) and (popuprow >= 0) and
        (activepage.getbreakpointstate(popuprow) > bkpts_none);
 sender.menu.itembyname('showasform').enabled:= 
        (activepage <> nil) and activepage.ismoduletext;
 sender.menu.itembyname('setbm').enabled:= 
        (activepage <> nil) and (popuprow >= 0);
 sender.menu.itembyname('insgui').enabled:= (activepage <> nil);
 sender.menu.itembyname('insuid').enabled:= (activepage <> nil);
 sender.menu.itembyname('convpas').enabled:= (activepage <> nil) and 
                                                  activepage.edit.hasselection;
 sender.menu.itembyname('addwatch').enabled:= (activepage <> nil) and  
            (sender.mouseinfopo <> nil) and
              (getpascalvarname(activepage.edit,
                translateclientpoint(sender.mouseinfopo^.pos,
                        activepage,activepage.edit)) <> '');
{
 sender.menu.itembyname('instempl').enabled:= (activepage <> nil) and 
      codetemplates.hastemplate(
                activepage.edit.wordatpos(activepage.edit.editpos,gc1,'',[],true));
}                
end;

procedure tsourcefo.completeclassexecute(const sender: TObject);
var
 pos1: sourceposty;
begin
 if activepage <> nil then begin
  activepage.edit.editor.begingroup;
  try
   pos1.pos:= activepage.edit.editpos;
   completeclass(activepage.filepath,pos1);
  finally
   activepage.edit.editor.endgroup;
  end;
 end;
end;

procedure tsourcefo.showasformexe(const sender: TObject);
begin
 activepage.asyncevent(integer(spat_showasform));
end;

procedure tsourcefo.setbookmark(const apage: tsourcepage; const arow: integer;
                                  const bookmarknum: integer);
var
 int1: integer;
 page1: tsourcepage;
 bo1: boolean;
begin
 if bookmarknum >= 0 then begin
  bo1:= (arow >= 0) and (bookmarknum >= 0);
  for int1:= 0 to self.count - 1 do begin
   page1:= items[int1];
   if bo1 and (page1 = apage) and (page1.findbookmark(bookmarknum) = arow) then begin
    page1.clearbookmark(bookmarknum);
    exit;
   end;
   page1.clearbookmark(bookmarknum);
  end;
 end;
 apage.setbookmark(arow,bookmarknum);
end;

procedure tsourcefo.setbmexec(const sender: TObject);
begin
 setbookmark(activepage,-1,tmenuitem(sender).tag);
end;

function tsourcefo.findbookmark(const bookmarknum: integer): boolean;
var
 int1,int2: integer;
begin
 result:= false;
 for int1:= 0 to count - 1 do begin
  with items[int1] do begin
   int2:= findbookmark(bookmarknum);
   if int2 >= 0 then begin
    source_editor.showcell(makegridcoord(invalidaxis,int2),cep_rowcenteredif);
    edit.editpos:= makegridcoord(0,int2);
    activate;
    result:= true;
   end;
  end;
 end;
end;

procedure tsourcefo.findbmexec(const sender: TObject);
begin
 findbookmark(tmenuitem(sender).tag);
end;

procedure tsourcefo.insguiexec(const sender: TObject);
begin
 with activepage.edit do begin
  inserttext(editpos,'['''+createguidstring+''']');
 end;
end;

procedure tsourcefo.insuidexec(const sender: TObject);
var
 id1,int1: integer;
 str1: string[4];
 str2: string;
begin
 id1:= projectoptions.o.uid;
 if integerenter(id1,minint,maxint,'ID','Enter ID') = mr_ok then begin
  for int1:= 0 to 3 do begin
   str1[int1+1]:= char(bitreverse[byte(
                           (id1 and ($ff shl (int1*8))shr(int1*8)))]);
  end;
  str1[0]:= #1;
  for int1:= 4 downto 1 do begin
   if str1[int1] <> #0 then begin
    str1[0]:= char(int1);
    break;
   end;
  end;
  str2:= encodebase64(str1);
  for int1:= length(str2) downto 1 do begin
   if str2[int1] <> '=' then begin
    setlength(str2,int1);
    break;
   end;
  end;
  
  with activepage.edit do begin
   inserttext(editpos,'['''+str2+''']{'+inttostr(id1)+'}');
  end;
  projectoptions.o.uid:= id1+1;
 end;
end;

procedure tsourcefo.convpasex(const sender: TObject);

var
 ar1: msestringarty;

 function messagestr(const def: msestring): msestring;
 begin
  if high(ar1) > 4 then begin
   result:= concatstrings(copy(ar1,0,5),lineend);
   result:= result+lineend+'...';
  end
  else begin
   result:= def;
  end;
 end; //msessagestr

var
 mstr1,mstr2,mstr3,mstr4: msestring;
 int1: integer;
begin
 with activepage.edit do begin
  mstr1:= selectedtext;
  ar1:= breaklines(mstr1);
  mstr3:= messagestr(mstr1);
  for int1:= 0 to high(ar1)-1 do begin
   ar1[int1]:= stringtopascalstring(ar1[int1])+'+lineend+';
  end;
  ar1[high(ar1)]:= stringtopascalstring(ar1[high(ar1)]);  
  mstr2:= concatstrings(ar1,lineend);
  mstr4:= messagestr(mstr2);
  if askyesno(c[ord(wishreplace)]+lineend+mstr3+lineend+c[ord(str_with)]+lineend+
        mstr4+lineend+'?',c[ord(confirmation)]) then begin
   editor.begingroup;
   deleteselection;
   inserttext(mstr2,true);
   editor.endgroup;
  end;
 end;
end;

procedure tsourcefo.savecanceled;
begin
 fallsaved:= false;
end;

function tsourcefo.currentselection: msestring;
begin
 result:= '';
 if activepage <> nil then begin
  with activepage do begin
   result:= edit.selectedtext;
  end;
 end;
end;

function tsourcefo.currentfilename: filenamety;
begin
 result:= '';
 if activepage <> nil then begin
  with activepage do begin
   result:= filepath;
  end;
 end;
end;

function tsourcefo.currentwordatcursor: msestring;
var
 gridcoord1: gridcoordty;
begin
 result:= '';
 if activepage <> nil then begin
  with activepage do begin
   result:= getpascalvarname(edit,edit.editpos,gridcoord1);
  end;
 end;
end;

procedure tsourcefo.stephintev(const sender: TObject; var info: hintinfoty);
begin
 info.caption:= info.caption + '('+
      encodeshortcutname(tstockglyphbutton(sender).shortcut)+').';
end;

procedure tsourcefo.onpageadd(const sender: TObject; const awidget: twidget);
begin
end;

end.
