program Asistencia;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
    cthreads, {$ENDIF} {$ENDIF}
    Interfaces, // this includes the LCL widgetset
    Forms, pl_visualplanit, pl_excontrols, pl_luicontrols, pl_openwire,
    pl_bgracontrols, runtimetypeinfocontrols, tachartlazaruspkg, pl_geogis,
    pl_glscene, pl_graphics32, formprincipal, formlogin, forminfempleados,
    forminfasistencias, forminfinasistencias, formacercade, formasistencia,
    formjustificaciones, formprueba;

{$R *.res}

begin
    RequireDerivedFormResource := True;
    Application.Initialize;
    Application.CreateForm(TfrmLogin, frmLogin);
    Application.CreateForm(TfrmPrincipal, frmPrincipal);
    Application.Run;
end.
