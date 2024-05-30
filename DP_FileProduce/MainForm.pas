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
    iPictureCount:Integer;           // ��ܹϤ��p�ƥ�
    sRecordDate,sRecordHour:String;  // ��������B��
    iDataCount:Integer;              // �������ͤ�󤺮e�����ث���
    sData: array[0..7] of String;    // �s��txt�T�w���e��
  end;

var
  MF: TMF;

implementation

{$R *.dfm}

// -�۰ʲ��X�ɮפ����e+log- //
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
      Rewrite(wText);              // Rewwrite ����󤺮e,[��󤣦s�b�|�s�W]
  end;
  Append(wText);               // Append �V�奻���l�[�奻,[��󤣦s�b�|����]
  Writeln(wText,FormatDateTime('yyyy-mm-dd hh:nn:ss',now)+' '+sMessage);     // �ĤG�ӰѼƬ� �ק�/�l�[ �����e
  CloseFile(wText);
end;

// -����log- //
{procedure TMF.WriteTxT(sMessage:String);
var
  wText:TextFile;
begin
  AssignFile(wText,ExtractFilePath(Application.Exename) + 'BackupLog.txt');
  if not FileExists(ExtractFilePath(Application.Exename) + 'BackupLog.txt') then
    Rewrite(wText);              // Rewwrite ����󤺮e,[��󤣦s�b�|�s�W]
  Append(wText);               // Append �V�奻���l�[�奻,[��󤣦s�b�|����]
  Writeln(wText,FormatDateTime('yyyy-mm-dd hh:nn:ss',now)+' '+sMessage);     // �ĤG�ӰѼƬ� �ק�/�l�[ �����e
  CloseFile(wText);
end;}

// -�Ұ�- //
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

// -����- //
procedure TMF.Button2Click(Sender: TObject);
begin
  Timer2.Enabled:=false;
  Timer1.Enabled:=false;
  // �M���w�}�Ҫ�����
  Image1.Picture.Graphic := nil;
  Button1.Enabled:=true;
  Button2.Enabled:=false;
  Button3.Enabled:=true;
end;

// -����ɮצs����|- //
procedure TMF.Button3Click(Sender: TObject);
var
  dir:String;
begin
  if not SelectDirectory('�п�ܳƥ���m','',dir) then
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

// -��l�]�w- //
procedure TMF.FormCreate(Sender: TObject);
begin
  iPictureCount:=1;
  sData[0]:='�ֳ��H����ť���ݤ]�N�S�Pı..';
  sData[1]:='�@�ਭ�~�o�{�Ů��ح�..';
  sData[2]:='�����ƴ��۰O�Ъ����..';
  sData[3]:='�֦��ҿשεL�ҿפ]�������..';
  sData[4]:='��ӬO��~�b�R�W�p��������..';
  sData[5]:='�N�Q�x�b����̭�~';
  sData[6]:='�h~�i�d�A���𳣦b~';
  sData[7]:='�藍��..';
end;

// -��ܹ�,�N��t�ιB�@��- //
procedure TMF.Timer1Timer(Sender: TObject);
begin
  case iPictureCount of
    1:
    begin
      Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'data\�u�i.jpg');
      inc(iPictureCount);
    end;
    2:
    begin
      Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'data\�u�i2.jpg');
      inc(iPictureCount);
    end;
    3:
    begin
      Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'data\�u�i3.jpg');
      inc(iPictureCount);
    end;
    4:
    begin
      Image1.Picture.LoadFromFile(ExtractFilePath(Application.Exename)+'data\�u�i4.jpg');
      iPictureCount:=1;
    end;
  end;
end;

// -�}�l�����ɮ�(txt)- //
procedure TMF.Timer2Timer(Sender: TObject);
begin
  // �P�_�C��or�C��
  if CheckBox1.State=cbChecked then
  begin
    // �P�_�P�Ѥw�@�h���L
    if sRecordDate<>FormatDateTime('yyyymmdd',now) then
    begin
      // �P�_�O�_�����whour
      if ComboBox1.Text=FormatDateTime('hh',now) then
      begin
        WriteTxT('','Start Auto Output Files on Every Day..');
        // �]�}�C�u��0~7,�ҥH���F�n�k0
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
    // �C�p�ɰ��@��,���ޭ���
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
