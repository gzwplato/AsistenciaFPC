unit formempleados;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    StdCtrls, DBCtrls, Buttons, dmData;

type

    { TfrmEmpleados }

    TfrmEmpleados = class(TForm)
        Bevel1: TBevel;
        brnGuardar: TSpeedButton;
        brnBuscarFoto: TSpeedButton;
        brnBorrarFoto: TSpeedButton;
        btnAtras: TSpeedButton;
        bdcbFacultad: TDBComboBox;
        bdcbHorario: TDBComboBox;
        bdeCI: TDBEdit;
        bdeNombre: TDBEdit;
        bdeTelefono: TDBEdit;
        bdeCargo: TDBEdit;
        bdeFoto: TDBText;
        Header: TImage;
        Header1: TImage;
        imgFoto: TImage;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label6: TLabel;
        Label7: TLabel;
        Label8: TLabel;
        openDialog: TOpenDialog;
        procedure bdeFotoChange(Sender: TObject);
        procedure brnBuscarFotoClick(Sender: TObject);
        procedure brnGuardar2Click(Sender: TObject);
        procedure brnGuardarClick(Sender: TObject);
        procedure btnAtrasClick(Sender: TObject);
        procedure ComboBox1Change(Sender: TObject);
        procedure bdeNombreChange(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCreate(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }

    end;

var
    frmEmpleados: TfrmEmpleados;

implementation

uses
    formPrincipal;

{$R *.lfm}

{ TfrmEmpleados }

procedure TfrmEmpleados.ComboBox1Change(Sender: TObject);
begin

end;

procedure TfrmEmpleados.bdeNombreChange(Sender: TObject);
begin

end;

procedure TfrmEmpleados.brnGuardarClick(Sender: TObject);
begin
   if length(bdeFoto.Caption )= 0 then
   begin
     with frmPrincipal.Data do
     begin
          SQLQuery.Edit;
          SQLQuery.FieldByName('Foto').Value:= 'imgInc/fotos/silueta.jpg';
     end;
   end;
    frmPrincipal.Data.AplicarCambios();
    Close;
end;

procedure TfrmEmpleados.brnBuscarFotoClick(Sender: TObject);
var
    imagen: string;
begin
    //#TODO: TERMINAR LAS IMAGENES
    if Length(bdeCI.Text) = 0 then
       ShowMessage('Llenar campos')
    else
    begin
        if openDialog.Execute then
        begin
          imagen :=openDialog.FileName;
          CopyFile(imagen, 'imgInc/fotos/' + bdeCI.Text + '.jpg');
          imgFoto.Picture.LoadFromFile(imagen);
          frmPrincipal.Data.SQLQuery.Edit;
          frmPrincipal.Data.SQLQuery.FieldByName('foto').AsString := 'imgInc/fotos/' + bdeCI.Text + '.jpg';
        end;
    end;
end;

procedure TfrmEmpleados.bdeFotoChange(Sender: TObject);
begin

end;

procedure TfrmEmpleados.brnGuardar2Click(Sender: TObject);
begin
end;

procedure TfrmEmpleados.btnAtrasClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmEmpleados.FormCreate(Sender: TObject);
begin
    //Cargamos los horarios en bdcbHorario
    frmPrincipal.Data.CerrarConexion();
    frmPrincipal.Data.SQLQuery.SQL.Text:='SELECT * FROM horarios';
    frmPrincipal.Data.AbrirConexion();
    while not frmPrincipal.Data.SQLQuery.EOF do
    begin
      bdcbHorario.Items.Add(frmPrincipal.Data.SQLQuery.FieldByName('descripcion').AsString);
      frmPrincipal.Data.SQLQuery.Next;
    end;
    //Cargamos Normal y Seteamos datasets
    with frmPrincipal.Data do
    begin
      CerrarConexion();
      SQLQuery.SQL.Text:='SELECT * FROM empleados';
      AbrirConexion();
    end;

    bdeCI.DataField:= 'id';
    bdeNombre.DataField:='nombre';
    bdeTelefono.DataField:='telefono';
    bdeCargo.DataField:='cargo';
    bdeFoto.DataField:='foto';
    bdcbFacultad.DataField:='facultad';
    bdcbHorario.DataField:= 'id_horario';
end;

procedure TfrmEmpleados.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction := caFree;
end;

end.
