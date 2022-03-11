unit sourceform;

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
  confideu,
  ideusettings,
  commandorform,
  SysUtils,
  msetimer,
  msetextedit,
  msewidgetgrid,
  mseforms,
  Classes,
  mclasses,
  msegdbutils,
  msebitmap,
  msetabs,
  sourcepage,
  mseglob,
  msetypes,
  msestrings,
  mseguiglob,
  msegui,
  msesyntaxpainter,
  msemenus,
  mseactions,
  msestat,
  finddialogform,
  msestream,
  msefilechange,
  dateutils,
  breakpointsform,
  mseparser,
  msesimplewidgets,
  msegrids,
  msegraphutils,
  msegridsglob,
  msestringcontainer,
  msedragglob,
  msegraphics,
  msescrollbar,
  msewidgets,
  mseclasses;

type
  stringconsts = (
    str_file,           //0 File "
    haschanged,         //1 " has changed.
    therearemody,       //2 There are modifications in edit buffer also.
    wishreload,         //3 Do you wish to reload from disk?
    confirmation,       //4 Confirmation
    none,               //5 <none>
    wishreplace,        //6 Do you wish to replace:
    str_with,           //7 with:
    str_new,            //8 <new>
    syntaxdeffile,      //9 Syntaxdeffile:
    str_text,           //10 Text
    str_notfound,       //11 not found.
    restartbegin,       //12 Restart from begin of file?
    cancel,             //13 Cancel?
    replaceoccu,        //14 Do you wish to to replace this occurence?
    gotoline,           //15 Go to line number:
    findline,           //16 Find line
    modieditalso,       //17 There are modifications in edit buffer also.
    restartend          //18 Restart from end of file?
    );

  tsourcefo = class;

  tnaviglist = class(tsourceposlist)
  private
    fsourcefo: tsourcefo;
    findex: integer;
    procedure updateshowpos(const acellpos: cellpositionty = cep_rowcenteredif);
  public
    constructor Create;
    procedure showsource(const apos: sourceposty; const asetfocus: Boolean = False);
    function back: Boolean;
    function forward: Boolean;
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
    timagelist2: timagelist;
    tfacecomp1: tfacecomp;
    tfacecomp2: tfacecomp;
    tfacecomp1dark: tfacecomp;
    tfacecomp2dark: tfacecomp;
    step_back: TButton;
    buttonimage: timagelist;
    step_forward: TButton;
    tfacecomp2horz: tfacecomp;
    tfacecomp2horzdark: tfacecomp;
    procedure formonidle(var again: Boolean);
    procedure doselectpage(const Sender: TObject);

    procedure navigback(const Sender: TObject);
    procedure navigforward(const Sender: TObject);
    procedure onfilechanged(const Sender: tfilechangenotifyer; const info: filechangeinfoty);
    procedure sourcefoonclosequery(const Sender: tcustommseform; var modalresult: modalresultty);
    procedure tabwidgetpageremoved(const Sender: TObject; const awidget: twidget);
    procedure tabwidgetonactivepagechanged(const Sender: TObject);
    procedure addwatchactonexecute(const Sender: TObject);
    procedure enterexe(const Sender: TObject);
    procedure editbreakpointexec(const Sender: TObject);
    procedure popupmonupdate(const Sender: tcustommenu);
    procedure completeclassexecute(const Sender: TObject);
    procedure showasformexe(const Sender: TObject);
    procedure setbmexec(const Sender: TObject);
    procedure findbmexec(const Sender: TObject);
    procedure insguiexec(const Sender: TObject);
    procedure convpasex(const Sender: TObject);
    procedure insuidexec(const Sender: TObject);
    procedure stephintev(const Sender: TObject; var info: hintinfoty);
   private
    fasking: Boolean;
    fgdbpage: tsourcepage;
    ffileloading: Boolean;
    ffiletag: longword;
    fnaviglist: tnaviglist;
    feditposar: gridcoordarty;
    factbookmark: integer;
    fbookmarkar: array of bookmarkarty;
    fpagedestroying: integer;
    popuprow: integer;
    fallsaved: Boolean;
    function geteditpositem(const index: integer): msestring;
    procedure seteditposcount(const Count: integer);
    procedure seteditpositem(const index: integer; const avalue: msestring);
    function getbookmarkitem(const index: integer): msestring;
    procedure setbookmarkcount(const Count: integer);
    procedure setbookmarkitem(const index: integer; const avalue: msestring);
    function getitems(const index: integer): tsourcepage;
    function createnewpage(const afilename: filenamety): tsourcepage;
    function getsourcepos: sourceposty;
    procedure setsourcehintwidget(const avalue: twidget);
  public
    // fred
    tabdeleted: Boolean;
    hintsize: sizety;
    fsourcehintwidget: twidget;
    constructor Create(aowner: TComponent); override;
    destructor Destroy; override;

    procedure updatestat(const statfiler: tstatfiler);

    function hidesourcehint: Boolean;    //false if no action;
    procedure updatebreakpointicon(const path: filenamety; const info: bkptlineinfoty);
    procedure textmodified(const Sender: tsourcepage);
    function openfile(const filename: filenamety; aactivate: Boolean = False): tsourcepage; //nil if not ok
    function showsourceline(const filename: filenamety; line: integer; col: integer = 0; asetfocus: Boolean = False; const aposition: cellpositionty = cep_rowcentered): tsourcepage;
    function showsourcepos(const apos: sourceposty; asetfocus: Boolean = False; const aposition: cellpositionty = cep_top): tsourcepage;
    procedure resetactiverow;
    function locate(const info: stopinfoty): tsourcepage;
    function Count: integer;
    function ActivePage: tsourcepage;
    function currentselection: msestring;
    function currentfilename: filenamety;
    function currentwordatcursor: msestring;
    procedure updatecaption;
    procedure updatehinttab;
    function newpage: tsourcepage;
    function findsourcepage(afilename: filenamety; wholepath: Boolean = True; onlyifloaded: Boolean = False): tsourcepage;
    procedure saveactivepage(const newname: filenamety = '');
    function saveall(noconfirm: Boolean): modalresultty; //false if canceled
    procedure savecanceled; //resets fallsaved
    property allsaved: Boolean read fallsaved;
    function closeactivepage: Boolean;
    function closepage(const apage: tsourcepage; noclosecheck: Boolean = False): Boolean; overload;
    function closepage(const aname: filenamety): Boolean; overload;
    function closeall(const nosave: Boolean): Boolean; //false on cancel
    function gdbpage: tsourcepage;
    function modified: Boolean;
    function newfiletag: longword;
    property items[const index: integer]: tsourcepage read getitems; default;
    property naviglist: tnaviglist read fnaviglist;
    function findbookmark(const bookmarknum: integer): Boolean;
    //true if found
    procedure setbookmark(const apage: tsourcepage; const arow: integer; const bookmarknum: integer);

    function gettextstream(const filename: filenamety; forwrite: Boolean): ttextstream;
    function getfiletext(const filename: filenamety; const startpos, endpos: gridcoordty): msestring;
    procedure replacefiletext(const filename: filenamety; const startpos, endpos: gridcoordty; const newtext: msestring);
    property sourcepos: sourceposty read getsourcepos;
    property sourcehintwidget: twidget read fsourcehintwidget write setsourcehintwidget;
  end;

  errorlevelty = (el_none, el_all, el_hint, el_note, el_warning, el_error);

