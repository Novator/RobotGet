{******************************************************************}
{                                                                  }
{ 2003(fw) Ironsoft Lab, Perm, Russia                              }
{ http://ironsite.narod.ru                                         }
{ Written by Iron (Michael Galyuk), ironsoft@mail.ru               }
{                                                                  }
{ Код распространяется на правах лицензии GNU GPL                  }
{ При использовании кода ссылка на автора обязательна              }
{                                                                  }
{ Software distributed under the License is distributed on an      }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   }
{ implied.                                                         }
{                                                                  }
{ КОД РАСПРОСТРАНЯЕТСЯ ПО ПРИНЦИПУ "КАК ЕСТЬ", НИКАКИХ             }
{ ГАРАНТИЙ НЕ ПРЕДУСМАТРИВАЕТСЯ, ВЫ ИСПОЛЬЗУЕТЕ ЕГО НА СВОЙ РИСК.  }
{ АВТОР НЕ НЕСЕТ ОТВЕТСТВЕННОСТИ ЗА ПРИЧИНЕННЫЙ УЩЕРБ СВЯЗАННЫЙ    }
{ С ЕГО ИСПОЛЬЗОВАНИЕМ (ПРАВИЛЬНЫМ ИЛИ НЕПРАВИЛЬНЫМ).              }
{                                                                  }
{******************************************************************}

unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Psock, NMHttp, Mask, ToolEdit, ExtCtrls,
  Menus, ToolWin, ActnList, ImgList, Grids, VarFrm, CheckLst,
  ShellApi, RasApi, ComCtrls;

const
  pinCurValue  = 0;
  pinFromValue = 1;
  pinToValue = 2;
  pinStep   = 3;

type
  TVarKind = (vtNone, vtIntLim, vtStrLim, vtIntRow, vtStrRow);

  TVarior = class(TComponent)
  private
    FActive: Boolean;
    FName, FRow: string;
    FKind: TVarKind;
    FCurValue: Pointer;
    FFromValue, FToValue, FStep: Pointer;
    FMask: string;
  protected
    procedure SetKind(Value: TVarKind);
    function GetAsInteger(Index: Integer): Integer;
    procedure SetAsInteger(Index: Integer; Value: Integer);
    function GetAsString(Index: Integer): string;
    procedure SetAsString(Index: Integer; Value: string);
  public
    property Active: Boolean read FActive write FActive;
    property Name: string read FName write FName;
    property Mask: string read FMask write FMask;
    property Row: string read FRow write FRow;
    property Kind: TVarKind read FKind write FKind;
    property AsInteger[Index: Integer]: Integer read GetAsInteger
      write SetAsInteger;
    property AsString[Index: Integer]: string read GetAsString write SetAsString;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

  TProcessEvent = procedure (Url: string) of object;

  TVarList = class(TComponent)
  private
    FUrl: string;
    FOnCreate: TProcessEvent;
    FAborted: Boolean;
    FCount: Integer;
  protected
    function GetVarior(Index: Integer): TVarior;
  public
    property Aborted: Boolean read FAborted;
    property Url: string read FUrl write FUrl;
    property Variors[Index: Integer]: TVarior read GetVarior;
    property OnProcess: TProcessEvent read FOnCreate write FOnCreate;
    property Count: Integer read FCount;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function IndexOfName(Name: string): Integer;
    function SetActiveVariors(Url: string): Integer;
    function LoadVariors(TaskList: TStrings): Boolean;
    function DecodeUrl(S: string): string;
    procedure ProcessUrlHigherVar(Level: Integer);
    procedure Abort;
    function Process(Url: string): Integer;
  end;

