{******************************************************************}
{                                                                  }
{ 2003(fw) Ironsoft Lab, Perm, Russia                              }
{ http://ironsite.narod.ru                                         }
{ Written by Iron (Michael Galyuk), ironsoft@mail.ru               }
{                                                                  }
{ Êîä ğàñïğîñòğàíÿåòñÿ íà ïğàâàõ ëèöåíçèè GNU GPL                  }
{ Ïğè èñïîëüçîâàíèè êîäà ññûëêà íà àâòîğà îáÿçàòåëüíà              }
{                                                                  }
{ Software distributed under the License is distributed on an      }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   }
{ implied.                                                         }
{                                                                  }
{ ÊÎÄ ĞÀÑÏĞÎÑÒĞÀÍßÅÒÑß ÏÎ ÏĞÈÍÖÈÏÓ "ÊÀÊ ÅÑÒÜ", ÍÈÊÀÊÈÕ             }
{ ÃÀĞÀÍÒÈÉ ÍÅ ÏĞÅÄÓÑÌÀÒĞÈÂÀÅÒÑß, ÂÛ ÈÑÏÎËÜÇÓÅÒÅ ÅÃÎ ÍÀ ÑÂÎÉ ĞÈÑÊ.  }
{ ÀÂÒÎĞ ÍÅ ÍÅÑÅÒ ÎÒÂÅÒÑÒÂÅÍÍÎÑÒÈ ÇÀ ÏĞÈ×ÈÍÅÍÍÛÉ ÓÙÅĞÁ ÑÂßÇÀÍÍÛÉ    }
{ Ñ ÅÃÎ ÈÑÏÎËÜÇÎÂÀÍÈÅÌ (ÏĞÀÂÈËÜÍÛÌ ÈËÈ ÍÅÏĞÀÂÈËÜÍÛÌ).              }
{                                                                  }
{******************************************************************}

unit VarFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TVarForm = class(TForm)
    RangeRadioGroup: TRadioGroup;
    KindRadioGroup: TRadioGroup;
    OkBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    FormatGroupBox: TGroupBox;
    FormatCheckBox: TCheckBox;
    MaskComboBox: TComboBox;
    FromEdit: TEdit;
    FromLabel: TLabel;
    ToLabel: TLabel;
    ToEdit: TEdit;
    StepLabel: TLabel;
    StepEdit: TEdit;
    RowLabel: TLabel;
    RowEdit: TEdit;
    NameLabel: TLabel;
    NameComboBox: TComboBox;
    procedure FormatCheckBoxClick(Sender: TObject);
    procedure RangeRadioGroupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NameComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure NameComboBoxChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VarForm: TVarForm;

implementation

{$R *.DFM}

procedure TVarForm.FormatCheckBoxClick(Sender: TObject);
begin
  MaskComboBox.Enabled := FormatCheckBox.Checked;
  MaskComboBox.ParentColor := not MaskComboBox.Enabled;
  if not MaskComboBox.ParentColor then
    MaskComboBox.Color := clWindow;
end;

procedure TVarForm.RangeRadioGroupClick(Sender: TObject);
begin
  FromEdit.Visible := RangeRadioGroup.ItemIndex=0;
  FromLabel.Visible := FromEdit.Visible;
  ToLabel.Visible := FromEdit.Visible;
  ToEdit.Visible := FromEdit.Visible;
  StepLabel.Visible := FromEdit.Visible;
  StepEdit.Visible := FromEdit.Visible;
  RowLabel.Visible := not FromEdit.Visible;
  RowEdit.Visible := RowLabel.Visible;
end;

procedure TVarForm.FormShow(Sender: TObject);
begin
  FormatCheckBoxClick(nil);
  RangeRadioGroupClick(nil);
  NameComboBoxChange(nil);
end;

procedure TVarForm.NameComboBoxKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key<#32) or (Key in ['A'..'Z', 'a'..'z'])) then
    Key := #0;
end;

procedure TVarForm.NameComboBoxChange(Sender: TObject);
begin
  OkBitBtn.Enabled := Length(NameComboBox.Text)>0;
end;

end.
