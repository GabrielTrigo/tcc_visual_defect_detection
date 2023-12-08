unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids, Data.DB,
  Datasnap.DBClient, Vcl.DBGrids, Datasnap.Provider, StrUtils, IdBaseComponent,
  Vcl.ExtCtrls, Winapi.ShellAPI, System.Diagnostics, System.TypInfo,
  System.IOUtils;

type
  TProcessOutput = record
    Confidence: String;
    ClassName: String;
    Status: Boolean;
  end;

  TProcessStatus = (psWaiting, psRunning, psFailed, psComplete);

  TForm5 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1file_name: TStringField;
    ClientDataSet1file_path: TStringField;
    ClientDataSet1status: TStringField;
    Button2: TButton;
    ClientDataSet1class_name: TStringField;
    ClientDataSet1confidence: TStringField;
    Button3: TButton;
    ClientDataSet1guid: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    function FormatOutputData(AFilePath: String): TProcessOutput;
    function DetectImage(AImagePath: string): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

const
  PYTHON_PATH = 'C:\Users\Gabri\AppData\Local\Programs\Python\Python310\python.exe';

implementation

{$R *.dfm}

function ProcessStatusToStr(AProcessStatus: TProcessStatus): string;
begin
  Result := GetEnumName(TypeInfo(TProcessStatus), Integer(AProcessStatus));
end;

function StrToProcessStatus(AProcessStatus: string): TProcessStatus;
begin
  Result := TProcessStatus(GetEnumValue(TypeInfo(TProcessStatus), AProcessStatus));
end;

function GetOutputImagePathFromGUID(AGUID: string): string;
begin
  Result := ExpandFileName(GetCurrentDir() + PathDelim +
      Format('..\segmented_images\%s_segmented.png', [AGUID]));
end;

function GetOutputLogPathFromGUID(AGUID: string): string;
begin
  Result := ExpandFileName(GetCurrentDir() + PathDelim +
      Format('%s.txt', [AGUID]));
end;

function GetGUIDFromFile(AFile: string): string;
begin
  Result := ExtractFileName(AFile).Split(['.'])[0]
end;

function StartProcessWithRedirectedOutput(const ACommandLine: string; const AOutputFile: string;
  AShowWindow: boolean = True; AWaitForFinish: boolean = False): Integer;
var
  CommandLine: string;
  StartupInfo: TStartupInfo;
  ProcessInformation: TProcessInformation;
  StdOutFileHandle: THandle;
begin
  Result := 0;

  StdOutFileHandle := CreateFile(PChar(AOutputFile), GENERIC_WRITE, FILE_SHARE_READ, nil, CREATE_ALWAYS,
    FILE_ATTRIBUTE_NORMAL, 0);

  Win32Check(StdOutFileHandle <> INVALID_HANDLE_VALUE);
  try
    Win32Check(SetHandleInformation(StdOutFileHandle, HANDLE_FLAG_INHERIT, 1));
    FillChar(StartupInfo, SizeOf(TStartupInfo), 0);
    FillChar(ProcessInformation, SizeOf(TProcessInformation), 0);

    StartupInfo.cb := SizeOf(TStartupInfo);
    StartupInfo.dwFlags := StartupInfo.dwFlags or STARTF_USESTDHANDLES;
    StartupInfo.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
    StartupInfo.hStdOutput := StdOutFileHandle;
    StartupInfo.hStdError := StdOutFileHandle;

    if not(AShowWindow) then
    begin
      StartupInfo.dwFlags := StartupInfo.dwFlags or STARTF_USESHOWWINDOW;
      StartupInfo.wShowWindow := SW_HIDE;
    end;

    CommandLine := ACommandLine;
    UniqueString(CommandLine);

    Win32Check(CreateProcess(nil, PChar(CommandLine), nil, nil, True,
      CREATE_NEW_PROCESS_GROUP + NORMAL_PRIORITY_CLASS, nil, nil, StartupInfo, ProcessInformation));

    try
      Result := ProcessInformation.dwProcessId;

      if AWaitForFinish then
        WaitForSingleObject(ProcessInformation.hProcess, INFINITE);

    finally
      CloseHandle(ProcessInformation.hProcess);
      CloseHandle(ProcessInformation.hThread);
    end;

  finally
    CloseHandle(StdOutFileHandle);
  end;
end;

function TForm5.DetectImage(AImagePath: string): String;
var
  lDefaultPath,
  lHomePath,
  lFileName,
  lScriptPath,
  lOutputImagePath,
  lProcessGUID: string;
begin
  Result := EmptyStr;

  lDefaultPath := GetCurrentDir();
  try
    lProcessGUID := GUIDToString(TGUID.NewGuid()).Replace('{', '').Replace('}', '');

    SetCurrentDir(ExpandFileName(lDefaultPath + PathDelim + '..\ai_python_yolov8'));

    lFileName := lDefaultPath + PathDelim + lProcessGUID + '.txt';

    lScriptPath := 'main.py';

    lOutputImagePath  := Format('..\segmented_images\%s_segmented.png', [lProcessGUID]);

    StartProcessWithRedirectedOutput(
      Format('%s %s %s %s', [PYTHON_PATH, lScriptPath, AImagePath, lOutputImagePath]),
      lFileName,
      True,
      True
    );
  finally
    SetCurrentDir(lDefaultPath);
    Result := lFileName;
  end;
end;

function TForm5.FormatOutputData(AFilePath: String): TProcessOutput;
var
  lList: TStrings;
