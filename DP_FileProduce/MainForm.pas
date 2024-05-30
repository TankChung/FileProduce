unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,JPEG, Vcl.StdCtrls,
  Vcl.Mask,Vcl.FileCtrl;

type
  TMF = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    Image1: TImage;
    Timer1: TTimer;
    Button2: TButton;
    LabeledEdit1: TLabeledEdit;
    Button3: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Panel2: TPanel;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    { Private declarations }
    //procedure WriteTxT(sMessage:String);overload;
    procedure WriteTxT(sFilePath,sMessage:String);
  public
    { Public declarations }
    iPictureCount:Integer;           // 顯示圖片計數用
    sRecordDate,sRecordHour:String;  // 紀錄日期、時
    iDataCount:Integer;              // 紀錄產生文件內容的項目指標
    sData: array[0..7] of String;    // 存放txt固定內容用
  end;

var
  MF: TMF;

implementation

{$R *.dfm}

// -自動產出檔案之內容+log- //
procedure TMF.WriteTxT(sFilePath,sMessage:String);
var
  wText:TextFile;
begin
  if sFilePath='' then
  begin
    AssignFile(wText,ExtractFilePath(Application.Exename) + 'BackupLog.txt');
    if not FileExists(ExtractFilePath(Application.Exename) + 'BackupLog.txt') then
      Rewrite(wText);
  end else
  begin
    AssignFile(wText,sFilePath);
    if not FileExists(sFilePath) then
      Rewrite(wText);              // Rewwrite 更改文件內容,[文件不存在會新增]
  end;
  Append(wText);               // Append 向文本內追加文本,[文件不存在會報錯]
  Writeln(wText,FormatDateTime('yyyy-mm-dd hh:nn:ss',now)+' '+sMessage);     // 第二個參數為 修改/追加 的內容
  CloseFile(wText);
end;

// -紀錄log- //
{procedure TMF.WriteTxT(sMessage:String);
var
  wText:TextFile;
begin
  AssignFile(wText,ExtractFilePath(Application.Exename) + 'BackupLog.txt');
  if not FileExists(ExtractFilePath(Application.Exename) + 'BackupLog.txt') then
    Rewrite(wText);              // Rewwrite 更改文件內容,[文件不存在會新增]
  Append(wText);               // Append 向文本內追加文本,[文件不存在會報錯]
  Writeln(wText,FormatDateTime('yyyy-mm-dd hh:nn:ss',now)+' '+sMessage);     // 第二個參數為 修改/追加 的內容
  CloseFile(wText);
end;}

// -啟動- //
procedure TMF.Button1Click(Sender: TObject);
begin
  if LabeledEdit1.Text='' then
  begin
    ShowMessage('Output File Place can''t null!!');
    exit;
  end;
  if (CheckBox1.State=cbUnchecked) and (CheckBox2.State=cbUnchecked) then
  begin
    ShowMessage('Must choose Every hour or Every day!!');
    exit;
  end;

  sRecordDate:='';
  sRecordHour:='';
  iDataCount:=0;
  Timer2.Enabled:=true;
  Timer1.Enabled:=true;
  Button2.Enabled:=true;
  Button1.Enabled:=false;
  Button3.Enabled:=false;
end;

// -關閉- //
procedure TMF.Button2Click(Sender: TObject);
begin
  Timer2.Enabled:=false;
  Timer1.Enabled:=false;
  // 清掉已開啟的圖檔
  Image1.Picture.Graphic := nil;
  Button1.Enabled:=true;
  Button2.Enabled:=false;
  Button3.Enabled:=true;
end;

// -選擇檔案存放路徑- //
procedure TMF.Button3Click(Sender: TObject);
var
  dir:String;
begin
  if not SelectDirectory('請選擇備份位置','',dir) then
    abort;
  LabeledEdit1.Text	:=dir;
end;

procedure TMF.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.State=cbChecked then
  begin
    CheckBox2.State:=cbUnchecked;
    Label1.Enabled:=true;
    ComboBox1.Enabled:=true;
  end else
  begin
    Label1.Enabled:=false;
    ComboBox1.Enabled:=false;
  end;

end;

procedure TMF.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.State=cbChecked then
  begin
    CheckBox1.State:=cbUnchecked;
    Label1.Enabled:=false;
    ComboBox1.Enabled:=false;
  end;

end;

// -初始設定- //
procedure TMF.FormCreate(Sender: TObject);
begin
  iPictureCount:=1;
  sData[0]:='誰都以為不聽不看也就沒感覺..';
  sData[1]:='一轉身才發現空氣裏面..';
  sData[2]:='依舊飄散著記憶的氣味..';
  sData[3]:='誰有所謂或無所謂也不能改變..';
  sData[4]:='原來是我~在愛上妳的那瞬間..';
  sData[5]:='就被困在圍牆裡面~';
  sData[6]:='多~可悲，圍牆都在~';
  sData[7]:='對不對..';
end;

// -顯示圖,代表系統運作中- //
procedure TMF.Timer1Timer(Sender: TObject);
begin
  case iPictureCount of
    1:
    begin
      Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'data\優菈.jpg');
      inc(iPictureCount);
    end;
    2:
    begin
      Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'data\優菈2.jpg');
      inc(iPictureCount);
    end;
    3:
    begin
      Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'data\優菈3.jpg');
      inc(iPictureCount);
    end;
    4:
    begin
      Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'data\優菈4.jpg');
      iPictureCount:=1;
    end;
  end;
end;

// -開始產生檔案(txt)- //
procedure TMF.Timer2Timer(Sender: TObject);
begin
  // 判斷每天or每時
  if CheckBox1.State=cbChecked then
  begin
    // 判斷同天已作則跳過
    if sRecordDate<>FormatDateTime('yyyymmdd',now) then
    begin
      // 判斷是否為指定hour
      if ComboBox1.Text=FormatDateTime('hh',now) then
      begin
        WriteTxT('','Start Auto Output Files on Every Day..');
        // 因陣列只有0~7,所以滿了要歸0
        if iDataCount=8 then
          iDataCount:=0;
        WriteTxT(LabeledEdit1.Text+'\'+FormatDateTime('yyyymmdd_hh_',now)+'AutoFile.txt',sData[iDataCount]);
        if FileExists(LabeledEdit1.Text+'\'+FormatDateTime('yyyymmdd_hh_',now)+'AutoFile.txt') then
          WriteTxT('','Auto Output Files on Every Day is Success !!')
        else
          WriteTxT('','Auto Output Files on Every Day is Fail ..');
        inc(iDataCount);
        sRecordDate:=FormatDateTime('yyyymmdd',now);
      end;
    end;
  end else
  begin
    // 每小時做一次,不管哪天
    if sRecordHour<>FormatDateTime('hh',now) then
    begin
      WriteTxT('','Start Auto Output Files on Every Hour..');
      if iDataCount=8 then
        iDataCount:=0;
      WriteTxT(LabeledEdit1.Text+'\'+FormatDateTime('yyyymmdd_hh_',now)+'AutoFile.txt',sData[iDataCount]);
      if FileExists(LabeledEdit1.Text+'\'+FormatDateTime('yyyymmdd_hh_',now)+'AutoFile.txt') then
        WriteTxT('','Auto Output Files on Every Hour is Success !!')
      else
        WriteTxT('','Auto Output Files on Every Hour is Fail ..');
      inc(iDataCount);
      sRecordHour:=FormatDateTime('hh',now);
    end;
  end;
end;

end.
