unit replacedialogform_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,replacedialogform;

const
 objdata: record size: integer; data: array[0..4354] of byte end =
      (size: 4355; data: (
  84,80,70,48,16,116,114,101,112,108,97,99,101,100,105,97,108,111,103,102,
  111,15,114,101,112,108,97,99,101,100,105,97,108,111,103,102,111,7,118,105,
  115,105,98,108,101,8,8,98,111,117,110,100,115,95,120,3,191,1,8,98,
  111,117,110,100,115,95,121,3,253,0,9,98,111,117,110,100,115,95,99,120,
  3,77,1,9,98,111,117,110,100,115,95,99,121,3,229,0,12,98,111,117,
  110,100,115,95,99,120,109,105,110,3,77,1,26,99,111,110,116,97,105,110,
  101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,27,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,16,99,111,110,116,97,105,110,101,
  114,46,98,111,117,110,100,115,1,2,0,2,0,3,77,1,3,229,0,0,
  9,102,111,110,116,46,110,97,109,101,6,11,115,116,102,95,100,101,102,97,
  117,108,116,15,102,111,110,116,46,108,111,99,97,108,112,114,111,112,115,11,
  0,14,102,111,110,116,101,109,112,116,121,46,110,97,109,101,6,9,115,116,
  102,95,101,109,112,116,121,20,102,111,110,116,101,109,112,116,121,46,108,111,
  99,97,108,112,114,111,112,115,11,0,7,111,112,116,105,111,110,115,11,14,
  102,111,95,102,114,101,101,111,110,99,108,111,115,101,13,102,111,95,99,108,
  111,115,101,111,110,101,115,99,17,102,111,95,108,111,99,97,108,115,104,111,
  114,116,99,117,116,115,15,102,111,95,97,117,116,111,114,101,97,100,115,116,
  97,116,16,102,111,95,97,117,116,111,119,114,105,116,101,115,116,97,116,10,
  102,111,95,115,97,118,101,112,111,115,13,102,111,95,115,97,118,101,122,111,
  114,100,101,114,0,8,115,116,97,116,102,105,108,101,7,9,115,116,97,116,
  102,105,108,101,49,7,99,97,112,116,105,111,110,6,21,70,105,110,100,32,
  97,110,100,32,82,101,112,108,97,99,101,32,84,101,120,116,12,105,99,111,
  110,46,111,112,116,105,111,110,115,11,10,98,109,111,95,109,97,115,107,101,
  100,0,15,105,99,111,110,46,111,114,105,103,102,111,114,109,97,116,6,3,
  112,110,103,10,105,99,111,110,46,105,109,97,103,101,10,100,2,0,0,0,
  0,0,0,2,0,0,0,16,0,0,0,16,0,0,0,240,1,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,0,0,0,0,239,0,21,49,255,255,1,74,
  255,255,1,107,255,255,1,165,255,255,1,181,255,255,1,165,255,255,1,0,
  239,0,9,107,255,247,1,49,255,255,1,82,255,255,1,123,255,255,1,181,
  255,255,1,198,255,255,1,165,255,255,2,0,239,0,7,8,239,8,1,24,
  255,173,1,57,255,255,1,90,255,255,1,140,255,255,1,198,255,255,1,214,
  255,255,1,165,255,255,1,90,255,181,1,41,255,41,1,0,239,0,5,49,
  239,49,1,8,239,8,1,24,255,173,1,66,255,255,1,107,255,255,1,165,
  255,255,1,231,255,255,1,222,255,255,1,165,255,255,1,82,255,181,1,41,
  255,41,1,66,255,66,1,0,239,0,4,49,239,49,1,8,239,8,1,24,
  255,90,1,66,255,247,1,123,255,255,1,198,255,255,3,165,255,255,1,74,
  255,132,1,41,255,41,1,57,247,57,1,0,239,0,4,49,239,49,1,8,
  239,8,1,24,255,33,1,74,255,206,1,148,255,255,1,222,255,255,1,198,
  255,255,2,156,255,231,1,66,255,74,1,33,255,33,1,57,247,57,1,0,
  239,0,4,49,239,49,1,8,239,8,1,24,255,24,1,82,255,107,1,222,
  255,255,1,198,255,255,3,148,255,165,1,66,255,66,1,33,255,33,1,57,
  247,57,1,0,239,0,4,49,239,49,1,8,231,8,1,16,247,16,1,57,
  247,57,1,222,247,222,1,198,255,255,2,222,247,222,1,90,255,90,1,33,
  255,33,1,16,247,16,1,49,239,49,1,0,239,0,4,49,239,49,1,0,
  231,0,2,8,231,8,1,115,239,115,1,198,255,255,2,115,239,115,1,16,
  231,16,1,0,231,0,2,49,239,49,1,0,239,0,4,49,239,49,1,0,
  231,0,3,16,231,16,1,41,222,41,2,16,231,16,1,0,231,0,3,49,
  239,49,1,0,239,0,4,49,239,49,1,0,231,0,2,0,222,0,5,0,
  231,0,3,49,239,49,1,0,239,0,4,49,239,49,1,0,231,0,10,49,
  239,49,1,0,239,0,4,49,239,49,1,0,231,0,10,49,239,49,1,0,
  239,0,5,115,239,115,1,0,222,0,1,0,231,0,5,0,222,0,2,115,
  239,115,1,0,239,0,19,0,0,0,0,224,7,0,0,240,15,0,0,248,
  31,0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,
  63,0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,63,0,0,252,
  63,0,0,248,31,0,0,0,0,0,0,13,119,105,110,100,111,119,111,112,
  97,99,105,116,121,5,0,0,0,0,0,0,0,128,255,255,6,111,110,115,
  104,111,119,7,7,111,110,99,114,101,97,116,15,109,111,100,117,108,101,99,
  108,97,115,115,110,97,109,101,6,8,116,109,115,101,102,111,114,109,0,12,
  116,104,105,115,116,111,114,121,101,100,105,116,8,102,105,110,100,116,101,120,
  116,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,13,84,101,120,
  116,32,116,111,32,38,102,105,110,100,22,102,114,97,109,101,46,99,97,112,
  116,105,111,110,116,101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,
  116,116,111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,
  18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,18,
  102,114,97,109,101,46,98,117,116,116,111,110,46,99,111,108,111,114,4,2,
  0,0,128,29,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,30,102,114,97,109,
  101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,49,11,0,27,102,114,97,109,101,46,98,117,116,116,111,
  110,46,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,
  105,110,102,111,46,109,97,105,110,109,101,110,117,102,114,97,109,101,19,102,
  114,97,109,101,46,98,117,116,116,111,110,115,46,99,111,117,110,116,2,1,
  19,102,114,97,109,101,46,98,117,116,116,111,110,115,46,105,116,101,109,115,
  14,1,5,99,111,108,111,114,4,2,0,0,128,16,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,
  101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,97,105,110,
  109,101,110,117,102,114,97,109,101,0,0,16,102,114,97,109,101,46,111,117,
  116,101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,0,8,98,
  111,117,110,100,115,95,120,2,4,8,98,111,117,110,100,115,95,121,2,40,
  9,98,111,117,110,100,115,95,99,120,3,69,1,9,98,111,117,110,100,115,
  95,99,121,2,39,7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,
  102,116,6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,19,
  100,114,111,112,100,111,119,110,46,99,111,108,115,46,99,111,117,110,116,2,
  1,19,100,114,111,112,100,111,119,110,46,99,111,108,115,46,105,116,101,109,
  115,14,1,0,0,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,
  15,0,0,12,116,104,105,115,116,111,114,121,101,100,105,116,11,114,101,112,
  108,97,99,101,116,101,120,116,13,102,114,97,109,101,46,99,97,112,116,105,
  111,110,6,13,38,82,101,112,108,97,99,101,32,119,105,116,104,22,102,114,
  97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,102,108,97,103,115,
  11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,
  109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,116,102,114,97,109,
  101,99,111,109,112,51,18,102,114,97,109,101,46,98,117,116,116,111,110,46,
  99,111,108,111,114,4,2,0,0,128,29,102,114,97,109,101,46,98,117,116,
  116,111,110,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  11,0,30,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,27,102,114,97,109,
  101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,116,101,109,112,108,
  97,116,101,7,20,109,97,105,110,102,111,46,109,97,105,110,109,101,110,117,
  102,114,97,109,101,19,102,114,97,109,101,46,98,117,116,116,111,110,115,46,
  99,111,117,110,116,2,1,19,102,114,97,109,101,46,98,117,116,116,111,110,
  115,46,105,116,101,109,115,14,1,5,99,111,108,111,114,4,2,0,0,128,
  16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,
  102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,
  102,111,46,109,97,105,110,109,101,110,117,102,114,97,109,101,0,0,16,102,
  114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,18,
  2,0,2,0,0,8,116,97,98,111,114,100,101,114,2,1,8,98,111,117,
  110,100,115,95,120,2,4,8,98,111,117,110,100,115,95,121,2,84,9,98,
  111,117,110,100,115,95,99,120,3,69,1,9,98,111,117,110,100,115,95,99,
  121,2,39,7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,
  6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,8,115,116,
  97,116,102,105,108,101,7,9,115,116,97,116,102,105,108,101,49,19,100,114,
  111,112,100,111,119,110,46,99,111,108,115,46,99,111,117,110,116,2,1,19,
  100,114,111,112,100,111,119,110,46,99,111,108,115,46,105,116,101,109,115,14,
  1,0,0,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,
  0,12,116,98,111,111,108,101,97,110,101,100,105,116,13,99,97,115,101,115,
  101,110,115,105,116,105,118,101,13,102,114,97,109,101,46,99,97,112,116,105,
  111,110,6,14,38,99,97,115,101,115,101,110,115,105,116,105,118,101,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,
  97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,
  46,109,101,110,117,105,116,101,109,102,114,97,109,101,16,102,114,97,109,101,
  46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,0,2,82,2,1,
  0,8,116,97,98,111,114,100,101,114,2,2,8,98,111,117,110,100,115,95,
  120,2,4,8,98,111,117,110,100,115,95,121,3,133,0,9,98,111,117,110,
  100,115,95,99,120,2,95,9,98,111,117,110,100,115,95,99,121,2,17,0,
  0,12,116,98,111,111,108,101,97,110,101,100,105,116,9,119,104,111,108,101,
  119,111,114,100,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,11,
  38,119,104,111,108,101,32,119,111,114,100,16,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,
  112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,105,116,
  101,109,102,114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,114,102,
  114,97,109,101,1,2,0,2,2,2,72,2,2,0,8,116,97,98,111,114,
  100,101,114,2,3,8,98,111,117,110,100,115,95,120,2,4,8,98,111,117,
  110,100,115,95,121,3,154,0,9,98,111,117,110,100,115,95,99,120,2,85,
  9,98,111,117,110,100,115,95,99,121,2,17,0,0,7,116,98,117,116,116,
  111,110,15,116,105,110,116,101,103,101,114,98,117,116,116,111,110,49,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,
  97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,
  46,116,102,114,97,109,101,99,111,109,112,51,15,102,97,99,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,46,116,101,109,112,
  108,97,116,101,7,13,109,97,105,110,102,111,46,99,111,110,118,101,120,8,
  116,97,98,111,114,100,101,114,2,6,8,98,111,117,110,100,115,95,120,2,
  4,8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,110,100,115,95,
  99,120,2,114,9,98,111,117,110,100,115,95,99,121,2,30,5,115,116,97,
  116,101,11,15,97,115,95,108,111,99,97,108,99,97,112,116,105,111,110,0,
  7,99,97,112,116,105,111,110,6,8,38,82,101,112,108,97,99,101,11,109,
  111,100,97,108,114,101,115,117,108,116,7,5,109,114,95,111,107,0,0,7,
  116,98,117,116,116,111,110,15,116,105,110,116,101,103,101,114,98,117,116,116,
  111,110,50,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,
  97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,15,102,97,
  99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,
  46,116,101,109,112,108,97,116,101,7,13,109,97,105,110,102,111,46,99,111,
  110,118,101,120,8,116,97,98,111,114,100,101,114,2,7,8,98,111,117,110,
  100,115,95,120,2,123,8,98,111,117,110,100,115,95,121,2,2,9,98,111,
  117,110,100,115,95,99,120,3,130,0,9,98,111,117,110,100,115,95,99,121,
  2,30,5,115,116,97,116,101,11,15,97,115,95,108,111,99,97,108,99,97,
  112,116,105,111,110,0,7,99,97,112,116,105,111,110,6,12,82,101,112,108,
  97,99,101,32,38,97,108,108,11,109,111,100,97,108,114,101,115,117,108,116,
  7,6,109,114,95,97,108,108,0,0,12,116,98,111,111,108,101,97,110,101,
  100,105,116,12,115,101,108,101,99,116,101,100,111,110,108,121,13,102,114,97,
  109,101,46,99,97,112,116,105,111,110,6,14,115,101,108,101,99,116,38,101,
  100,32,111,110,108,121,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,
  7,20,109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,
  109,101,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,
  2,0,2,2,2,82,2,2,0,8,116,97,98,111,114,100,101,114,2,4,
  8,98,111,117,110,100,115,95,120,2,4,8,98,111,117,110,100,115,95,121,
  3,175,0,9,98,111,117,110,100,115,95,99,120,2,95,9,98,111,117,110,
  100,115,95,99,121,2,17,8,115,116,97,116,102,105,108,101,7,9,115,116,
  97,116,102,105,108,101,49,0,0,12,116,98,111,111,108,101,97,110,101,100,
  105,116,15,112,114,111,109,112,116,111,110,114,101,112,108,97,99,101,13,102,
  114,97,109,101,46,99,97,112,116,105,111,110,6,18,38,112,114,111,109,112,
  116,32,111,110,32,114,101,112,108,97,99,101,16,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,
  109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,105,
  116,101,109,102,114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,114,
  102,114,97,109,101,1,2,0,2,2,2,115,2,2,0,8,116,97,98,111,
  114,100,101,114,2,5,8,98,111,117,110,100,115,95,120,2,4,8,98,111,
  117,110,100,115,95,121,3,201,0,9,98,111,117,110,100,115,95,99,120,3,
  128,0,9,98,111,117,110,100,115,95,99,121,2,17,8,115,116,97,116,102,
  105,108,101,7,9,115,116,97,116,102,105,108,101,49,5,118,97,108,117,101,
  9,0,0,7,116,98,117,116,116,111,110,5,98,117,116,111,107,17,102,114,
  97,109,101,46,104,105,100,100,101,110,101,100,103,101,115,11,10,101,100,103,
  95,98,111,116,116,111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,
  116,101,7,18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,
  112,50,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  13,102,97,99,101,46,116,101,109,112,108,97,116,101,7,13,109,97,105,110,
  102,111,46,99,111,110,118,101,120,8,116,97,98,111,114,100,101,114,2,8,
  8,98,111,117,110,100,115,95,120,3,2,1,8,98,111,117,110,100,115,95,
  121,2,2,9,98,111,117,110,100,115,95,99,120,2,70,9,98,111,117,110,
  100,115,95,99,121,2,30,7,97,110,99,104,111,114,115,11,6,97,110,95,
  116,111,112,8,97,110,95,114,105,103,104,116,0,5,115,116,97,116,101,11,
  10,97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,
  100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,97,112,116,
  105,111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,
  101,0,7,99,97,112,116,105,111,110,6,2,79,75,11,99,97,112,116,105,
  111,110,100,105,115,116,2,1,9,111,110,101,120,101,99,117,116,101,7,4,
  111,110,111,107,0,0,9,116,115,116,97,116,102,105,108,101,9,115,116,97,
  116,102,105,108,101,49,8,102,105,108,101,110,97,109,101,6,19,114,101,112,
  108,97,99,101,100,105,97,108,111,103,102,111,46,115,116,97,7,111,112,116,
  105,111,110,115,11,10,115,102,111,95,109,101,109,111,114,121,0,4,108,101,
  102,116,3,144,0,3,116,111,112,3,132,0,0,0,0)
 );

initialization
 registerobjectdata(@objdata,treplacedialogfo,'');
end.
