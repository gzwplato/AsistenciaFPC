unit formPrincipal;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    ComCtrls, Buttons, DBGrids, StdCtrls, DbCtrls, dmData, formempleados,
    formhorarios, forminfempleados, forminfasistencias, forminfinasistencias,
    formacercade, formjustificaciones;

type

    { TfrmPrincipal }

    TfrmPrincipal = class(TForm)
        btnJusModificar: TSpeedButton;
        BitBtn18: TSpeedButton;
        BitBtn19: TSpeedButton;
        blBotonera: TBevel;
        bmHoModificar: TSpeedButton;
        btnAcercaDe: TSpeedButton;
        btnAgEmpleado: TSpeedButton;
        btnAgJustificacion: TSpeedButton;
        btnAgrHorario: TSpeedButton;
        btnAyuda: TSpeedButton;
        btnBusqueda: TSpeedButton;
        btnBusqueda1: TSpeedButton;
        btnBusquedaHora: TSpeedButton;
        btnCancelBusqueda: TSpeedButton;
        btnCancelBusqueda1: TSpeedButton;
        btnCancelBusquedaHora: TSpeedButton;
        btnEmBorrar: TSpeedButton;
        btnEmModificar: TSpeedButton;
        btnHoBorrar: TSpeedButton;
        blDivision: TBevel;
        btnInfAsistencia: TSpeedButton;
        btnInfEmpleado: TSpeedButton;
        btnInfInasistencia: TSpeedButton;
        btnSalir: TSpeedButton;
        DBEdit1: TDBEdit;
        DBEdit2: TDBEdit;
        DBEdit3: TDBEdit;
        DBEdit4: TDBEdit;
        DBEdit5: TDBEdit;
        DBEdit6: TDBEdit;
        DBEdit7: TDBEdit;
        dbGridEmpleados: TDBGrid;
        dbGridHorarios: TDBGrid;
        dbgridJustificaciones: TDBGrid;
        editBusqueda: TEdit;
        editBusqueda1: TEdit;
        editBusquedaHora: TEdit;
        gbPasswd: TGroupBox;
        Empresa: TGroupBox;
        GroupBox1: TGroupBox;
        Image1: TImage;
        Image2: TImage;
        Image3: TImage;
        Image4: TImage;
        imgFotoP: TImage;
        imgHeader: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label6: TLabel;
        Label7: TLabel;
        Page: TPageControl;
        rbCedula1: TRadioButton;
        rbCodigoHora: TRadioButton;
        rbNombre: TRadioButton;
        rbCedula: TRadioButton;
        rbNombre1: TRadioButton;
        rbNombreHora: TRadioButton;
        SpeedButton1: TSpeedButton;
        SpeedButton2: TSpeedButton;
        SpeedButton3: TSpeedButton;
        status: TStatusBar;
        tabEmpleados: TTabSheet;
        tabHorarios: TTabSheet;
        tabJustificaciones: TTabSheet;
        tabConfig: TTabSheet;
        procedure Bevel1ChangeBounds(Sender: TObject);
        procedure bmHoModificarClick(Sender: TObject);
        procedure btnAcercaDeClick(Sender: TObject);
        procedure btnAgEmpleadoClick(Sender: TObject);
        procedure btnAgJustificacionClick(Sender: TObject);
        procedure btnAgrHorarioClick(Sender: TObject);
        procedure btnBusquedaClick(Sender: TObject);
        procedure btnBusquedaHoraClick(Sender: TObject);
        procedure btnCancelBusquedaClick(Sender: TObject);
        procedure btnCancelBusquedaHoraClick(Sender: TObject);
        procedure btnEmBorrarClick(Sender: TObject);
        procedure btnEmModificarClick(Sender: TObject);
        procedure btnHoBorrarClick(Sender: TObject);
        procedure btnInfAsistenciaClick(Sender: TObject);
        procedure btnInfEmpleadoClick(Sender: TObject);
        procedure btnInfInasistenciaClick(Sender: TObject);
        procedure btnJusModificarClick(Sender: TObject);
        procedure btnSalirClick(Sender: TObject);
        procedure dbGridEmpleadosCellClick(Column: TColumn);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCreate(Sender: TObject);
        procedure PageChange(Sender: TObject);
    private
        { private declarations }

    public
        { public declarations }
        Data: TDModule;
    end;

