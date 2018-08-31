unit guitemplates_mfm;
{$ifdef FPC}{$mode objfpc}{$h+}{$endif}

interface

implementation
uses
 mseclasses,guitemplates;

const
 objdata: record size: integer; data: array[0..4168] of byte end =
      (size: 4169; data: (
  84,80,70,48,15,116,103,117,105,116,101,109,112,108,97,116,101,115,109,111,
  14,103,117,105,116,101,109,112,108,97,116,101,115,109,111,9,98,111,117,110,
  100,115,95,99,120,3,227,1,9,98,111,117,110,100,115,95,99,121,3,132,
  0,8,111,110,108,111,97,100,101,100,7,9,108,111,97,100,101,100,101,120,
  101,4,108,101,102,116,2,99,3,116,111,112,3,135,0,15,109,111,100,117,
  108,101,99,108,97,115,115,110,97,109,101,6,14,116,109,115,101,100,97,116,
  97,109,111,100,117,108,101,0,9,116,102,97,99,101,99,111,109,112,14,102,
  97,100,101,118,101,114,116,107,111,110,118,101,120,23,116,101,109,112,108,97,
  116,101,46,102,97,100,101,95,112,111,115,46,99,111,117,110,116,2,2,23,
  116,101,109,112,108,97,116,101,46,102,97,100,101,95,112,111,115,46,105,116,
  101,109,115,1,2,0,2,1,0,25,116,101,109,112,108,97,116,101,46,102,
  97,100,101,95,99,111,108,111,114,46,99,111,117,110,116,2,2,25,116,101,
  109,112,108,97,116,101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,
  101,109,115,1,4,219,219,219,0,4,200,200,200,0,0,23,116,101,109,112,
  108,97,116,101,46,102,97,100,101,95,100,105,114,101,99,116,105,111,110,7,
  7,103,100,95,100,111,119,110,4,108,101,102,116,2,24,3,116,111,112,2,
  16,0,0,9,116,102,97,99,101,99,111,109,112,14,102,97,100,101,104,111,
  114,122,99,111,110,118,101,120,23,116,101,109,112,108,97,116,101,46,102,97,
  100,101,95,112,111,115,46,99,111,117,110,116,2,2,23,116,101,109,112,108,
  97,116,101,46,102,97,100,101,95,112,111,115,46,105,116,101,109,115,1,2,
  0,2,1,0,25,116,101,109,112,108,97,116,101,46,102,97,100,101,95,99,
  111,108,111,114,46,99,111,117,110,116,2,2,25,116,101,109,112,108,97,116,
  101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,4,
  219,219,219,0,4,200,200,200,0,0,4,108,101,102,116,2,24,3,116,111,
  112,2,40,0,0,9,116,102,97,99,101,99,111,109,112,15,102,97,100,101,
  104,111,114,122,99,111,110,99,97,118,101,23,116,101,109,112,108,97,116,101,
  46,102,97,100,101,95,112,111,115,46,99,111,117,110,116,2,2,23,116,101,
  109,112,108,97,116,101,46,102,97,100,101,95,112,111,115,46,105,116,101,109,
  115,1,2,0,2,1,0,25,116,101,109,112,108,97,116,101,46,102,97,100,
  101,95,99,111,108,111,114,46,99,111,117,110,116,2,2,25,116,101,109,112,
  108,97,116,101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,
  115,1,4,219,219,219,0,4,200,200,200,0,0,23,116,101,109,112,108,97,
  116,101,46,102,97,100,101,95,100,105,114,101,99,116,105,111,110,7,7,103,
  100,95,108,101,102,116,4,108,101,102,116,3,144,0,3,116,111,112,2,40,
  0,0,9,116,102,97,99,101,99,111,109,112,15,102,97,100,101,118,101,114,
  116,99,111,110,99,97,118,101,23,116,101,109,112,108,97,116,101,46,102,97,
  100,101,95,112,111,115,46,99,111,117,110,116,2,2,23,116,101,109,112,108,
  97,116,101,46,102,97,100,101,95,112,111,115,46,105,116,101,109,115,1,2,
  0,2,1,0,25,116,101,109,112,108,97,116,101,46,102,97,100,101,95,99,
  111,108,111,114,46,99,111,117,110,116,2,2,25,116,101,109,112,108,97,116,
  101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,1,4,
  219,219,219,0,4,200,200,200,0,0,23,116,101,109,112,108,97,116,101,46,
  102,97,100,101,95,100,105,114,101,99,116,105,111,110,7,5,103,100,95,117,
  112,4,108,101,102,116,3,144,0,3,116,111,112,2,16,0,0,15,116,115,
  107,105,110,99,111,110,116,114,111,108,108,101,114,4,115,107,105,110,9,101,
  120,116,101,110,100,101,114,115,2,0,18,115,98,95,104,111,114,122,95,102,
  97,99,101,98,117,116,116,111,110,7,14,102,97,100,101,118,101,114,116,107,
  111,110,118,101,120,21,115,98,95,104,111,114,122,95,102,97,99,101,101,110,
  100,98,117,116,116,111,110,7,14,102,97,100,101,118,101,114,116,107,111,110,
  118,101,120,18,115,98,95,118,101,114,116,95,102,97,99,101,98,117,116,116,
  111,110,7,14,102,97,100,101,104,111,114,122,99,111,110,118,101,120,21,115,
  98,95,118,101,114,116,95,102,97,99,101,101,110,100,98,117,116,116,111,110,
  7,14,102,97,100,101,104,111,114,122,99,111,110,118,101,120,15,115,116,101,
  112,98,117,116,116,111,110,95,102,97,99,101,7,14,102,97,100,101,104,111,
  114,122,99,111,110,118,101,120,12,119,105,100,103,101,116,95,99,111,108,111,
  114,4,3,0,0,128,14,99,111,110,116,97,105,110,101,114,95,102,97,99,
  101,7,14,102,97,100,101,104,111,114,122,99,111,110,118,101,120,17,103,114,
  105,100,95,102,105,120,114,111,119,115,95,102,97,99,101,7,14,102,97,100,
  101,118,101,114,116,107,111,110,118,101,120,11,98,117,116,116,111,110,95,102,
  97,99,101,7,14,102,97,100,101,118,101,114,116,107,111,110,118,101,120,15,
  100,97,116,97,98,117,116,116,111,110,95,102,97,99,101,7,14,102,97,100,
  101,118,101,114,116,107,111,110,118,101,120,16,102,114,97,109,101,98,117,116,
  116,111,110,95,102,97,99,101,7,14,102,97,100,101,104,111,114,122,99,111,
  110,118,101,120,16,116,97,98,98,97,114,95,104,111,114,122,95,102,97,99,
  101,7,15,102,97,100,101,118,101,114,116,99,111,110,99,97,118,101,20,116,
  97,98,98,97,114,95,104,111,114,122,95,116,97,98,95,102,97,99,101,7,
  14,102,97,100,101,118,101,114,116,107,111,110,118,101,120,19,116,97,98,98,
  97,114,95,104,111,114,122,111,112,111,95,102,97,99,101,7,15,102,97,100,
  101,118,101,114,116,99,111,110,99,97,118,101,23,116,97,98,98,97,114,95,
  104,111,114,122,111,112,111,95,116,97,98,95,102,97,99,101,7,14,102,97,
  100,101,118,101,114,116,107,111,110,118,101,120,16,116,97,98,98,97,114,95,
  118,101,114,116,95,102,97,99,101,7,15,102,97,100,101,104,111,114,122,99,
  111,110,99,97,118,101,20,116,97,98,98,97,114,95,118,101,114,116,95,116,
  97,98,95,102,97,99,101,7,14,102,97,100,101,118,101,114,116,107,111,110,
  118,101,120,19,116,97,98,98,97,114,95,118,101,114,116,111,112,111,95,102,
  97,99,101,7,15,102,97,100,101,104,111,114,122,99,111,110,99,97,118,101,
  23,116,97,98,98,97,114,95,118,101,114,116,111,112,111,95,116,97,98,95,
  102,97,99,101,7,14,102,97,100,101,118,101,114,116,107,111,110,118,101,120,
  13,109,97,105,110,109,101,110,117,95,102,97,99,101,7,15,102,97,100,101,
  118,101,114,116,99,111,110,99,97,118,101,4,108,101,102,116,2,24,3,116,
  111,112,2,72,0,0,9,116,102,97,99,101,99,111,109,112,13,102,97,100,
  101,99,111,110,116,97,105,110,101,114,23,116,101,109,112,108,97,116,101,46,
  102,97,100,101,95,112,111,115,46,99,111,117,110,116,2,2,23,116,101,109,
  112,108,97,116,101,46,102,97,100,101,95,112,111,115,46,105,116,101,109,115,
  1,2,0,2,1,0,25,116,101,109,112,108,97,116,101,46,102,97,100,101,
  95,99,111,108,111,114,46,99,111,117,110,116,2,2,25,116,101,109,112,108,
  97,116,101,46,102,97,100,101,95,99,111,108,111,114,46,105,116,101,109,115,
  1,4,5,0,0,160,4,204,204,204,0,0,4,108,101,102,116,3,144,0,
  3,116,111,112,2,72,0,0,9,116,102,97,99,101,99,111,109,112,8,110,
  117,108,108,102,97,99,101,4,108,101,102,116,3,16,1,3,116,111,112,2,
  16,0,0,14,116,115,121,115,101,110,118,109,97,110,97,103,101,114,6,115,
  121,115,101,110,118,10,104,101,108,112,104,101,97,100,101,114,6,96,77,83,
  69,105,100,101,32,67,111,112,121,114,105,103,104,116,32,49,57,57,57,45,
  50,48,49,53,32,98,121,32,77,97,114,116,105,110,32,83,99,104,114,101,
  105,98,101,114,10,85,115,97,103,101,58,32,109,115,101,105,100,101,32,91,
  79,80,84,73,79,78,93,46,46,46,32,91,80,82,79,74,69,67,84,70,
  73,76,69,93,10,10,79,112,116,105,111,110,115,58,10,104,101,108,112,102,
  111,111,116,101,114,6,218,10,69,110,118,105,114,111,110,109,101,110,116,32,
  118,97,114,105,97,98,108,101,115,10,70,80,67,68,73,82,44,32,70,80,
  67,76,73,66,68,73,82,44,32,77,83,69,68,73,82,44,32,77,83,69,
  76,73,66,68,73,82,10,83,89,78,84,65,88,68,69,70,68,73,82,44,
  32,84,69,77,80,76,65,84,69,68,73,82,44,32,67,79,77,80,83,84,
  79,82,69,68,73,82,10,67,79,77,80,73,76,69,82,44,32,68,69,66,
  85,71,71,69,82,44,32,69,88,69,69,88,84,44,84,65,82,71,69,84,
  44,84,65,82,71,69,84,79,83,68,73,82,10,99,97,110,32,98,101,32,
  117,115,101,100,32,116,111,32,111,118,101,114,114,105,100,101,32,116,104,101,
  32,115,101,116,116,105,110,103,115,32,109,97,99,114,111,115,46,10,10,72,
  97,118,101,32,97,32,108,111,116,32,111,102,32,102,117,110,33,10,10,77,
  97,114,116,105,110,4,108,101,102,116,2,24,3,116,111,112,2,96,4,100,
  101,102,115,1,1,7,9,97,107,95,112,97,114,97,114,103,6,13,45,103,
  108,111,98,115,116,97,116,102,105,108,101,1,0,11,0,6,0,6,10,60,
  102,105,108,101,112,97,116,104,62,6,31,83,101,116,32,112,97,116,104,32,
  116,111,32,103,108,111,98,97,108,32,115,116,97,116,117,115,32,102,105,108,
  101,46,6,0,6,0,0,1,7,9,97,107,95,112,97,114,97,114,103,6,
  9,45,109,97,99,114,111,100,101,102,1,0,11,0,6,0,6,31,60,110,
  97,109,101,62,44,60,118,97,108,117,101,62,123,44,60,110,97,109,101,62,
  44,60,118,97,108,117,101,62,125,6,109,77,97,99,114,111,32,100,101,102,
  105,110,105,116,105,111,110,44,32,119,105,108,108,32,98,101,32,111,118,101,
  114,114,105,100,100,101,110,32,98,121,32,39,80,114,111,106,101,99,116,39,
  45,39,79,112,116,105,111,110,115,39,45,39,77,97,99,114,111,115,39,46,
  10,32,69,120,97,109,112,108,101,58,10,32,45,45,109,97,99,114,111,100,
  101,102,61,77,65,67,49,44,97,98,99,44,77,65,67,50,44,100,101,102,
  6,0,6,0,0,1,7,6,97,107,95,112,97,114,6,18,45,115,116,111,
  114,101,103,108,111,98,97,108,109,97,99,114,111,115,1,0,11,0,6,0,
  6,0,6,63,83,116,111,114,101,32,45,45,109,97,99,114,111,100,101,102,
  32,118,97,108,117,101,115,32,97,115,32,103,108,111,98,97,108,32,109,97,
  99,114,111,115,32,97,110,100,32,116,101,114,109,105,110,97,116,101,32,77,
  83,69,105,100,101,46,32,6,0,6,0,0,1,7,9,97,107,95,112,97,
  114,97,114,103,6,11,45,109,97,99,114,111,103,114,111,117,112,1,0,11,
  0,6,0,6,3,60,110,62,6,71,85,115,101,32,39,80,114,111,106,101,
  99,116,39,45,39,79,112,116,105,111,110,115,39,45,39,77,97,99,114,111,
  115,39,45,39,65,99,116,105,118,101,32,103,114,111,117,112,39,32,110,117,
  109,98,101,114,32,60,110,62,44,10,60,110,62,32,61,32,49,46,46,54,
  46,6,0,6,0,0,1,7,6,97,107,95,112,97,114,6,2,110,112,1,
  0,11,0,6,0,6,0,6,22,68,111,32,110,111,116,32,108,111,97,100,
  32,97,32,112,114,111,106,101,99,116,46,6,0,6,0,0,1,7,6,97,
  107,95,112,97,114,6,2,110,115,1,0,11,0,6,0,6,0,6,28,68,
  111,32,110,111,116,32,117,115,101,32,97,32,115,107,105,110,44,32,110,111,
  32,102,97,100,101,115,46,6,0,6,0,0,1,7,6,97,107,95,112,97,
  114,6,5,45,104,101,108,112,1,0,11,8,97,114,102,95,104,101,108,112,
  0,6,0,6,0,6,27,68,105,115,112,108,97,121,32,116,104,105,115,32,
  104,101,108,112,32,97,110,100,32,101,120,105,116,46,6,0,6,1,32,0,
  1,7,9,97,107,95,101,110,118,118,97,114,6,6,70,80,67,68,73,82,
  1,0,11,0,6,0,6,0,6,0,6,0,6,0,0,1,7,9,97,107,
  95,101,110,118,118,97,114,6,9,70,80,67,76,73,66,68,73,82,1,0,
  11,0,6,0,6,0,6,0,6,0,6,0,0,1,7,9,97,107,95,101,
  110,118,118,97,114,6,6,77,83,69,68,73,82,1,0,11,0,6,0,6,
  0,6,0,6,0,6,0,0,1,7,9,97,107,95,101,110,118,118,97,114,
  6,9,77,83,69,76,73,66,68,73,82,1,0,11,0,6,0,6,0,6,
  0,6,0,6,0,0,1,7,9,97,107,95,101,110,118,118,97,114,6,12,
  83,89,78,84,65,88,68,69,70,68,73,82,1,0,11,0,6,0,6,0,
  6,0,6,0,6,0,0,1,7,9,97,107,95,101,110,118,118,97,114,6,
  11,84,69,77,80,76,65,84,69,68,73,82,1,0,11,0,6,0,6,0,
  6,0,6,0,6,0,0,1,7,9,97,107,95,101,110,118,118,97,114,6,
  12,67,79,77,80,83,84,79,82,69,68,73,82,1,0,11,0,6,0,6,
  0,6,0,6,0,6,0,0,1,7,9,97,107,95,101,110,118,118,97,114,
  6,8,67,79,77,80,73,76,69,82,1,0,11,0,6,0,6,0,6,0,
  6,0,6,0,0,1,7,9,97,107,95,101,110,118,118,97,114,6,8,68,
  69,66,85,71,71,69,82,1,0,11,0,6,0,6,0,6,0,6,0,6,
  0,0,1,7,9,97,107,95,101,110,118,118,97,114,6,6,69,88,69,69,
  88,84,1,0,11,0,6,0,6,0,6,0,6,0,6,0,0,1,7,9,
  97,107,95,101,110,118,118,97,114,6,6,84,65,82,71,69,84,1,0,11,
  0,6,0,6,0,6,0,6,0,6,0,0,1,7,9,97,107,95,101,110,
  118,118,97,114,6,11,84,65,82,71,69,84,79,83,68,73,82,1,0,11,
  0,6,0,6,0,6,0,6,0,6,0,0,1,7,6,97,107,95,97,114,
  103,6,0,1,0,11,0,6,0,6,0,6,0,6,0,6,0,0,1,7,
  6,97,107,95,112,97,114,6,17,45,78,79,90,79,82,68,69,82,72,65,
  78,68,76,73,78,71,1,0,11,0,6,0,6,0,6,36,68,111,32,110,
  111,116,32,116,111,117,99,104,32,90,45,111,114,100,101,114,32,111,102,32,
  116,104,101,32,119,105,110,100,111,119,115,46,6,0,6,0,0,1,7,6,
  97,107,95,112,97,114,6,16,45,78,79,82,69,83,84,65,67,75,87,73,
  78,68,79,87,1,0,11,0,6,0,6,0,6,43,68,111,32,110,111,116,
  32,117,115,101,32,116,104,101,32,78,69,84,95,82,69,83,84,65,67,75,
  95,87,73,78,68,79,87,32,112,114,111,116,111,99,111,108,46,6,0,6,
  0,0,1,7,6,97,107,95,112,97,114,6,14,45,82,69,83,84,65,67,
  75,87,73,78,68,79,87,1,0,11,0,6,0,6,0,6,36,85,115,101,
  32,116,104,101,32,78,69,84,95,82,69,83,84,65,67,75,95,87,73,78,
  68,79,87,32,112,114,111,116,111,99,111,108,46,6,0,6,0,0,1,7,
  6,97,107,95,112,97,114,6,22,45,78,79,82,69,67,79,78,70,73,71,
  85,82,69,87,77,87,73,78,68,79,87,1,0,11,0,6,0,6,0,6,
  64,68,111,32,110,111,116,32,117,115,101,32,120,114,101,99,111,110,102,105,
  103,117,114,101,119,109,119,105,110,100,111,119,40,41,32,102,111,114,32,119,
  105,110,100,111,119,32,115,116,97,99,107,105,110,103,32,111,112,101,114,97,
  116,105,111,110,46,6,0,6,0,0,1,7,6,97,107,95,112,97,114,6,
  20,45,82,69,67,79,78,70,73,71,85,82,69,87,77,87,73,78,68,79,
  87,1,0,11,0,6,0,6,0,6,57,85,115,101,32,120,114,101,99,111,
  110,102,105,103,117,114,101,119,109,119,105,110,100,111,119,40,41,32,102,111,
  114,32,119,105,110,100,111,119,32,115,116,97,99,107,105,110,103,32,111,112,
  101,114,97,116,105,111,110,46,6,0,6,0,0,1,7,6,97,107,95,112,
  97,114,6,25,45,83,84,65,67,75,77,79,68,69,66,69,76,79,87,87,
  79,82,75,65,82,79,85,78,68,1,0,11,0,6,0,6,0,6,73,78,
  101,99,101,115,115,97,114,114,121,32,102,111,114,32,119,105,110,100,111,119,
  109,97,110,97,103,101,114,115,32,119,105,116,104,32,98,117,103,103,121,32,
  120,114,101,99,111,110,102,105,103,117,114,101,119,109,119,105,110,100,111,119,
  40,41,32,104,97,110,100,108,105,110,103,46,6,0,6,0,0,1,7,6,
  97,107,95,112,97,114,6,27,45,78,79,83,84,65,67,75,77,79,68,69,
  66,69,76,79,87,87,79,82,75,65,82,79,85,78,68,1,0,11,0,6,
  0,6,0,6,14,78,111,32,119,111,114,107,97,114,111,117,110,100,46,6,
  0,6,0,0,1,7,6,97,107,95,112,97,114,6,14,45,84,79,80,76,
  69,86,69,76,82,65,73,83,69,1,0,11,0,6,0,6,0,6,161,85,
  115,101,32,116,104,101,32,116,111,112,32,108,101,118,101,108,32,102,114,97,
  109,101,32,119,105,110,100,111,119,32,105,100,32,105,110,115,116,101,97,100,
  32,111,102,32,116,104,101,32,97,112,112,108,105,99,97,116,105,111,110,32,
  99,108,105,101,110,116,32,119,105,110,100,111,119,32,105,100,10,102,111,114,
  32,119,105,110,100,111,119,32,114,97,105,115,101,32,111,112,101,114,97,116,
  105,111,110,46,32,73,109,112,108,105,101,115,32,45,45,78,79,82,69,83,
  84,65,67,75,87,73,78,68,79,87,32,97,110,100,10,32,45,45,78,79,
  82,69,67,79,78,70,73,71,85,82,69,87,77,87,73,78,68,79,87,46,
  6,0,6,0,0,0,0,0,0)
 );

initialization
 registerobjectdata(@objdata,tguitemplatesmo,'');
end.
