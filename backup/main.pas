unit main;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Math;

const
  BoundsOffset = 10;

  ParticlesCount = 200;

  MaxParticleSize = 8;
  MinParticleSize = 5;

  MaxParticleVelocity = 30;
  MinParticleVelocity = 5;

type
  TParticle = record
    Radius: single;
    Angle: single;
    Size: integer;
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
  Self.MakeParticles;
end;

procedure TParticlesUltimate.FormPaint(Sender: TObject);
var
  Curr: TParticle;
  X, Y: integer;
  MidX, MidY: single;
  I: integer;
begin
  Canvas.Brush.Color := clBlack;
  Canvas.fillRect(0, 0, ClientWidth, ClientHeight);

  Canvas.Pen.Style := psClear;
  Canvas.Brush.Color := clWhite;

  MidX := ClientWidth / 2;
  MidY := ClientHeight / 2;

  for I := 0 to High(Self.Particles) do
  begin
    Curr := Self.Particles[I];
    X := Trunc(MidX + Curr.Radius * Cos(Curr.Angle));
    Y := Trunc(MidY + Curr.Radius * Sin(Curr.Angle));

    Canvas.Rectangle(X, Y, X + Curr.Size, Y + Curr.Size);
  end;
end;

procedure TParticlesUltimate.TimerUpdateTimer(Sender: TObject);
begin
  Self.UpdateParticles;
  Self.Invalidate;
end;

procedure TParticlesUltimate.MakeParticles;
var
  I: integer;
begin
  for I := 0 to High(Self.Particles) do
    Self.Particles[I] := MakeParticle;
end;

procedure TParticlesUltimate.UpdateParticles;
var
  I: integer;
  X, Y: integer;
  MidX, MidY: integer;
begin
  MidX := ClientWidth div 2;
  MidY := ClientHeight div 2;

  for I := 0 to High(Self.Particles) do
  begin
    Self.Particles[I].Angle := Self.Particles[I].Angle + 0.005 * Pi;
    Self.Particles[I].Radius := Self.Particles[I].Radius + Self.Particles[I].Velocity;

    X := Trunc(MidX + Self.Particles[I].Radius * Cos(Self.Particles[I].Angle));
    Y := Trunc(MidY + Self.Particles[I].Radius * Sin(Self.Particles[I].Angle));

    if (X >= ClientWidth) or (Y >= ClientHeight) then
      Self.Particles[I] := Self.MakeParticle;
  end;
end;

function TParticlesUltimate.MakeParticle: TParticle;
begin
  Result.Angle := Random * 2 * Pi;
  Result.Radius := RandomRange(0, BoundsOffset);
  Result.Size := RandomRange(MinParticleSize, MaxParticleSize);
  Result.Velocity := RandomRange(MinParticleVelocity, MaxParticleVelocity) * 0.1;
end;


end.