var
    frmPrincipal: TfrmPrincipal;
    idempleado: string;
implementation

{$R *.lfm}

{ TfrmPrincipal }

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin

    //El panel
    status.Panels[0].Text := 'No Asignado';
    status.Panels[1].Text := 'Fecha: ' + DateToStr(Date);
    status.Panels[2].Text := 'Hora:' + TimeToStr(Time);
    //Configuracion inicial de primer tab, se cambia al cambiar tab.
    Data := TDModule.Create(self);
    Data.Conectar();
    Data.SQLQuery.SQL.Text := 'SELECT * FROM empleados';
    Data.AbrirConexion();

    status.Panels[0].Text := 'Aqui puedes agregar, modificar y borrar empleados';
    //Asigna la ayuda del status bar

    //Ponemos la primera foto
    imgFotoP.Picture.LoadFromFile(Data.SQLQuery.FieldByName('foto').AsString);
end;

procedure TfrmPrincipal.PageChange(Sender: TObject);
//Procedimiento para cerrar y cambiar SQL mediante el cambio de TAB
var
    today : string;
begin
    today := DateToStr(DATE);
    if Page.ActivePageIndex = 0 then
    begin
        //TAB EMPLEADOS
        //Cambio de Header
        imgHeader.Picture.LoadFromFile('imgInc/headers/bannerempleados.png');
        //Cerramos las consultas.
        status.Panels[0].Text := 'Aqui puedes agregar, modificar y borrar empleados';
        Data.CerrarConexion();
        //Añadimos la nueva Consulta
        Data.SQLQuery.SQL.Text := 'SELECT * FROM empleados';
        dbGridEmpleados.DataSource := Data.SQLDataSource;
        Data.AbrirConexion();
    end;
    if Page.ActivePageIndex = 1 then
    begin
        //TAB HORARIOS
        //Cerramos las consultas.
        imgHeader.Picture.LoadFromFile('imgInc/headers/bannerhorarios.png');
        status.Panels[0].Text := 'Aqui puedes agregar, modificar y borrar Horarios';
        Data.CerrarConexion();
        //Añadimos la nueva Consulta
        Data.SQLQuery.SQL.Text := 'SELECT * FROM horarios';
        dbGridHorarios.DataSource := Data.SQLDataSource;
        Data.AbrirConexion();
    end;
    if Page.ActivePageIndex = 2 then
        //TAB JUSTIFICACIONES
    begin
        imgHeader.Picture.LoadFromFile('imgInc/headers/bannerjustificacion.png');
        status.Panels[0].Text := 'Aqui puedes agregar, modificar y borrar Justificaciones';
        Data.CerrarConexion();
        //Añadimos la nueva Consulta
       { Data.SQLQuery.SQL.Clear;
        Data.SQLQuery.Params.ParamByName('D2') := today;
        dbgridJustificaciones.DataSource := Data.SQLDataSource;
        Data.AbrirConexion();      }
    end;
    if Page.ActivePageIndex = 3 then
        //TAB CONFIGURACIONES
        imgHeader.Picture.LoadFromFile('imgInc/headers/bannerconfiguracion.png');
end;

procedure TfrmPrincipal.Bevel1ChangeBounds(Sender: TObject);
begin

end;

procedure TfrmPrincipal.bmHoModificarClick(Sender: TObject);
//Procedimiento para modificar horarios
var
    vHorarios: TfrmHorarios;
begin
    try
        vHorarios := TfrmHorarios.Create(nil);
        vHorarios.Header1.Visible:= True;
        vHorarios.Header.Free;
        //Pasar Checks Activados.
        if (Length(vHorarios.bdeLun1.Text) > 0) or (Length(vHorarios.bdeLun2.Text) > 0)then
           vHorarios.cbLunes.Checked:=True;
        if (Length(vHorarios.bdeMar1.Text) > 0) or (Length(vHorarios.bdeMar2.Text) > 0)then
           vHorarios.cbMartes.Checked:=True;
        if (Length(vHorarios.bdeMie1.Text) > 0) or (Length(vHorarios.bdeMie2.Text) > 0)then
           vHorarios.cbMiercoles.Checked:=True;
        if (Length(vHorarios.bdeJue1.Text) > 0) or (Length(vHorarios.bdeJue2.Text) > 0)then
           vHorarios.cbJueves.Checked:=True;
        if (Length(vHorarios.bdeVie1.Text) > 0) or (Length(vHorarios.bdeVie2.Text) > 0)then
           vHorarios.cbViernes.Checked:=True;
        if (Length(vHorarios.bdeSab1.Text) > 0) or (Length(vHorarios.bdeSab2.Text) > 0)then
           vHorarios.cbSabado.Checked:=True;
        if (Length(vHorarios.bdeDom1.Text) > 0) or (Length(vHorarios.bdeDom2.Text) > 0)then
           vHorarios.cbDomingo.Checked:=True;
        vHorarios.ShowModal;
    finally
        vHorarios.Free;
    end;