var
  sourcefo: tsourcefo;
 
function checkerrormessage(const Text: msestring; out alevel: errorlevelty; out afilename: filenamety; out col, row: integer): Boolean;
function locateerrormessage(const Text: msestring; var apage: tsourcepage; minlevel: errorlevelty = el_all): Boolean;
//true if valid errormessage

implementation

uses
  sourceform_mfm,
  msefileutils,
  mseformatstr,
  dialogfiles,
  projectoptionsform,
  main,
  mseeditglob,
  watchform,
  msesys,
  msedesigner,
  selecteditpageform,
  sourceupdate,
  msearrayutils,
  msebits,
  msesysutils,
  mseintegerenter,
  panelform,
  beauty,
  procedurelistform;

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

type
  tsourcepage1 = class(tsourcepage);

function checkerrormessage(const Text: msestring; out alevel: errorlevelty; out afilename: filenamety; out col, row: integer): Boolean;
var
  ar1, ar2, ar3: msestringarty;
  int1: integer;
  Text2: msestring;
begin
  Result := False;
  col    := 0;
  row    := 0;
  alevel := el_none;

  Text2 := Text;

  splitstring(Text2, ar1, msechar('('));
  if length(ar1) > 1 then
  begin         //try FPC
    splitstring(ar1[1], ar2, msechar(')'));
    if length(ar2) > 1 then
    begin
      splitstring(ar2[0], ar3, msechar(','));
      if (high(ar3) >= 0) then
      begin
        if (system.pos('Error:', ar2[1]) > 0) or
          (system.pos('Fatal:', ar2[1]) > 0) then
          alevel := el_error
        else if (system.pos('Warning:', ar2[1]) > 0) then
          alevel := el_warning
        else if (system.pos('Note:', ar2[1]) > 0) then
          alevel := el_note
        else if (system.pos('Hint:', ar2[1]) > 0) then
          alevel := el_hint;

        if trystrtoint(ar3[0], row) then
        begin
          Dec(row);
          if high(ar3) >= 1 then
          begin
            if trystrtoint(ar3[1], col) then
            begin
              Dec(col);
              Result := True;
            end;
          end
          else
            Result    := True;
          if Result then
            afilename := ar1[0];
        end;
        if Result and (alevel = el_none) then
          alevel := el_all;
      end;
    end;
  end;
  if (alevel = el_none) and not Result then
  begin
    ar1 := nil;
    ar2 := nil;
    splitstring(Text, ar1, msechar(':'));
    if high(ar1) > 2 then
    begin
      for int1 := 2 to 3 do
        ar1[int1] := struppercase(ar1[int1]);
      if (ar1[2] = ' ERROR') or (ar1[3] = ' ERROR') then
        alevel    := el_error
      else if (ar1[2] = ' WARNING') or (ar1[3] = ' WARNING') then
        alevel    := el_warning
      else if (ar1[2] = ' HINT') or (ar1[3] = ' HINT') then
        alevel    := el_hint
      else
        alevel    := el_all;
      if alevel <> el_none then
        if trystrtoint(ar1[1], row) then
        begin
          Dec(row);
          if trystrtoint(ar1[2], col) then
            Dec(col)
          else
            col     := 0;
          afilename := ar1[0];
          Result    := True;
        end;
    end;
  end;
end;

function locateerrormessage(const Text: msestring; var apage: tsourcepage; minlevel: errorlevelty = el_all): Boolean;
var
  lev1: errorlevelty;
  col1, row1: integer;
  fna1: filenamety;
begin
  apage  := nil;
  Result := False;
  if checkerrormessage(Text, lev1, fna1, col1, row1) and (fna1 <> '') and
    (lev1 >= minlevel) then
  begin
    apage  := sourcefo.showsourceline(objpath(fna1), row1, col1, True);
    Result := True;

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

constructor tnaviglist.Create;
begin
  findex := -1;
  inherited;
end;

procedure tnaviglist.updateshowpos(const acellpos: cellpositionty = cep_rowcenteredif);
begin
  with fsourcefo do
  begin
    showsourcepos(self.items[findex]^, True, acellpos);
    navigforwardact.Enabled := findex < fcount - 1;
    navigbackact.Enabled    := findex > 0;
    step_forward.Enabled    := findex < fcount - 1;
    step_back.Enabled       := findex > 0;
  end;
end;

function tnaviglist.back: Boolean;
begin
  if findex > 0 then
  begin
    Result := True;
    Dec(findex);
    updateshowpos;
  end
  else
    Result := False;
end;

function tnaviglist.forward: Boolean;
begin
  if (findex < Count - 1) then
  begin
    Result := True;
    Inc(findex);
    updateshowpos;
  end
  else
    Result := False;
end;

procedure tnaviglist.showsource(const apos: sourceposty; const asetfocus: Boolean = False);
begin
  Count := findex + 1;
  if Count = 0 then
    add(fsourcefo.sourcepos)
  else
    items[findex]^ := fsourcefo.sourcepos;
  findex           := add(apos);
  updateshowpos(cep_top);
end;

{ tsourcefo }

constructor tsourcefo.Create(aowner: TComponent);
begin
  fnaviglist        := tnaviglist.Create;
  fnaviglist.fsourcefo := self;
  // fred
  tabdeleted        := False;
  thetimer          := ttimer.Create(nil);
  thetimer.interval := 1500000;
  thetimer.tag      := 0;
  thetimer.Enabled  := False;
  inherited Create(aowner);
