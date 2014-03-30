program Asistencia;

{$mode objfpc}{$H+}

uses {$IFDEF UNIX} {$IFDEF UseCThreads}
    cthreads, {$ENDIF} {$ENDIF}
    Interfaces, // this includes the LCL widgetset
    Forms, pl_visualplanit, pl_excontrols, pl_luicontrols, pl_openwire,
    pl_bgracontrols, formprincipal, formlogin, forminfempleados,
    forminfasistencias, forminfinasistencias, formacercade, formasistencia,
    formjustificaciones;

{$R *.res}

begin
    RequireDerivedFormResource := True;
    Application.Initialize;
    Application.CreateForm(TfrmAsistencia, frmAsistencia);
    Application.Run;
end.
