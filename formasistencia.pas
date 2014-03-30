unit formasistencia;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, FileUtil, BGRAVirtualScreen, Forms, Controls, Graphics,
    Dialogs, ExtCtrls, StdCtrls, Buttons, BGRABitmap, BGRABitmapTypes,
    bgrasamples, BGRATextFX,dmData;

type

    { TfrmAsistencia }

    TfrmAsistencia = class(TForm)
        editCedula: TEdit;
        Image1: TImage;
        imgFoto: TImage;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        lblFecha: TLabel;
        lblHora: TLabel;
        btnValidar: TSpeedButton;
        btnCerrar: TSpeedButton;
        SuperRelog: TBGRAVirtualScreen;
        Timer1: TTimer;
        procedure btnValidarClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure SuperRelogRedraw(Sender: TObject; Bitmap: TBGRABitmap);
        procedure Timer1Timer(Sender: TObject);
        function verificarSalida(id : String): integer;
    private
        { private declarations }
    public
        { public declarations }
    end;

var
    frmAsistencia: TfrmAsistencia;
    Data : TDModule;
implementation

{$R *.lfm}

{ TfrmAsistencia }

function TfrmAsistencia.verificarSalida(id : String): integer;
var
    contador: integer;
begin
  contador := 0;
  Data.SQLQuery.SQL.Text := 'SELECT * FROM ASISTENCIAS where (id_empleado = :IDE) and FECHA = :TODAY';
  Data.SQLQuery.Params.ParamByName('IDE').Value := id;
  Data.SQLQuery.Params.ParamByName('TODAY').Value := DateToStr(Date);
  Data.AbrirConexion();
  while not Data.SQLQuery.EOF do
  begin
     contador := contador + 1;
     Data.SQLQuery.Next;
  end;
  verificarSalida:= contador;
end;

procedure TfrmAsistencia.FormCreate(Sender: TObject);
begin
    lblFecha.Caption := DateToStr(Date);

  //Crear Objeto Data.
  Data := TDModule.Create(self);
  Data.Conectar();

end;

procedure TfrmAsistencia.btnValidarClick(Sender: TObject);
var
  seleccion : integer;
  cant_reg: integer;
begin
  //Validamos Empleado
  if length(editCedula.Text) > 0 then
    begin
         cant_reg := verificarSalida(editCedula.Text);
         with Data do
            begin
                CerrarConexion();
                SQLQuery.SQL.Text:= 'SELECT * FROM empleados WHERE id = "'+editCedula.Text+'"';
                AbrirConexion();
                imgFoto.Picture.LoadFromFile(Data.SQLQuery.FieldByName('foto').AsString);
            end;
         if editCedula.Text = Data.SQLQuery.FieldByName('id').AsString then //Si existe el empleado
           begin
           if cant_reg = 2 then   //verifica estus de asistencias del empleado.
             begin
                  ShowMessage('Ya usted marco asistencia y salida este dia');
                  imgFoto.Picture.LoadFromFile('imgInc/fotos/silueta.jpg');
                  editCedula.Clear;
                  editCedula.SetFocus;
             end
            else
            begin
             seleccion := MessageDlg('Bienvenida '+Data.SQLQuery.FieldByName('nombre').AsString +' Desea marcar asistencia?', mtCustom,[mbYes, mbNo], 0);
             if seleccion = mrYes then
               begin
                 //Si Dijo que si.
                 With Data Do
                    begin
                        CerrarConexion();
                        SQLQuery.SQL.Text:= 'SELECT * FROM asistencias WHERE id = "'+editCedula.Text+'"';
                        AbrirConexion();
                        SQLQuery.Edit;
                        SQLQuery.FieldByName('id_empleado').Value := editCedula.Text;
                        SQLQuery.FieldByName('fecha').Value := DateToStr(Date);
                        SQLQuery.FieldByName('hora').Value := TimeToStr(Time);
                        SQLQuery.FieldByName('operacion').Value:= cant_reg; //0.Entrada, 1.Salida.
                        SQLQuery.ApplyUpdates();
                        SQLTransaction.Commit;
                    end;
                    //Borramos todo.
                    imgFoto.Picture.LoadFromFile('imgInc/fotos/silueta.jpg');
                    editCedula.Clear;
                    editCedula.SetFocus;
               end
             else
             begin
                 //Si Dijo que no.
              //Borramos todo.
                    imgFoto.Picture.LoadFromFile('imgInc/fotos/silueta.jpg');
                    editCedula.Clear;
                    editCedula.SetFocus;
             end;
            end;
           end
         else
             ShowMessage('Empleado no Existe');
    end
  else
      ShowMessage('Introduzca la cedula');
