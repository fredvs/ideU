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
 msetypes,msegraphics,mseglob,msegui,msebitmap,msegraphutils,mseclasses,
 msestrings,msedatamodules,mseguiglob;

const
 boxsize = 11;      //for treelistitem expand box
 checkboxsize = 13; //for listitem checkbox

{.$ifdef mse_dynpo}
VAR
  lang_stockcaption,
  lang_modalresult,
  lang_modalresultnoshortcut,
  lang_extended,
  lang_langnames: array of msestring;
{.$endif}

type

 stockbitmapty = (stb_default,stb_none,
                  stb_dens0,stb_dens10,stb_dens25,
                                stb_dens50,stb_dens75,stb_dens90,stb_dens100,
                  stb_block2,stb_block3,stb_block4,
                  stb_hatchup3,stb_hatchup4,stb_hatchup5,
                  stb_hatchdown3,stb_hatchdown4,stb_hatchdown5,
                  stb_crosshatch3,stb_crosshatch4,stb_crosshatch5,stb_crosshatch6
                  );
const
 stb_block1 = stb_dens50;

type
 stockglyphty = (        //order fix!
 //  0         1               2
  stg_none,stg_checked,stg_checkedradio,
 //   3         4               5
  stg_box,stg_boxexpanded,stg_boxexpand,
 //   6             7              8            9
  stg_arrowright,stg_arrowup,stg_arrowleft,stg_arrowdown,
 //  10
  stg_ellipse,
 //        11               12                 13                14
  stg_arrowrightsmall,stg_arrowupsmall,stg_arrowleftsmall,stg_arrowdownsmall,
 //       15                16
  stg_arrowfirstsmall,stg_arrowlastsmall,
 //       17
  stg_ellipsesmall,
 //     18         19         20         21         22
  stg_dbfirst,stg_dbprior,stg_dbnext,stg_dblast,stg_dbinsert,
 //     23          24        25         26         27
  stg_dbdelete,stg_dbedit,stg_dbpost,stg_dbcancel,stg_dbrefresh,
 //     28            29              30            31          32
  stg_dbfilter,stg_dbfiltermin,stg_dbfiltermax,stg_dbfilteron,stg_dbfind,
 //     33              34              35            36
  stg_dbfilteroff,stg_dbindbrowse,stg_dbindedit,stg_dbindinsert,
 //  37        38           39                    40
  stg_dot,stg_dotsmall,stg_arrowtopsmall,stg_arrowbottomsmall,
 //    41               42                      43               44
  stg_checkbox,stg_checkboxchecked,stg_checkboxchildchecked,stg_checkboxradio,
 //    45             46          47
  stg_circlesmall,stg_circle,stg_circlebig,
 //    48             49          50
  stg_squaresmall,stg_square,stg_squarebig,
 //    51             52          53
  stg_diamondsmall,stg_diamond,stg_diamondbig,
 //    54             55          56
  stg_crosssmall,stg_cross,stg_crossbig,
 //    57             58          59
  stg_diagsmall,stg_diag,stg_diagbig,
 //    60             61          62
  stg_triasmall,stg_tria,stg_triabig,
 //    63             64          65
  stg_triatopsmall,stg_triatop,stg_triatopbig,
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
  stg_doublesquare,stg_dbfilterclear,stg_checkboxparentnotchecked,
 //    83
  stg_checkboxchildnotchecked, stg_nil
                 );

const
 firsttracesymbol = stg_circlesmall;
 lasttracesymbol = stg_triatopbig;

{.$ifdef mse_dynpo}
type
  extendedty = (
    ex_del_row_selected,
    ex_del_rows_selected
    );
{.$endif}
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
    sc_exists_overwrite, sc_is_modified_save,
    sc_warningupper, sc_exception, sc_system,
    sc_does_not_exist,
    sc_passwordupper, sc_enterpassword, sc_invalidpassword,
    sc_can_not_read_directory,
    sc_graphic_format_not_supported, sc_graphic_format_error,
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
    sc_newfile, sc_tools, sc_lang,
    sc_directory, sc_noicons, sc_nolateral, sc_compact,
    sc_path, sc_file
    );

 textgeneratorfuncty = function(const params: array of const): msestring;
 textgeneratorty = (tg_delete_n_selected_rows);

 tstockobjects = class
  private
   fbitmaps: array[stockbitmapty] of tbitmap;
   ffonts: array[stockfontty] of twidgetfont;
   fglyphs: timagelist;
   ffontaliasregistered: boolean;
   function getbitmaps(index: stockbitmapty): tbitmap;
   function getfonts(index: stockfontty): twidgetfont;
   procedure setmseicon(const avalue: tmaskedbitmap);
   function getmseicon: tmaskedbitmap;
   function getglyphs: timagelist;
   procedure fontchanged(const sender: tobject);
