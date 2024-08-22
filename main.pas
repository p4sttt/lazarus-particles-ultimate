unit main;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Math;

const
  ParticlesCount = 500;

  MaxAvaibleSize = 10;

  MaxRadius = 10;
  MaxSize = 5;
  MinSize = 1;

  AngleCoef = 1 / 200;
  RadiusCoef = 5 / 4;
  SizeCoef = 1 / 5000;

  Accseleration = 1 / 150;

type
  TParticle = record
    Angle: single;
    Radius: single;
    Size: single;

    Velocity: single;
  end;

  { TParticlesUltimate }

  TParticlesUltimate = class(TForm)
    TimerUpdate: TTimer;

    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure TimerUpdateTimer(Sender: TObject);

  private
    Particles: array[0..ParticlesCount] of TParticle;

    procedure MakeParticles;
    procedure UpdateParticles;

    function MakeParticle: TParticle;
  public

  end;

var
  ParticlesUltimate: TParticlesUltimate;

implementation

{$R *.lfm}


{ TParticlesUltimate }

procedure TParticlesUltimate.FormCreate(Sender: TObject);
begin
  MakeParticles;
end;

procedure TParticlesUltimate.FormPaint(Sender: TObject);
var
  X, Y: integer;
  MiddleX, MiddleY: integer;
  I: integer;
  Size: integer;
begin
  Canvas.Brush.Color := clBlack;
  Canvas.fillRect(0, 0, ClientWidth, ClientHeight);

  Canvas.Pen.Style := psClear;
  Canvas.Brush.Color := clWhite;

  MiddleX := ClientWidth div 2;
  MiddleY := ClientHeight div 2;

  for I := 0 to High(Particles) do
  begin
    X := Trunc(MiddleX + Particles[I].Radius * Cos(Particles[I].Angle));
    Y := Trunc(MiddleY + Particles[I].Radius * Sin(Particles[I].Angle));
    Size := Trunc(Particles[I].Size);

    Canvas.Rectangle(X, Y, X + Size, Y + Size);
  end;
end;

procedure TParticlesUltimate.TimerUpdateTimer(Sender: TObject);
begin
  UpdateParticles;
  Invalidate;
end;

procedure TParticlesUltimate.MakeParticles;
var
  I: integer;
begin
  for I := 0 to High(Particles) do
    Particles[I] := MakeParticle;
end;

procedure TParticlesUltimate.UpdateParticles;
var
  X, Y: integer;
  MiddleX, MiddleY: integer;
  I: integer;
begin
  MiddleX := ClientWidth div 2;
  MiddleY := ClientHeight div 2;

  for I := 0 to High(Particles) do
  begin
    Particles[I].Angle := Particles[I].Angle + Particles[I].Velocity * AngleCoef;
    Particles[I].Radius := Particles[I].Radius + Particles[I].Velocity * RadiusCoef;
    Particles[I].Size := Min(MaxAvaibleSize, Particles[I].Size +
      Particles[I].Radius * SizeCoef);

    Particles[I].Velocity := Particles[I].Velocity + Accseleration;

    X := Trunc(MiddleX + Particles[I].Radius * Cos(Particles[I].Angle));
    Y := Trunc(MiddleY + Particles[I].Radius * Sin(Particles[I].Angle));

    if (X <= -MaxAvaibleSize) or (Y >= ClientHeight + MaxAvaibleSize) then
      Particles[I] := MakeParticle;
  end;
end;

function TParticlesUltimate.MakeParticle: TParticle;
begin
  Result.Velocity := Random;

  Result.Angle := Random * 2 * Pi;
  Result.Radius := Result.Velocity * MaxRadius;
  Result.Size := MinSize + Result.Velocity * MaxSize;
end;

end.