end;

destructor tsourcefo.Destroy;
begin
  thetimer.Enabled := False;
  thetimer.Free;
  if han <> -1 then
    syntaxpainter.freedeffile(han);
  //hidesourcehint;
  inherited;
  fnaviglist.Free;
end;

function tsourcefo.hidesourcehint: Boolean;
begin
  if fsourcehintwidget <> nil then
  begin
    Result := True;
    FreeAndNil(fsourcehintwidget);
  end
  else
    Result := False;
end;

procedure tsourcefo.tabwidgetpageremoved(const Sender: TObject; const awidget: twidget);
begin
  tabdeleted := True;
  if awidget = fgdbpage then
    fgdbpage := nil;

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
  filenames, relpaths, modulenames: filenamearty;
  moduleoptions: integerarty;
  // moduledock: stringarty;
  ismod: longboolarty;
  ar1, ar2: longboolarty;
  page1: tsourcepage1;
  intar1, intar2: integerarty;
  mstr1: filenamety;
  bo1: Boolean;
  po1: pmoduleinfoty;
  // fred
  strtmp: unicodestring;
  pos1, len1, len2, i: integer;
  // ar3: msestringarty;
  // pt1: pointty;
begin

  with statfiler do
  begin
    setsection('edit');
    updatevalue('hintwidth', hintsize.cx);
    updatevalue('hintheight', hintsize.cy);
    updatefindvalues(statfiler, projectoptions.findreplaceinfo.find);
    if iswriter then
    begin
      intar1 := files_tab.idents;
      sortarray(intar1, intar2);
      setlength(filenames, Count);
      setlength(relpaths, Count);
      setlength(feditposar, Count);
      setlength(fbookmarkar, Count);
      setlength(ismod, Count);
      for int1 := 0 to high(filenames) do
        with items[intar2[int1]] do
        begin
          filenames[int1]   := filepath;
          relpaths[int1]    := relpath;
          feditposar[int1]  := edit.editpos;
          fbookmarkar[int1] := getbookmarks;
          ismod[int1]       := ismoduletext;
        end;
      setlength(modulenames, designer.modules.Count);
      setlength(moduleoptions, length(modulenames));
      //   setlength(moduledock,length(modulenames));
      setlength(ar1, length(modulenames));
      setlength(ar2, length(modulenames));
      for int1 := 0 to designer.modules.Count - 1 do
        with designer.modules[int1]^ do
        begin

          modulenames[int1] := filename;

          moduleoptions[int1] :=
         {$ifdef FPC}
            longword
{$else}byte{$endif}
            (designformintf.moduleoptions);
          ar1[int1]           := designform.Visible;
          ar2[int1]           := not hasmenuitem;
          //     moduledock[int1]:= encodemoduledock(dockinfo);
        end;
      tstatwriter(statfiler).writerecordarray('editpos', length(feditposar),
               {$ifdef FPC}
        @
{$endif}
        geteditpositem);
      for int1 := 0 to high(fbookmarkar) do
      begin
        factbookmark := int1;
        tstatwriter(statfiler).writerecordarray(UTF8Decode('bookmarks' + IntToStr(int1)),
          length(fbookmarkar[int1]),
                {$ifdef FPC}
          @
{$endif}
          getbookmarkitem);
      end;
    end
    else
    begin
      tstatreader(statfiler).readrecordarray('editpos',
            {$ifdef FPC}
        @
{$endif}
        seteditposcount,
            {$ifdef FPC}
        @
{$endif}
        seteditpositem);
      setlength(fbookmarkar, length(feditposar));
      for int1 := 0 to high(fbookmarkar) do
      begin
        factbookmark := int1;
        tstatreader(statfiler).readrecordarray(UTF8Decode('bookmarks' + IntToStr(int1)),
            {$ifdef FPC}
          @
{$endif}
          setbookmarkcount,
            {$ifdef FPC}
          @
{$endif}
          setbookmarkitem);
      end;
    end;

    //// fred => insert marcro ${PROJECTDIR}
    for i := 0 to high(filenames) do
      if msePosEx(TheProjectDirectory, filenames[i]) > 0 then
      begin
        // for clarity => used variables...
        pos1         := msePosEx(TheProjectDirectory, filenames[i]);
        len1         := length(TheProjectDirectory);
        len2         := length(filenames[i]);
        strtmp       := trim(copy(filenames[i], pos1 + len1, len2 - len1)); // all after
        filenames[i] := '${PROJECTDIR}/' + strtmp;
      end;

    updatevalue('sourcefiles', filenames);

    for i := 0 to high(relpaths) do
    begin
      relpaths[i] := trim(relpaths[i]);
      if msePosEx(TheProjectDirectory, relpaths[i]) > 0 then
      begin
        pos1        := msePosEx(TheProjectDirectory, relpaths[i]);
        len1        := length(TheProjectDirectory);
        len2        := length(relpaths[i]);
        strtmp      := trim(copy(relpaths[i], pos1 + len1, len2 - len1)); // all after
        relpaths[i] := strtmp;
      end;

      if msePosEx('../', relpaths[i]) > 0 then
      begin
        len2        := length(relpaths[i]);
        strtmp      := trim(copy(relpaths[i], 4, len2 - 3)); // all after
        relpaths[i] := strtmp;
      end;

    end;

    updatevalue('relpaths', relpaths);

    updatevalue('ismoduletexts', ismod);
    updatevalue('modules', modulenames);
    updatevalue('moduleoptions', moduleoptions);
    //  updatevalue('moduledock',moduledock);
    updatevalue('visiblemodules', ar1);
    updatevalue('nomenumodules', ar2);
    if not iswriter then
    begin
      files_tab.window.nofocus;
      files_tab.Clear;
      files_tab.beginupdate;
      try
        for int1 := 0 to high(filenames) do
        begin
          page1 := tsourcepage1(createnewpage(''));
          if (page1 <> nil) then
          begin
            page1.finitialfilepath := filenames[int1];
            if int1 <= high(relpaths) then
              page1.relpath        := relpaths[int1];
            if int1 <= high(ismod) then
              page1.ismoduletext   := ismod[int1];
            if int1 <= high(feditposar) then
            begin
              page1.finitialeditpos       := feditposar[int1];
              if page1.finitialeditpos.col < 0 then
                page1.finitialeditpos.col := 0;
              if page1.finitialeditpos.row < 0 then
                page1.finitialeditpos.row := 0;
            end;
            if int1 <= high(fbookmarkar) then
              page1.finitialbookmarks := fbookmarkar[int1];
            page1.updatecaption(False);
          end;
        end;
        mainfo.errorformfilename := '';
        setlength(ar2, length(modulenames));
        setlength(moduleoptions, length(modulenames));
        //    setlength(moduledock,length(modulenames));
        designer.beginskipall;
        for int1 := 0 to high(modulenames) do
          try
            if int1 > high(ar1) then
              bo1 := True
            else
              bo1 := ar1[int1];
            mstr1 := relativepath(modulenames[int1], projectoptions.projectdir);
            if findfile(mstr1) then
              po1 := mainfo.openformfile(filepath(mstr1), bo1, False, False, not ar2[int1], True)
            else
              po1 := mainfo.openformfile(modulenames[int1], bo1, False, False, not ar2[int1], True);
            if (po1 <> nil) then
              with po1^ do
                designformintf.moduleoptions :=
                  moduleoptionsty(
{$ifdef FPC}
                  longword
{$else}byte{$endif}
                  (moduleoptions[int1])) * [mo_hidewidgets, mo_hidecomp]//        if decodemoduledock(moduledock[int1],dockinfo) then begin
            //         docktopanel(designformintf.getdockcontroller(),dockinfo.panelname,
            //                                                     dockinfo.rect);
            //        end;
            ;
          except
            if checkprojectloadabort then
              break//do not load more modules
            ;
          end;
        designer.endskipall;
        files_tab.activepageindex := -1; //do not load source
        //    updatestat(istatfile(tabwidget));
      finally
        files_tab.endupdate;
      end;
    end;
    //  if visible and (activepage <> nil) then begin
    //   activepage.sourcefoonshow(nil);
    //  end;
    feditposar  := nil; //no longer used
    fbookmarkar := nil;
    updatestat(istatfile(files_tab));
    if mainfo.errorformfilename <> '' then
      showsourceline(mainfo.errorformfilename, 0, 0, True);
    if (files_tab.activepageindex < 0) and (files_tab.Count > 0) then
      files_tab.activepageindex := 0//default
    ;
  end;