//  {$ifndef mse_dynpo}
   function getmodalresulttext(index: modalresultty): msestring;
   function getmodalresulttextnoshortcut(index: modalresultty): msestring;
   function getcaptions(index: stockcaptionty): msestring;
  {$ifndef mse_dynpo}
   function gettextgenerator(index: textgeneratorty): textgeneratorfuncty;
  {$else}
   function getextended  (index: extendedty): msestring;
   function getlangnames (index: integer): msestring;
  {$endif}
  public
   constructor create;
   destructor destroy; override;
   procedure paintglyph(const canvas: tcanvas; const glyph: stockglyphty;
              const rect: rectty; const grayed: boolean = false;
              const color: colorty = cl_glyph;
              aalignment: alignmentsty = [al_ycentered,al_xcentered]);
   property bitmaps[index: stockbitmapty]: tbitmap read getbitmaps;
   property fonts[index: stockfontty]: twidgetfont read getfonts;
   property glyphs: timagelist read getglyphs;
   property mseicon: tmaskedbitmap read getmseicon write setmseicon;
//  {$ifndef mse_dynpo}
   property modalresulttext[index: modalresultty]: msestring
                                               read getmodalresulttext;
   property modalresulttextnoshortcut[index: modalresultty]: msestring
                                            read getmodalresulttextnoshortcut;
   property captions[index: stockcaptionty]: msestring read getcaptions;
{$ifndef mse_dynpo}
   property textgenerators[index: textgeneratorty]: textgeneratorfuncty
                                                       read gettextgenerator;
{$else}
   property extended [index: extendedty]: msestring read getextended;
   property langname [index: integer]:    msestring read getlangnames;
{$endif}
end;

type
 tstockdata = class(tmsedatamodule)
   glyphs: timagelist;
   mseicon: tbitmapcomp;
 end;

function stockobjects: tstockobjects;
function sc(const acaption: stockcaptionty): msestring;
{$ifdef mse_dynpo}
function stockcaptions (const acaption: stockcaptionty): msestring;
{$endif}
procedure init;
procedure deinit;

implementation

