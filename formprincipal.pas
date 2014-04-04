unit formPrincipal;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    ComCtrls, Buttons, DBGrids, StdCtrls, DBCtrls, Grids, ExtDlgs, dmData,
    formempleados, formhorarios, forminfempleados, forminfasistencias,
    forminfinasistencias, formacercade, formjustificaciones, dateutils, LCLIntf;

type

    { TfrmPrincipal }

    TfrmPrincipal = class(TForm)
        btnJusModificar: TSpeedButton;
        BitBtn19: TSpeedButton;
        blBotonera: TBevel;
        bmHoModificar: TSpeedButton;
        btnAcercaDe: TSpeedButton;
        btnAgEmpleado: TSpeedButton;
        btnAgJustificacion: TSpeedButton;
        btnAgrHorario: TSpeedButton;
        btnAyuda: TSpeedButton;
        btnBusqueda: TSpeedButton;
        btnJustiBusqueda: TSpeedButton;
        btnBusquedaHora: TSpeedButton;
        btnCancelBusqueda: TSpeedButton;
        btnJustiCancelBusqueda: TSpeedButton;
        btnCancelBusquedaHora: TSpeedButton;
        btnEmBorrar: TSpeedButton;
        btnEmModificar: TSpeedButton;
        btnHoBorrar: TSpeedButton;
        blDivision: TBevel;
        btnInfAsistencia: TSpeedButton;
        btnInfEmpleado: TSpeedButton;
        btnInfInasistencia: TSpeedButton;
        btnSalir: TSpeedButton;
        dbGridEmpleados: TDBGrid;
        dbGridHorarios: TDBGrid;
        EditEmpresa: TEdit;
        editRif: TEdit;
        editTelefono: TEdit;
        editDireccion: TEdit;
        editEmail: TEdit;
        editUsuario: TEdit;
        editContrasena: TEdit;
        editBusqueda: TEdit;
        editJustiBusqueda: TEdit;
        editBusquedaHora: TEdit;
        gbPasswd: TGroupBox;
        Empresa: TGroupBox;
        grid: TStringGrid;
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
        page: TPageControl;
        rbCodigoHora: TRadioButton;
        rbNombre: TRadioButton;
        rbCedula: TRadioButton;
        rbNombreHora: TRadioButton;
        btnConGuardarEmpresa: TSpeedButton;
        btnConGuardarUser: TSpeedButton;
        btnBorrarSistema: TSpeedButton;
        status: TStatusBar;
        tabEmpleados: TTabSheet;
        tabHorarios: TTabSheet;
        tabJustificaciones: TTabSheet;
        tabConfig: TTabSheet;
        procedure Bevel1ChangeBounds(Sender: TObject);
        procedure BitBtn19Click(Sender: TObject);
        procedure bmHoModificarClick(Sender: TObject);
        procedure btnAcercaDeClick(Sender: TObject);
        procedure btnAgEmpleadoClick(Sender: TObject);
        procedure btnAgJustificacionClick(Sender: TObject);
        procedure btnAgrHorarioClick(Sender: TObject);
        procedure btnBorrarSistemaClick(Sender: TObject);
        procedure btnBusquedaClick(Sender: TObject);
        procedure btnBusquedaHoraClick(Sender: TObject);
        procedure btnCancelBusquedaClick(Sender: TObject);
        procedure btnCancelBusquedaHoraClick(Sender: TObject);
        procedure btnConGuardarEmpresaClick(Sender: TObject);
        procedure btnConGuardarUserClick(Sender: TObject);
        procedure btnEmBorrarClick(Sender: TObject);
        procedure btnEmModificarClick(Sender: TObject);
        procedure btnHoBorrarClick(Sender: TObject);
        procedure btnInfAsistenciaClick(Sender: TObject);
        procedure btnInfEmpleadoClick(Sender: TObject);
        procedure btnInfInasistenciaClick(Sender: TObject);
        procedure btnJusModificarClick(Sender: TObject);
        procedure btnJustiBusquedaClick(Sender: TObject);
        procedure btnJustiCancelBusquedaClick(Sender: TObject);
        procedure btnSalirClick(Sender: TObject);
        procedure dbGridEmpleadosCellClick(Column: TColumn);
        procedure editJustiBusquedaEnter(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure FormCreate(Sender: TObject);
        procedure pageChange(Sender: TObject);
        procedure ordenarJustificaciones(id: string);
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
    if Data.SQLQuery.RecordCount > 0 then
       imgFotoP.Picture.LoadFromFile(Data.SQLQuery.FieldByName('foto').AsString);
end;



procedure TfrmPrincipal.ordenarJustificaciones(id: string);
var
    fechasFalto, fechasAsistio, fechasCompletas: TStringList;
    fecha: TDateTime;
    i, n: integer;
begin
    //Creamos las StringLists.
    fechasAsistio := TStringList.Create();
    fechasCompletas := TStringList.Create();
    fechasFalto := TStringList.Create();
    //Buscamos las fechas marcadas en BD
    Data.CerrarConexion();
    Data.SQLQuery.SQL.Text :=
        'SELECT fecha,justificacion FROM asistencias WHERE (id_empleado = "' +
        id + '") and (hora is not null)';         //Consultas de las fechas que asistio.
    Data.AbrirConexion();
    if Data.SQLQuery.RecordCount = 0 then
    begin
        ShowMessage('Empleado no existe o No ha marcado asistencia nunca');
        editJustiBusqueda.SetFocus;
    end
    else
    begin
        editJustiBusqueda.Enabled := False; //Ponemos en disable el edit.
        while not Data.SQLQuery.EOF do
        begin
            fechasAsistio.Add(Data.SqlQuery.FieldByName('fecha').AsString);
            Data.SqlQuery.Next;
        end;
        //Ordenamos las fechas en la lista
        fechasAsistio.Sort;

        //Buscamos los dias del mes los guardamos en fechasCompletas.
        for i := 1 to StrToInt(FormatDateTime('dd', date)) do
        begin
            fecha := StrToDate(IntToStr(i) + '/' + FormatDateTime('mm/yy', date));
            fechasCompletas.add(DateToStr(fecha));
        end;

        //Comparamos las dos listas, y las que no sean iguales las ponemos en fechasFalto.

        for i := 0 to fechasCompletas.Count - 1 do
            if fechasAsistio.indexof(fechasCompletas[i]) < 0 then
                fechasFalto.add(fechasCompletas[i]);

        //Cargamos en el string list los dias que se pueden justificar

        with grid do
        begin
            RowCount := fechasFalto.Count;
            for i := 1 to RowCount - 1 do
            begin
                Cells[1, i] := fechasFalto[i];
                Data.CerrarConexion();
                Data.SQLQuery.SQL.Text :=
                    'SELECT * FROM asistencias where fecha = "' + fechasFalto[i] + '"';
                Data.AbrirConexion();
                Cells[2, i] := Data.SQLQuery.FieldByName('justificacion').AsString;
            end;
        end;
    end;
end;

procedure TfrmPrincipal.pageChange(Sender: TObject);
//Procedimiento para cerrar y cambiar SQL mediante el cambio de TAB
var
    today: string;
begin
    today := DateToStr(DATE);
    if page.ActivePageIndex = 0 then
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
    if page.ActivePageIndex = 1 then
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
    if page.ActivePageIndex = 2 then
        //TAB JUSTIFICACIONES
    begin
        imgHeader.Picture.LoadFromFile('imgInc/headers/bannerjustificacion.png');
        status.Panels[0].Text :=
            'Aqui puedes agregar, modificar y borrar Justificaciones';
        Data.CerrarConexion();
        //Añadimos la nueva Consulta
    end;
    if page.ActivePageIndex = 3 then
        //TAB CONFIGURACIONES
    begin
        imgHeader.Picture.LoadFromFile('imgInc/headers/bannerconfiguracion.png');
        status.Panels[0].Text :=
            'Configuraciones Generales de la empresa.';
        //Cargamos los Usuario edit y cerramos la db.
        with Data do
        begin
             CerrarConexion();
             SQLQuery.SQL.Text:= 'select * from admin';
             AbrirConexion();
             editUsuario.Text:= SQLQuery.FieldByName('usuario').AsString;
             editContrasena.Text := SQLQuery.FieldByName('contrasena').AsString;
             CerrarConexion();
        end;
        //Cargamos Edits de Empresa
        with Data do
        begin
             CerrarConexion();
             SQLQuery.SQL.Text:= 'select * from empresa';
             AbrirConexion();
             editRif.Text:= SQLQuery.FieldByName('rif').AsString;
             EditEmpresa.Text:= SQLQuery.FieldByName('descripcion').AsString;
             editDireccion.Text := SQLQuery.FieldByName('direccion').AsString;
             editTelefono.Text := SQLQuery.FieldByName('telefono').AsString;
             editEmail.Text:= SQLQuery.FieldByName('email').AsString;
             CerrarConexion();
        end;
    end;
end;

procedure TfrmPrincipal.Bevel1ChangeBounds(Sender: TObject);
begin

end;

procedure TfrmPrincipal.BitBtn19Click(Sender: TObject);
begin

    if grid.RowCount < 2 then
        ShowMessage('Debe buscar un empleado y seleccionar el dia, para ver la justificacion.')
    else
        begin
            Data.CerrarConexion();
            Data.SQLQuery.SQL.Text :=
             'SELECT * FROM ASISTENCIAS WHERE (id_empleado = :IDE) and (fecha = :FECHA)';
            data.SQLQuery.ParamByName('IDE').Value:= editJustiBusqueda.Text;
            data.SQLQuery.ParamByName('FECHA').Value:= grid.Cells[1, grid.Row];
            Data.AbrirConexion();
             OpenDocument(data.SQLQuery.FieldByName('archivo').AsString);
        end;
end;

procedure TfrmPrincipal.bmHoModificarClick(Sender: TObject);
//Procedimiento para modificar horarios
var
    vHorarios: TfrmHorarios;
begin
    try
        vHorarios := TfrmHorarios.Create(nil);
        vHorarios.Header1.Visible := True;
        vHorarios.Header.Free;
        //Pasar Checks Activados.
        if (Length(vHorarios.bdeLun1.Text) > 0) or
            (Length(vHorarios.bdeLun2.Text) > 0) then
            vHorarios.cbLunes.Checked := True;
        if (Length(vHorarios.bdeMar1.Text) > 0) or
            (Length(vHorarios.bdeMar2.Text) > 0) then
            vHorarios.cbMartes.Checked := True;
        if (Length(vHorarios.bdeMie1.Text) > 0) or
            (Length(vHorarios.bdeMie2.Text) > 0) then
            vHorarios.cbMiercoles.Checked := True;
        if (Length(vHorarios.bdeJue1.Text) > 0) or
            (Length(vHorarios.bdeJue2.Text) > 0) then
            vHorarios.cbJueves.Checked := True;
        if (Length(vHorarios.bdeVie1.Text) > 0) or
            (Length(vHorarios.bdeVie2.Text) > 0) then
            vHorarios.cbViernes.Checked := True;
        if (Length(vHorarios.bdeSab1.Text) > 0) or
            (Length(vHorarios.bdeSab2.Text) > 0) then
            vHorarios.cbSabado.Checked := True;
        if (Length(vHorarios.bdeDom1.Text) > 0) or
            (Length(vHorarios.bdeDom2.Text) > 0) then
            vHorarios.cbDomingo.Checked := True;
        vHorarios.ShowModal;
    finally
        vHorarios.Free;
    end;
end;

procedure TfrmPrincipal.btnAcercaDeClick(Sender: TObject);
var
    vAcerca: TfrmAcerca;
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
        frmEmpleados.bdeFoto.Caption := '';
        //Esto es para que cuando sea nvo empleado, no carge la foto de data.
        Data.SQLQuery.Insert;

        frmEmpleados.ShowModal;
    finally
        Data.SQLQuery.Cancel;
        frmEmpleados.Free;
    end;

end;

procedure TfrmPrincipal.btnAgJustificacionClick(Sender: TObject);
var
    vJustificaciones: TfrmJustificaciones;
begin
    page.TabIndex := 2; //Cambiamos al Index correcto.
    ShowMessage(
        'Para Justificar una falta introdusca la cedula del empleado seleccione el dia de la falta y click en modificar');
end;

procedure TfrmPrincipal.btnAgrHorarioClick(Sender: TObject);
var
    vHorarios: TfrmHorarios;
begin
    try
        page.TabIndex := 1; //Cambiamos al Index correcto.
        vHorarios := TfrmHorarios.Create(nil);
        Data.SQlQuery.Insert;
        vHorarios.ShowModal;
    finally
        Data.SQLQuery.Cancel;
        vHorarios.Free;
    end;
end;

procedure TfrmPrincipal.btnBorrarSistemaClick(Sender: TObject);
var
    seleccion: integer;
begin
    seleccion := MessageDlg('Esta opcion borrara toda la información del sistema, De verdad desea borrar del Sistema?', mtCustom, [mbYes, mbCancel], 0);
    if seleccion = mrYes then
        begin
            Data.SQLConexion.ExecuteDirect('delete from empleados where 1');
            Data.SQLConexion.ExecuteDirect('delete from asistencias where 1');
            Data.SQLConexion.ExecuteDirect('delete from sqlite_sequence where name= "asistencias"');
            Data.SQLConexion.ExecuteDirect('delete from empresa where 1');
            Data.SQLConexion.ExecuteDirect('delete from horarios where 1');
            Data.SQLConexion.ExecuteDirect('update admin set usuario = "admin", contrasena = "admin" where id = 1');
            data.SQLTransaction.Commit;
            ShowMessage('Se borro todo, se cerrara el sistema debe abrirlo de nuevo.');
            Close;
        end
    else
        ShowMessage('No se borro nada');
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
        Data.SQLQuery.SQL.Text :=
            'SELECT * FROM HORARIOS WHERE descripcion LIKE ' + buscar;
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

procedure TfrmPrincipal.btnConGuardarEmpresaClick(Sender: TObject);
begin
    with Data do
    begin
        SQLQuery.SQL.Text := 'SELECT * FROM EMPRESA';
        AbrirConexion();
        SQLQuery.Edit;
        SQLQuery.FieldByName('descripcion').AsString:= EditEmpresa.Text;
        SQLQuery.FieldByName('rif').AsString:= editRif.Text;
        SQLQuery.FieldByName('telefono').AsString:= editTelefono.Text;
        SQLQuery.FieldByName('direccion').AsString:= editDireccion.Text;
        SQLQuery.FieldByName('email').AsString:= editEmail.Text;
        AplicarCambios();
        CerrarConexion();
    end;
end;

procedure TfrmPrincipal.btnConGuardarUserClick(Sender: TObject);
begin
    with Data do
    begin
        SQLQuery.SQL.Text:= 'select * from admin';
        AbrirConexion();
        SQLQuery.Edit;
        SQLQuery.FieldByName('usuario').AsString:= editUsuario.Text;
        SqlQuery.FieldByName('contrasena').AsString:= editContrasena.Text;
        AplicarCambios();
        CerrarConexion();
    end;
end;

procedure TfrmPrincipal.btnEmBorrarClick(Sender: TObject);
var
    seleccion: integer;
begin
    seleccion := MessageDlg('Desea borrar este empleado?', mtCustom,
        [mbYes, mbCancel], 0);
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
    idempleado := Data.SQLQuery.FieldByName('id').AsString;
    try
        frmEmpleados := TfrmEmpleados.Create(nil);
        //Colocamos el id correcto porque al crear se modifica para cargar las categorias.
        with Data do
        begin
            CerrarConexion();
            SQLQuery.SQL.Text :=
                'SELECT * FROM empleados where id = "' + idempleado + '"';
            AbrirConexion();
        end;
        //Cargar Imagen.
        if Length(frmEmpleados.bdeFoto.Caption) = 0 then
        begin
            frmEmpleados.imgFoto.Picture.LoadFromFile('imgInc/fotos/silueta.jpg');
            frmEmpleados.bdeFoto.Caption := 'imgInc/fotos/silueta.jpg';
        end
        else
            frmEmpleados.imgFoto.Picture.LoadFromFile(frmEmpleados.bdeFoto.Caption);
        frmEmpleados.Header1.Visible := True;
        frmEmpleados.Header.Destroy;
        frmEmpleados.ShowModal;
    finally
        with Data do //Devolvemos la tabla completa
        begin
            CerrarConexion();
            SQLQuery.SQL.Text := 'SELECT * FROM empleados';
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
    vInfAsistencia: TfrmInfAsistencias;
begin
    try
        vInfAsistencia := TfrmInfAsistencias.Create(nil);
        vInfAsistencia.ShowModal;
    finally
        vInfAsistencia.Free;
    end;
end;

procedure TfrmPrincipal.btnInfEmpleadoClick(Sender: TObject);
var
    vInfEmpleados: TfrmInfEmpleados;
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
    vInfInasistencias: TfrmInfInasistencias;
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
    vJustificaciones: TfrmJustificaciones;
    row: integer;
begin
    row := grid.row;
    if grid.RowCount > 1 then
    begin
        //Seteamos la data.
        Data.CerrarConexion();
        //Añadimos la nueva Consulta
        Data.SQLQuery.SQL.Text := 'SELECT * FROM asistencias';
        dbGridEmpleados.DataSource := Data.SQLDataSource;
        Data.AbrirConexion();
        if Length(grid.Cells[2, grid.row]) = 0 then
           Data.SQLQuery.Insert
        else
            begin
            data.CerrarConexion();
            data.SQLQuery.SQL.Text:= 'select * from asistencias where (id_empleado = :IDE) and (fecha = :FECHA) and (hora is null)';
            data.SQLQuery.Params.ParamByName('IDE').Value:= editJustiBusqueda.text;
            data.SQLQuery.Params.ParamByName('FECHA').Value := grid.Cells[1,grid.row];
            Data.AbrirConexion();
            Data.SQLQuery.Edit;

            end;

        try
            vJustificaciones := TfrmJustificaciones.Create(nil);
            vJustificaciones.Header1.Visible := True;
            vJustificaciones.editFecha.Text := grid.Cells[1, row];
            vJustificaciones.editCedula.Text := editJustiBusqueda.Text;
            vJustificaciones.memo.Text := grid.Cells[2, row];
            vJustificaciones.ShowModal;
        finally
            vJustificaciones.Free;
            btnJustiBusquedaClick(self);
        end;
    end
    else
        ShowMessage('Debe realizar la busqueda y seleccionar una falta.');
end;

procedure TfrmPrincipal.btnJustiBusquedaClick(Sender: TObject);
begin
    ordenarJustificaciones(editJustiBusqueda.Text);

end;

procedure TfrmPrincipal.btnJustiCancelBusquedaClick(Sender: TObject);
begin
    editJustiBusqueda.Enabled := True;
    editJustiBusqueda.Clear;
    grid.Clear;
    editJustiBusqueda.SetFocus;
end;

procedure TfrmPrincipal.btnSalirClick(Sender: TObject);
begin
    Close;
end;



procedure TfrmPrincipal.dbGridEmpleadosCellClick(Column: TColumn);
begin
    imgFotoP.Picture.LoadFromFile(Data.SQLQuery.FieldByName('foto').AsString);
end;

procedure TfrmPrincipal.editJustiBusquedaEnter(Sender: TObject);
begin
    editJustiBusqueda.Clear;
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
