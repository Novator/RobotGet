{******************************************************************}
{                                                                  }
{ 2003(fw) Ironsoft Lab, Perm, Russia                              }
{ http://ironsite.narod.ru                                         }
{ Written by Iron (Michael Galyuk), ironsoft@mail.ru               }
{                                                                  }
{ Êîä ðàñïðîñòðàíÿåòñÿ íà ïðàâàõ ëèöåíçèè GNU GPL                  }
{ Ïðè èñïîëüçîâàíèè êîäà ññûëêà íà àâòîðà îáÿçàòåëüíà              }
{                                                                  }
{ Software distributed under the License is distributed on an      }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   }
{ implied.                                                         }
{                                                                  }
{ ÊÎÄ ÐÀÑÏÐÎÑÒÐÀÍßÅÒÑß ÏÎ ÏÐÈÍÖÈÏÓ "ÊÀÊ ÅÑÒÜ", ÍÈÊÀÊÈÕ             }
{ ÃÀÐÀÍÒÈÉ ÍÅ ÏÐÅÄÓÑÌÀÒÐÈÂÀÅÒÑß, ÂÛ ÈÑÏÎËÜÇÓÅÒÅ ÅÃÎ ÍÀ ÑÂÎÉ ÐÈÑÊ.  }
{ ÀÂÒÎÐ ÍÅ ÍÅÑÅÒ ÎÒÂÅÒÑÒÂÅÍÍÎÑÒÈ ÇÀ ÏÐÈ×ÈÍÅÍÍÛÉ ÓÙÅÐÁ ÑÂßÇÀÍÍÛÉ    }
{ Ñ ÅÃÎ ÈÑÏÎËÜÇÎÂÀÍÈÅÌ (ÏÐÀÂÈËÜÍÛÌ ÈËÈ ÍÅÏÐÀÂÈËÜÍÛÌ).              }
{                                                                  }
{******************************************************************}

unit LinkFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TLinkForm = class(TForm)
    OkBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    MaskLabel: TLabel;
    VarComboBox: TComboBox;
    VarLabel: TLabel;
    MaskComboBox2: TComboBox;
    MaskComboBox: TEdit;
    InsBitBtn: TBitBtn;
    procedure VarComboBoxChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure InsBitBtnClick(Sender: TObject);
    procedure MaskComboBoxChange(Sender: TObject);
    procedure MaskComboBox2Click(Sender: TObject);
    procedure MaskComboBoxKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LinkForm: TLinkForm;

implementation

{$R *.DFM}

procedure TLinkForm.VarComboBoxChange(Sender: TObject);
begin
  InsBitBtn.Enabled := Length(VarComboBox.Text)>0;
  MaskComboBoxChange(nil);
end;

procedure TLinkForm.InsBitBtnClick(Sender: TObject);
begin
  if InsBitBtn.Enabled then
    MaskComboBox.SelText := '['+VarComboBox.Text+']';
end;

procedure TLinkForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_INSERT:
      InsBitBtnClick(nil);
  end;
end;

procedure TLinkForm.MaskComboBoxChange(Sender: TObject);
begin
  OkBitBtn.Enabled := Length(MaskComboBox.Text)>0;
end;

procedure TLinkForm.MaskComboBox2Click(Sender: TObject);
begin
  MaskComboBox.Text := MaskComboBox2.Text;
  MaskComboBox.SetFocus;
end;

procedure TLinkForm.MaskComboBoxKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP, VK_DOWN:
      SendMessage(MaskComboBox2.Handle, WM_KEYDOWN, Key, 0);
  end;
end;

end.
