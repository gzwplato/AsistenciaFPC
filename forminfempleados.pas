unit forminfempleados;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
    Buttons, ExtCtrls;

type

    { TfrmInfEmpleados }

    TfrmInfEmpleados = class(TForm)
        Bevel1: TBevel;
        Edit2: TEdit;
        Edit3: TEdit;
        Edit4: TEdit;
        GroupBox2: TGroupBox;
        GroupBox3: TGroupBox;
        Header1: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        RadioButton1: TRadioButton;
        RadioButton2: TRadioButton;
        RadioButton3: TRadioButton;
        RadioButton4: TRadioButton;
        RadioGroup1: TRadioGroup;
        SpeedButton1: TSpeedButton;
        SpeedButton2: TSpeedButton;
        procedure SpeedButton2Click(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    frmInfEmpleados: TfrmInfEmpleados;

implementation

{$R *.lfm}

{ TfrmInfEmpleados }

procedure TfrmInfEmpleados.SpeedButton2Click(Sender: TObject);
begin
    Close;
end;

end.

