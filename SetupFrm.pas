{******************************************************************}
{                                                                  }
{ 2003(fw) Ironsoft Lab, Perm, Russia                              }
{ http://ironsite.narod.ru                                         }
{ Written by Iron (Michael Galyuk), ironsoft@mail.ru               }
{                                                                  }
{ ��� ���������������� �� ������ �������� GNU GPL                  }
{ ��� ������������� ���� ������ �� ������ �����������              }
{                                                                  }
{ Software distributed under the License is distributed on an      }
{ "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or   }
{ implied.                                                         }
{                                                                  }
{ ��� ���������������� �� �������� "��� ����", �������             }
{ �������� �� �����������������, �� ����������� ��� �� ���� ����.  }
{ ����� �� ����� ��������������� �� ����������� ����� ���������    }
{ � ��� �������������� (���������� ��� ������������).              }
{                                                                  }
{******************************************************************}

unit SetupFrm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons;

type
  TSetupForm = class(TForm)
    OkBitBtn: TBitBtn;
    CancelBitBtn: TBitBtn;
    ProxyLabel: TLabel;
    ProxyEdit: TEdit;
    PortLabel: TLabel;
    PortEdit: TEdit;
    PathLabel: TLabel;
    PathComboBox: TComboBox;
    FileNameGroupBox: TGroupBox;
    FullPathCheckBox: TCheckBox;
    KeepExtCheckBox: TCheckBox;
    OverwriteCheckBox: TCheckBox;
    AfterLoadLabel: TLabel;
    AfterLoadComboBox: TComboBox;
    procedure PortEditKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SetupForm: TSetupForm;

implementation

{$R *.DFM}

procedure TSetupForm.PortEditKeyPress(Sender: TObject; var Key: Char);
begin
  if not ((Key in ['0'..'9']) or (Key < #32)) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
end;

end.
