unit forminfinasistencias;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
    ExtCtrls, StdCtrls;

type

    { TfrmInfInasistencias }

    TfrmInfInasistencias = class(TForm)
        Bevel1: TBevel;
        Edit3: TEdit;
        Edit4: TEdit;
        GroupBox3: TGroupBox;
        Header1: TImage;
        Label2: TLabel;
        Label3: TLabel;
        RadioButton1: TRadioButton;
        RadioButton2: TRadioButton;
        RadioButton3: TRadioButton;
        RadioButton4: TRadioButton;
        RadioGroup1: TRadioGroup;
        RadioGroup2: TRadioGroup;
        SpeedButton1: TSpeedButton;
        SpeedButton2: TSpeedButton;
        procedure SpeedButton2Click(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    frmInfInasistencias: TfrmInfInasistencias;

implementation

{$R *.lfm}

{ TfrmInfInasistencias }

procedure TfrmInfInasistencias.SpeedButton2Click(Sender: TObject);
begin
    Close;
end;

end.