end;

procedure tsourcefo.doselectpage(const Sender: TObject);
begin
  selecteditpage;
end;

procedure tsourcefo.navigback(const Sender: TObject);
begin
  fnaviglist.back;
end;

procedure tsourcefo.navigforward(const Sender: TObject);
begin
  fnaviglist.forward;
end;

procedure tsourcefo.formonidle(var again: Boolean);
var
  int1: integer;
  wstr1: msestring;
begin
  if (application.activewindow <> nil) and not fasking then
  begin
    fasking    := True;
    try
      for int1 := 0 to Count - 1 do
        with items[int1] do
          if filechanged then
          begin
            filechanged := False;
            wstr1       := lang_stockcaption[ord(sc_file)] + ' ' + filepath  + ' ' + 
                         lang_sourceform[ord(sf_haschanged)];
            if modified then
              wstr1 := wstr1 + ' ' + lang_sourceform[ord(sf_therearemody)];


            wstr1 := wstr1 + ' ' + lang_sourceform[ord(sf_wishreload)];

            //// fred

            if confideufo.tbfilereload.Value = True then
            begin
              mainfo.setstattext(filepath + ' was changed by external program and reloaded at ' + UTF8Decode(timetostr(now)), mtk_warning);
              filechanged := False;
              reload;
              mainfo.sourcechanged(items[int1]);
            end
            else if confideufo.tbfilenoload.Value = True then
              mainfo.setstattext(filepath + ' was changed by external program and not reloaded at ' + UTF8Decode(timetostr(now)), mtk_warning)
            else if askok(wstr1, lang_stockcaption[ord(sc_confirmation)]) then
            begin
              mainfo.setstattext(filepath + ' was changed by external program and reloaded at ' + UTF8Decode(timetostr(now)), mtk_warning);
              filechanged := False;
              reload;
              mainfo.sourcechanged(items[int1]);
            end
            else
              mainfo.setstattext(filepath + ' was changed by external program and not reloaded at ' +
                UTF8Decode(timetostr(now)), mtk_warning);

          end;
    finally
      fasking := False;
    end;
  end;
end;

procedure tsourcefo.onfilechanged(const Sender: tfilechangenotifyer; const info: filechangeinfoty);
var
  int1: integer;
begin
  for int1 := 0 to Count - 1 do
    with items[int1] do
      if (longword(info.tag) = filetag) and canchangenotify(info) then
      begin
        filechanged := True;
        application.wakeupmainthread;
      end;
end;

function tsourcefo.Count: integer;
begin
  Result := files_tab.Count;
end;

function tsourcefo.getitems(const index: integer): tsourcepage;
begin
  Result := tsourcepage(files_tab[index]);
end;

function tsourcefo.findsourcepage(afilename: filenamety; wholepath: Boolean = True; onlyifloaded: Boolean = False): tsourcepage;
var
  int1: integer;
begin
  Result := nil;
  if wholepath then
  begin
    for int1 := 0 to Count - 1 do
      if issamefilename(items[int1].filepath, afilename) then
      begin
        Result := items[int1];
        break;
      end;
  end
  else
    for int1 := 0 to Count - 1 do
      if issamefilename(items[int1].filename, afilename) then
      begin
        Result := items[int1];
        break;
      end;
  if Result <> nil then
    if onlyifloaded then
    begin
      if not Result.fileloaded then
        Result := nil;
    end
    else
      Result.loadfile;
end;

function tsourcefo.createnewpage(const afilename: filenamety): tsourcepage;
begin
  Result := tsourcepage.Create(nil);
  try
    Result.edit.syntaxpainter := syntaxpainter;
    Result.dataicon.imagelist := imagelist;
    Result.filepath := afilename;

    files_tab.add(Result, files_tab.activepageindex + 1);

    if afilename <> '' then
    begin
      filechangenotifyer.addnotification(Result.filepath, Result.filetag);
      designer.designfiles.add(afilename);
    end;
    updatehinttab;
  except
    Result.Free;
    Result := nil;
    application.handleexception(self);
  end;
end;

function tsourcefo.newpage: tsourcepage;
begin
  Result := createnewpage('');
  Result.updatecaption(False);
  Result.Show;
  Result.SetFocus(True);
end;