uses
 sysutils,msestockobjects_mfm,msesysintf1,mseguiintf,typinfo,mseconsts,msefont;
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

          //win98 can not use patternbrush < 8*8

 b_none_98:   array[0..7] of byte = ($00,$00,$00,$00,$00,$00,$00,$00);  //8*8
 b_0_98:   array[0..7] of byte = ($00,$00,$00,$00,$00,$00,$00,$00);     //8*8
 b_10_98:  array[0..15] of byte = ($41,$00,$00,$00,$08,$02,$00,$00,
                                  $41,$00,$00,$00,$08,$02,$00,$00); //12*8
 b_25_98:  array[0..7] of byte = ($11,$44,$11,$44,$11,$44,$11,$44);     //8*8
 b_50_98:  array[0..7] of byte = ($55,$aa,$55,$aa,$55,$aa,$55,$aa);     //8*8
 b_75_98:  array[0..7] of byte = ($ee,$bb,$ee,$bb,$ee,$bb,$ee,$bb);     //8*8
 b_90_98:  array[0..15] of byte = ($be,$0f,$ff,$0f,$f7,$0d,$ff,$0f,
                                  $be,$0f,$ff,$0f,$f7,$0d,$ff,$0f); //12*8
 b_100_98: array[0..7] of byte = ($ff,$ff,$ff,$ff,$ff,$ff,$ff,$ff);     //8*8
 b_block2_98: array[0..7] of byte = ($33,$33,$cc,$cc,$33,$33,$cc,$cc); //8*8
 b_block3_98: array[0..23] of byte = ($c7,$01,$c7,$01,$c7,$01,
                                      $38,$0e,$38,$0e,$38,$0e, //12*12
                                      $c7,$01,$c7,$01,$c7,$01,
                                      $38,$0e,$38,$0e,$38,$0e);
 b_block4_98: array[0..7] of byte = ($0f,$0f,$0f,$0f,$f0,$f0,$f0,$f0); //8*8
 b_hatchup3_98: array[0..23] of byte = ($24,$09,$92,$04,$49,$02,
                                        $24,$09,$92,$04,$49,$02,
                                        $24,$09,$92,$04,$49,$02,
                                        $24,$09,$92,$04,$49,$02); //12*12
 b_hatchup4_98: array[0..7] of byte = ($88,$44,$22,$11,$88,$44,$22,$11); //8*8
 b_hatchup5_98: array[0..19] of byte = ($10,$02,$08,$01,$84,$00,$42,$00,$21,$00,
                                        $10,$02,$08,$01,$84,$00,$42,$00,$21,$00); //10*10
 b_hatchdown3_98: array[0..17] of byte = ($49,$00,$92,$00,$24,$01,
                                         $49,$00,$92,$00,$24,$01,
                                         $49,$00,$92,$00,$24,$01); //9*9
 b_hatchdown4_98: array[0..7] of byte = ($11,$22,$44,$88,$11,$22,$44,$88); //8*8
 b_hatchdown5_98: array[0..19] of byte = ($21,$00,$42,$00,$84,$00,$08,$01,$10,$02,
                                          $21,$00,$42,$00,$84,$00,$08,$01,$10,$02); //10*10
 b_crosshatch3_98: array[0..23] of byte = ($6d,$01,$92,$00,$6d,$01,
                                           $6d,$01,$92,$00,$6d,$01,
                                           $6d,$01,$92,$00,$6d,$01,
                                           $6d,$01,$92,$00,$6d,$01); //12*12
 b_crosshatch4_98: array[0..7] of byte = ($88,$55,$22,$55,$88,$55,$22,$55); //8*8
 b_crosshatch5_98: array[0..19] of byte = ($31,$02,$4a,$01,$84,$00,$4a,$01,$31,$02,
                                           $31,$02,$4a,$01,$84,$00,$4a,$01,$31,$02); //10*10
 b_crosshatch6_98: array[0..23] of byte = ($20,$08,$51,$04,$8a,$02,$04,$01,$8a,$02,$51,$04,
                                          $20,$08,$51,$04,$8a,$02,$04,$01,$8a,$02,$51,$04); //12*12

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
 if stockobjs = nil then begin
  stockobjs:= tstockobjects.create;
  application.initialize; //stockdata needs initialized application
 end;
 result:= stockobjs;
end;

function sc(const acaption: stockcaptionty): msestring;
begin
 result:= stockobjects.captions[acaption];
end;
{$ifdef mse_dynpo}
function stockcaptions (const acaption: stockcaptionty): msestring;
begin
 result:= stockobjects.captions[acaption];
end;
{$endif}
procedure init;
begin
// deinit;
 if stockdata = nil then begin
  stockdata:= tstockdata.create(nil,true);
 end;
end;

procedure deinit;
begin
 freeandnil(stockobjs);
 freeandnil(stockdata);
end;

{ tstockobjects }

constructor tstockobjects.create;
begin
 //dummy
end;

destructor tstockobjects.destroy;
var
 bmps: stockbitmapty;
 fonts1: stockfontty;
begin
 for bmps:= low(stockbitmapty) to high(stockbitmapty) do begin
  fbitmaps[bmps].free;
 end;
 for fonts1:= low(stockfontty) to high(stockfontty) do begin
  ffonts[fonts1].Free;
 end;
 fglyphs.Free;
 inherited;
end;

