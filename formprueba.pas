unit formprueba;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, RTTICtrls,
    Forms, Controls, Graphics, Dialogs, StdCtrls,
    dmData, dateutils, types, LCLIntf;

type

    { TForm1 }

    TForm1 = class(TForm)
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCreate(Sender: TObject);


    private
        { private declarations }
    public
        { public declarations }
    end;

var
    Form1: TForm1;
    Data: TDModule;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
    OpenDocument('imgInc/prueba.jpg');
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction := caFree;
end;


end.