function tsourcefo.openfile(const filename: filenamety; aactivate: Boolean = False): tsourcepage;
  //nil if not ok

  function loadfile(aname: filenamety): tsourcepage;
  var
    po1: pmoduleinfoty;
  begin
    po1 := designer.modules.findmodule(filepath(aname));
    if not mainfo.closemodule(po1, True) then
      SysUtils.abort;
    ffileloading := True;
    try
      Result     := createnewpage(aname);
      if Result <> nil then
      begin
        Result.ismoduletext := (po1 <> nil);
        mainfo.loadformbysource(aname);
      end;
    finally
      ffileloading := False;
    end;
  end;

var
  str1: filenamety;
  bo1: Boolean;
begin
  Result := nil;
  if filename = '' then
    Exit;
  application.beginwait;
  try
    bo1 := isrootpath(filename);
    if bo1 then
    begin
      Result := findsourcepage(filename);
      if Result = nil then
        if findfile(filename) then
          Result := loadfile(filename);
    end;
    if Result = nil then
      if bo1 and findfile(msefileutils.filename(filename),
        projectoptions.d.texp.sourcedirs, str1) or not bo1 and
        findfile(filename, projectoptions.d.texp.sourcedirs, str1) then
      begin
        Result   := findsourcepage(str1);
        if Result = nil then
          Result := loadfile(str1);
      end;
    if (Result <> nil) and aactivate then
      Result.activate(True);
  finally
    application.endwait;
  end;
end;

function tsourcefo.showsourceline(const filename: filenamety; line: integer; col: integer = 0; asetfocus: Boolean = False; const aposition: cellpositionty = cep_rowcentered): tsourcepage;
begin
  Result := openfile(filename);
  if Result <> nil then
  begin
    Result.Show;
    if line >= 0 then
    begin
      Result.source_editor.showcell(makegridcoord(0, line), aposition);
      if asetfocus then
      begin
        Result.edit.editpos := makegridcoord(col, line);
        Result.source_editor.SetFocus;
        Result.window.bringtofront;
      end;
    end;
  end;
end;

function tsourcefo.showsourcepos(const apos: sourceposty; asetfocus: Boolean = False; const aposition: cellpositionty = cep_top): tsourcepage;
var
  str1: filenamety;
begin
  Result := nil;
  str1   := designer.designfiles.getname(apos.filename);
  if str1 <> '' then
    Result := showsourceline(str1, apos.pos.row, apos.pos.col, asetfocus, aposition);
end;

procedure tsourcefo.resetactiverow;
begin
  if fgdbpage <> nil then
    fgdbpage.activerow := -1;
end;

function tsourcefo.locate(const info: stopinfoty): tsourcepage;
begin
  resetactiverow;
  if info.filename <> '' then
  begin
    Result := openfile(filepath(projectoptions.o.texp.makedir, info.filename));
    if Result <> nil then
    begin
      Result.activerow := info.line - 1;
      Result.Show;
    end;
  end
  else
    Result := nil;
  fgdbpage := Result;
end;

function tsourcefo.saveall(noconfirm: Boolean): modalresultty;
var
  int1, int2: integer;
begin
  Result   := mr_none;
  for int1 := 0 to files_tab.Count - 1 do
  begin
    Result := mainfo.checksavecancel(
      tsourcepage(files_tab[int1]).checksave(noconfirm, True));
    case Result of
      mr_cancel: Exit;
      mr_noall: break;
      mr_all:
      begin
        for int2 := int1 to files_tab.Count - 1 do
          tsourcepage(files_tab[int2]).checksave(True, True);
        break;
      end;
    end;
  end;
  updatehinttab;
  fallsaved := fallsaved or not noconfirm;
end;

function tsourcefo.modified: Boolean;
var
  int1: integer;
begin
  Result := False;
  if fpagedestroying = 0 then
    for int1 := 0 to Count - 1 do
      if items[int1].modified then
      begin
        Result := True;
        break;
      end;
end;

function tsourcefo.newfiletag: longword;
begin
  Inc(ffiletag);
  if ffiletag = 0 then
    ffiletag := 1;
  Result     := ffiletag;
end;

procedure tsourcefo.sourcefoonclosequery(const Sender: tcustommseform; var modalresult: modalresultty);
begin
{
 if saveall(false) = mr_cancel then begin
  modalresult:= mr_none;
 end;
}
end;


procedure tsourcefo.updatehinttab;
var
  x: integer;
  ainfo: fileinfoty;
  //modtime: tdatetime;
  //accesstime: tdatetime;
  //ctime: tdatetime;
begin
  for x := 0 to files_tab.Count - 1 do
  begin

    getfileinfo(expandprmacros(tsourcepage(files_tab[x]).pathdisp.Value), ainfo);
    tsourcepage(files_tab[x]).tabhint := tsourcepage(files_tab[x]).pathdisp.Value + lineend + 'Last modification: ' + UTF8Decode(formatdatetime('YYYY-MM-DD HH:mm:ss', UniversalTimeToLocal(ainfo.extinfo1.modtime))) +
      ' | Size: ' + UTF8Decode(IntToStr(ainfo.extinfo1.size div 1000)) + ' Kb.';

    tsourcepage(files_tab[x]).Caption := trim(tsourcepage(files_tab[x]).Caption) ;

  end;
end;

procedure tsourcefo.updatecaption;
var
  page: tsourcepage;