function tstockobjects.getbitmaps(index: stockbitmapty): tbitmap;
begin
  if fbitmaps[index] = nil then begin
  fbitmaps[index]:= tbitmap.create(bmk_mono);
  {$ifdef mswindows}
  if iswin98 then begin
   case index of             //must be >= 8*8 for win98
    stb_default,stb_none: fbitmaps[index].loaddata(makesize(8,8),@b_none_98);
    stb_dens0: fbitmaps[index].loaddata(makesize(8,8),@b_0_98);
    stb_dens10: fbitmaps[index].loaddata(makesize(12,8),@b_10_98);
    stb_dens25: fbitmaps[index].loaddata(makesize(8,8),@b_25_98);
    stb_dens50: fbitmaps[index].loaddata(makesize(8,8),@b_50_98);
    stb_dens75: fbitmaps[index].loaddata(makesize(8,8),@b_75_98);
    stb_dens90: fbitmaps[index].loaddata(makesize(12,8),@b_90_98);
    stb_dens100: fbitmaps[index].loaddata(makesize(8,8),@b_100_98);
    stb_block2: fbitmaps[index].loaddata(makesize(8,8),@b_block2_98);
    stb_block3: fbitmaps[index].loaddata(makesize(12,12),@b_block3_98);
    stb_block4: fbitmaps[index].loaddata(makesize(8,8),@b_block4_98);
    stb_hatchup3: fbitmaps[index].loaddata(makesize(12,12),@b_hatchup3_98);
    stb_hatchup4: fbitmaps[index].loaddata(makesize(8,8),@b_hatchup4_98);
    stb_hatchup5: fbitmaps[index].loaddata(makesize(10,10),@b_hatchup5_98);
    stb_hatchdown3: fbitmaps[index].loaddata(makesize(9,9),@b_hatchdown3_98);
    stb_hatchdown4: fbitmaps[index].loaddata(makesize(8,8),@b_hatchdown4_98);
    stb_hatchdown5: fbitmaps[index].loaddata(makesize(10,10),@b_hatchdown5_98);
    stb_crosshatch3: fbitmaps[index].loaddata(makesize(9,9),@b_crosshatch3_98);
    stb_crosshatch4: fbitmaps[index].loaddata(makesize(8,8),@b_crosshatch4_98);
    stb_crosshatch5: fbitmaps[index].loaddata(makesize(10,10),@b_crosshatch5_98);
    stb_crosshatch6: fbitmaps[index].loaddata(makesize(12,12),@b_crosshatch6_98);
   end;
  end
  else begin
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
 result:= fbitmaps[index];
end;

procedure tstockobjects.fontchanged(const sender: tobject);
var
 int1: integer;
begin
 with application do begin
  for int1:= 0 to windowcount - 1 do begin
   with twidget1(windows[int1].owner) do begin
    fontchanged;
   end;
  end;
 end;
end;

function tstockobjects.getfonts(index: stockfontty): twidgetfont;
var
 fo1: stockfontty;
 str1: string;
begin
 if not ffontaliasregistered then begin
  for fo1:= low(stockfontty) to high(stockfontty) do begin
   case fo1 of
    stf_default: begin
     str1:= '';
    end;
    else begin
     str1:= 'stf_default';
    end;
   end;
   registerfontalias(getenumname(typeinfo(stockfontty),ord(fo1)),
            gui_getdefaultfontnames[fo1],fam_nooverwrite,0,0,[],1.0,str1);
  end;
  ffontaliasregistered:= true;
 end;
 if ffonts[index] = nil then begin
  ffonts[index]:= twidgetfont.create;
  ffonts[index].name:= getenumname(typeinfo(stockfontty),ord(index));
  ffonts[index].onchange:= {$ifdef FPC}@{$endif}fontchanged;
 end;
 result:= ffonts[index];
end;

function tstockobjects.getglyphs: timagelist;
begin
 result:= stockdata.glyphs;
end;

function tstockobjects.getmseicon: tmaskedbitmap;
begin
 result:= stockdata.mseicon.bitmap;
end;

procedure tstockobjects.setmseicon(const avalue: tmaskedbitmap);
begin
 stockdata.mseicon.bitmap.assign(avalue);
end;

procedure tstockobjects.paintglyph(const canvas: tcanvas;
     const glyph: stockglyphty; const rect: rectty;
     const grayed: boolean = false;  const color: colorty = cl_glyph;
     aalignment: alignmentsty = [al_ycentered,al_xcentered]);
