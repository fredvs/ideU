{
    fpGUI  -  Free Pascal GUI Toolkit

    Copyright (C) 2006 - 2010 See the file AUTHORS.txt, included in this
    distribution, for details of the copyright.

    See the file COPYING.modifiedLGPL, included in this distribution,
    for details about redistributing fpGUI.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    Description:
      This descendant adds ReadOnly support and can read/write Form state
      information.
}

unit fpg_iniutils_ideu;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  IniFiles
  ;

type

  TfpgINIFile = class(TINIFile)
  private
    FReadOnly: Boolean;
  public
    constructor CreateExt(const AFileName: String = ''; AReadOnly: Boolean = False);
    function    ReadString(const ASection, AIdent, ADefault: string): string; override;
    function    ReadInteger(const ASection, AIdent: string; ADefault: longint): longint; override;
    function    ReadBool(const ASection, AIdent: string; ADefault: Boolean): Boolean; override;
    function    ReadDate(const ASection, AName: string; ADefault: TDateTime): TDateTime; override;
    function    ReadDateTime(const ASection, AName: string; ADefault: TDateTime): TDateTime; override;
    function    ReadFloat(const ASection, AName: string; ADefault: double): double; override;
    function    ReadTime(const ASection, AName: string; ADefault: TDateTime): TDateTime; override;
   
  end;

// singleton
function gINI(const AFileName: string = ''): TfpgINIFile;

implementation

var
  uINI: TfpgINIFile;

function gINI(const AFileName: string): TfpgINIFile;
begin
  if uINI = nil then
    uINI := TfpgINIFile.CreateExt(AFileName);
  Result := uINI;
end;

{ TfpgINIFile }

constructor TfpgINIFile.CreateExt(const AFileName: string; AReadOnly: Boolean);
var
  lDir: string;
  lFileName: string;
begin
  FReadOnly := AReadOnly;
  lDir      := ExtractFileDir(AFileName);
  lFileName := ExtractFileName(AFileName);

  if lDir = '' then
    lDir := GetAppConfigDir(False);
  if not (lDir[Length(lDir)] = PathDelim) then
    lDir := lDir + PathDelim;

  { We used a non-Global config dir, so should be able to create the dir }
 
 ForceDirectories(lDir) ;
 // if not ForceDirectories(lDir) then
 //   raise Exception.CreateFmt(rsErrFailedToCreateDir, [lDir]);


  if lFileName = '' then
    lFileName := ApplicationName + '.ini'
  else if ExtractFileExt(lFileName) = '' then
    lFileName := lFileName + '.ini';

  lFileName := lDir + lFileName;
  Create(lFileName);
end;

function TfpgINIFile.ReadString(const ASection, AIdent, ADefault: string): string;
begin
  Result := inherited ReadString(ASection, AIdent, ADefault);
  if (not ValueExists(ASection, AIdent)) and
    (not FReadOnly) then
    WriteString(ASection, AIdent, ADefault);
end;

function TfpgINIFile.ReadInteger(const ASection, AIdent: string; ADefault: longint): longint;
begin
  if (not ValueExists(ASection, AIdent)) and
    (not FReadOnly) then
    WriteInteger(ASection, AIdent, ADefault);
  Result := inherited ReadInteger(ASection, AIdent, ADefault);
end;

function TfpgINIFile.ReadBool(const ASection, AIdent: string; ADefault: Boolean): Boolean;
var
  lValueExists: Boolean;
begin
  lValueExists := ValueExists(ASection, AIdent);
  if (not lValueExists) and
    (not FReadOnly) then
    WriteBool(ASection, AIdent, ADefault);
  Result := inherited ReadBool(ASection, AIdent, ADefault);
end;

function TfpgINIFile.ReadDate(const ASection, AName: string; ADefault: TDateTime): TDateTime;
begin
  if (not ValueExists(ASection, AName)) and
    (not FReadOnly) then
    WriteDate(ASection, AName, ADefault);
  Result := inherited ReadDate(ASection, AName, ADefault);
end;

function TfpgINIFile.ReadDateTime(const ASection, AName: string; ADefault: TDateTime): TDateTime;
begin
  if (not ValueExists(ASection, AName)) and
    (not FReadOnly) then
    WriteDateTime(ASection, AName, ADefault);
  Result := inherited ReadDateTime(ASection, AName, ADefault);
end;

function TfpgINIFile.ReadFloat(const ASection, AName: string; ADefault: double): double;
begin
  if (not ValueExists(ASection, AName)) and
    (not FReadOnly) then
    WriteFloat(ASection, AName, ADefault);
  Result := inherited ReadFloat(ASection, AName, ADefault);
end;

function TfpgINIFile.ReadTime(const ASection, AName: string; ADefault: TDateTime): TDateTime;
begin
  if (not ValueExists(ASection, AName)) and
    (not FReadOnly) then
    WriteTime(ASection, AName, ADefault);
  Result := inherited ReadTime(ASection, AName, ADefault);
end;


initialization
  uINI := nil;

finalization
  uINI.Free;

end.