begin

  page := tsourcepage(files_tab.ActivePage);
  if page <> nil then
  begin
    Caption := page.Caption;

    if Assigned(ActivePage) then
    begin
      if fileexists(ActivePage.pathdisp.Value) then
        if Assigned(mainfo) then
          if Assigned(mainfo.openfile) then
          begin
            mainfo.openfile.controller.icon    := mainfo.icon;
            mainfo.openfile.controller.lastdir := ExtractFilePath(ActivePage.pathdisp.Value);
          end;
      thefilename := Caption;

      if Assigned(debuggerfo) and
        (length(lang_stockcaption) > 0) then
      begin
        debuggerfo.edited_make.hint := ' ' + lang_xstockcaption[Ord(sc_edited)] +
          ' : ' + lang_xstockcaption[Ord(sc_make)] + ' ' + Caption + ' ';

        debuggerfo.edited_run.hint := ' ' + lang_xstockcaption[Ord(sc_edited)] +
          ' : ' + lang_xstockcaption[Ord(sc_debugrun)] + ' ' + Caption + ' ';

        debuggerfo.toggle_form_unit.hint := ' ' + lang_xstockcaption[Ord(sc_edited)] +
          ' : ' + lang_xstockcaption[Ord(sc_toggleformunit)] + ' ' + Caption + ' ';

        debuggerfo.file_history.Value := tosysfilepath(filepath(ActivePage.pathdisp.Value, fk_file, True));

        debuggerfo.edit_compiler.hint    := ' Compiler Type for ' + Caption + ' ';
        debuggerfo.edit_compilernum.hint := ' Compiler Number for ' + Caption + ' ';
        debuggerfo.edit_options.hint     := ' Option Number for ' + Caption + '. X --> No parameters.';

      end;

      if beautyformcreated then
      begin
        beautyfo.filetoclean.Value := ExtractFileName(debuggerfo.file_history.Value);
        beautyfo.filetoclean.hint  := debuggerfo.file_history.Value;
      end;

      if plformcreated then
        procedurelistfo.updatelist(debuggerfo.file_history.Value);
    end;
  //  tsourcepage(files_tab.ActivePage).Caption := trim(tsourcepage(files_tab.ActivePage).Caption) + '   ';
  end
  else
    Caption := lang_sourceform[ord(sf_none)];

end;

procedure tsourcefo.tabwidgetonactivepagechanged(const Sender: TObject);
var
  color0, color1, color2: longword;
  str1: ttextstream;
  thedir: msestring;
  ratio: double;
begin
  //tabcloser := True;
  updatecaption;
  ratio     := confideufo.fontsize.Value / 12;

  if ActivePage <> nil then
  begin
    with ActivePage do
    begin
      if mainfo.themenr = 0 then
      begin
        ActivePage.color := cl_ltgray;
        ActivePage.container.color := cl_ltgray;
        pathdisp.face.template := debuggerfo.templatemain;
        pathdisp.font.color := cl_black;
        linedisp.face.template := debuggerfo.templatemain;
        linedisp.font.color := cl_black;
        color           := cl_ltgray;
        container.color := cl_ltgray;
        color0          := cl_white;
        color1          := cl_dkgray;
        color2          := cl_black;
        pathdisp.Height := round(ratio * 20);
        linedisp.Height := round(ratio * 20);

        files_tab.tab_size  := round(24 * ratio);
        step_back.Height    := round(24 * ratio);
        step_forward.Height := round(24 * ratio);

        source_editor.Height := Height -
          pathdisp.Height - 2;

        pathdisp.top := source_editor.Height + 1;
        linedisp.top := pathdisp.top;
      end;

      if mainfo.themenr = 1 then
      begin
        ActivePage.color := cl_black;
        ActivePage.container.color := cl_black;
        pathdisp.face.template := debuggerfo.templatemaindark;
        pathdisp.font.color := cl_white;
        linedisp.face.template := debuggerfo.templatemaindark;
        linedisp.font.color := cl_white;
        color           := cl_black;
        container.color := cl_black;
        color0          := cl_black;
        color1          := cl_dkgray;
        color2          := cl_white;
      end;
    end;

    ActivePage.source_editor.frame.sbhorz.facebutton.fade_color.items[1] := color0;
    ActivePage.source_editor.frame.sbhorz.facebutton.fade_color.items[0] := color1;
    ActivePage.source_editor.frame.sbhorz.face.fade_color.items[0] := color0;
    ActivePage.source_editor.frame.sbhorz.face.fade_color.items[1] := color1;
    ActivePage.source_editor.frame.sbhorz.face1.fade_color.items[0] := color0;
    ActivePage.source_editor.frame.sbhorz.face1.fade_color.items[1] := color1;
    ActivePage.source_editor.frame.sbhorz.face2.fade_color.items[0] := color0;
    ActivePage.source_editor.frame.sbhorz.face2.fade_color.items[1] := color1;
    ActivePage.source_editor.frame.sbhorz.faceendbutton.fade_color.items[0] := color0;
    ActivePage.source_editor.frame.sbhorz.faceendbutton.fade_color.items[1] := color1;
    ActivePage.source_editor.frame.sbhorz.colorglyph := color2;

    ActivePage.source_editor.frame.sbvert.facebutton.fade_color.items[0] := color0;
    ActivePage.source_editor.frame.sbvert.facebutton.fade_color.items[1] := color1;
    ActivePage.source_editor.frame.sbvert.face.fade_color.items[1] := color0;
    ActivePage.source_editor.frame.sbvert.face.fade_color.items[0] := color1;
    ActivePage.source_editor.frame.sbvert.face1.fade_color.items[1] := color0;
    ActivePage.source_editor.frame.sbvert.face1.fade_color.items[0] := color1;
    ActivePage.source_editor.frame.sbvert.face2.fade_color.items[1] := color0;
    ActivePage.source_editor.frame.sbvert.face2.fade_color.items[0] := color1;
    ActivePage.source_editor.frame.sbvert.faceendbutton.fade_color.items[0] := color0;
    ActivePage.source_editor.frame.sbvert.faceendbutton.fade_color.items[1] := color1;
    ActivePage.source_editor.frame.sbvert.colorglyph := color2;

  end;

  if (ActivePage <> nil) and (confideufo.usedefaulteditoroptions.Value) and (layoutbusy = False) then
  begin
    if han <> -1 then
      sourcefo.syntaxpainter.freedeffile(han);

    thedir := tosysfilepath(confideufo.defsynt.Text);

    str1 := ttextstream.Create(thedir);

    han := syntaxpainter.readdeffile(str1);
    ActivePage.edit.setsyntaxdef(han);
    ActivePage.updatestatvalues;
    str1.Destroy();
  end;

end;

procedure tsourcefo.saveactivepage(const newname: filenamety = '');
begin
  if ActivePage <> nil then
    ActivePage.save(newname)//  if newname <> '' then begin
  //   filechangenotifyer.removenotification(activepage.filepath);
  //  end;
  //  if newname <> '' then begin
  //   filechangenotifyer.addnotification(activepage.filepath,activepage.filetag);
  //  end;
  ;
  updatehinttab;
end;

function tsourcefo.closepage(const apage: tsourcepage; noclosecheck: Boolean = False): Boolean;
var
  str1: filenamety;
  bo1: Boolean;