var
 colorbefore: colorty;
begin
 colorbefore:= canvas.color;
 canvas.color:= color;
 if grayed then begin
  aalignment:= aalignment + [al_grayed];
 end;
 glyphs.paint(canvas,integer(glyph),rect,aalignment,color);
 canvas.color:= colorbefore;
end;

{$ifndef mse_dynpo}
function tstockobjects.getmodalresulttext(index: modalresultty): msestring;
begin
 result:= mseconsts.modalresulttext(index);
// result:= fmodalresulttext[index];
end;

function tstockobjects.getmodalresulttextnoshortcut(index: modalresultty): msestring;
begin
 result:= mseconsts.modalresulttextnoshortcut(index);
// result:= fmodalresulttextnoshortcut[index];
end;

function tstockobjects.getcaptions(index: stockcaptionty): msestring;
begin
 result:= stockcaptions(index);
end;

function tstockobjects.gettextgenerator(index: textgeneratorty): textgeneratorfuncty;
begin
 result:= stocktextgenerators(index);
end;

 {$else}

function tstockobjects.getmodalresulttext (index: modalresultty): msestring;
begin
// result:= mseconsts.modalresulttext(index);
 stockobjects;   // assure initialization
 if length(lang_modalresult) >= ord(index) -1 then
 result:= lang_modalresult [ord(index)] else
 begin
 if ord(index) = 7 then result:= '&Cancel' else
 if ord(index) = 8 then result:= '&Abort' else
 if ord(index) = 9 then result:= '&OK' else
 if ord(index) = 10 then result:= '&Yes' else
 if ord(index) = 11 then result:= '&No' else
 if ord(index) = 12 then result:= '&All' else
 if ord(index) = 13 then result:= 'Yes &all' else
 if ord(index) = 14 then result:= 'N&o all' else
 if ord(index) = 15 then result:= '&Ignore' else
 if ord(index) = 16 then result:= '&Skip' else
 if ord(index) = 17 then result:= 'Skip a&ll' else
 if ord(index) = 18 then result:= 'Co&ntinue' else
 result:= inttostr(ord(index));
 end;
end;

function tstockobjects.getmodalresulttextnoshortcut (index: modalresultty): msestring;
begin
// result:= mseconsts.modalresulttextnoshortcut(index);
 stockobjects;   // assure initialization
 if length(lang_modalresultnoshortcut) >= ord(index) -1 then
 result:= lang_modalresultnoshortcut [ord(index)]
 else
 begin
 if ord(index) = 7 then result:= 'Cancel' else
 if ord(index) = 8 then result:= 'Abort' else
 if ord(index) = 9 then result:= 'OK' else
 if ord(index) = 10 then result:= 'Yes' else
 if ord(index) = 11 then result:= 'No' else
 if ord(index) = 12 then result:= 'All' else
 if ord(index) = 13 then result:= 'Yes all' else
 if ord(index) = 14 then result:= 'No all' else
 if ord(index) = 15 then result:= 'Ignore' else
 if ord(index) = 16 then result:= 'Skip' else
 if ord(index) = 17 then result:= 'Skip all' else
 if ord(index) = 18 then result:= 'Continue' else
 result:= inttostr(ord(index));
 end;
end;

function tstockobjects.getcaptions (index: stockcaptionty): msestring;
begin
// result:= stockcaptions(index);
 stockobjects;   // assure initialization
 if length(lang_stockcaption) >= ord(index) -1 then
 result:= lang_stockcaption [ord(index)] else
 result:= inttostr(ord(index)); 
end;

function tstockobjects.getextended (index: extendedty): msestring;
begin
// result:= stockobjects.extended [index];
 stockobjects;   // assure initialization
 if length(lang_extended) >= ord(index) -1 then
 result:= lang_extended [ord(index)] else
 result:= inttostr(ord(index));  
end;

function tstockobjects.getlangnames (index: integer): msestring;
begin
// result:= stockobjects.langname [index];
 stockobjects;   // assure initialization
 if length(lang_langnames) >= ord(index) -1 then
 result:= lang_langnames [ord(index)] else
 result:= inttostr(ord(index));  
end;
 {$endif}

end.