type
  TMainForm = class(TForm)
    StatusBar: TStatusBar;
    HTTPManager: TNMHTTP;
    MainMenu: TMainMenu;
    FileItem: TMenuItem;
    ToolBar: TToolBar;
    CloseItem: TMenuItem;
    ConnectItem: TMenuItem;
    HelpItem: TMenuItem;
    AboutItem: TMenuItem;
    GetItem: TMenuItem;
    VarItem: TMenuItem;
    AddItem: TMenuItem;
    DelItem: TMenuItem;
    PopupMenu: TPopupMenu;
    FileBreaker: TMenuItem;
    OpenItem: TMenuItem;
    SaveItem: TMenuItem;
    ActionList: TActionList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    EditItem: TMenuItem;
    SaveAsItem: TMenuItem;
    AddPopupItem: TMenuItem;
    EditPopupItem: TMenuItem;
    DelPopupItem: TMenuItem;
    AddAction: TAction;
    EditAction: TAction;
    DelAction: TAction;
    AbortItem: TMenuItem;
    GetAction: TAction;
    AbortAction: TAction;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    OpenAction: TAction;
    SaveAction: TAction;
    Splitter1: TSplitter;
    AddLinkAction: TAction;
    EditLinkAction: TAction;
    DelLinkAction: TAction;
    ImageList: TImageList;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    NewItem: TMenuItem;
    Splitter2: TSplitter;
    VarGroupBox: TGroupBox;
    VarListBox: TListBox;
    LinkGroupBox: TGroupBox;
    LinkCheckListBox: TCheckListBox;
    StatGroupBox: TGroupBox;
    UrlListBox: TListBox;
    TestAction: TAction;
    ToolButton10: TToolButton;
    TestItem: TMenuItem;
    SetupAction: TAction;
    ConnectBreakItem: TMenuItem;
    SetupItem: TMenuItem;
    ToolButton11: TToolButton;
    ToolButton13: TToolButton;
    ProgressBar: TProgressBar;
    PathEdit: TEdit;
    OverwriteCheckBox: TCheckBox;
    FullPathCheckBox: TCheckBox;
    KeepExtCheckBox: TCheckBox;
    AfterLoadEdit: TEdit;
    HangUpAction: TAction;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ConnectBreakItem1: TMenuItem;
    HangUpItem: TMenuItem;
    InstrItem: TMenuItem;
    HelpBreaker: TMenuItem;
    FileBreaker2: TMenuItem;
    LanguageItem: TMenuItem;
    RussianItem: TMenuItem;
    EnglishItem: TMenuItem;
    ProtoPopupMenu: TPopupMenu;
    SaveProtoItem: TMenuItem;
    SaveProtoDialog: TSaveDialog;
    procedure CloseItemClick(Sender: TObject);
    procedure AddActionExecute(Sender: TObject);
    procedure StatusBarHint(Sender: TObject);
    procedure AbortActionExecute(Sender: TObject);
    procedure GetActionExecute(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure VarListBoxClick(Sender: TObject);
    procedure EditActionExecute(Sender: TObject);
    procedure DelActionExecute(Sender: TObject);
    procedure AddLinkActionExecute(Sender: TObject);
    procedure EditLinkActionExecute(Sender: TObject);
    procedure DelLinkActionExecute(Sender: TObject);
    procedure AboutItemClick(Sender: TObject);
    procedure SaveActionExecute(Sender: TObject);
    procedure SaveAsItemClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure OpenActionExecute(Sender: TObject);
    procedure NewItemClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LinkCheckListBoxClickCheck(Sender: TObject);
    procedure SetupActionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure HTTPManagerAuthenticationNeeded(Sender: TObject);
    procedure HTTPManagerConnectionFailed(Sender: TObject);
    procedure HTTPManagerFailure(Cmd: CmdType);
    procedure HTTPManagerInvalidHost(var Handled: Boolean);
    procedure HangUpActionExecute(Sender: TObject);
    procedure UrlListBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure InstrItemClick(Sender: TObject);
    procedure EnglishItemClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SaveProtoItemClick(Sender: TObject);
  private
    VarList: TVarList;
    ProcessMode: Integer;
  public
    procedure ShowMes(S: string);
    function DestPath: string;
    procedure ProcessUrl(Url: string);
    procedure SetNotSaved;
    procedure InitProgress(AMin, AMax: Integer);
    procedure FinishProgress;
    function UrlToFileName(Url: string): string;
    procedure ProtoMes(S: string);
    procedure RelocateControls;
    procedure UpdateFilename;
  end;

var
  MainForm: TMainForm;

implementation

uses LinkFrm, SetupFrm;

{$R *.DFM}

const
  piFileName     = 0;
  piModify       = 1;
  piProgress     = 2;
  piMessages     = 3;

constructor TVarior.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FKind := vtNone;
end;

destructor TVarior.Destroy;
begin
  SetKind(vtNone);
  inherited Destroy;
end;

procedure TVarior.SetKind(Value: TVarKind);
var
  P: PString;
begin
  if FKind<>Value then
  begin
    case FKind of
      vtIntLim:
        begin
          FreeMem(FCurValue);
          FreeMem(FFromValue);
          FreeMem(FToValue);
          FreeMem(FStep);
        end;
      vtStrLim:
        begin
          Dispose(FCurValue);
          Dispose(FFromValue);
          Dispose(FToValue);
          Dispose(FStep);
        end;
      vtIntRow:
        begin
          FreeMem(FCurValue);
        end;
      vtStrRow:
        begin
          Dispose(FCurValue);
        end;
    end;
    FKind := Value;
    case FKind of
      vtIntLim:
        begin
          GetMem(FCurValue, SizeOf(Integer));
          GetMem(FFromValue, SizeOf(Integer));
          GetMem(FToValue, SizeOf(Integer));
          GetMem(FStep, SizeOf(Integer));
        end;
      vtStrLim:
        begin
          New(P);
          FCurValue := P;
          New(P);
          FFromValue := P;
          New(P);
          FToValue := P;
          New(P);
          FStep := P;
        end;
      vtIntRow:
        begin
          GetMem(FCurValue, SizeOf(Integer));
        end;
      vtStrRow:
        begin
          New(P);
          FCurValue := P;
        end;
    end;
  end;
end;

function TVarior.GetAsInteger(Index: Integer): Integer;
begin
  case FKind of
    vtIntLim, vtIntRow:
      begin
        if (FKind=vtIntRow) and (Index<>pinCurValue) then
          Result := 0
        else begin
          case Index of
            pinCurValue : Result := PInteger(FCurValue)^;
            pinFromValue: Result := PInteger(FFromValue)^;
            pinToValue: Result := PInteger(FToValue)^;
            pinStep  : Result := PInteger(FStep)^;
          end;
        end;
      end;
    vtStrLim, vtStrRow:
      begin
        if (FKind=vtStrRow) and (Index<>pinCurValue) then
          Result := 0
        else begin
          try
            case Index of
              pinCurValue:
                Result := StrToInt(PString(FCurValue)^);
              pinFromValue:
                Result := StrToInt(PString(FFromValue)^);
              pinToValue:
                Result := StrToInt(PString(FToValue)^);
              pinStep:
                Result := StrToInt(PString(FStep)^);
            end;
          except
            Result := 0;
          end;
        end;
      end;
  end;
end;

procedure TVarior.SetAsInteger(Index: Integer; Value: Integer);
begin
  case FKind of
    vtIntLim, vtIntRow:
      if (FKind<>vtIntRow) or (Index=pinCurValue) then
      begin
        case Index of
          pinCurValue : PInteger(FCurValue)^  := Value;
          pinFromValue: PInteger(FFromValue)^ := Value;
          pinToValue: PInteger(FToValue)^ := Value;
          pinStep  : PInteger(FStep)^   := Value;
        end;
      end;
    vtStrLim, vtStrRow:
      if (FKind<>vtStrRow) or (Index=pinCurValue) then
      begin
        case Index of
          pinCurValue : PString(FCurValue)^  := IntToStr(Value);
          pinFromValue: PString(FFromValue)^ := IntToStr(Value);
          pinToValue: PString(FToValue)^ := IntToStr(Value);
          pinStep  : PString(FStep)^   := IntToStr(Value);
        end;
      end;
  end;
end;

function TVarior.GetAsString(Index: Integer): string;
begin
  case FKind of
    vtIntLim, vtIntRow:
      begin
        if (FKind=vtIntRow) and (Index<>pinCurValue) then
          Result := ''
        else
          case Index of
            pinCurValue : Result := IntToStr(PInteger(FCurValue)^);
            pinFromValue: Result := IntToStr(PInteger(FFromValue)^);
            pinToValue: Result := IntToStr(PInteger(FToValue)^);
            pinStep  : Result := IntToStr(PInteger(FStep)^);
          end;
      end;
    vtStrLim, vtStrRow:
      begin
        if (FKind=vtStrRow) and (Index<>pinCurValue) then
          Result := ''
        else
          case Index of
            pinCurValue : Result := PString(FCurValue)^;
            pinFromValue: Result := PString(FFromValue)^;
            pinToValue: Result := PString(FToValue)^;
            pinStep  : Result := PString(FStep)^;
          end;
      end;
  end;
end;

procedure TVarior.SetAsString(Index: Integer; Value: string);
begin
  case FKind of
    vtIntLim, vtIntRow:
      if (FKind<>vtIntRow) or (Index=pinCurValue) then
      begin
        case Index of
          pinCurValue : PInteger(FCurValue)^  := StrToInt(Value);
          pinFromValue: PInteger(FFromValue)^ := StrToInt(Value);
          pinToValue: PInteger(FToValue)^ := StrToInt(Value);
          pinStep  : PInteger(FStep)^   := StrToInt(Value);
        end;
      end;
    vtStrLim, vtStrRow:
      if (FKind<>vtStrRow) or (Index=pinCurValue) then
      begin
        case Index of
          pinCurValue : PString(FCurValue)^  := Value;
          pinFromValue: PString(FFromValue)^ := Value;
          pinToValue: PString(FToValue)^ := Value;
          pinStep  : PString(FStep)^   := Value;
        end;
      end;
  end;
end;

constructor TVarList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TVarList.Destroy;
begin
  inherited Destroy;
end;

function TVarList.GetVarior(Index: Integer): TVarior;
begin
  Result := TVarior(Components[Index]);
end;

const
  MaxLang = 1;
  NumOfLangStr = 84;
  LangStrings: array[0..MaxLang, 0..NumOfLangStr] of PChar =
    (('&Добавить', '&Изменить', '&Удалить', '&Скачать', '&Прервать', '&Открыть...',
      '&Сохранить',
      '&Проверить', '&Настройки', '&Разорвать', '&Файл', '&Выход', '&Закачка',
      '&Помощь', '&О программе', '&Список', '&Сохранить как...', '&Новый',
      'Вариации', 'Ссылки', 'Статистика', '&Инструкция',
      'OK', 'Отмена', '&Прокси-сервер', '&Порт', '&Каталог для закачанных файлов',
      '&Генерация имени файла', 'По&лный путь в имени файла', '&Оставлять расширение',
      '&Затирать предыдущие файлы',
      '&Действие после закачки', 'Настройки', 'Отсутствует', 'Разорвать соединение',
      'Вариация', 'Область', 'Тип', 'Формат', '&использовать',
      '&от', '&до', '&шаг', '&ряд (через запятую)', '&Имя',
      'Ссылка', '&Маска', '&Вариация', 'Вст&авить',
      'Задания на скачивание (*.dnl)|*.dnl|Все файлы (*.*)|*.*',
      'Загрузка параметров', 'Не задан символ |',
      'Нет используемых вариаций', 'Анализ ссылок',
      'Разрыв соединения', 'Не удалось разорвать соединение',
      'Процесс', 'Каталог для файлов не существует', 'Путь не существует',
      'Пролистано ссылок', 'Проверка прервана пользователем',
      'Проверка завершена', 'Скачено ссылок',
      'Скачивание прервано пользователем', 'Скачивание завершено',
      'Нет вариаций', 'Удалить вариацию?', 'Удаление', 'Удалить ссылку?',
      'Не удалось создать', 'Сохранение', 'Не удалось открыть', 'Открытие',
      'Сохранить изменения?', 'Файл перезаписан: ', 'Файл существует, пропущен: ',
      'Выгружен: ', 'Не удается загрузить в', 'изм', '&число'#13#10'&символ',
      '&лимиты'#13#10'р&яд', 'Текстовые файлы (*.txt)|*.txt|Все файлы (*.*)|*.*',
      '&Сохранить протокол...', 'Протокол сохранен в', 'Ошибка сохранения'
      ),
     ('&Add', '&Edit', '&Delete', '&Get', '&Abort', '&Open...', '&Save',
      '&Test', '&Setup', '&Hang up', '&File', '&Close', '&Download',
      '&Help', '&About', '&List', '&Save As...', '&New',
      'Variables', 'Links', 'Statistics', '&Instruction',
      'OK', 'Cancel', '&Proxy server', 'Por&t', '&Directory for download',
      '&Filename generation', 'Full file&name (with path)',
      '&Keep extention', '&Overwrite exist', 'Do &after download',
      'Setup', 'None', 'Hang up',
      'Variable', 'Range', 'Kind', 'Format', '&Use format',
      'Fr&om', '&To', '&Step', '&Row', '&Name',
      'Link', '&Mask', '&Variables', '&Insert',
      'Download tasks (*.dnl)|*.dnl|All files (*.*)|*.*',
      'Recognize variables', 'No symbol |',
      'No used variables', 'Analyse of links',
      'Hang up', 'Cannot disconnect',
      'Process', 'Directory for download does not exist', 'Path does not exist',
      'Processed links', 'Check is interrupted by user',
      'Check completed', 'Downloaded links', 'Download is interrupted by user',
      'Download completed', 'No variables', 'Delete the variable?', 'Removing',
      'Delete the link?', 'Cannot create', 'Saving',
      'Cannot open', 'Opening', 'Save change?', 'File is rewritten: ',
      'File exists, is missed: ', 'Downloaded: ', 'Cannot load in', 'mod',
      'in&teger'#13#10'&char', 'li&mits'#13#10'ro&w',
      'Text files (*.txt)|*.txt|All files (*.*)|*.*', '&Save protocol...',
      'Proto is saved to', 'Error on saving'
     ));
  Lang: Integer = 0;

function TVarList.LoadVariors(TaskList: TStrings): Boolean;
var
  I, K, J: Integer;
  S: string;
  V: TVarior;
begin
  Result := False;
  DestroyComponents;
  FAborted := False;
  for I := 0 to TaskList.Count-1 do
  begin
    S := TaskList.Strings[I];
    K := Pos('|', S);
    if K>0 then
    begin
      V := TVarior.Create(Self);
      with V do
      begin
        Name := Copy(S, 1, K-1);
        Delete(S, 1, K);
        K := Pos(':', S);
        if K>2 then
        begin
          if UpCase(S[2])='R' then
          begin
            if S[1]='1' then
              SetKind(vtStrRow)
            else
              SetKind(vtIntRow);
          end
          else begin
            if S[1]='1' then
              SetKind(vtStrLim)
            else
              SetKind(vtIntLim);
          end;
          Delete(S, 1, K);

          Mask := '';
          K := Pos('|#', S);
          if K>0 then
          begin
            J := K+2;
            if S[J] = '!' then
            begin
              Inc(J);
              Mask := Copy(S, J, Length(S)-J+1);
            end;
            Delete(S, K, Length(S)-K+1);
          end;

          if (Kind=vtIntLim) or (Kind=vtStrLim) then
          begin
            K := Pos(',', S);
            if K>0 then
            begin
              AsString[pinFromValue] := Copy(S, 1, K-1);
              Delete(S, 1, K);
              K := Pos(',', S);
              if K>0 then
              begin
                AsString[pinToValue] := Copy(S, 1, K-1);
                Delete(S, 1, K);
                AsString[pinStep] := S;
              end;
            end;
          end
          else
            Row := S;
        end;
      end;
    end
    else
      MessageBox(Application.Handle,
        LangStrings[Lang, 51], LangStrings[Lang, 50], MB_OK + MB_ICONERROR);
  end;
  Result := ComponentCount>0;
end;

const
  LimSym1 = '[';
  LimSym2 = ']';

function TVarList.IndexOfName(Name: string): Integer;
var
  I: Integer;
begin
  I := 0;
  while (I<ComponentCount) and (UpperCase(Name)<>UpperCase(Variors[I].Name)) do
    Inc(I);
  if I<ComponentCount then
    Result := I
  else
    Result := -1;
end;

function TVarList.SetActiveVariors(Url: string): Integer;
var
  I: Integer;
  S: string;
begin
  Result := 0;
  for I := 0 to ComponentCount-1 do
  begin
    Variors[I].Active := Pos(LimSym1 + Variors[I].Name + LimSym2, Url)>0;
    if Variors[I].Active then
      Inc(Result);
  end;
end;

function DecodeMask(V, M: string): string;
var
  L1, L2: Integer;
begin
  Result := V;
  L1 := Length(Result);
  L2 := Length(M);
  if L1<L2 then
    Result := Copy(M, 1, L2-L1) + Result;
end;

function TVarList.DecodeUrl(S: string): string;
var
  I, J: Integer;
begin
  Result := '';
  I := Pos(LimSym1, S);
  while I>0 do
  begin
    Result := Result + Copy(S, 1, I-1);
    Delete(S, 1, I);
    I := Pos(LimSym2, S);
    if I>0 then
    begin
      J := IndexOfName(Copy(S, 1, I-1));
      if J>=0 then
        Result := Result +
          DecodeMask(Variors[J].AsString[pinCurValue], Variors[J].Mask);
      Delete(S, 1, I);
      I := Pos(LimSym1, S);
    end;
  end;
  Result := Result + S;
end;

function NextChar(var C: Char; Max: Char; Step: Byte): Boolean;
var
  I: Integer;
begin
  if C<Max then
  begin
    I := Ord(C)+Step;
    if I>Ord(Max) then
      C := Max
    else
      C := Chr(I);
    Result := True;
  end
  else
    Result := False;
end;

procedure TVarList.ProcessUrlHigherVar(Level: Integer);
var
  I, K: Integer;
  S, S1, S2: string;
begin
  if not FAborted then
  begin
    while (Level<ComponentCount) and not Variors[Level].Active do
      Inc(Level);
    if Level<ComponentCount then
    begin
      with Variors[Level] do
        case Kind of
          vtIntLim:
            begin
              I := AsInteger[pinFromValue];
              while not FAborted
                and ((AsInteger[pinStep]>=0) and (I<=AsInteger[pinToValue])
                 or (AsInteger[pinStep]<0) and (I>=AsInteger[pinToValue])) do
              begin
                AsInteger[pinCurValue] := I;
                ProcessUrlHigherVar(Level+1);
                I := I+AsInteger[pinStep]
              end;
            end;
          vtStrLim:
            begin
              S1 := AsString[pinFromValue];
              if Length(S1)=0 then
                S1 := 'A';
              S2 := AsString[pinToValue];
              if Length(S2)=0 then
                S2 := 'Z';
              try
                I := AsInteger[pinStep];
                if I<=0 then
                  I := 1;
              except
                I := 1;
              end;
              S := S1;
              K := 1;
              while not FAborted and (S<=S2) and (K<=Length(S2)) do
              begin
                AsString[pinCurValue] := S;
                ProcessUrlHigherVar(Level+1);
                if not NextChar(S[K], S2[K], I) then
                begin
                  Inc(K);
                  if K<=Length(S1) then
                  begin
                    if Length(S)<K then
                      S := S+S1[K]
                  end
                  else
                    while Length(S)<K do
                      S := S+'A';
                end;
              end;
            end;
          vtIntRow, vtStrRow:
            begin
              S := Row;
              I := Pos(',', S);
              while not FAborted and (I>0) do
              begin
                AsString[pinCurValue] := Copy(S, 1, I-1);
                ProcessUrlHigherVar(Level+1);
                Delete(S, 1, I);
                I := Pos(',', S);
                if (I=0) and (Length(S)>0) then
                  I := Length(S)+1;
              end;
            end;
          else
            MessageBox(0, 'Not registred variable type', 'Process Url',
              MB_OK + MB_ICONERROR);
        end;
    end
    else begin
      OnProcess(DecodeUrl(FUrl));
      Inc(FCount);
    end;
  end;
end;

procedure TVarList.Abort;
begin
  FAborted := True;
end;

function TVarList.Process(Url: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  if (Length(Url)>0) and Assigned(OnProcess) then
  begin
    if SetActiveVariors(Url)>0 then
    begin
      FCount := 0;
      Result := 0;
      FUrl := Url;
      FAborted := False;
      ProcessUrlHigherVar(0);
    end
    else
      MessageBox(Application.Handle, LangStrings[Lang, 52],
        LangStrings[Lang, 53], MB_OK+MB_ICONWARNING);
  end;
end;

procedure TMainForm.StatusBarHint(Sender: TObject);
var
  S: string;
begin
  S := GetLongHint(Application.Hint);
  with StatusBar do
  begin
    SimplePanel := Length(S)>0;
    if SimplePanel then
      SimpleText := S;
  end;
end;

procedure TMainForm.ShowMes(S: string);
begin
  StatusBar.Panels[piMessages].Text := S;
end;

function TMainForm.DestPath: string;
const
  KeyNum = 1;
  PathKeys: array[0..KeyNum] of string = ('%App%', '%MyDoc%');
var
  K, I: Integer;
  S, S2: string;
  hReg: HKEY;
  BufSize: Longint;
  Buf: array[0..127] of Char;
  rType: Longint;
begin
  Result := PathEdit.Text;
  for K := 0 to KeyNum do
  begin
    I := Pos(PathKeys[K], Result);
    if I>0 then
    begin
      S := '';
      case K of
        0:
          S := ExtractFilePath(Application.ExeName);
        1:
          if RegOpenKeyEx(HKEY_CURRENT_USER,
            'SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders',
            0, KEY_READ, hReg) = ERROR_SUCCESS then
          begin
            BufSize := SizeOf(Buf);
            if RegQueryValueEx(hReg, 'Personal', nil, @rType, @Buf,
              @BufSize) = ERROR_SUCCESS
            then
              S := StrPas(Buf);
            RegCloseKey(hReg);
          end;
      end;
      S2 := Copy(Result, I+Length(PathKeys[K]), Length(Result)-I);
      rType := Length(S);
      if (rType>0) and (S[rType]='\') and (Length(S2)>0) and (S2[1]='\') then
        Delete(S2, 1, 1);
      Result := Copy(Result, 1, I-1) + S + S2;
    end;
  end;
  I := Length(Result);
  if (I>0) and (Result[I]<>'\') then
    Result := Result + '\';
end;

procedure TMainForm.ProtoMes(S: string);
begin
  UrlListBox.Items.Add(S);
end;

procedure TMainForm.HangUpActionExecute(Sender: TObject);
var
  Ras: packed array[0..20] of RASCONN;
  Size, Number, Res: DWord;
  PRasConn: HRASCONN;
  I: Integer;
begin
  Ras[0].dwSize := SizeOf(RASCONN);
  Size := SizeOf(Ras);
  Res := RasEnumConnections(@Ras, Size, Number);
  if (Res=0) and (Number>0) then
  begin
    for I := 0 to Number-1 do
    begin
      PRasConn := Ras[I].HRasConn;
      Res := RasHangUp(PRasConn);
      if Res<>0 then
        MessageBox(Application.Handle, PChar(LangStrings[Lang, 55]+' ['+
          Ras[I].szEntryName+']'), LangStrings[Lang, 54], MB_OK+MB_ICONWARNING)
    end;
  end;
  HangUpAction.Enabled := False;
end;

var
  FullCount: Integer = 0;
  LoadCount: Integer = 0;
  DestinationPath: string = '';

procedure TMainForm.GetActionExecute(Sender: TObject);
var
  I: Integer;
  Code: Integer;
begin
  StatusBar.SimplePanel := False;
  with VarList do
  begin
    TestAction.Enabled := False;
    GetAction.Enabled := False;
    AbortAction.Enabled := True;
    if LoadVariors(VarListBox.Items) then
    begin
      HangUpAction.Enabled := True;
      UrlListBox.Items.Clear;
      DestinationPath := DestPath;
      if (Sender as TComponent).Name = TestAction.Name then
        ProcessMode := 1
      else begin
        ProcessMode := -1;
        Code := GetFileAttributes(PChar(DestinationPath));
        if (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0) then
        begin
          ProcessMode := 0;
          FullCount := 0;
          I := 0;
          with LinkCheckListBox do
            while (I<Items.Count) and not Aborted do
            begin
              if Checked[I] then
                Process(Items.Strings[I]);
              Inc(I);
            end;
          ProcessMode := 2;
          InitProgress(0, FullCount);
        end
        else begin
          ShowMes(LangStrings[Lang, 57]);
          MessageBox(Handle, PChar(LangStrings[Lang, 58]+' ['+DestinationPath+']'),
            LangStrings[Lang, 56], MB_OK or MB_ICONWARNING);
        end;
      end;
      if ProcessMode>=0 then
      begin
        FullCount := 0;
        LoadCount := 0;
        I := 0;
        with LinkCheckListBox do
          while (I<Items.Count) and not Aborted do
          begin
            if Checked[I] then
              Process(Items.Strings[I]);
            Inc(I);
          end;
        if ProcessMode=2 then
          FinishProgress;
        ProtoMes(LangStrings[Lang, 59]+': '+IntToStr(FullCount));
        if ProcessMode=1 then
        begin
          if Aborted then
            ShowMes(LangStrings[Lang, 60])
          else
            ShowMes(LangStrings[Lang, 61]);
        end
        else begin
          ProtoMes(LangStrings[Lang, 62]+': '+IntToStr(LoadCount));
          if Aborted then
            ShowMes(LangStrings[Lang, 63])
          else begin
            ShowMes(LangStrings[Lang, 64]);
            if AfterLoadEdit.Text='1' then
              HangUpActionExecute(nil);
          end;
        end
      end;
    end
    else
      MessageBox(Handle, LangStrings[Lang, 65],
        LangStrings[Lang, 56], MB_OK or MB_ICONWARNING);
    AbortAction.Enabled := False;
    GetAction.Enabled := True;
    TestAction.Enabled := True;
  end;
end;

procedure TMainForm.AbortActionExecute(Sender: TObject);
begin
  VarList.Abort;
  try
    HTTPManager.Abort;
  except
  end;
  AbortAction.Enabled := False;
  TestAction.Enabled := True;
  GetAction.Enabled := True;
end;

(*procedure TMainForm.SetupItemClick(Sender: TObject);
var
  x,y,L,T: Integer;
  S: string;
begin
  with Image.Picture.Bitmap do
  begin
    PixelFormat := pf8bit;
    Width := 100*(50+60+1);
    Height := 100*(60+30+1);
    for x := -60 to 30 do
      for y := -50 to 60 do
      begin
        S := 'Bits\x='+IntToStr(x)+'00&y='+IntToStr(y)+'00&sc=3213.bmp';
        StatusBar.Panels[2].Text := S;
        StatusBar.Repaint;
        try
          BitImage.Picture.LoadFromFile(S);
          MessageBox(Handle, PChar('Считан '+S), 'Отчет',
            MB_OK);
        except
          MessageBox(Handle, PChar('Не удалось считать '+S), 'Ошибка чтения',
            MB_OK+MB_ICONERROR);
        end;
        L := (y+50)*100;
        T := (30-x)*100;
        Canvas.Draw(L, T, BitImage.Picture.Bitmap);
      end;
    StatusBar.Panels[2].Text := 'Образ сформирован';
    S := 'fullmap.bmp';
    StatusBar.Panels[2].Text := 'Сохраняю в файл ['+S+']...';
    try
      SaveToFile(S);
    except
      MessageBox(Handle, PChar('Не удалось спасти '+S), 'Ошибка записи',
        MB_OK+MB_ICONERROR);
    end;
    StatusBar.Panels[2].Text := 'Ок';
  end;
end; *)

procedure TMainForm.FormCreate(Sender: TObject);
const
  Border = 2;
var
  I, L: Integer;
begin
  VarList := TVarList.Create(Self);
  VarList.OnProcess := ProcessUrl;
  OpenDialog.Filter := SaveDialog.Filter;
  with ProgressBar do
  begin
    Parent := StatusBar;
    L := Border;
    I := 0;
    for I := 0 to piProgress-1 do
      L := L + StatusBar.Panels[I].Width;
    SetBounds(L, Border, Width, StatusBar.Height - Border);
  end;
end;

procedure TMainForm.InitProgress(AMin, AMax: Integer);
const
  Border=2;
begin
  with ProgressBar do
  begin
    StatusBar.Panels[piProgress].Width := Width+2;
    Position := Min;
    Min := AMin;
    Max := AMax;
    Position := AMin;
    Show;
  end;
end;

procedure TMainForm.FinishProgress;
begin
  ProgressBar.Hide;
  StatusBar.Panels[piProgress].Width := 0;
end;

function IniFileName: string;
begin
  Result := ChangeFileExt(Application.ExeName, '.ini');
end;

function BoolToChar(Value: Boolean): Char;
begin
  if Value then
    Result := '1'
  else
    Result := '0';
end;

procedure TMainForm.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := NewSize>30;
end;

procedure TMainForm.CloseItemClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.AddActionExecute(Sender: TObject);
var
  S: string;
  I, J, K: Integer;
begin
  if LinkCheckListBox.Focused then
    AddLinkActionExecute(Sender)
  else begin
    Application.CreateForm(TVarForm, VarForm);
    with VarForm do
    begin
      OkBitBtn             .Caption         := LangStrings[Lang, 22];
      CancelBitBtn         .Caption         := LangStrings[Lang, 23];
      Caption                               := LangStrings[Lang, 35];
      RangeRadioGroup      .Caption         := LangStrings[Lang, 36];
      KindRadioGroup       .Caption         := LangStrings[Lang, 37];
      FormatGroupBox       .Caption         := LangStrings[Lang, 38];
      FormatCheckBox       .Caption         := LangStrings[Lang, 39];
      FromLabel            .Caption         := LangStrings[Lang, 40];
      ToLabel              .Caption         := LangStrings[Lang, 41];
      StepLabel            .Caption         := LangStrings[Lang, 42];
      RowLabel             .Caption         := LangStrings[Lang, 43];
      NameLabel            .Caption         := LangStrings[Lang, 44];
      KindRadioGroup.Items.Text             := LangStrings[Lang, 79];
      RangeRadioGroup.Items.Text            := LangStrings[Lang, 80];
      if Sender=nil then
      begin
        if VarListBox.ItemIndex>=0 then
        begin
          S := VarListBox.Items.Strings[VarListBox.ItemIndex];
          I := Pos('|', S);
          if I>0 then
          begin
            NameComboBox.Text := Copy(S, 1, I-1);
            Delete(S, 1, I);
            I := Pos(':', S);
            if I>0 then
            begin
              K := Ord(S[1])-48;
              if K<KindRadioGroup.Items.Count then
                KindRadioGroup.ItemIndex := K;
              if S[2]='r' then
                RangeRadioGroup.ItemIndex := 1;
              Delete(S, 1, I);

              I := Pos('|#', S);
              if I>0 then
              begin
                J := I+2;
                if S[J] = '!' then
                begin
                  FormatCheckBox.Checked := True;
                  Inc(J);
                end;
                MaskComboBox.Text := Copy(S, J, Length(S)-J+1);
                Delete(S, I, Length(S)-I+1);
              end;
              case RangeRadioGroup.ItemIndex of
                0:
                  begin
                    I := Pos(',', S);
                    if I>0 then
                    begin
                      FromEdit.Text := Copy(S, 1, I-1);
                      Delete(S, 1, I);
                      I := Pos(',', S);
                      if I>0 then
                      begin
                        ToEdit.Text := Copy(S, 1, I-1);
                        Delete(S, 1, I);
                        StepEdit.Text := S;
                      end;
                    end;
                  end;
                1:
                  RowEdit.Text := S;
              end;
            end;
          end;
        end
        else
          Sender := Self;
      end;
      if ShowModal=mrOk then
      begin
        S := NameComboBox.Text+'|'+IntToStr(KindRadioGroup.ItemIndex);
        case RangeRadioGroup.ItemIndex of
          0:
            S := S+'f:'+FromEdit.Text+','+ToEdit.Text+','+StepEdit.Text;
          1:
            S := S+'r:'+RowEdit.Text;
        end;
        if Length(MaskComboBox.Text)>0 then
        begin
          S := S+'|#';
          if FormatCheckBox.Checked then
            S := S+'!';
          S := S + MaskComboBox.Text;
        end;
        if Sender=nil then
          VarListBox.Items.Strings[VarListBox.ItemIndex] := S
        else
          VarListBox.Items.Add(S);
        SetNotSaved;
      end;
      Free;
    end;
  end;
end;

procedure TMainForm.EditActionExecute(Sender: TObject);
begin
  if LinkCheckListBox.Focused then
    EditLinkActionExecute(Sender)
  else
    AddActionExecute(nil);
end;

procedure TMainForm.DelActionExecute(Sender: TObject);
begin
  if LinkCheckListBox.Focused then
    DelLinkActionExecute(Sender)
  else begin
    if MessageBox(Handle,
      LangStrings[Lang, 66], LangStrings[Lang, 67],
      MB_YESNOCANCEL+MB_ICONWARNING)=ID_YES then
    begin
      VarListBox.Items.Delete(VarListBox.ItemIndex);
      VarListBoxClick(nil);
      SetNotSaved;
    end;
  end;
end;

procedure TMainForm.VarListBoxClick(Sender: TObject);
begin
  EditAction.Enabled := not LinkCheckListBox.Focused
    and (VarListBox.ItemIndex>=0)
    and (VarListBox.Items.Count>0)
    or LinkCheckListBox.Focused
    and (LinkCheckListBox.ItemIndex>=0)
    and (LinkCheckListBox.Items.Count>0);
  DelAction.Enabled := EditAction.Enabled;
end;

procedure TMainForm.AddLinkActionExecute(Sender: TObject);
var
  I: Integer;
  S: string;
  C: Boolean;
begin
  Application.CreateForm(TLinkForm, LinkForm);
  with LinkForm do
  begin
    OkBitBtn             .Caption         := LangStrings[Lang, 22];
    CancelBitBtn         .Caption         := LangStrings[Lang, 23];
    Caption                               := LangStrings[Lang, 45];

    MaskLabel   .Caption         := LangStrings[Lang, 46];
    VarLabel    .Caption         := LangStrings[Lang, 47];
    InsBitBtn   .Caption         := LangStrings[Lang, 48];

    C := True;
    if Sender=nil then
    begin
      with LinkCheckListBox do
        if ItemIndex>=0 then
        begin
          MaskComboBox.Text := Items.Strings[ItemIndex];
          C := Checked[ItemIndex];
        end
        else
          Sender := Self;
    end;
    with VarListBox.Items do
      for I := 0 to Count-1 do
      begin
        S := Strings[I];
        S := Copy(S, 1, Pos('|', S)-1);
        if Length(S)>0 then
          VarComboBox.Items.Add(S);
      end;
    if ShowModal=mrOk then
    begin
      with LinkCheckListBox do
      begin
        if Sender=nil then
          Items.Strings[LinkCheckListBox.ItemIndex] := MaskComboBox.Text
        else
          Items.Add(MaskComboBox.Text);
        if ItemIndex>=0 then
          Checked[ItemIndex] := C;
      end;
      SetNotSaved;
    end;
    Free;
  end;
end;

procedure TMainForm.EditLinkActionExecute(Sender: TObject);
begin
  AddLinkActionExecute(nil);
end;

procedure TMainForm.DelLinkActionExecute(Sender: TObject);
begin
  if MessageBox(Handle,
    LangStrings[Lang, 68], LangStrings[Lang, 67],
    MB_YESNOCANCEL+MB_ICONWARNING)=ID_YES then
  begin
    LinkCheckListBox.Items.Delete(LinkCheckListBox.ItemIndex);
    VarListBoxClick(nil);
    SetNotSaved;
  end;
end;

procedure TMainForm.LinkCheckListBoxClickCheck(Sender: TObject);
begin
  SetNotSaved;
end;

const
  CopyrStr: array[0..108] of Char =
    #169' Ironsoft Lab, 2003'#0#10#174' Programmed by Michael Galyuk'#0
    +'Russia, Perm, ironsoft@mail.ru'#10'http://ironsite.narod.ru'#0;
  AboutCount: Byte = 0;

procedure TMainForm.AboutItemClick(Sender: TObject);
begin
  Inc(AboutCount);       
  if AboutCount>3 then
  begin
    CopyrStr[20] := #13;
    AboutCount := 0;
  end
  else
    CopyrStr[20] := #0;
  ShellAbout(Handle, PChar(Caption), CopyrStr,
    Application.Icon.Handle);
end;

procedure TMainForm.SetNotSaved;
begin
  StatusBar.Panels[piModify].Text := LangStrings[Lang, 78];
  SaveAction.Enabled := True;
  FormActivate(nil);
end;

const
  NonameFN: string = 'NONAME.DNL';

procedure TMainForm.UpdateFilename;
begin
  StatusBar.Panels[piFileName].Text := ExtractFileName(SaveDialog.FileName);
  SaveProtoDialog.FileName := ChangeFileExt(StatusBar.Panels[piFileName].Text, '.txt');
  StatusBar.Panels[piModify].Text := '';
  SaveAction.Enabled := False;
end;

procedure TMainForm.SaveAsItemClick(Sender: TObject);
var
  F: TextFile;
  S: string;
  I: Integer;
begin
  if (Sender=nil) and (Length(SaveDialog.FileName)>0)
    and (UpperCase(SaveDialog.FileName)<>NonameFN)
    or SaveDialog.Execute then
  begin
    AssignFile(F, SaveDialog.FileName);
    {$I-} Rewrite(F); {$I+}
    if IOResult=0 then
    begin
      WriteLn(F, '[Variors]');
      with VarListBox.Items do
      begin
        for I := 0 to Count-1 do
        begin
          S := Strings[I];
          WriteLn(F, S);
        end;
      end;
      WriteLn(F, '[Links]');
      with LinkCheckListBox.Items do
      begin
        for I := 0 to Count-1
         do
        begin
          S := '';
          if LinkCheckListBox.Checked[I] then
            S := S+'*';
          S := S+Strings[I];
          WriteLn(F, S);
        end;
      end;
      CloseFile(F);
      UpdateFilename;
    end
    else
      MessageBox(Handle, PChar(LangStrings[Lang, 69]+' ['+SaveDialog.FileName+']'),
        LangStrings[Lang, 70], MB_OK+MB_ICONWARNING);
  end;
end;

procedure TMainForm.SaveActionExecute(Sender: TObject);
begin
  SaveAsItemClick(nil);
end;

procedure TMainForm.NewItemClick(Sender: TObject);
var
  CanClose: Boolean;
begin
  CanClose := True;
  FormCloseQuery(Sender, CanClose);
  if CanClose then
  begin
    VarListBox.Items.Clear;
    LinkCheckListBox.Items.Clear;
    if Sender=nil then
      SaveDialog.FileName := ''
    else
      SaveDialog.FileName := 'noname.dnl';
    UpdateFilename;
    ShowMes('');
  end;
end;

procedure TMainForm.FormActivate(Sender: TObject);
begin
  TestAction.Enabled := LinkCheckListBox.Items.Count>0;
  GetAction.Enabled := TestAction.Enabled;
end;

procedure TMainForm.OpenActionExecute(Sender: TObject);
var
  F: TextFile;
  S: string;
  M: Integer;
begin
  if OpenDialog.Execute then
  begin
    AssignFile(F, OpenDialog.FileName);
    {$I-} Reset(F); {$I+}
    if IOResult=0 then
    begin
      NewItemClick(nil);
      if not SaveAction.Enabled then
      begin
        M := 0;
        while not Eof(F) do
        begin
          ReadLn(F, S);
          if S='[Variors]' then
            M := 1
          else
            if S='[Links]' then
              M := 2
            else begin
              if Length(S)>0 then
                case M of
                  1:
                    VarListBox.Items.Add(S);
                  2:
                    begin
                      if S[1]='*' then
                      begin
                        LinkCheckListBox.Items.Add(Copy(S, 2, Length(S)-1));
                        LinkCheckListBox.Checked[LinkCheckListBox.Items.Count-1] := True;
                      end
                      else
                        LinkCheckListBox.Items.Add(S);
                    end;
              end;
            end;
        end;
        SaveDialog.FileName := OpenDialog.FileName;
        UpdateFilename;
        FormActivate(nil);
      end;
      CloseFile(F);
    end
    else
      MessageBox(Handle, PChar(LangStrings[Lang, 71]+
        ' ['+OpenDialog.FileName+']'), LangStrings[Lang, 72],
        MB_OK+MB_ICONWARNING);
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  A: dWord;
begin
  CanClose := True;
  if SaveAction.Enabled
    and ((VarListBox.Items.Count>0)
    or (LinkCheckListBox.Items.Count>0)) then
  begin
    A := MessageBox(Handle, LangStrings[Lang, 73], LangStrings[Lang, 70],
      MB_YESNOCANCEL+MB_ICONWARNING);
    if A=ID_CANCEL then
      CanClose := False
    else begin
      if A=ID_YES then
      begin
        SaveActionExecute(nil);
        CanClose := not SaveAction.Enabled;
      end;
    end;
  end;
end;

function TMainForm.UrlToFileName(Url: string): string;
var
  I, L: Integer;
  S: string;
begin
  Result := '';
  if UpperCase(Copy(Url, 1, 7))='HTTP://' then
    Delete(Url, 1, 7);
  if UpperCase(Copy(Url, 1, 4))='WWW.' then
    Delete(Url, 1, 4);

  if not FullPathCheckBox.Checked then
  begin
    L := Length(Url);
    I := L;
    while (I>0) and not (Url[I] in ['/', ':']) do
      Dec(I);
    if (I>0) and (Url[I] in ['/', ':']) then
      Delete(Url, 1, I);
  end;

  S := '';
  if KeepExtCheckBox.Checked then
  begin
    L := Length(Url);
    I := L;
    while (I>0)
      and not (Url[I] in ['?', '/', '\', ':', '.', '&', '=', '-'])
    do
      Dec(I);
    if (I>0) and (Url[I]='.') then
    begin
      S := Copy(Url, I, L-I+1);
      Delete(Url, I, L-I+1);
    end;
  end;

  L := Length(Url);
  for I := 1 to L do
    if not (Url[I] in ['?', '/', '\', ':', '.', '&']) then
      Result := Result + Url[I]
    else begin
      if (Length(Result)>0) and (Result[Length(Result)]<>'_') then
        Result := Result + '_';
    end;
  Result := Result + S;
end;

procedure TMainForm.ProcessUrl(Url: string);
var
  P: Boolean;
  S: string;
begin
  Inc(FullCount);
  if ProcessMode>0 then
  begin
    ProtoMes(Url);
    if ProcessMode=2 then
    begin
      with HTTPManager do
      begin
        try
          Body := DestinationPath + UrlToFileName(Url);
          ShowMes(Url+'...');
          Application.ProcessMessages;
          if FileExists(Body) then
          begin
            P := OverwriteCheckBox.Checked;
            if P then
              S := LangStrings[Lang, 74]
            else
              S := LangStrings[Lang, 75];
          end
          else begin
            P := True;
            S := LangStrings[Lang, 76];
          end;
          if P then
          begin
            Get(Url);
            Inc(LoadCount);
          end;
          ProtoMes(S+Body);
          ProgressBar.Position := FullCount;
          Application.ProcessMessages;
        except
          ProtoMes('('+IntToStr(ReplyNumber)+') '
            +LangStrings[Lang, 77]+' '+Body);
          {AbortActionExecute(nil);}
        end;
      end;
    end;
  end;
end;

procedure TMainForm.SetupActionExecute(Sender: TObject);
begin
  Application.CreateForm(TSetupForm, SetupForm);
  with SetupForm do
  begin
    Caption                               := LangStrings[Lang, 32];
    OkBitBtn             .Caption         := LangStrings[Lang, 22];
    CancelBitBtn         .Caption         := LangStrings[Lang, 23];
    ProxyLabel           .Caption         := LangStrings[Lang, 24];
    PortLabel            .Caption         := LangStrings[Lang, 25];
    PathLabel            .Caption         := LangStrings[Lang, 26];
    FileNameGroupBox     .Caption         := LangStrings[Lang, 27];
    FullPathCheckBox     .Caption         := LangStrings[Lang, 28];
    KeepExtCheckBox      .Caption         := LangStrings[Lang, 29];
    OverwriteCheckBox    .Caption         := LangStrings[Lang, 30];
    AfterLoadLabel       .Caption         := LangStrings[Lang, 31];
    AfterLoadComboBox.Items.Clear;
    AfterLoadComboBox.Items.Add(LangStrings[Lang, 33]);
    AfterLoadComboBox.Items.Add(LangStrings[Lang, 34]);
    with HTTPManager do
    begin
      ProxyEdit.Text := Proxy;
      if (Length(Proxy)>0) or (ProxyPort<>0) then
        PortEdit.Text := IntToStr(ProxyPort);
      PathComboBox.Text := PathEdit.Text;
      OverwriteCheckBox.Checked := Self.OverwriteCheckBox.Checked;
      FullPathCheckBox.Checked := Self.FullPathCheckBox.Checked;
      KeepExtCheckBox.Checked := Self.KeepExtCheckBox.Checked;
      if AfterLoadEdit.Text='1' then
        AfterLoadComboBox.ItemIndex := 1
      else
        AfterLoadComboBox.ItemIndex := 0;
      if ShowModal = mrOk then
      begin
        Proxy := ProxyEdit.Text;
        if Length(PortEdit.Text)>0 then
          ProxyPort := StrToInt(PortEdit.Text)
        else
          ProxyPort := 0;
        PathEdit.Text := PathComboBox.Text;
        Self.OverwriteCheckBox.Checked := OverwriteCheckBox.Checked;
        Self.FullPathCheckBox.Checked := FullPathCheckBox.Checked;
        Self.KeepExtCheckBox.Checked := KeepExtCheckBox.Checked;
        AfterLoadEdit.Text := IntToStr(AfterLoadComboBox.ItemIndex);
      end;
    end;
    Free;
  end;
end;

procedure TMainForm.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
const
  HeightTail = 130;
begin
  if NewHeight - (VarGroupBox.Height + StatGroupBox.Height) < HeightTail then
    NewHeight := HeightTail + VarGroupBox.Height + StatGroupBox.Height;
end;

var
  HttpErrStr: PChar = 'Http error: ';

procedure TMainForm.HTTPManagerAuthenticationNeeded(Sender: TObject);
begin
  ProtoMes(HttpErrStr+'AuthenticationNeeded');
end;

procedure TMainForm.HTTPManagerConnectionFailed(Sender: TObject);
begin
  ProtoMes(HttpErrStr+'ConnectionFailed');
end;

procedure TMainForm.HTTPManagerFailure(Cmd: CmdType);
begin
  ProtoMes(HttpErrStr+'Failure');
end;

procedure TMainForm.HTTPManagerInvalidHost(var Handled: Boolean);
begin
  ProtoMes(HttpErrStr+'InvalidHost');
end;

var
  Buf: array[0..511] of Char;

procedure TMainForm.UrlListBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  with UrlListBox do
    if (ssDouble in Shift) and (Button = mbLeft)
      and (ItemIndex>=0) and (Items.Count>0) then
    begin
      StrPLCopy(Buf, Items.Strings[ItemIndex], SizeOf(Buf));
      if (UpperCase(Copy(Buf, 1, 4))='HTTP')
        or (UpperCase(Copy(Buf, 1, 3))='WWW')
      then
        ShellExecute(Application.Handle, nil, @Buf, nil, nil,
          SW_SHOWNORMAL);
    end;
end;

procedure TMainForm.InstrItemClick(Sender: TObject);
var
  Buf: array[0..255] of Char;
begin
  if Lang=0 then
    Buf := 'Rus'
  else
    Buf := 'Eng';
  StrPLCopy(Buf, ExtractFilePath(Application.ExeName)+'\ReadMe'
    +Buf+'.txt', SizeOf(Buf));
  Screen.Cursor := crHourGlass;
  ShellExecute(Application.Handle, nil, @Buf, nil, nil,
    SW_SHOWNORMAL);
  Screen.Cursor := crDefault;
end;

procedure TMainForm.RelocateControls;
begin
  AddAction.Caption         := LangStrings[Lang, 0];
  EditAction.Caption        := LangStrings[Lang, 1];
  DelAction.Caption         := LangStrings[Lang, 2];
  GetAction.Caption         := LangStrings[Lang, 3];
  AbortAction.Caption       := LangStrings[Lang, 4];
  OpenAction.Caption        := LangStrings[Lang, 5];
  SaveAction.Caption        := LangStrings[Lang, 6];
  TestAction.Caption        := LangStrings[Lang, 7];
  SetupAction.Caption       := LangStrings[Lang, 8];
  HangUpAction.Caption      := LangStrings[Lang, 9];
  FileItem.Caption          := LangStrings[Lang, 10];
  CloseItem.Caption         := LangStrings[Lang, 11];
  ConnectItem.Caption       := LangStrings[Lang, 12];
  HelpItem.Caption          := LangStrings[Lang, 13];
  AboutItem.Caption         := LangStrings[Lang, 14];
  VarItem.Caption           := LangStrings[Lang, 15];
  SaveAsItem.Caption        := LangStrings[Lang, 16];
  NewItem.Caption           := LangStrings[Lang, 17];
  VarGroupBox.Caption       := LangStrings[Lang, 18];
  LinkGroupBox.Caption      := LangStrings[Lang, 19];
  StatGroupBox.Caption      := LangStrings[Lang, 20];
  InstrItem.Caption         := LangStrings[Lang, 21];
  SaveDialog.Filter         := LangStrings[Lang, 49];
  SaveProtoDialog.Filter    := LangStrings[Lang, 81];
  SaveProtoItem.Caption     := LangStrings[Lang, 82];
  OpenDialog.Filter := SaveDialog.Filter;
end;

procedure TMainForm.EnglishItemClick(Sender: TObject);
begin
  if (Sender<>nil) and not (Sender as TMenuItem).Checked then
  begin
    (Sender as TMenuItem).Checked := True;
    if Sender = EnglishItem then
      Lang := 1
    else
      Lang := 0;
  end;
  RelocateControls;
end;

procedure TMainForm.FormShow(Sender: TObject);
var
  F: TextFile;
  I: Integer;
  S: string;
begin
  AssignFile(F, IniFileName);
  {$I-} Reset(F); {$I+}
  I := IOResult;
  if I=0 then
  begin
    while not Eof(F) and (I<=7) do
    begin
      ReadLn(F, S);
      case I of
        0:
          HTTPManager.Proxy := S;
        1:
          try
            HTTPManager.ProxyPort := StrToInt(S);
          except
            HTTPManager.ProxyPort := 0;
          end;
        2:
          PathEdit.Text := S;
        3:
          OverwriteCheckBox.Checked := (Length(S)>0) and (S[1]='1');
        4:
          FullPathCheckBox.Checked := (Length(S)>0) and (S[1]='1');
        5:
          KeepExtCheckBox.Checked := (Length(S)>0) and (S[1]='1');
        6:
          AfterLoadEdit.Text := S;
        7:
          try
            Lang := StrToInt(S);
            if (0>Lang) or (Lang>MaxLang) then
              Lang := 0;
          except
            Lang := 0;
          end;
      end;
      Inc(I);
    end;
    CloseFile(F);
  end;
  case Lang of
    1: EnglishItemClick(EnglishItem);
  end;
  NewItemClick(Sender);
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  F: TextFile;
begin
  VarList.Free;
  AssignFile(F, IniFileName);
  {$I-} Rewrite(F); {$I+}
  if IOResult=0 then
  begin
    WriteLn(F, HTTPManager.Proxy);
    WriteLn(F, IntToStr(HTTPManager.ProxyPort));
    WriteLn(F, PathEdit.Text);
    WriteLn(F, BoolToChar(OverwriteCheckBox.Checked));
    WriteLn(F, BoolToChar(FullPathCheckBox.Checked));
    WriteLn(F, BoolToChar(KeepExtCheckBox.Checked));
    WriteLn(F, AfterLoadEdit.Text);
    WriteLn(F, IntToStr(Lang));
    CloseFile(F);
  end;
end;

procedure TMainForm.SaveProtoItemClick(Sender: TObject);
begin
  if SaveProtoDialog.Execute then
    try
      UrlListBox.Items.SaveToFile(SaveProtoDialog.FileName);
      ShowMes(LangStrings[Lang, 83]+' '+SaveProtoDialog.FileName);
    except
      ShowMes(LangStrings[Lang, 84]+' '+SaveProtoDialog.FileName);
      MessageBox(Application.Handle,
        PChar(LangStrings[Lang, 84]+' '+SaveProtoDialog.FileName),
        LangStrings[Lang, 70], MB_OK or MB_ICONERROR);
    end;
end;

end.
