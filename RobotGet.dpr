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

program RobotGet;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {MainForm},
  VarFrm in 'VarFrm.pas' {VarForm},
  LinkFrm in 'LinkFrm.pas' {LinkForm},
  SetupFrm in 'SetupFrm.pas' {SetupForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'RobotGet.hlp';
  Application.Title := 'RobotGet';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