begin
  lList := TStringList.Create;
  try
    lList.NameValueSeparator := ':';
    lList.LoadFromFile(AFilePath);

    Result.Confidence := lList.Values['confidence'].ToLower().Trim();
    Result.ClassName := lList.Values['class_name'].ToLower().Trim();

    if lList.Text.Contains('no detections') then
      Result.Status := False
    else
      Result.Status := lList.Values['status'].ToLower().Trim().Contains('true');
  finally
    FreeAndNil(lList);
  end;
end;

procedure TForm5.Button1Click(Sender: TObject);
var
  lFilePath: string;
begin
  if OpenDialog1.Execute() and (OpenDialog1.Files.Count > 0) then
  begin
    ClientDataSet1.EmptyDataSet();

    for lFilePath in OpenDialog1.Files do
    begin
      ClientDataSet1.Append();

      ClientDataSet1.FieldByName('file_name').AsString := ExtractFileName(lFilePath);
      ClientDataSet1.FieldByName('file_path').AsString := lFilePath;
      ClientDataSet1.FieldByName('status').AsString := ProcessStatusToStr(psWaiting);

      ClientDataSet1.Post();
    end;
  end;
end;

procedure TForm5.Button2Click(Sender: TObject);
var
  lOutputFilePath,
  lStatus: String;
  lProcessOutput: TProcessOutput;
begin
  ClientDataSet1.First();

  while not ClientDataSet1.Eof do
  begin
    ClientDataSet1.Edit();

    ClientDataSet1.FieldByName('status').AsString := ProcessStatusToStr(psRunning);
    Application.ProcessMessages();

    lOutputFilePath := DetectImage(
      ClientDataSet1.FieldByName('file_path').AsString
    );

    if lOutputFilePath.IsEmpty then
    begin
      ClientDataSet1.FieldByName('status').AsString := ProcessStatusToStr(psFailed);
      ClientDataSet1.Post();
      ClientDataSet1.Next();
      Application.ProcessMessages();
      Continue;
    end;

    lProcessOutput := FormatOutputData(lOutputFilePath);

    if lProcessOutput.Status then
    begin
      ClientDataSet1.FieldByName('status').AsString := ProcessStatusToStr(psComplete);
      ClientDataSet1.FieldByName('confidence').AsString := lProcessOutput.Confidence;
      ClientDataSet1.FieldByName('class_name').AsString := lProcessOutput.ClassName;
    end
    else
      ClientDataSet1.FieldByName('status').AsString := ProcessStatusToStr(psFailed);

    ClientDataSet1.FieldByName('guid').AsString := GetGUIDFromFile(lOutputFilePath);

    ClientDataSet1.Post();
    ClientDataSet1.Next();
    Application.ProcessMessages();
  end;
end;

procedure TForm5.Button3Click(Sender: TObject);
var
  lGUID, lHtml, lItemsSnippet, lOutputImagePath: string;
begin
  lHtml := TFile.ReadAllText('template_report.html');
  lItemsSnippet := EmptyStr;

  ClientDataSet1.First();

  while not ClientDataSet1.Eof do
  begin
    lGUID := ClientDataSet1.FieldByName('guid').AsString;
    lOutputImagePath := GetOutputImagePathFromGUID(lGUID);

    lItemsSnippet := lItemsSnippet +
      Format('<div class="flex gap-1 item items-center"> ' +
      '  <img src="%s"> ' +
      '  <div> ' +
      '    <p>File Name: %s</p> ' +
      '    <p>Status: %s</p> ' +
      '    <p>Confidence: %s</p> ' +
      '    <p>Class Name: %s</p> ' +
      '    <p>Original Image Path: %s</p> ' +
      '    <p>Output Image Path: %s</p> ' +
      '    <p>Log Path: %s</p> ' +
      '  </div> ' +
      '</div>',
      [
        lOutputImagePath,
        ClientDataSet1.FieldByName('file_name').AsString,
        IfThen(StrToProcessStatus(ClientDataSet1.FieldByName('status').AsString) =
          psFailed,
          '<span style="color: red">FAILED</span>',
          '<span style="color: green">COMPLETE</span>'),
        ClientDataSet1.FieldByName('confidence').AsString,
        ClientDataSet1.FieldByName('class_name').AsString,

        Format('<code>%s</code>', [ClientDataSet1.FieldByName('file_path').AsString]),
        Format('<code>%s</code>', [lOutputImagePath]),
        Format('<code>%s</code>', [GetOutputLogPathFromGUID(lGUID)])
      ]);

    ClientDataSet1.Next();
  end;

  TFile.WriteAllText('last_report.html', lHtml.Replace('{{items}}', lItemsSnippet));
//
  ShellExecute(Handle, nil, PChar('last_report.html'), nil,  nil, SW_SHOWNORMAL);
end;

procedure TForm5.Button4Click(Sender: TObject);
begin
  //
end;

procedure TForm5.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  lField: TField;
begin
  lField := Column.Field;

  if Assigned(lField) and SameText(lField.FieldName, 'status') then
    case StrToProcessStatus(lField.AsString)  of
      psWaiting: DBGrid1.Canvas.Brush.Color := clWebYellow;
      psRunning: DBGrid1.Canvas.Brush.Color := clWebCornFlowerBlue;
      psFailed: DBGrid1.Canvas.Brush.Color := clWebIndianRed;
      psComplete: DBGrid1.Canvas.Brush.Color := clWebLightGreen;
    end;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  ClientDataSet1.FileName := 'data.xml';
  //ClientDataSet1.CreateDataSet();
  ClientDataSet1.Open();

  ClientDataSet1.EmptyDataSet();
end;

end.
