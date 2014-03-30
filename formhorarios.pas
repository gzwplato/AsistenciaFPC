unit formhorarios;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    StdCtrls, DBCtrls, Buttons;

type

    { TfrmHorarios }

    TfrmHorarios = class(TForm)
        bdeCodigo: TDBEdit;
        Bevel1: TBevel;
        brnGuardar: TSpeedButton;
        btnAtras: TSpeedButton;
        cbLunes: TCheckBox;
        cbMartes: TCheckBox;
        cbMiercoles: TCheckBox;
        cbViernes: TCheckBox;
        cbSabado: TCheckBox;
        cbDomingo: TCheckBox;
        cbJueves: TCheckBox;
        bdeLun1: TDBEdit;
        bdeSab2: TDBEdit;
        bdeDom1: TDBEdit;
        bdeDom2: TDBEdit;
        bdeDescripcion: TDBEdit;
        bdeJue1: TDBEdit;
        bdeJue2: TDBEdit;
        bdeLun2: TDBEdit;
        bdeMar1: TDBEdit;
        bdeMar2: TDBEdit;
        bdeMie1: TDBEdit;
        bdeMie2: TDBEdit;
        bdeVie1: TDBEdit;
        bdeVie2: TDBEdit;
        bdeSab1: TDBEdit;
        Header: TImage;
        Header1: TImage;
        Label1: TLabel;
        Label10: TLabel;
        Label11: TLabel;
        Label12: TLabel;
        Label13: TLabel;
        Label14: TLabel;
        Label15: TLabel;
        Label16: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label6: TLabel;
        Label7: TLabel;
        Label8: TLabel;
        Label9: TLabel;
        procedure brnGuardarClick(Sender: TObject);
        procedure btnAtrasClick(Sender: TObject);
        procedure cbDomingoChange(Sender: TObject);
        procedure cbJuevesChange(Sender: TObject);
        procedure cbLunesChange(Sender: TObject);
        procedure cbMartesChange(Sender: TObject);
        procedure cbMiercolesChange(Sender: TObject);
        procedure cbSabadoChange(Sender: TObject);
        procedure cbViernesChange(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCreate(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    frmHorarios: TfrmHorarios;

implementation

uses
    formPrincipal;

{$R *.lfm}

{ TfrmHorarios }

procedure TfrmHorarios.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction := caFree;
end;

procedure TfrmHorarios.FormCreate(Sender: TObject);
begin

end;

procedure TfrmHorarios.brnGuardarClick(Sender: TObject);
begin
    if Length(bdeDescripcion.Text) < 4 then
       ShowMessage('La Descripcion debe ser de 4 a 20 Digitos')
    else
        begin
        frmPrincipal.Data.AplicarCambios();
        Close;
        end;
end;

procedure TfrmHorarios.btnAtrasClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmHorarios.cbLunesChange(Sender: TObject);
begin
    //LUNES
    if cbLunes.Checked then
    begin
        bdeLun1.Enabled := True;
        bdeLun2.Enabled := True;
    end
    else
    begin
        bdeLun1.Enabled := False;
        bdeLun2.Enabled := False;
    end;
end;

procedure TfrmHorarios.cbMartesChange(Sender: TObject);
begin
    //MARTES
    if cbMartes.Checked then
    begin
        bdeMar1.Enabled := True;
        bdeMar2.Enabled := True;
    end
    else
    begin
        bdeMar1.Enabled := False;
        bdeMar2.Enabled := False;
    end;
end;

procedure TfrmHorarios.cbMiercolesChange(Sender: TObject);
begin
    //MIERCOLES
    if cbMiercoles.Checked then
    begin
        bdeMie1.Enabled := True;
        bdeMie2.Enabled := True;
    end
    else
    begin
        bdeMie1.Enabled := False;
        bdeMie2.Enabled := False;
    end;
end;



procedure TfrmHorarios.cbJuevesChange(Sender: TObject);
begin
    //JUEVES
    if cbJueves.Checked then
    begin
        bdeJue1.Enabled := True;
        bdeJue2.Enabled := True;
    end
    else
    begin
        bdeJue1.Enabled := False;
        bdeJue2.Enabled := False;
    end;
end;

procedure TfrmHorarios.cbViernesChange(Sender: TObject);
begin
    //VIERNES
    if cbViernes.Checked then
    begin
        bdeVie1.Enabled := True;
        bdeVie2.Enabled := True;
    end
    else
    begin
        bdeVie1.Enabled := False;
        bdeVie2.Enabled := False;
    end;
end;

procedure TfrmHorarios.cbSabadoChange(Sender: TObject);
begin
    //SABADO
    if cbSabado.Checked then
    begin
        bdeSab1.Enabled := True;
        bdeSab2.Enabled := True;
    end
    else
    begin
        bdeSab1.Enabled := False;
        bdeSab2.Enabled := False;
    end;
end;

procedure TfrmHorarios.cbDomingoChange(Sender: TObject);
begin
    //DOMINGO
    if cbDomingo.Checked then
    begin
        bdeDom1.Enabled := True;
        bdeDom2.Enabled := True;
    end
    else
    begin
        bdeDom1.Enabled := False;
        bdeDom2.Enabled := False;
    end;
end;

end.
