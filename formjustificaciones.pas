unit formjustificaciones;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    StdCtrls, Buttons, DBCtrls, ExtDlgs;

type

    { TfrmJustificaciones }

    TfrmJustificaciones = class(TForm)
        Bevel1: TBevel;
        brnGuardar: TSpeedButton;
        brnGuardar1: TSpeedButton;
        btnAtras: TSpeedButton;
        memo: TDBMemo;
        editCedula: TDBEdit;
        editFecha: TDBEdit;
        Header: TImage;
        Header1: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        OpenDialog1: TOpenPictureDialog;
        procedure brnGuardar1Click(Sender: TObject);
        procedure brnGuardarClick(Sender: TObject);
        procedure btnAtrasClick(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    frmJustificaciones: TfrmJustificaciones;

implementation

uses
    formPrincipal;

{$R *.lfm}

{ TfrmJustificaciones }

procedure TfrmJustificaciones.btnAtrasClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmJustificaciones.brnGuardarClick(Sender: TObject);
begin
    with frmPrincipal.Data do
    begin
        SQLQuery.FieldByName('id_empleado').Value := editCedula.Text;
        SQLQuery.FieldByName('fecha').Value := editFecha.Text;
        SQLQuery.FieldByName('justificacion').Value := memo.Text;
        SQLQuery.ApplyUpdates();
        SQLTransaction.Commit;
        SQLQuery.Open;
    end;
    Close;
end;

procedure TfrmJustificaciones.brnGuardar1Click(Sender: TObject);
var
    imagen: string;
begin
    if Length(editCedula.Text) = 0 then
        ShowMessage('Llenar campos')
    else
    begin
        if openDialog1.Execute then
        begin
            imagen := openDialog1.FileName;
            CopyFile(imagen, 'imgInc/justificaciones/' + editCedula.Text  +
                '-' + FormatDateTime('dd-mm-yy',StrToDate(editFecha.Text)) + '.jpg');
            frmPrincipal.Data.SQLQuery.Edit;
            frmPrincipal.Data.SQLQuery.FieldByName('archivo').AsString :=
                'imgInc/justificaciones/' + editCedula.Text +
                '-' + FormatDateTime('dd-mm-yy',StrToDate(editFecha.Text)) + '.jpg';
        end;
    end;
end;

end.