end;

procedure TfrmPrincipal.btnAcercaDeClick(Sender: TObject);
var
   vAcerca : TfrmAcerca;
begin
   try
       vAcerca := TfrmAcerca.Create(nil);
       vAcerca.ShowModal;
   finally
       vAcerca.Free;
   end;
end;

procedure TfrmPrincipal.btnAgEmpleadoClick(Sender: TObject);
//Procedimiento para abrir ventana de usuario.
var
    frmEmpleados: TfrmEmpleados;
begin
    try
        page.TabIndex := 0;
        frmEmpleados := TfrmEmpleados.Create(nil);
        frmEmpleados.bdeFoto.Caption:= '';  //Esto es para que cuando sea nvo empleado, no carge la foto de data.
        Data.SQLQuery.Insert;

        frmEmpleados.ShowModal;
    finally
        Data.SQLQuery.Cancel;
        frmEmpleados.Free;
    end;

end;

procedure TfrmPrincipal.btnAgJustificacionClick(Sender: TObject);
var
    vJustificaciones : TfrmJustificaciones;
begin
    try
        Page.TabIndex := 2; //Cambiamos al Index correcto.
        vJustificaciones := TfrmJustificaciones.Create(nil);
        vJustificaciones.ShowModal;
    finally
        vJustificaciones.free;
        Data.SQLQuery.Cancel;
    end;
end;

procedure TfrmPrincipal.btnAgrHorarioClick(Sender: TObject);
var
    vHorarios: TfrmHorarios;
begin
    try
        Page.TabIndex := 1; //Cambiamos al Index correcto.
        vHorarios := TfrmHorarios.Create(nil);
        Data.SQlQuery.Insert;
        vHorarios.ShowModal;
    finally
        Data.SQLQuery.Cancel;
        vHorarios.Free;
    end;
end;

procedure TfrmPrincipal.btnBusquedaClick(Sender: TObject);
var
    buscar: string;
begin
    Data.CerrarConexion();
    if rbNombre.Checked then
    begin
        buscar := '"%' + editBusqueda.Text + '%"';
        Data.SQLQuery.SQL.Text := 'SELECT * FROM EMPLEADOS WHERE nombre LIKE ' + buscar;
        Data.SQLQuery.ExecSQL;
    end;
    if rbCedula.Checked then
    begin
        buscar := '"%' + editBusqueda.Text + '%"';
        Data.SQLQuery.SQL.Text := 'SELECT * FROM EMPLEADOS WHERE id LIKE ' + buscar;
        Data.SQLQuery.ExecSQL;
    end;
    Data.AbrirConexion();
end;

procedure TfrmPrincipal.btnBusquedaHoraClick(Sender: TObject);
var
    buscar: string;
begin
    Data.CerrarConexion();
    if rbNombreHora.Checked then
    begin
        buscar := '"%' + editBusquedaHora.Text + '%"';
        Data.SQLQuery.SQL.Text := 'SELECT * FROM HORARIOS WHERE descripcion LIKE ' + buscar;
        Data.SQLQuery.ExecSQL;
    end;
    if rbCodigoHora.Checked then
    begin
        buscar := '"%' + editBusquedaHora.Text + '%"';
        Data.SQLQuery.SQL.Text := 'SELECT * FROM HORARIOS WHERE id LIKE ' + buscar;
        Data.SQLQuery.ExecSQL;
    end;
    Data.AbrirConexion();
end;

procedure TfrmPrincipal.btnCancelBusquedaClick(Sender: TObject);
begin
    Data.CerrarConexion();
    Data.SQLQuery.SQL.Text := 'SELECT * FROM EMPLEADOS';
    Data.AbrirConexion();
end;

