unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  System.types,
  System.Colors,
  SmartCL.Time,
  // W3C.Date,
  // SmartCL.Fonts,
  // SmartCL.Borders,
  SmartCL.Application,
  SmartCL.Controls.Button,
  SmartCL.Controls.Elements, SmartCL.Controls.Panel, SmartCL.Controls.Label;

type
  TForm1 = class(TW3Form)
    procedure startClick(Sender: TObject);
    procedure StopClick(Sender: TObject);

  private
{$I 'Form1:intf'}
    DelayHolder: integer;
    secs: integer;
    st: string;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm1 }
procedure TForm1.StopClick(Sender: TObject);
begin
  w3_ClearInterval(DelayHolder);
end;

procedure TForm1.startClick(Sender: TObject);
begin
  st := 'verde';
  start.Caption := '25';
  GREEN.Handle.style.setProperty('opacity', '1');
  secs := StrToInt(start.Caption);

  procedure blink;
  begin
    dec(secs);

    if (secs = 5) and (st = "verde") then
    begin
      st := "amarillo";
      RED.Handle.style.setProperty('opacity', '0.2');
      YELLOW.Handle.style.setProperty('opacity', '1');
      GREEN.Handle.style.setProperty('opacity', '0.2');
    end
    else
    begin
      if (secs = 0) and (st = "amarillo") then
      begin
        st := "rojo";
        RED.Handle.style.setProperty('opacity', '1');
        YELLOW.Handle.style.setProperty('opacity', '0.2');
        GREEN.Handle.style.setProperty('opacity', '0.2');
        secs := 25;
      end;
      if (secs = 0) and (st = "rojo") then
      begin
        st := "verde";
        RED.Handle.style.setProperty('opacity', '0.2');
        YELLOW.Handle.style.setProperty('opacity', '0.2');
        GREEN.Handle.style.setProperty('opacity', '1');
        secs := 25;
      end;
    end;
  end;

  DelayHolder := w3_SetInterval(procedure()
    begin
      blink;
      start.Caption := IntToStr(secs);
    end, 1000);
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm1.InitializeObject;
begin
  inherited;
{$I 'Form1:impl'}
  RED.Handle.id := 'rojo';
  YELLOW.Handle.id := 'amarillo';
  GREEN.Handle.id := 'verde';
end;

procedure TForm1.Resize;
begin
  inherited;
end;

initialization

Forms.RegisterForm({$I %FILE%}, TForm1);

end.
