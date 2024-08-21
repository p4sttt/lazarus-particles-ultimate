program Particles;

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  main { you can add units after this };

begin
  RequireDerivedFormResource := True;
  Application.Title := 'Particles Ultimate';
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TParticlesUltimate, ParticlesUltimate);
  Application.Run;
end.