begin
  Result := apage = nil;
  if not Result then
    if apage.checksave(False, False) <> mr_cancel then
    begin
      str1 := apage.filepath;
      if not noclosecheck and (fileext(str1) = pasfileext) then
        if not mainfo.closemodule(
          designer.modules.findmodule(replacefileext(str1, formfileext)), True,
          noclosecheck) then
          Exit;
      filechangenotifyer.removenotification(str1);
      Inc(fpagedestroying);
      try
        //bo1 := files_tab.entered;
        apage.Free;
        // if bo1 then files_tab.SetFocus;
      finally
        Dec(fpagedestroying);
      end;
      Result := True;
    end;
end;

function tsourcefo.closepage(const aname: filenamety): Boolean;
begin
  Result := closepage(findsourcepage(aname));
end;

function tsourcefo.closeactivepage: Boolean;
begin
  Result := closepage(ActivePage);
end;

function tsourcefo.closeall(const nosave: Boolean): Boolean; //false on cancel
var
  int1: integer;
begin
  Result := nosave or (saveall(False) <> mr_cancel);
  if Result then
  begin
    for int1 := Count - 1 downto 0 do
      items[int1].Enabled := False//avoid showing
    ;
    for int1 := Count - 1 downto 0 do
      closepage(items[int1], True);
  end;
end;

function tsourcefo.ActivePage: tsourcepage;
begin
  if fpagedestroying > 0 then
    Result := nil
  else
    Result := tsourcepage(files_tab.ActivePage);
end;

procedure tsourcefo.textmodified(const Sender: tsourcepage);
begin
  fallsaved := False;
  if not ffileloading then
    mainfo.sourcechanged(Sender);
end;

function tsourcefo.gdbpage: tsourcepage;
begin
  Result := fgdbpage;
end;

procedure tsourcefo.addwatchactonexecute(const Sender: TObject);
begin
  with Sender as tmenuitem do
    watchfo.addwatch(getpascalvarname(ActivePage.edit,
      translateclientpoint(owner.mouseinfopo^.pos,
      owner.transientfor, ActivePage.edit)));
end;

procedure tsourcefo.updatebreakpointicon(const path: filenamety; const info: bkptlineinfoty);
var
  int1: integer;
  wstr1: msestring;
begin
  wstr1    := filename(path);
  for int1 := 0 to Count - 1 do
    with tsourcepage(files_tab[int1]) do
      if issamefilename(filename, wstr1) then
        try
          updatebreakpointicon(info);
        except
        end;
end;

function tsourcefo.geteditpositem(const index: integer): msestring;
begin
  Result := encoderecord([feditposar[index].col, feditposar[index].row]);
end;

procedure tsourcefo.seteditposcount(const Count: integer);
begin
  setlength(feditposar, Count);
end;

procedure tsourcefo.seteditpositem(const index: integer; const avalue: msestring);
begin
  decoderecord(avalue, [@feditposar[index].col, @feditposar[index].row], 'ii');
end;

function tsourcefo.getbookmarkitem(const index: integer): msestring;
begin
  Result := encoderecord([fbookmarkar[factbookmark][index].row,
    fbookmarkar[factbookmark][index].bookmarknum]);
end;

procedure tsourcefo.setbookmarkcount(const Count: integer);
begin
  setlength(fbookmarkar[factbookmark], Count);
end;

procedure tsourcefo.setbookmarkitem(const index: integer; const avalue: msestring);
begin
  decoderecord(avalue, [@fbookmarkar[factbookmark][index].row, @fbookmarkar[factbookmark][index].bookmarknum], 'ii');
end;

procedure tsourcefo.enterexe(const Sender: TObject);
begin
  mainfo.designformactivated(self);
end;

function tsourcefo.gettextstream(const filename: filenamety; forwrite: Boolean): ttextstream;
var
  page1: tsourcepage;
begin
  page1 := findsourcepage(filename, True, True);
  if forwrite then
    if page1 = nil then
      page1 := openfile(filename);
  if page1 <> nil then
    Result  := page1.edit.datalist.dataastextstream
  else if not forwrite then
    Result  := ttextstream.Create(filename, fm_read)
  else
    Result  := nil;
end;

function tsourcefo.getfiletext(const filename: filenamety; const startpos, endpos: gridcoordty): msestring;
var
  apage: tsourcepage;
begin
  apage    := openfile(filename);
  if apage <> nil then
    Result := apage.edit.gettext(startpos, endpos)
  else
    Result := '';
end;

procedure tsourcefo.replacefiletext(const filename: filenamety; const startpos, endpos: gridcoordty; const newtext: msestring);
var
  apage: tsourcepage;
begin
  apage := openfile(filename);
  if apage <> nil then
  begin
    apage.edit.deletetext(startpos, endpos);
    apage.edit.inserttext(startpos, newtext);
  end;
end;

function tsourcefo.getsourcepos: sourceposty;
begin
  finalize(Result);
  fillchar(Result, sizeof(Result), 0);
  if ActivePage <> nil then
  begin
    Result.filename := designer.designfiles.find(ActivePage.filepath);
    Result.pos      := ActivePage.edit.editpos;
  end;
end;

procedure tsourcefo.setsourcehintwidget(const avalue: twidget);
begin
  fsourcehintwidget.Free;
  setlinkedvar(avalue, tmsecomponent(fsourcehintwidget));
end;

procedure tsourcefo.editbreakpointexec(const Sender: TObject);
begin
  breakpointsfo.showbreakpoint(ActivePage.filepath, popuprow + 1, True);
end;

{
procedure tsourcefo.togglebreakpointexe(const sender: TObject);
begin
 activepage.togglebreakpoint(popuprow);
end;
}
procedure tsourcefo.popupmonupdate(const Sender: tcustommenu);
 //var
 // gc1: gridcoordty;
begin
  if (ActivePage <> nil) and (Sender.mouseinfopo <> nil) then
    popuprow := ActivePage.source_editor.cellatpos(translateclientpoint(
      Sender.mouseinfopo^.pos, ActivePage, ActivePage.source_editor)).row
  else
    popuprow := invalidaxis;
  Sender.menu.itembyname('editbreakpoint').Enabled :=
    (ActivePage <> nil) and (popuprow >= 0) and
    (ActivePage.getbreakpointstate(popuprow) > bkpts_none);
  Sender.menu.itembyname('showasform').Enabled :=
    (ActivePage <> nil) and ActivePage.ismoduletext;
  Sender.menu.itembyname('setbm').Enabled :=
    (ActivePage <> nil) and (popuprow >= 0);
  Sender.menu.itembyname('insgui').Enabled   := (ActivePage <> nil);
  Sender.menu.itembyname('insuid').Enabled   := (ActivePage <> nil);
  Sender.menu.itembyname('convpas').Enabled  := (ActivePage <> nil) and
    ActivePage.edit.hasselection;
  Sender.menu.itembyname('addwatch').Enabled := (ActivePage <> nil) and
    (Sender.mouseinfopo <> nil) and
    (getpascalvarname(ActivePage.edit,
    translateclientpoint(Sender.mouseinfopo^.pos,
    ActivePage, ActivePage.edit)) <> '');
{
 sender.menu.itembyname('instempl').enabled:= (activepage <> nil) and
      codetemplates.hastemplate(
                activepage.edit.wordatpos(activepage.edit.editpos,gc1,'',[],true));
}
end;

