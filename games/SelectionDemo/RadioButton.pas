{ **************************************************************************** }
{ Adapted from CheckBox in                                                     }
{                                                                              }
{ Smart Mobile Studio - Runtime Library                                        }
{                                                                              }
{ Copyright © 2012-2014 Optimale Systemer AS.                                  }
{                                                                              }
{ **************************************************************************** }

unit RadioButton;

interface

uses
  System.Types, SmartCL.System, SmartCL.Components, SmartCL.Controls.Label;

type
  TW3RadioCheckMark = class(TW3CustomControl)
  protected
    procedure setWidth(aValue: Integer); override;
    procedure setHeight(aValue: Integer); override;
    function makeElementTagObj: THandle; override;
    procedure StyleTagObject; override;
    function getChecked: Boolean; virtual;
    procedure setChecked(const aValue: Boolean); virtual;
  published
    property Checked: Boolean read getChecked write setChecked;
  end;

  TW3RadioButton = class(TW3CustomControl)
  private
    FLabel: TW3Label;
    FMark: TW3RadioCheckMark;
    procedure HandleLabelClick(Sender: TObject);
  protected
    function getCaption: String;
    procedure setCaption(aValue: String);
    function getChecked: Boolean;
    procedure setChecked(aValue: Boolean);
    function getEnabled: Boolean; override;
    procedure setEnabled(aValue: Boolean); override;
    procedure InitializeObject; override;
    procedure FinalizeObject; override;
    procedure Resize; override;
  public
    property Label: TW3Label read FLabel;
    property CheckMark: TW3RadioCheckMark read FMark;
  published
    property Caption: String read getCaption write setCaption;
    property Checked: Boolean read getChecked write setChecked;
  end;

implementation

{ **************************************************************************** }
{ TW3RadioCheckMark                                                            }
{ **************************************************************************** }

procedure TW3RadioCheckMark.setWidth(aValue: Integer);
begin
  aValue := 20;
end;

procedure TW3RadioCheckMark.setHeight(aValue: Integer);
begin
  aValue := 20;
end;

function TW3RadioCheckMark.getChecked: Boolean;
begin
  Result := w3_getPropertyAsBool(Handle, 'checked');
end;

procedure TW3RadioCheckMark.setChecked(const aValue: Boolean);
begin
  w3_setProperty(Handle, 'checked', aValue);
end;

function TW3RadioCheckMark.makeElementTagObj: THandle;
begin
  Result := w3_createHtmlElement('input');
end;

procedure TW3RadioCheckMark.StyleTagObject;
begin
  inherited;
  w3_setProperty(Handle, 'type', 'radio');
  Handle.style.setProperty('height', '21px');
  Handle.style.setProperty('width', '21px');
end;

{ **************************************************************************** }
{ TW3RadioButton                                                               }
{ **************************************************************************** }

procedure TW3RadioButton.InitializeObject;
begin
  inherited;
  FLabel := TW3Label.Create(Self);
  FMark := TW3RadioCheckMark.Create(Self);
  FLabel.Caption := 'Radio Button';
  FLabel.Container.OnClick := HandleLabelClick;
  FLabel.Handle.style.setProperty('margin-left', '0.8em');
end;

procedure TW3RadioButton.FinalizeObject;
begin
  FMark.Free;
  FLabel.Free;
  inherited;
end;

function TW3RadioButton.getEnabled: Boolean;
begin
  Result := FMark.Enabled;
end;

procedure TW3RadioButton.HandleLabelClick(Sender: TObject);
begin
  if FLabel.Enabled then
    if not Checked then
      setChecked(true);
end;

function TW3RadioButton.getChecked: Boolean;
begin
  Result := FMark.Checked;
end;

procedure TW3RadioButton.setChecked(aValue: Boolean);
begin
  FMark.Checked := aValue;
end;

procedure TW3RadioButton.setEnabled(aValue: Boolean);
begin
  FMark.Enabled := aValue;
  FLabel.Enabled := aValue;
end;

function TW3RadioButton.getCaption: String;
begin
  Result := FLabel.Caption;
end;

procedure TW3RadioButton.setCaption(aValue: String);
begin
  FLabel.Caption := aValue;
end;

procedure TW3RadioButton.Resize;
var
  dx, dy: Integer;
begin
  inherited;
  dy := (ClientHeight div 2) - (FMark.Height div 2);
  FMark.MoveTo(0,dy);
  dx := FMark.Left + FMark.Width + 1;
  FLabel.SetBounds(dx, 0, ClientWidth - dx, ClientHeight);
end;

end.
