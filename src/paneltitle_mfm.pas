unit paneltitle_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,paneltitle;

const
 objdata: record size: integer; data: array[0..1551] of byte end =
      (size: 1552; data: (
  84,80,70,48,13,116,112,97,110,101,108,116,105,116,108,101,102,111,12,112,
  97,110,101,108,116,105,116,108,101,102,111,7,118,105,115,105,98,108,101,8,
  8,98,111,117,110,100,115,95,120,3,22,2,8,98,111,117,110,100,115,95,
  121,3,8,1,9,98,111,117,110,100,115,95,99,120,3,43,1,9,98,111,
  117,110,100,115,95,99,121,2,78,26,99,111,110,116,97,105,110,101,114,46,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,27,99,
  111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,114,46,98,
  111,117,110,100,115,1,2,0,2,0,3,43,1,2,78,0,9,102,111,110,
  116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,117,108,116,15,
  102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,0,14,102,111,
  110,116,101,109,112,116,121,46,110,97,109,101,6,9,115,116,102,95,101,109,
  112,116,121,20,102,111,110,116,101,109,112,116,121,46,108,111,99,97,108,112,
  114,111,112,115,11,0,7,99,97,112,116,105,111,110,6,14,84,105,116,108,
  101,32,111,102,32,112,97,110,101,108,12,105,99,111,110,46,111,112,116,105,
  111,110,115,11,10,98,109,111,95,109,97,115,107,101,100,0,15,105,99,111,
  110,46,111,114,105,103,102,111,114,109,97,116,6,3,112,110,103,10,105,99,
  111,110,46,105,109,97,103,101,10,100,2,0,0,0,0,0,0,2,0,0,
  0,16,0,0,0,16,0,0,0,240,1,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,239,0,21,49,255,255,1,74,255,255,1,107,255,255,
  1,165,255,255,1,181,255,255,1,165,255,255,1,0,239,0,9,107,255,247,
  1,49,255,255,1,82,255,255,1,123,255,255,1,181,255,255,1,198,255,255,
  1,165,255,255,2,0,239,0,7,8,239,8,1,24,255,173,1,57,255,255,
  1,90,255,255,1,140,255,255,1,198,255,255,1,214,255,255,1,165,255,255,
  1,90,255,181,1,41,255,41,1,0,239,0,5,49,239,49,1,8,239,8,
  1,24,255,173,1,66,255,255,1,107,255,255,1,165,255,255,1,231,255,255,
  1,222,255,255,1,165,255,255,1,82,255,181,1,41,255,41,1,66,255,66,
  1,0,239,0,4,49,239,49,1,8,239,8,1,24,255,90,1,66,255,247,
  1,123,255,255,1,198,255,255,3,165,255,255,1,74,255,132,1,41,255,41,
  1,57,247,57,1,0,239,0,4,49,239,49,1,8,239,8,1,24,255,33,
  1,74,255,206,1,148,255,255,1,222,255,255,1,198,255,255,2,156,255,231,
  1,66,255,74,1,33,255,33,1,57,247,57,1,0,239,0,4,49,239,49,
  1,8,239,8,1,24,255,24,1,82,255,107,1,222,255,255,1,198,255,255,
  3,148,255,165,1,66,255,66,1,33,255,33,1,57,247,57,1,0,239,0,
  4,49,239,49,1,8,231,8,1,16,247,16,1,57,247,57,1,222,247,222,
  1,198,255,255,2,222,247,222,1,90,255,90,1,33,255,33,1,16,247,16,
  1,49,239,49,1,0,239,0,4,49,239,49,1,0,231,0,2,8,231,8,
  1,115,239,115,1,198,255,255,2,115,239,115,1,16,231,16,1,0,231,0,
  2,49,239,49,1,0,239,0,4,49,239,49,1,0,231,0,3,16,231,16,
  1,41,222,41,2,16,231,16,1,0,231,0,3,49,239,49,1,0,239,0,
  4,49,239,49,1,0,231,0,2,0,222,0,5,0,231,0,3,49,239,49,
  1,0,239,0,4,49,239,49,1,0,231,0,10,49,239,49,1,0,239,0,
  4,49,239,49,1,0,231,0,10,49,239,49,1,0,239,0,5,115,239,115,
  1,0,222,0,1,0,231,0,5,0,222,0,2,115,239,115,1,0,239,0,
  19,0,0,0,0,224,7,0,0,240,15,0,0,248,31,0,0,252,63,0,
  0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,
  0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,0,248,31,0,
  0,0,0,0,0,13,119,105,110,100,111,119,111,112,97,99,105,116,121,5,
  0,0,0,0,0,0,0,128,255,255,15,109,111,100,117,108,101,99,108,97,
  115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,109,0,5,116,101,
  100,105,116,6,116,101,100,105,116,49,13,102,114,97,109,101,46,99,97,112,
  116,105,111,110,6,41,67,117,115,116,111,109,32,116,105,116,108,101,32,40,
  108,101,97,118,101,32,101,109,112,116,121,32,102,111,114,32,97,117,116,111,
  45,116,105,116,108,101,41,22,102,114,97,109,101,46,99,97,112,116,105,111,
  110,116,101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,
  109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,
  0,2,18,2,0,2,0,0,8,98,111,117,110,100,115,95,120,2,9,8,
  98,111,117,110,100,115,95,121,2,8,9,98,111,117,110,100,115,95,99,120,
  3,22,1,9,98,111,117,110,100,115,95,99,121,2,39,13,114,101,102,102,
  111,110,116,104,101,105,103,104,116,2,15,0,0,7,116,98,117,116,116,111,
  110,8,116,98,117,116,116,111,110,49,8,116,97,98,111,114,100,101,114,2,
  1,8,98,111,117,110,100,115,95,120,2,85,8,98,111,117,110,100,115,95,
  121,2,51,9,98,111,117,110,100,115,95,99,120,2,50,9,98,111,117,110,
  100,115,95,99,121,2,20,5,115,116,97,116,101,11,15,97,115,95,108,111,
  99,97,108,99,97,112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,
  110,101,120,101,99,117,116,101,0,7,99,97,112,116,105,111,110,6,2,79,
  75,9,111,110,101,120,101,99,117,116,101,7,4,111,110,111,107,0,0,7,
  116,98,117,116,116,111,110,8,116,98,117,116,116,111,110,50,8,116,97,98,
  111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,3,170,0,8,
  98,111,117,110,100,115,95,121,2,51,9,98,111,117,110,100,115,95,99,120,
  2,53,9,98,111,117,110,100,115,95,99,121,2,20,5,115,116,97,116,101,
  11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,17,97,115,
  95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,112,
  116,105,111,110,6,6,67,97,110,99,101,108,9,111,110,101,120,101,99,117,
  116,101,7,5,110,111,99,97,110,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tpaneltitlefo,'');
end.
