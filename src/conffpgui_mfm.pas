unit conffpgui_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,conffpgui;

const
 objdata: record size: integer; data: array[0..5726] of byte end =
      (size: 5727; data: (
  84,80,70,48,12,116,99,111,110,102,102,112,103,117,105,102,111,11,99,111,
  110,102,102,112,103,117,105,102,111,13,111,112,116,105,111,110,115,119,105,100,
  103,101,116,11,6,111,119,95,116,111,112,13,111,119,95,97,114,114,111,119,
  102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,117,115,17,111,119,
  95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,9,111,119,95,104,
  105,110,116,111,110,0,7,118,105,115,105,98,108,101,8,8,98,111,117,110,
  100,115,95,120,3,159,1,8,98,111,117,110,100,115,95,121,3,169,0,9,
  98,111,117,110,100,115,95,99,120,3,17,1,9,98,111,117,110,100,115,95,
  99,121,3,70,1,23,99,111,110,116,97,105,110,101,114,46,111,112,116,105,
  111,110,115,119,105,100,103,101,116,11,13,111,119,95,109,111,117,115,101,102,
  111,99,117,115,11,111,119,95,116,97,98,102,111,99,117,115,13,111,119,95,
  97,114,114,111,119,102,111,99,117,115,11,111,119,95,115,117,98,102,111,99,
  117,115,19,111,119,95,109,111,117,115,101,116,114,97,110,115,112,97,114,101,
  110,116,17,111,119,95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,
  0,26,99,111,110,116,97,105,110,101,114,46,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,27,99,111,110,116,97,105,110,101,114,
  46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  16,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,115,1,2,0,
  2,0,3,17,1,3,70,1,0,13,111,112,116,105,111,110,115,119,105,110,
  100,111,119,11,9,119,111,95,100,105,97,108,111,103,0,7,111,112,116,105,
  111,110,115,11,17,102,111,95,115,99,114,101,101,110,99,101,110,116,101,114,
  101,100,13,102,111,95,99,108,111,115,101,111,110,101,115,99,15,102,111,95,
  97,117,116,111,114,101,97,100,115,116,97,116,16,102,111,95,97,117,116,111,
  119,114,105,116,101,115,116,97,116,10,102,111,95,115,97,118,101,112,111,115,
  12,102,111,95,115,97,118,101,115,116,97,116,101,0,8,115,116,97,116,102,
  105,108,101,7,19,109,97,105,110,102,111,46,109,97,105,110,115,116,97,116,
  102,105,108,101,7,99,97,112,116,105,111,110,6,22,67,111,110,102,105,103,
  117,114,97,116,105,111,110,32,111,102,32,102,112,71,85,73,12,105,99,111,
  110,46,111,112,116,105,111,110,115,11,10,98,109,111,95,109,97,115,107,101,
  100,12,98,109,111,95,103,114,97,121,109,97,115,107,0,15,105,99,111,110,
  46,111,114,105,103,102,111,114,109,97,116,6,3,112,110,103,13,119,105,110,
  100,111,119,111,112,97,99,105,116,121,5,0,0,0,0,0,0,0,128,255,
  255,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,6,8,116,
  109,115,101,102,111,114,109,0,13,116,102,105,108,101,110,97,109,101,101,100,
  105,116,13,102,112,103,117,105,100,101,115,105,103,110,101,114,3,84,97,103,
  2,7,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,16,36,123,
  70,80,71,85,73,68,69,83,73,71,78,69,82,125,22,102,114,97,109,101,
  46,99,97,112,116,105,111,110,116,101,120,116,102,108,97,103,115,11,9,116,
  102,95,98,111,116,116,111,109,0,16,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,
  97,116,101,7,18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,
  109,112,51,19,102,114,97,109,101,46,98,117,116,116,111,110,115,46,99,111,
  117,110,116,2,1,19,102,114,97,109,101,46,98,117,116,116,111,110,115,46,
  105,116,101,109,115,14,1,17,102,114,97,109,101,46,104,105,100,100,101,110,
  101,100,103,101,115,11,10,101,100,103,95,98,111,116,116,111,109,0,16,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,
  97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,
  46,116,102,114,97,109,101,99,111,109,112,50,7,105,109,97,103,101,110,114,
  2,17,0,0,30,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,
  97,109,101,46,104,105,100,100,101,110,101,100,103,101,115,11,10,101,100,103,
  95,98,111,116,116,111,109,0,29,102,114,97,109,101,46,98,117,116,116,111,
  110,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  30,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,49,11,0,27,102,114,97,109,101,46,
  98,117,116,116,111,110,46,102,114,97,109,101,46,116,101,109,112,108,97,116,
  101,7,18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,
  50,20,102,114,97,109,101,46,98,117,116,116,111,110,46,105,109,97,103,101,
  110,114,2,17,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,
  101,1,2,0,2,18,2,0,2,0,0,4,104,105,110,116,6,22,80,97,
  116,104,32,111,102,32,102,112,71,85,73,32,68,101,115,105,103,110,101,114,
  8,98,111,117,110,100,115,95,120,2,2,8,98,111,117,110,100,115,95,121,
  2,21,9,98,111,117,110,100,115,95,99,120,3,13,1,9,98,111,117,110,
  100,115,95,99,121,2,41,7,97,110,99,104,111,114,115,11,7,97,110,95,
  108,101,102,116,6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,
  0,8,115,116,97,116,102,105,108,101,7,19,109,97,105,110,102,111,46,109,
  97,105,110,115,116,97,116,102,105,108,101,18,99,111,110,116,114,111,108,108,
  101,114,46,108,97,115,116,100,105,114,6,31,36,123,73,68,69,85,68,73,
  82,125,47,112,108,117,103,105,110,47,100,101,115,105,103,110,101,114,95,101,
  120,116,47,18,99,111,110,116,114,111,108,108,101,114,46,111,112,116,105,111,
  110,115,11,15,102,100,111,95,115,121,115,102,105,108,101,110,97,109,101,15,
  102,100,111,95,115,97,118,101,108,97,115,116,100,105,114,0,22,99,111,110,
  116,114,111,108,108,101,114,46,99,97,112,116,105,111,110,111,112,101,110,6,
  19,102,112,71,85,73,32,68,101,115,105,103,110,101,114,32,112,97,116,104,
  19,99,111,110,116,114,111,108,108,101,114,46,111,110,99,104,97,110,103,101,
  13,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,12,
  116,98,111,111,108,101,97,110,101,100,105,116,19,101,110,97,98,108,101,102,
  112,103,117,105,100,101,115,105,103,110,101,114,13,102,114,97,109,101,46,99,
  97,112,116,105,111,110,6,20,68,101,115,105,103,110,101,114,32,105,110,116,
  101,103,114,97,116,105,111,110,16,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,
  116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,102,
  114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,
  101,1,2,0,2,2,2,126,2,2,0,8,116,97,98,111,114,100,101,114,
  2,1,4,104,105,110,116,6,27,69,110,97,98,108,101,32,100,101,115,105,
  103,110,101,114,32,105,110,116,101,103,114,97,116,105,111,110,8,98,111,117,
  110,100,115,95,120,2,18,8,98,111,117,110,100,115,95,121,2,65,9,98,
  111,117,110,100,115,95,99,120,3,139,0,9,98,111,117,110,100,115,95,99,
  121,2,17,8,115,116,97,116,102,105,108,101,7,19,109,97,105,110,102,111,
  46,109,97,105,110,115,116,97,116,102,105,108,101,0,0,12,116,98,111,111,
  108,101,97,110,101,100,105,116,12,116,98,102,112,103,111,110,108,121,111,110,
  101,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,12,79,110,101,
  32,73,110,115,116,97,110,99,101,16,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,
  97,116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,
  102,114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,
  109,101,1,2,0,2,2,2,83,2,2,0,8,116,97,98,111,114,100,101,
  114,2,2,4,104,105,110,116,6,38,79,110,108,121,32,79,110,101,32,73,
  110,115,116,97,110,99,101,32,40,115,101,116,117,112,32,100,101,115,105,103,
  110,101,114,32,116,111,111,41,8,98,111,117,110,100,115,95,120,2,18,8,
  98,111,117,110,100,115,95,121,2,83,9,98,111,117,110,100,115,95,99,120,
  2,96,9,98,111,117,110,100,115,95,99,121,2,17,8,115,116,97,116,102,
  105,108,101,7,19,109,97,105,110,102,111,46,109,97,105,110,115,116,97,116,
  102,105,108,101,5,118,97,108,117,101,9,0,0,9,116,103,114,111,117,112,
  98,111,120,12,103,114,111,117,112,99,111,109,109,97,110,100,17,102,114,97,
  109,101,46,104,105,100,100,101,110,101,100,103,101,115,11,10,101,100,103,95,
  98,111,116,116,111,109,0,13,102,114,97,109,101,46,99,97,112,116,105,111,
  110,6,18,67,111,109,109,97,110,100,32,108,105,110,101,32,112,97,114,97,
  109,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,102,
  108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,
  101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,116,
  102,114,97,109,101,99,111,109,112,50,16,102,114,97,109,101,46,111,117,116,
  101,114,102,114,97,109,101,1,2,0,2,9,2,0,2,0,0,8,116,97,
  98,111,114,100,101,114,2,3,8,98,111,117,110,100,115,95,120,2,12,8,
  98,111,117,110,100,115,95,121,2,105,9,98,111,117,110,100,115,95,99,120,
  3,238,0,9,98,111,117,110,100,115,95,99,121,3,144,0,0,5,116,101,
  100,105,116,10,101,100,102,105,108,101,110,97,109,101,16,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,
  116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,116,102,114,
  97,109,101,99,111,109,112,51,8,98,111,117,110,100,115,95,120,2,124,8,
  98,111,117,110,100,115,95,121,2,25,9,98,111,117,110,100,115,95,99,120,
  2,94,9,98,111,117,110,100,115,95,99,121,2,21,8,115,116,97,116,102,
  105,108,101,7,19,109,97,105,110,102,111,46,109,97,105,110,115,116,97,116,
  102,105,108,101,4,116,101,120,116,6,11,36,123,70,73,76,69,78,65,77,
  69,125,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,
  5,116,101,100,105,116,7,101,100,99,108,111,115,101,16,102,114,97,109,101,
  46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,
  116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,116,102,114,
  97,109,101,99,111,109,112,51,8,116,97,98,111,114,100,101,114,2,1,8,
  98,111,117,110,100,115,95,120,2,124,8,98,111,117,110,100,115,95,121,2,
  47,9,98,111,117,110,100,115,95,99,120,2,94,9,98,111,117,110,100,115,
  95,99,121,2,21,8,115,116,97,116,102,105,108,101,7,19,109,97,105,110,
  102,111,46,109,97,105,110,115,116,97,116,102,105,108,101,4,116,101,120,116,
  6,8,99,108,111,115,101,97,108,108,13,114,101,102,102,111,110,116,104,101,
  105,103,104,116,2,15,0,0,5,116,101,100,105,116,6,101,100,104,105,100,
  101,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,
  17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,
  110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,8,116,97,98,111,
  114,100,101,114,2,2,8,98,111,117,110,100,115,95,120,2,124,8,98,111,
  117,110,100,115,95,121,2,91,9,98,111,117,110,100,115,95,99,120,2,94,
  9,98,111,117,110,100,115,95,99,121,2,21,8,115,116,97,116,102,105,108,
  101,7,19,109,97,105,110,102,111,46,109,97,105,110,115,116,97,116,102,105,
  108,101,4,116,101,120,116,6,6,104,105,100,101,105,116,13,114,101,102,102,
  111,110,116,104,101,105,103,104,116,2,15,0,0,5,116,101,100,105,116,6,
  101,100,115,104,111,119,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,
  7,18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,
  8,116,97,98,111,114,100,101,114,2,3,8,98,111,117,110,100,115,95,120,
  2,124,8,98,111,117,110,100,115,95,121,2,69,9,98,111,117,110,100,115,
  95,99,120,2,94,9,98,111,117,110,100,115,95,99,121,2,21,8,115,116,
  97,116,102,105,108,101,7,19,109,97,105,110,102,111,46,109,97,105,110,115,
  116,97,116,102,105,108,101,4,116,101,120,116,6,6,115,104,111,119,105,116,
  13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,5,116,
  101,100,105,116,6,101,100,113,117,105,116,16,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,
  112,108,97,116,101,7,18,109,97,105,110,102,111,46,116,102,114,97,109,101,
  99,111,109,112,51,8,116,97,98,111,114,100,101,114,2,4,8,98,111,117,
  110,100,115,95,120,2,124,8,98,111,117,110,100,115,95,121,2,113,9,98,
  111,117,110,100,115,95,99,120,2,94,9,98,111,117,110,100,115,95,99,121,
  2,21,8,115,116,97,116,102,105,108,101,7,19,109,97,105,110,102,111,46,
  109,97,105,110,115,116,97,116,102,105,108,101,4,116,101,120,116,6,4,113,
  117,105,116,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,
  0,12,116,98,111,111,108,101,97,110,101,100,105,116,10,105,102,108,111,97,
  100,102,105,108,101,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,
  12,76,111,97,100,32,70,105,108,101,32,61,62,16,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,
  101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,
  105,116,101,109,102,114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,
  114,102,114,97,109,101,1,2,0,2,2,2,80,2,2,0,8,116,97,98,
  111,114,100,101,114,2,5,8,98,111,117,110,100,115,95,120,2,12,8,98,
  111,117,110,100,115,95,121,2,25,9,98,111,117,110,100,115,95,99,120,2,
  93,9,98,111,117,110,100,115,95,99,121,2,17,5,118,97,108,117,101,9,
  0,0,12,116,98,111,111,108,101,97,110,101,100,105,116,7,105,102,99,108,
  111,115,101,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,13,67,
  108,111,115,101,32,70,105,108,101,32,61,62,16,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,
  109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,105,
  116,101,109,102,114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,114,
  102,114,97,109,101,1,2,0,2,2,2,82,2,2,0,8,116,97,98,111,
  114,100,101,114,2,6,8,98,111,117,110,100,115,95,120,2,12,8,98,111,
  117,110,100,115,95,121,2,47,9,98,111,117,110,100,115,95,99,120,2,95,
  9,98,111,117,110,100,115,95,99,121,2,17,8,115,116,97,116,102,105,108,
  101,7,19,109,97,105,110,102,111,46,109,97,105,110,115,116,97,116,102,105,
  108,101,5,118,97,108,117,101,9,0,0,12,116,98,111,111,108,101,97,110,
  101,100,105,116,6,105,102,115,104,111,119,13,102,114,97,109,101,46,99,97,
  112,116,105,111,110,6,12,83,104,111,119,32,68,101,115,105,32,61,62,16,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,
  114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,
  111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,16,102,114,97,109,
  101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,2,2,89,2,
  2,0,8,116,97,98,111,114,100,101,114,2,7,8,98,111,117,110,100,115,
  95,120,2,12,8,98,111,117,110,100,115,95,121,2,69,9,98,111,117,110,
  100,115,95,99,120,2,102,9,98,111,117,110,100,115,95,99,121,2,17,8,
  115,116,97,116,102,105,108,101,7,19,109,97,105,110,102,111,46,109,97,105,
  110,115,116,97,116,102,105,108,101,5,118,97,108,117,101,9,0,0,12,116,
  98,111,111,108,101,97,110,101,100,105,116,6,105,102,104,105,100,101,13,102,
  114,97,109,101,46,99,97,112,116,105,111,110,6,12,72,105,100,101,32,68,
  101,115,105,32,61,62,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,
  7,20,109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,
  109,101,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,
  2,0,2,2,2,83,2,2,0,8,116,97,98,111,114,100,101,114,2,8,
  8,98,111,117,110,100,115,95,120,2,12,8,98,111,117,110,100,115,95,121,
  2,91,9,98,111,117,110,100,115,95,99,120,2,96,9,98,111,117,110,100,
  115,95,99,121,2,17,8,115,116,97,116,102,105,108,101,7,19,109,97,105,
  110,102,111,46,109,97,105,110,115,116,97,116,102,105,108,101,5,118,97,108,
  117,101,9,0,0,12,116,98,111,111,108,101,97,110,101,100,105,116,6,105,
  102,113,117,105,116,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,
  12,81,117,105,116,32,68,101,115,105,32,61,62,16,102,114,97,109,101,46,
  108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,
  111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,
  101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,101,110,117,
  105,116,101,109,102,114,97,109,101,16,102,114,97,109,101,46,111,117,116,101,
  114,102,114,97,109,101,1,2,0,2,2,2,81,2,2,0,8,116,97,98,
  111,114,100,101,114,2,9,8,98,111,117,110,100,115,95,120,2,12,8,98,
  111,117,110,100,115,95,121,2,113,9,98,111,117,110,100,115,95,99,120,2,
  94,9,98,111,117,110,100,115,95,99,121,2,17,8,115,116,97,116,102,105,
  108,101,7,19,109,97,105,110,102,111,46,109,97,105,110,115,116,97,116,102,
  105,108,101,5,118,97,108,117,101,9,0,0,0,5,116,101,100,105,116,8,
  101,100,102,105,108,116,101,114,16,102,114,97,109,101,46,108,111,99,97,108,
  112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,
  116,101,7,18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,
  112,51,8,116,97,98,111,114,100,101,114,2,4,8,98,111,117,110,100,115,
  95,120,2,12,8,98,111,117,110,100,115,95,121,3,23,1,9,98,111,117,
  110,100,115,95,99,120,3,250,0,9,98,111,117,110,100,115,95,99,121,2,
  21,7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,6,97,
  110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,8,115,116,97,116,
  102,105,108,101,7,19,109,97,105,110,102,111,46,109,97,105,110,115,116,97,
  116,102,105,108,101,4,116,101,120,116,6,31,42,46,102,112,103,32,44,32,
  102,112,103,95,42,46,112,97,115,32,44,32,102,112,103,117,105,95,42,46,
  112,97,115,13,114,101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,
  0,12,116,98,111,111,108,101,97,110,101,100,105,116,8,105,102,102,105,108,
  116,101,114,13,102,114,97,109,101,46,99,97,112,116,105,111,110,6,7,70,
  105,108,116,101,114,58,16,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,
  7,20,109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,
  109,101,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,1,
  2,0,2,2,2,37,2,2,0,8,116,97,98,111,114,100,101,114,2,5,
  8,98,111,117,110,100,115,95,120,2,20,8,98,111,117,110,100,115,95,121,
  3,1,1,9,98,111,117,110,100,115,95,99,120,2,50,9,98,111,117,110,
  100,115,95,99,121,2,17,8,115,116,97,116,102,105,108,101,7,19,109,97,
  105,110,102,111,46,109,97,105,110,115,116,97,116,102,105,108,101,0,0,7,
  116,98,117,116,116,111,110,2,111,107,14,111,112,116,105,111,110,115,119,105,
  100,103,101,116,49,11,19,111,119,49,95,102,111,110,116,103,108,121,112,104,
  104,101,105,103,104,116,13,111,119,49,95,97,117,116,111,115,99,97,108,101,
  0,13,111,112,116,105,111,110,115,119,105,100,103,101,116,11,11,111,119,95,
  116,97,98,102,111,99,117,115,13,111,119,95,97,114,114,111,119,102,111,99,
  117,115,15,111,119,95,97,114,114,111,119,102,111,99,117,115,105,110,16,111,
  119,95,97,114,114,111,119,102,111,99,117,115,111,117,116,17,111,119,95,100,
  101,115,116,114,111,121,119,105,100,103,101,116,115,0,5,99,111,108,111,114,
  4,3,0,0,128,17,102,114,97,109,101,46,104,105,100,100,101,110,101,100,
  103,101,115,11,10,101,100,103,95,98,111,116,116,111,109,0,17,102,114,97,
  109,101,46,111,112,116,105,111,110,115,115,107,105,110,11,8,102,115,111,95,
  102,108,97,116,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,11,15,102,114,108,95,111,112,116,105,111,110,115,115,107,105,110,0,
  17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,
  14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,
  110,102,111,46,116,102,114,97,109,101,99,111,109,112,50,15,102,97,99,101,
  46,108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,46,116,
  101,109,112,108,97,116,101,7,19,115,111,117,114,99,101,102,111,46,116,102,
  97,99,101,99,111,109,112,49,8,116,97,98,111,114,100,101,114,2,6,8,
  98,111,117,110,100,115,95,120,3,173,0,8,98,111,117,110,100,115,95,121,
  2,2,9,98,111,117,110,100,115,95,99,120,2,92,9,98,111,117,110,100,
  115,95,99,121,2,30,7,97,110,99,104,111,114,115,11,6,97,110,95,116,
  111,112,8,97,110,95,114,105,103,104,116,0,5,115,116,97,116,101,11,10,
  97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,100,
  101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,97,112,116,105,
  111,110,13,97,115,95,108,111,99,97,108,99,111,108,111,114,0,7,99,97,
  112,116,105,111,110,6,2,79,75,11,109,111,100,97,108,114,101,115,117,108,
  116,7,5,109,114,95,111,107,13,114,101,102,102,111,110,116,104,101,105,103,
  104,116,2,15,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tconffpguifo,'');
end.
