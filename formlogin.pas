unit formlogin;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
    Buttons, StdCtrls, dmData, formPrincipal;

type

    { TfrmLogin }

    TfrmLogin = class(TForm)
        editUsuario: TEdit;
        editContrasena: TEdit;
        Image1: TImage;
        Image2: TImage;
        Image3: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        btnAcceder: TSpeedButton;
        btnSalir: TSpeedButton;
        procedure btnAccederClick(Sender: TObject);
        procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
        procedure btnSalirClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    frmLogin: TfrmLogin;

implementation

{$R *.lfm}

{ TfrmLogin }

procedure TfrmLogin.btnSalirClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin

end;

procedure TfrmLogin.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
    CloseAction := caFree;
end;

procedure TfrmLogin.btnAccederClick(Sender: TObject);
var
   Data : TDModule;
   vPrincipal : TfrmPrincipal;
   Ban : Boolean; //Bandera
begin
    Ban := False;
    //Creamos Data.
    try
        Data := TDModule.Create(self);
        Data.SQLQuery.SQL.Text := 'SELECT * FROM admin';
        //Abrimos Conexion
        Data.Conectar();
        Data.AbrirConexion();
        //Verificamos User
        if Length(Data.SQLQuery.FieldByName('usuario').AsString) <> 0 then       //Verificamos que exista un admin.
        begin
          if (editUsuario.Text = Data.SQLQuery.FieldByName('usuario').AsString) then   //Verificamos Admin con El Ingresado.
          begin
               if (editContrasena.Text = Data.SQLQuery.FieldByName('contrasena').AsString) then   //Verificamos que coincidan los passwd
               begin
                    Ban := True;

               end;
          end;
        end;
    finally
      Data.Free;
    end;

    //Verificamos la bandera
    if Ban then
    begin
         try
             vPrincipal := TfrmPrincipal.Create(nil);
             vPrincipal.ShowModal;
         finally
             vPrincipal.free;
             self.close;
         end;
    end
    else
        ShowMessage('Usuario/Contraseña Incorrecta');

end;

end.

