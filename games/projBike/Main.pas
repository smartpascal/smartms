unit Main;

interface

uses
  SmartCL.System, SmartCL.Components, SmartCL.Forms,
  SmartCL.Application, Form1, Form2, Form3;

type
  TApplication = class(TW3CustomApplication)
  private

  protected
    procedure ApplicationStarting; override;
    procedure ApplicationClosing; override;
  public
  end;

implementation

procedure TApplication.ApplicationStarting;
var
  mForm: TW3CustomForm;
begin
	mForm := TForm1.Create(display.view);
	mForm.name := 'Form1';
	RegisterFormInstance(mForm, true);

 	mForm := TForm2.Create(display.view);
	mForm.name := 'Form2';
	RegisterFormInstance(mForm, false);

 	mForm := TForm3.Create(display.view);
	mForm.name := 'Form3';
	RegisterFormInstance(mForm, false);

  inherited;
end;

procedure TApplication.ApplicationClosing;
begin
  inherited;

end;

initialization

end.