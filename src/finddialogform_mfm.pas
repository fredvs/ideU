unit finddialogform_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,finddialogform;

const
 objdata: record size: integer; data: array[0..6595] of byte end =
      (size: 6596; data: (
  84,80,70,48,13,116,102,105,110,100,100,105,97,108,111,103,102,111,12,102,
  105,110,100,100,105,97,108,111,103,102,111,13,111,112,116,105,111,110,115,119,
  105,100,103,101,116,11,11,111,119,95,116,97,98,102,111,99,117,115,13,111,
  119,95,97,114,114,111,119,102,111,99,117,115,15,111,119,95,97,114,114,111,
  119,102,111,99,117,115,105,110,16,111,119,95,97,114,114,111,119,102,111,99,
  117,115,111,117,116,11,111,119,95,115,117,98,102,111,99,117,115,17,111,119,
  95,100,101,115,116,114,111,121,119,105,100,103,101,116,115,9,111,119,95,104,
  105,110,116,111,110,0,7,118,105,115,105,98,108,101,8,8,98,111,117,110,
  100,115,95,120,3,176,3,8,98,111,117,110,100,115,95,121,2,114,9,98,
  111,117,110,100,115,95,99,120,3,10,1,9,98,111,117,110,100,115,95,99,
  121,3,179,1,12,98,111,117,110,100,115,95,99,120,109,105,110,3,10,1,
  12,98,111,117,110,100,115,95,99,121,109,105,110,3,220,0,23,99,111,110,
  116,97,105,110,101,114,46,111,112,116,105,111,110,115,119,105,100,103,101,116,
  11,13,111,119,95,109,111,117,115,101,102,111,99,117,115,11,111,119,95,116,
  97,98,102,111,99,117,115,13,111,119,95,97,114,114,111,119,102,111,99,117,
  115,15,111,119,95,97,114,114,111,119,102,111,99,117,115,105,110,16,111,119,
  95,97,114,114,111,119,102,111,99,117,115,111,117,116,11,111,119,95,115,117,
  98,102,111,99,117,115,19,111,119,95,109,111,117,115,101,116,114,97,110,115,
  112,97,114,101,110,116,17,111,119,95,100,101,115,116,114,111,121,119,105,100,
  103,101,116,115,0,26,99,111,110,116,97,105,110,101,114,46,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,27,99,111,110,116,97,
  105,110,101,114,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,49,11,0,16,99,111,110,116,97,105,110,101,114,46,98,111,117,110,100,
  115,1,2,0,2,0,3,10,1,3,179,1,0,13,111,112,116,105,111,110,
  115,119,105,110,100,111,119,11,10,119,111,95,109,101,115,115,97,103,101,0,
  7,111,112,116,105,111,110,115,11,14,102,111,95,102,114,101,101,111,110,99,
  108,111,115,101,13,102,111,95,99,108,111,115,101,111,110,101,115,99,17,102,
  111,95,108,111,99,97,108,115,104,111,114,116,99,117,116,115,15,102,111,95,
  97,117,116,111,114,101,97,100,115,116,97,116,16,102,111,95,97,117,116,111,
  119,114,105,116,101,115,116,97,116,10,102,111,95,115,97,118,101,112,111,115,
  13,102,111,95,115,97,118,101,122,111,114,100,101,114,0,8,115,116,97,116,
  102,105,108,101,7,9,115,116,97,116,102,105,108,101,49,7,99,97,112,116,
  105,111,110,6,9,70,105,110,100,32,84,101,120,116,12,105,99,111,110,46,
  111,112,116,105,111,110,115,11,10,98,109,111,95,109,97,115,107,101,100,0,
  15,105,99,111,110,46,111,114,105,103,102,111,114,109,97,116,6,3,112,110,
  103,13,119,105,110,100,111,119,111,112,97,99,105,116,121,5,0,0,0,0,
  0,0,0,128,255,255,9,111,110,99,114,101,97,116,101,100,7,5,111,110,
  99,114,101,7,111,110,99,108,111,115,101,7,9,111,110,99,108,111,115,101,
  101,118,15,109,111,100,117,108,101,99,108,97,115,115,110,97,109,101,6,8,
  116,109,115,101,102,111,114,109,0,12,116,104,105,115,116,111,114,121,101,100,
  105,116,8,102,105,110,100,116,101,120,116,13,102,114,97,109,101,46,99,97,
  112,116,105,111,110,6,15,84,101,120,116,32,116,111,32,38,102,105,110,100,
  32,49,22,102,114,97,109,101,46,99,97,112,116,105,111,110,116,101,120,116,
  102,108,97,103,115,11,9,116,102,95,98,111,116,116,111,109,0,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,
  109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,105,110,102,111,46,
  116,102,114,97,109,101,99,111,109,112,51,29,102,114,97,109,101,46,98,117,
  116,116,111,110,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,11,0,30,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,27,102,114,97,
  109,101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,116,101,109,112,
  108,97,116,101,7,20,109,97,105,110,102,111,46,109,97,105,110,109,101,110,
  117,102,114,97,109,101,19,102,114,97,109,101,46,98,117,116,116,111,110,115,
  46,99,111,117,110,116,2,1,19,102,114,97,109,101,46,98,117,116,116,111,
  110,115,46,105,116,101,109,115,14,1,16,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,
  108,112,114,111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,
  108,97,116,101,7,20,109,97,105,110,102,111,46,109,97,105,110,109,101,110,
  117,102,114,97,109,101,0,0,16,102,114,97,109,101,46,111,117,116,101,114,
  102,114,97,109,101,1,2,0,2,18,2,0,2,0,0,8,98,111,117,110,
  100,115,95,120,2,24,8,98,111,117,110,100,115,95,121,2,56,9,98,111,
  117,110,100,115,95,99,120,3,238,0,9,98,111,117,110,100,115,95,99,121,
  2,40,7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,6,
  97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,12,111,112,116,
  105,111,110,115,101,100,105,116,49,11,17,111,101,49,95,97,117,116,111,112,
  111,112,117,112,109,101,110,117,13,111,101,49,95,115,97,118,101,118,97,108,
  117,101,13,111,101,49,95,115,97,118,101,115,116,97,116,101,0,11,111,112,
  116,105,111,110,115,101,100,105,116,11,12,111,101,95,117,110,100,111,111,110,
  101,115,99,13,111,101,95,99,108,111,115,101,113,117,101,114,121,16,111,101,
  95,99,104,101,99,107,109,114,99,97,110,99,101,108,20,111,101,95,114,101,
  115,101,116,115,101,108,101,99,116,111,110,101,120,105,116,15,111,101,95,101,
  120,105,116,111,110,99,117,114,115,111,114,13,111,101,95,97,117,116,111,115,
  101,108,101,99,116,25,111,101,95,97,117,116,111,115,101,108,101,99,116,111,
  110,102,105,114,115,116,99,108,105,99,107,0,19,100,114,111,112,100,111,119,
  110,46,99,111,108,115,46,99,111,117,110,116,2,1,19,100,114,111,112,100,
  111,119,110,46,99,111,108,115,46,105,116,101,109,115,14,1,0,0,13,114,
  101,102,102,111,110,116,104,101,105,103,104,116,2,15,0,0,9,116,108,97,
  121,111,117,116,101,114,10,116,108,97,121,111,117,116,101,114,49,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,8,116,97,98,
  111,114,100,101,114,2,1,8,98,111,117,110,100,115,95,120,3,1,1,8,
  98,111,117,110,100,115,95,121,2,88,9,98,111,117,110,100,115,95,99,120,
  2,0,9,98,111,117,110,100,115,95,99,121,2,0,7,97,110,99,104,111,
  114,115,11,6,97,110,95,116,111,112,8,97,110,95,114,105,103,104,116,0,
  12,111,112,116,105,111,110,115,115,99,97,108,101,11,11,111,115,99,95,101,
  120,112,97,110,100,120,11,111,115,99,95,115,104,114,105,110,107,120,11,111,
  115,99,95,101,120,112,97,110,100,121,11,111,115,99,95,115,104,114,105,110,
  107,121,0,13,111,112,116,105,111,110,115,108,97,121,111,117,116,11,10,108,
  97,111,95,112,108,97,99,101,120,10,108,97,111,95,97,108,105,103,110,121,
  19,108,97,111,95,115,121,110,99,109,97,120,97,117,116,111,115,105,122,101,
  0,10,97,108,105,103,110,95,103,108,117,101,7,9,119,97,109,95,115,116,
  97,114,116,13,112,108,97,99,101,95,109,105,110,100,105,115,116,2,5,13,
  112,108,97,99,101,95,109,97,120,100,105,115,116,2,5,10,112,108,97,99,
  101,95,109,111,100,101,7,7,119,97,109,95,101,110,100,0,0,7,116,98,
  117,116,116,111,110,8,116,98,117,116,116,111,110,50,17,102,114,97,109,101,
  46,104,105,100,100,101,110,101,100,103,101,115,11,10,101,100,103,95,98,111,
  116,116,111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,
  112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,
  18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,50,15,
  102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,
  99,101,46,116,101,109,112,108,97,116,101,7,13,109,97,105,110,102,111,46,
  99,111,110,118,101,120,8,116,97,98,111,114,100,101,114,2,2,8,98,111,
  117,110,100,115,95,120,2,2,8,98,111,117,110,100,115,95,121,2,2,9,
  98,111,117,110,100,115,95,99,120,2,90,9,98,111,117,110,100,115,95,99,
  121,2,30,5,115,116,97,116,101,11,10,97,115,95,100,101,102,97,117,108,
  116,15,97,115,95,108,111,99,97,108,100,101,102,97,117,108,116,15,97,115,
  95,108,111,99,97,108,99,97,112,116,105,111,110,17,97,115,95,108,111,99,
  97,108,111,110,101,120,101,99,117,116,101,0,7,99,97,112,116,105,111,110,
  6,9,70,105,110,100,32,78,101,120,116,9,111,110,101,120,101,99,117,116,
  101,7,4,111,110,111,107,0,0,17,116,98,111,111,108,101,97,110,101,100,
  105,116,114,97,100,105,111,9,98,111,111,108,102,105,110,100,49,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,
  109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,
  109,101,110,117,105,116,101,109,102,114,97,109,101,8,116,97,98,111,114,100,
  101,114,2,3,8,98,111,117,110,100,115,95,120,2,4,8,98,111,117,110,
  100,115,95,121,2,77,5,118,97,108,117,101,9,0,0,12,116,104,105,115,
  116,111,114,121,101,100,105,116,9,102,105,110,100,116,101,120,116,50,13,102,
  114,97,109,101,46,99,97,112,116,105,111,110,6,15,84,101,120,116,32,116,
  111,32,38,102,105,110,100,32,50,22,102,114,97,109,101,46,99,97,112,116,
  105,111,110,116,101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,116,
  116,111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,
  115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,
  109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,29,102,
  114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,108,111,
  99,97,108,112,114,111,112,115,11,0,30,102,114,97,109,101,46,98,117,116,
  116,111,110,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  49,11,0,27,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,
  109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,
  109,97,105,110,109,101,110,117,102,114,97,109,101,19,102,114,97,109,101,46,
  98,117,116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,109,
  101,46,98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,16,102,114,
  97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,
  109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,
  109,97,105,110,109,101,110,117,102,114,97,109,101,0,0,16,102,114,97,109,
  101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,
  0,0,8,116,97,98,111,114,100,101,114,2,4,8,98,111,117,110,100,115,
  95,120,2,24,8,98,111,117,110,100,115,95,121,2,125,9,98,111,117,110,
  100,115,95,99,120,3,238,0,9,98,111,117,110,100,115,95,99,121,2,39,
  7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,6,97,110,
  95,116,111,112,8,97,110,95,114,105,103,104,116,0,12,111,112,116,105,111,
  110,115,101,100,105,116,49,11,17,111,101,49,95,97,117,116,111,112,111,112,
  117,112,109,101,110,117,13,111,101,49,95,115,97,118,101,118,97,108,117,101,
  13,111,101,49,95,115,97,118,101,115,116,97,116,101,0,11,111,112,116,105,
  111,110,115,101,100,105,116,11,12,111,101,95,117,110,100,111,111,110,101,115,
  99,13,111,101,95,99,108,111,115,101,113,117,101,114,121,16,111,101,95,99,
  104,101,99,107,109,114,99,97,110,99,101,108,20,111,101,95,114,101,115,101,
  116,115,101,108,101,99,116,111,110,101,120,105,116,15,111,101,95,101,120,105,
  116,111,110,99,117,114,115,111,114,13,111,101,95,97,117,116,111,115,101,108,
  101,99,116,25,111,101,95,97,117,116,111,115,101,108,101,99,116,111,110,102,
  105,114,115,116,99,108,105,99,107,0,19,100,114,111,112,100,111,119,110,46,
  99,111,108,115,46,99,111,117,110,116,2,1,19,100,114,111,112,100,111,119,
  110,46,99,111,108,115,46,105,116,101,109,115,14,1,0,0,13,114,101,102,
  102,111,110,116,104,101,105,103,104,116,2,15,0,0,12,116,104,105,115,116,
  111,114,121,101,100,105,116,9,102,105,110,100,116,101,120,116,51,13,102,114,
  97,109,101,46,99,97,112,116,105,111,110,6,15,84,101,120,116,32,116,111,
  32,38,102,105,110,100,32,51,22,102,114,97,109,101,46,99,97,112,116,105,
  111,110,116,101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,116,116,
  111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,
  97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,29,102,114,
  97,109,101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,11,0,30,102,114,97,109,101,46,98,117,116,116,
  111,110,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,27,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,109,
  101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,
  97,105,110,109,101,110,117,102,114,97,109,101,19,102,114,97,109,101,46,98,
  117,116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,109,101,
  46,98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,
  101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,
  97,105,110,109,101,110,117,102,114,97,109,101,0,0,16,102,114,97,109,101,
  46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,
  0,8,116,97,98,111,114,100,101,114,2,5,8,98,111,117,110,100,115,95,
  120,2,24,8,98,111,117,110,100,115,95,121,3,186,0,9,98,111,117,110,
  100,115,95,99,120,3,238,0,9,98,111,117,110,100,115,95,99,121,2,39,
  7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,6,97,110,
  95,116,111,112,8,97,110,95,114,105,103,104,116,0,12,111,112,116,105,111,
  110,115,101,100,105,116,49,11,17,111,101,49,95,97,117,116,111,112,111,112,
  117,112,109,101,110,117,13,111,101,49,95,115,97,118,101,118,97,108,117,101,
  13,111,101,49,95,115,97,118,101,115,116,97,116,101,0,11,111,112,116,105,
  111,110,115,101,100,105,116,11,12,111,101,95,117,110,100,111,111,110,101,115,
  99,13,111,101,95,99,108,111,115,101,113,117,101,114,121,16,111,101,95,99,
  104,101,99,107,109,114,99,97,110,99,101,108,20,111,101,95,114,101,115,101,
  116,115,101,108,101,99,116,111,110,101,120,105,116,15,111,101,95,101,120,105,
  116,111,110,99,117,114,115,111,114,13,111,101,95,97,117,116,111,115,101,108,
  101,99,116,25,111,101,95,97,117,116,111,115,101,108,101,99,116,111,110,102,
  105,114,115,116,99,108,105,99,107,0,19,100,114,111,112,100,111,119,110,46,
  99,111,108,115,46,99,111,117,110,116,2,1,19,100,114,111,112,100,111,119,
  110,46,99,111,108,115,46,105,116,101,109,115,14,1,0,0,13,114,101,102,
  102,111,110,116,104,101,105,103,104,116,2,15,0,0,12,116,104,105,115,116,
  111,114,121,101,100,105,116,9,102,105,110,100,116,101,120,116,52,13,102,114,
  97,109,101,46,99,97,112,116,105,111,110,6,15,84,101,120,116,32,116,111,
  32,38,102,105,110,100,32,52,22,102,114,97,109,101,46,99,97,112,116,105,
  111,110,116,101,120,116,102,108,97,103,115,11,9,116,102,95,98,111,116,116,
  111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,
  11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,
  97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,51,29,102,114,
  97,109,101,46,98,117,116,116,111,110,46,102,114,97,109,101,46,108,111,99,
  97,108,112,114,111,112,115,11,0,30,102,114,97,109,101,46,98,117,116,116,
  111,110,46,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,
  11,0,27,102,114,97,109,101,46,98,117,116,116,111,110,46,102,114,97,109,
  101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,
  97,105,110,109,101,110,117,102,114,97,109,101,19,102,114,97,109,101,46,98,
  117,116,116,111,110,115,46,99,111,117,110,116,2,1,19,102,114,97,109,101,
  46,98,117,116,116,111,110,115,46,105,116,101,109,115,14,1,16,102,114,97,
  109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,114,97,109,
  101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,114,97,109,
  101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,111,46,109,
  97,105,110,109,101,110,117,102,114,97,109,101,0,0,16,102,114,97,109,101,
  46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,18,2,0,2,0,
  0,8,116,97,98,111,114,100,101,114,2,6,8,98,111,117,110,100,115,95,
  120,2,24,8,98,111,117,110,100,115,95,121,3,1,1,9,98,111,117,110,
  100,115,95,99,120,3,238,0,9,98,111,117,110,100,115,95,99,121,2,39,
  7,97,110,99,104,111,114,115,11,7,97,110,95,108,101,102,116,6,97,110,
  95,116,111,112,8,97,110,95,114,105,103,104,116,0,12,111,112,116,105,111,
  110,115,101,100,105,116,49,11,17,111,101,49,95,97,117,116,111,112,111,112,
  117,112,109,101,110,117,13,111,101,49,95,115,97,118,101,118,97,108,117,101,
  13,111,101,49,95,115,97,118,101,115,116,97,116,101,0,11,111,112,116,105,
  111,110,115,101,100,105,116,11,12,111,101,95,117,110,100,111,111,110,101,115,
  99,13,111,101,95,99,108,111,115,101,113,117,101,114,121,16,111,101,95,99,
  104,101,99,107,109,114,99,97,110,99,101,108,20,111,101,95,114,101,115,101,
  116,115,101,108,101,99,116,111,110,101,120,105,116,15,111,101,95,101,120,105,
  116,111,110,99,117,114,115,111,114,13,111,101,95,97,117,116,111,115,101,108,
  101,99,116,25,111,101,95,97,117,116,111,115,101,108,101,99,116,111,110,102,
  105,114,115,116,99,108,105,99,107,0,19,100,114,111,112,100,111,119,110,46,
  99,111,108,115,46,99,111,117,110,116,2,1,19,100,114,111,112,100,111,119,
  110,46,99,111,108,115,46,105,116,101,109,115,14,1,0,0,13,114,101,102,
  102,111,110,116,104,101,105,103,104,116,2,15,0,0,17,116,98,111,111,108,
  101,97,110,101,100,105,116,114,97,100,105,111,9,98,111,111,108,102,105,110,
  100,50,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,
  105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,8,116,
  97,98,111,114,100,101,114,2,7,8,98,111,117,110,100,115,95,120,2,4,
  8,98,111,117,110,100,115,95,121,3,146,0,0,0,17,116,98,111,111,108,
  101,97,110,101,100,105,116,114,97,100,105,111,9,98,111,111,108,102,105,110,
  100,51,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,
  105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,8,116,
  97,98,111,114,100,101,114,2,8,8,98,111,117,110,100,115,95,120,2,4,
  8,98,111,117,110,100,115,95,121,3,208,0,0,0,17,116,98,111,111,108,
  101,97,110,101,100,105,116,114,97,100,105,111,9,98,111,111,108,102,105,110,
  100,52,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,
  105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,8,116,
  97,98,111,114,100,101,114,2,9,8,98,111,117,110,100,115,95,120,2,4,
  8,98,111,117,110,100,115,95,121,3,20,1,0,0,7,116,98,117,116,116,
  111,110,8,116,98,117,116,116,111,110,51,17,102,114,97,109,101,46,104,105,
  100,100,101,110,101,100,103,101,115,11,10,101,100,103,95,98,111,116,116,111,
  109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,
  0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,
  0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,18,109,97,
  105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,50,15,102,97,99,
  101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,102,97,99,101,46,
  116,101,109,112,108,97,116,101,7,13,109,97,105,110,102,111,46,99,111,110,
  118,101,120,8,116,97,98,111,114,100,101,114,2,10,8,98,111,117,110,100,
  115,95,120,2,97,8,98,111,117,110,100,115,95,121,2,2,9,98,111,117,
  110,100,115,95,99,120,2,90,9,98,111,117,110,100,115,95,99,121,2,30,
  5,115,116,97,116,101,11,10,97,115,95,100,101,102,97,117,108,116,15,97,
  115,95,108,111,99,97,108,100,101,102,97,117,108,116,15,97,115,95,108,111,
  99,97,108,99,97,112,116,105,111,110,17,97,115,95,108,111,99,97,108,111,
  110,101,120,101,99,117,116,101,0,7,99,97,112,116,105,111,110,6,10,70,
  105,110,100,32,80,114,105,111,114,9,111,110,101,120,101,99,117,116,101,7,
  7,111,110,112,114,105,111,114,0,0,12,116,98,111,111,108,101,97,110,101,
  100,105,116,13,99,97,115,101,115,101,110,115,105,116,105,118,101,13,102,114,
  97,109,101,46,99,97,112,116,105,111,110,6,14,99,97,115,101,38,115,101,
  110,115,105,116,105,118,101,16,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,
  101,7,20,109,97,105,110,102,111,46,109,101,110,117,105,116,101,109,102,114,
  97,109,101,16,102,114,97,109,101,46,111,117,116,101,114,102,114,97,109,101,
  1,2,0,2,2,2,82,2,2,0,8,116,97,98,111,114,100,101,114,2,
  11,8,98,111,117,110,100,115,95,120,2,10,8,98,111,117,110,100,115,95,
  121,3,65,1,9,98,111,117,110,100,115,95,99,120,2,95,9,98,111,117,
  110,100,115,95,99,121,2,17,0,0,12,116,98,111,111,108,101,97,110,101,
  100,105,116,9,119,104,111,108,101,119,111,114,100,13,102,114,97,109,101,46,
  99,97,112,116,105,111,110,6,11,38,119,104,111,108,101,32,119,111,114,100,
  16,102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,
  102,114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,
  102,111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,16,102,114,97,
  109,101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,2,2,72,
  2,2,0,8,116,97,98,111,114,100,101,114,2,12,8,98,111,117,110,100,
  115,95,120,2,10,8,98,111,117,110,100,115,95,121,3,147,1,9,98,111,
  117,110,100,115,95,99,120,2,85,9,98,111,117,110,100,115,95,99,121,2,
  17,0,0,12,116,98,111,111,108,101,97,110,101,100,105,116,12,115,101,108,
  101,99,116,101,100,111,110,108,121,13,102,114,97,109,101,46,99,97,112,116,
  105,111,110,6,14,115,101,108,101,99,116,38,101,100,32,111,110,108,121,16,
  102,114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,11,0,17,102,
  114,97,109,101,46,108,111,99,97,108,112,114,111,112,115,49,11,0,14,102,
  114,97,109,101,46,116,101,109,112,108,97,116,101,7,20,109,97,105,110,102,
  111,46,109,101,110,117,105,116,101,109,102,114,97,109,101,16,102,114,97,109,
  101,46,111,117,116,101,114,102,114,97,109,101,1,2,0,2,2,2,82,2,
  2,0,8,116,97,98,111,114,100,101,114,2,13,8,98,111,117,110,100,115,
  95,120,2,10,8,98,111,117,110,100,115,95,121,3,105,1,9,98,111,117,
  110,100,115,95,99,120,2,95,9,98,111,117,110,100,115,95,99,121,2,17,
  8,115,116,97,116,102,105,108,101,7,9,115,116,97,116,102,105,108,101,49,
  0,0,7,116,98,117,116,116,111,110,5,98,117,116,111,107,17,102,114,97,
  109,101,46,104,105,100,100,101,110,101,100,103,101,115,11,10,101,100,103,95,
  98,111,116,116,111,109,0,16,102,114,97,109,101,46,108,111,99,97,108,112,
  114,111,112,115,11,0,17,102,114,97,109,101,46,108,111,99,97,108,112,114,
  111,112,115,49,11,0,14,102,114,97,109,101,46,116,101,109,112,108,97,116,
  101,7,18,109,97,105,110,102,111,46,116,102,114,97,109,101,99,111,109,112,
  50,15,102,97,99,101,46,108,111,99,97,108,112,114,111,112,115,11,0,13,
  102,97,99,101,46,116,101,109,112,108,97,116,101,7,13,109,97,105,110,102,
  111,46,99,111,110,118,101,120,8,116,97,98,111,114,100,101,114,2,14,8,
  98,111,117,110,100,115,95,120,3,193,0,8,98,111,117,110,100,115,95,121,
  2,2,9,98,111,117,110,100,115,95,99,120,2,70,9,98,111,117,110,100,
  115,95,99,121,2,30,7,97,110,99,104,111,114,115,11,6,97,110,95,116,
  111,112,8,97,110,95,114,105,103,104,116,0,5,115,116,97,116,101,11,10,
  97,115,95,100,101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,100,
  101,102,97,117,108,116,15,97,115,95,108,111,99,97,108,99,97,112,116,105,
  111,110,17,97,115,95,108,111,99,97,108,111,110,101,120,101,99,117,116,101,
  0,7,99,97,112,116,105,111,110,6,2,79,75,11,99,97,112,116,105,111,
  110,100,105,115,116,2,1,9,111,110,101,120,101,99,117,116,101,7,10,111,
  110,98,117,116,99,108,111,115,101,0,0,9,116,115,116,97,116,102,105,108,
  101,9,115,116,97,116,102,105,108,101,49,8,102,105,108,101,110,97,109,101,
  6,16,102,105,110,100,100,105,97,108,111,103,102,111,46,115,116,97,7,111,
  112,116,105,111,110,115,11,10,115,102,111,95,109,101,109,111,114,121,0,4,
  108,101,102,116,2,31,3,116,111,112,3,231,0,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tfinddialogfo,'');
end.