procedure TfrmPrincipal.btnCancelBusquedaHoraClick(Sender: TObject);
begin
    Data.CerrarConexion();
    Data.SQLQuery.SQL.Text := 'SELECT * FROM horarios';
    Data.AbrirConexion();
end;

procedure TfrmPrincipal.btnEmBorrarClick(Sender: TObject);
var
    seleccion: integer;
begin
    seleccion := MessageDlg('Desea borrar este empleado?', mtCustom, [mbYes, mbCancel], 0);
    if seleccion = mrYes then
    begin
        Data.SQLQuery.Delete;
        Data.AplicarCambios();
    end;
end;

procedure TfrmPrincipal.btnEmModificarClick(Sender: TObject);
var
    frmEmpleados: TfrmEmpleados;
begin
    //Guardar el id del empleado
    idempleado:= data.SQLQuery.FieldByName('id').AsString;
    try
        frmEmpleados := TfrmEmpleados.Create(nil);
        //Colocamos el id correcto porque al crear se modifica para cargar las categorias.
        with Data do
        begin
             CerrarConexion();
             SQLQuery.SQL.Text:= 'SELECT * FROM empleados where id = "' + idempleado+'"';
             AbrirConexion();
        end;



        //Cargar Imagen.
        if Length(frmEmpleados.bdeFoto.Caption) = 0 then
        begin
           frmEmpleados.imgFoto.Picture.LoadFromFile('imgInc/fotos/silueta.jpg');
           frmEmpleados.bdeFoto.Caption:='imgInc/fotos/silueta.jpg';
        end
        else
           frmEmpleados.imgFoto.Picture.LoadFromFile(frmEmpleados.bdeFoto.Caption);

        frmEmpleados.Header1.Visible:= True;
        frmEmpleados.Header.Destroy;
        frmEmpleados.ShowModal;


    finally
        with Data do //Devolvemos la tabla completa
        begin
             CerrarConexion();
             SQLQuery.SQL.Text:= 'SELECT * FROM empleados';
             AbrirConexion();
             imgFotoP.Picture.LoadFromFile(Data.SQLQuery.FieldByName('foto').AsString);
        end;
        frmEmpleados.Free;
    end;
end;

procedure TfrmPrincipal.btnHoBorrarClick(Sender: TObject);
var
    seleccion: integer;
begin
    seleccion := MessageDlg('Desea borrar este horario?', mtCustom, [mbYes, mbNo], 0);
    if seleccion = mrYes then
    begin
        Data.SQLQuery.Delete;
        Data.AplicarCambios();
    end;
end;

procedure TfrmPrincipal.btnInfAsistenciaClick(Sender: TObject);
var
    vInfAsistencia : TfrmInfAsistencias;
begin
    try
       vInfAsistencia:= TfrmInfAsistencias.Create(nil);
       vInfAsistencia.ShowModal;
    finally
       vInfAsistencia.Free;
    end;
end;

procedure TfrmPrincipal.btnInfEmpleadoClick(Sender: TObject);
var
   vInfEmpleados : TfrmInfEmpleados;
begin
    try
       vInfEmpleados := TfrminfEmpleados.Create(nil);
       vInfEmpleados.ShowModal;
    finally
       vInfEmpleados.Free;
    end;
end;

procedure TfrmPrincipal.btnInfInasistenciaClick(Sender: TObject);
var
   vInfInasistencias : TfrmInfInasistencias;
begin
    try
       vInfInasistencias := TfrmInfInasistencias.Create(nil);
       vInfInasistencias.ShowModal;
    finally
       vInfInasistencias.Free;
    end;

end;

procedure TfrmPrincipal.btnJusModificarClick(Sender: TObject);
var
    vJustificaciones : TfrmJustificaciones;
begin
    try
        vJustificaciones := TfrmJustificaciones.Create(nil);
        vJustificaciones.Header1.Visible:=True;
        vJustificaciones.ShowModal;
    finally
        vJustificaciones.free;
    end;
end;

procedure TfrmPrincipal.btnSalirClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmPrincipal.dbGridEmpleadosCellClick(Column: TColumn);
begin
     imgFotoP.Picture.LoadFromFile(Data.SQLQuery.FieldByName('foto').AsString);
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
    seleccion: integer;
begin
    seleccion := MessageDlg('Desea Salir del Sistema?', mtCustom, [mbYes, mbCancel], 0);
    if seleccion = mrYes then
        Hide;
end;

end.
