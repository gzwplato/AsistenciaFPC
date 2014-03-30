unit dmData;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, sqlite3conn, sqldb, DB, FileUtil;

type

    { TDModule }

    TDModule = class(TDataModule)
        SQLDataSource: TDataSource;
        SQLConexion: TSQLite3Connection;
        SQLQuery: TSQLQuery;
        SQLTransaction: TSQLTransaction;
        procedure DataModuleCreate(Sender: TObject);
        procedure Conectar();
        procedure AbrirConexion();
        procedure CerrarConexion();
        procedure AplicarCambios();
        procedure VerificarJustificaciones();
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    DModule: TDModule;

implementation

{$R *.lfm}

{ TDModule }

procedure TDModule.DataModuleCreate(Sender: TObject);
begin
end;



procedure TDModule.Conectar();
//Procedimiento de Conexion a DB
var
    c1,c2:string;
begin
    {$IFDEF WINDOWS}
       {$IFDEF WIN32}
    c2 := 'c:/db.data';
       {$ENDIF}
    {$ENDIF}
       {$IFDEF LINUX}
    c2 := 'db.data';
       {$ENDIF}
    SQLConexion.DatabaseName := c2;
    SQLQuery.DataBase := SQLConexion;
    SQlQuery.Transaction := SQLTransaction;
    SQLDataSource.DataSet := SQLQuery;
end;

procedure TDModule.AbrirConexion();
//Abre La Conexion
begin
    SQLConexion.Connected := True;
    SQLTransaction.Active := True;
    SQLQuery.Open;
end;

procedure TDModule.CerrarConexion();
//Cierra la conexion
begin
    SQLQuery.Close;
    SQLTransaction.Active := False;
    SQLConexion.Connected := False;
end;

procedure TDModule.AplicarCambios();
begin
    SqlQuery.Edit;
    SQLQuery.ApplyUpdates;
    SQLTransaction.Commit;
    SQLQuery.Open;
end;

procedure TDModule.VerificarJustificaciones();
var
    fecha: string;
begin
  {Procedimiento que verifica si el empleado asistio determinado dia}
    fecha := DateToStr(Date);
  {  SQLQuery.Close;
    sqlQuery.SQL.Text:= 'SELECT * FROM asistencias where (id_empleado = :ID) and fecha is null';
    SQLQuery.Open;
    if SQLQuery.FieldByName('fecha').AsString;  }

end;

end.
