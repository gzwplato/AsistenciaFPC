unit formjustificaciones;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    StdCtrls, Buttons;

type

    { TfrmJustificaciones }

    TfrmJustificaciones = class(TForm)
        Bevel1: TBevel;
        brnGuardar: TSpeedButton;
        brnGuardar1: TSpeedButton;
        btnAtras: TSpeedButton;
        Edit1: TEdit;
        Edit2: TEdit;
        Header: TImage;
        Header1: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Memo1: TMemo;
        procedure btnAtrasClick(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    frmJustificaciones: TfrmJustificaciones;

implementation

{$R *.lfm}

{ TfrmJustificaciones }

procedure TfrmJustificaciones.btnAtrasClick(Sender: TObject);
begin
    Close;
end;

end.