end;

procedure TfrmAsistencia.Timer1Timer(Sender: TObject);
begin
    SuperRelog.RedrawBitmap;
    lblHora.Caption := TimeToStr(Time);
end;
procedure TfrmAsistencia.SuperRelogRedraw(Sender: TObject; Bitmap: TBGRABitmap);
var
  txt: TBGRACustomBitmap;
  w, h, r, A, Xo, Yo, X, Y, Xt, Yt: integer;
  Xs, Ys, Xm, Ym, Xh, Yh: integer;
  th, tm, ts, tn: word;
begin
  w := (Sender as TControl).Width;
  h := (Sender as TControl).Height;

  { Set center point }
  Xo := w div 2;
  Yo := h div 2;

  // Determine radius. If canvas is rectangular then r = shortest length w or h
  r := yo;

  if xo > yo then
    r := yo;

  if xo < yo then
    r := xo;

  // Convert current time to integer values
  decodetime(Time, th, tm, ts, tn);

  { Set coordinates (length of arm) for seconds }
  Xs := Xo + Round(r * 0.78 * Sin(ts * 6 * Pi / 180));
  Ys := Yo - Round(r * 0.78 * Cos(ts * 6 * Pi / 180));

  { Set coordinates (length of arm) for minutes }
  Xm := Xo + Round(r * 0.68 * Sin(tm * 6 * Pi / 180));
  Ym := Yo - Round(r * 0.68 * Cos(tm * 6 * Pi / 180));

  { Set coordinates (length of arm) for hours }
  Xh := Xo + Round(r * 0.50 * Sin((th * 30 + tm / 2) * Pi / 180));
  Yh := Yo - Round(r * 0.50 * Cos((th * 30 + tm / 2) * Pi / 180));

  // Draw Bitmap frame
  Bitmap.FillEllipseAntialias(Xo, Yo, r * 0.99, r * 0.99, BGRA(175, 175, 175));
  Bitmap.FillEllipseAntialias(Xo, Yo, r * 0.98, r * 0.98, BGRA(245, 245, 245));
  Bitmap.FillEllipseAntialias(Xo, Yo, r * 0.90, r * 0.90, BGRA(175, 175, 175));
  Bitmap.FillEllipseLinearColorAntialias(Xo, Yo, r * 0.88, r * 0.88, BGRA(0, 58, 81), BGRA(2, 94, 131));

  // Draw Bitmap face
  for A := 1 to 12 do
  begin
    X := Xo + Round(r * 0.80 * Sin(30 * A * Pi / 180));
    Y := Yo - Round(r * 0.80 * Cos(30 * A * Pi / 180));
    Xt := Xo + Round(r * 0.70 * Sin(30 * A * Pi / 180));
    Yt := Yo - Round(r * 0.70 * Cos(30 * A * Pi / 180));
    Bitmap.EllipseAntialias(x, y, (r * 0.02), (r * 0.02), BGRA(255, 255, 255, 200), 2, BGRA(2, 94, 131));

    Bitmap.FontName := 'Calibri';
    Bitmap.FontHeight := r div 8;
    Bitmap.FontQuality := fqFineAntialiasing;
    Bitmap.TextOut(Xt, Yt - (Bitmap.FontHeight / 1.7), IntToStr(A), BGRA(245, 245, 245), taCenter);
  end;

  // Draw text
  txt := TextShadow(w, h, 'Asistencia 1.0', trunc(r * 0.12), ColorToBGRA(clWhite), BGRABlack, 4, 4, 10, [], 'Calibri');
  Bitmap.BlendImage(0, 0 - (r div 3), txt, boLinearBlend);
  txt.Free;

  // Draw time hands
  Bitmap.DrawLineAntialias(xo, yo, xs, ys, BGRA(255, 0, 0), r * 0.02);
  Bitmap.DrawLineAntialias(xo, yo, xm, ym, BGRA(245, 245, 245), r * 0.03);
  Bitmap.DrawLineAntialias(xo, yo, xh, yh, BGRA(245, 245, 245), r * 0.07);
  Bitmap.DrawLineAntialias(xo, yo, xh, yh, BGRA(2, 94, 131), r * 0.04);

  // Draw Bitmap centre dot
  Bitmap.EllipseAntialias(Xo, Yo, r * 0.04, r * 0.04, BGRA(245, 245, 245, 255), r * 0.02, BGRA(210, 210, 210, 255));
  Bitmap.BlendImage(0, 0, Bitmap, boLinearBlend);
end;
end.