procedure tsourcefo.completeclassexecute(const Sender: TObject);
var
  pos1: sourceposty;
begin
  if ActivePage <> nil then
  begin
    ActivePage.edit.editor.begingroup;
    try
      pos1.pos := ActivePage.edit.editpos;
      completeclass(ActivePage.filepath, pos1);
    finally
      ActivePage.edit.editor.endgroup;
    end;
  end;
end;

procedure tsourcefo.showasformexe(const Sender: TObject);
begin
  ActivePage.asyncevent(integer(spat_showasform));
end;

procedure tsourcefo.setbookmark(const apage: tsourcepage; const arow: integer; const bookmarknum: integer);
var
  int1: integer;
  page1: tsourcepage;
  bo1: Boolean;
begin
  if bookmarknum >= 0 then
  begin
    bo1      := (arow >= 0) and (bookmarknum >= 0);
    for int1 := 0 to self.Count - 1 do
    begin
      page1  := items[int1];
      if bo1 and (page1 = apage) and (page1.findbookmark(bookmarknum) = arow) then
      begin
        page1.clearbookmark(bookmarknum);
        Exit;
      end;
      page1.clearbookmark(bookmarknum);
    end;
  end;
  apage.setbookmark(arow, bookmarknum);
end;

procedure tsourcefo.setbmexec(const Sender: TObject);
begin
  setbookmark(ActivePage, -1, tmenuitem(Sender).tag);
end;

function tsourcefo.findbookmark(const bookmarknum: integer): Boolean;
var
  int1, int2: integer;
begin
  Result   := False;
  for int1 := 0 to Count - 1 do
    with items[int1] do
    begin
      int2 := findbookmark(bookmarknum);
      if int2 >= 0 then
      begin
        source_editor.showcell(makegridcoord(invalidaxis, int2), cep_rowcenteredif);
        edit.editpos := makegridcoord(0, int2);
        activate;
        Result       := True;
      end;
    end;
end;

procedure tsourcefo.findbmexec(const Sender: TObject);
begin
  findbookmark(tmenuitem(Sender).tag);
end;

procedure tsourcefo.insguiexec(const Sender: TObject);
begin
  with ActivePage.edit do
    inserttext(editpos, UTF8Decode('[''' + createguidstring + ''']'));
end;

procedure tsourcefo.insuidexec(const Sender: TObject);
var
  id1, int1: integer;
  str1: string[4];
  str2: string;
begin
  id1 := projectoptions.o.uid;
  if integerenter(id1, minint, maxint, 'ID', 'Enter ID') = mr_ok then
  begin
    for int1 := 0 to 3 do
      str1[int1 + 1] := char(bitreverse[byte(
        (id1 and ($ff shl (int1 * 8)) shr (int1 * 8)))]);
    str1[0]          := #1;
    for int1 := 4 downto 1 do
      if str1[int1] <> #0 then
      begin
        str1[0] := char(int1);
        break;
      end;
    str2     := encodebase64(str1);
    for int1 := length(str2) downto 1 do
      if str2[int1] <> '=' then
      begin
        setlength(str2, int1);
        break;
      end;

    with ActivePage.edit do
      inserttext(editpos, UTF8Decode('[''' + str2 + ''']{' + IntToStr(id1) + '}'));
    projectoptions.o.uid := id1 + 1;
  end;
end;

procedure tsourcefo.convpasex(const Sender: TObject);
var
  ar1: msestringarty;

  function messagestr(const def: msestring): msestring;
  begin
    if high(ar1) > 4 then
    begin
      Result := concatstrings(copy(ar1, 0, 5), lineend);
      Result := Result + lineend + '...';
    end
    else
      Result := def;
  end; //msessagestr
var
  mstr1, mstr2, mstr3, mstr4: msestring;
  int1: integer;
begin
  with ActivePage.edit do
  begin
    mstr1 := selectedtext;
    ar1   := breaklines(mstr1);
    mstr3 := messagestr(mstr1);
    for int1 := 0 to high(ar1) - 1 do
      ar1[int1]    := UTF8Decode(stringtopascalstring(ar1[int1])) + '+lineend+';
    ar1[high(ar1)] := UTF8Decode(stringtopascalstring(ar1[high(ar1)]));
    mstr2          := concatstrings(ar1, lineend);
    mstr4          := messagestr(mstr2);
    if askyesno(lang_sourceform[ord(sf_wishreplace)] + lineend + mstr3 + lineend +
     lang_sourceform[ord(sf_str_with)] + lineend +
      mstr4 + lineend + '?', lang_xstockcaption[ord(sc_confirmation)]) then
    begin
      editor.begingroup;
      deleteselection;
      inserttext(mstr2, True);
      editor.endgroup;
    end;
  end;
end;

procedure tsourcefo.savecanceled;
begin
  fallsaved := False;
end;

function tsourcefo.currentselection: msestring;
begin
  Result := '';
  if ActivePage <> nil then
    with ActivePage do
      Result := edit.selectedtext;
end;

function tsourcefo.currentfilename: filenamety;
begin
  Result := '';
  if ActivePage <> nil then
    with ActivePage do
      Result := filepath;
end;

function tsourcefo.currentwordatcursor: msestring;
var
  gridcoord1: gridcoordty;
begin
  Result := '';
  if ActivePage <> nil then
    with ActivePage do
      Result := getpascalvarname(edit, edit.editpos, gridcoord1);
end;

procedure tsourcefo.stephintev(const Sender: TObject; var info: hintinfoty);
begin
  info.Caption := info.Caption + '(' +
    encodeshortcutname(tstockglyphbutton(Sender).shortcut) + ').';
end;


end.

