unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Layout,
  SmartCL.Controls.Image, SmartCL.Controls.Label, SmartCL.Controls.Button,
  SmartCL.Controls.EditBox, SmartCL.Controls.Panel;

type
  TForm1 = class(TW3Form)
  private
{$I 'Form1:intf'}
    fOldValue: Variant;
    fLayout: TLayout;

    fCentImg: TW3Image;
    fPennyImg: TW3Image;
    fNickelImg: TW3Image;
    fDimeImg: TW3Image;
    fQuarterImg: TW3Image;
    fHalfImg: TW3Image;
    fDollarImg: TW3Image;

    fDenomHdr: TW3Label;
    fFaceHdr: TW3Label;
    fTotalHdr: TW3Label;
    fQtyHdr: TW3Label;

    fSpacer1: TW3Panel;
    fSpacer2: TW3Panel;

    fPennyDenom: TW3Label;
    fPennyFace: TW3Label;
    fPennyTotal: TW3Label;

    fNickelDenom: TW3Label;
    fNickelFace: TW3Label;
    fNickelTotal: TW3Label;

    fDimeDenom: TW3Label;
    fDimeFace: TW3Label;
    fDimeTotal: TW3Label;

    fQuarterDenom: TW3Label;
    fQuarterFace: TW3Label;
    fQuarterTotal: TW3Label;

    fHalfDenom: TW3Label;
    fHalfFace: TW3Label;
    fHalfTotal: TW3Label;

    fDollarDenom: TW3Label;
    fDollarFace: TW3Label;
    fDollarTotal: TW3Label;

    fPennyEdit: TW3EditBox;
    fNickelEdit: TW3EditBox;
    fDimeEdit: TW3EditBox;
    fQuarterEdit: TW3EditBox;
    fHalfEdit: TW3EditBox;
    fDollarEdit: TW3EditBox;

    fGrandTotal: TW3Label;
    procedure UpdateGrandTotal;
  protected
    procedure EditGotFocus(Sender: TObject);
    procedure EditChanged(Sender: TObject);
    procedure EditKeyUp(Sender: TObject; aKeyCode: integer);
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm1 }

procedure TForm1.UpdateGrandTotal;
begin
  fGrandTotal.Caption := 'GRAND TOTAL: ' + format('$%0.2f',
    [integer(fPennyEdit.Value) * 0.01 + integer(fNickelEdit.Value) * 0.05 +
    integer(fDimeEdit.Value) * 0.10 + integer(fQuarterEdit.Value) * 0.25 +
    integer(fHalfEdit.Value) * 0.50 + integer(fDollarEdit.Value) * 1.00]);
end;

procedure TForm1.EditGotFocus(Sender: TObject);
begin
  fOldValue := TW3EditBox(Sender).Value;
end;

procedure TForm1.EditChanged(Sender: TObject);
begin
  fOldValue := TW3EditBox(Sender).Value;

  case TW3EditBox(Sender).TagValue of
    1:
      begin
        fPennyTotal.Caption :=
          format('$%0.2f', [integer(TW3EditBox(Sender).Value) * 0.01]);
      end;
    5:
      begin
        fNickelTotal.Caption :=
          format('$%0.2f', [integer(TW3EditBox(Sender).Value) * 0.05]);
      end;
    10:
      begin
        fDimeTotal.Caption :=
          format('$%0.2f', [integer(TW3EditBox(Sender).Value) * 0.10]);
      end;
    25:
      begin
        fQuarterTotal.Caption :=
          format('$%0.2f', [integer(TW3EditBox(Sender).Value) * 0.25]);
      end;
    50:
      begin
        fHalfTotal.Caption :=
          format('$%0.2f', [integer(TW3EditBox(Sender).Value) * 0.50]);
      end;
    100:
      begin
        fDollarTotal.Caption :=
          format('$%0.2f', [integer(TW3EditBox(Sender).Value) * 1.00]);
      end;
  end;
  UpdateGrandTotal;
end;

procedure TForm1.EditKeyUp(Sender: TObject; aKeyCode: integer);
begin
  if not(aKeyCode in [8, 48 .. 57, 96 .. 105]) then
    TW3EditBox(Sender).Value := fOldValue;
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
  fCentImg := TW3Image.Create(self);
  fCentImg.LoadFromURL('res\cent.png');
  fCentImg.Width := 50;
  fCentImg.Height := 50;

  fPennyImg := TW3Image.Create(self);
  fPennyImg.LoadFromURL('res\penny.png');
  fPennyImg.Width := 50;
  fPennyImg.Height := 50;

  fNickelImg := TW3Image.Create(self);
  fNickelImg.LoadFromURL('res\nickel.png');
  fNickelImg.Width := 50;
  fNickelImg.Height := 50;

  fDimeImg := TW3Image.Create(self);
  fDimeImg.LoadFromURL('res\dime.png');
  fDimeImg.Width := 50;
  fDimeImg.Height := 50;

  fQuarterImg := TW3Image.Create(self);
  fQuarterImg.LoadFromURL('res\quarter.png');
  fQuarterImg.Width := 50;
  fQuarterImg.Height := 50;

  fHalfImg := TW3Image.Create(self);
  fHalfImg.LoadFromURL('res\halfdollar.png');
  fHalfImg.Width := 50;
  fHalfImg.Height := 50;

  fDollarImg := TW3Image.Create(self);
  fDollarImg.LoadFromURL('res\dollar.png');
  fDollarImg.Width := 50;
  fDollarImg.Height := 50;

  fDenomHdr := TW3Label.Create(self);
  fDenomHdr.AlignText := taLeft;
  fDenomHdr.Caption := 'DENOM';
  fDenomHdr.Width := 76;
  fDenomHdr.Height := 25;

  fFaceHdr := TW3Label.Create(self);
  fFaceHdr.AlignText := taCenter;
  fFaceHdr.Caption := 'FACE';
  fFaceHdr.Width := 50;
  fFaceHdr.Height := 25;

  fQtyHdr := TW3Label.Create(self);
  fQtyHdr.AlignText := taCenter;
  fQtyHdr.Caption := 'QTY';
  fQtyHdr.Width := 50;
  fQtyHdr.Height := 25;

  fTotalHdr := TW3Label.Create(self);
  fTotalHdr.AlignText := taRight;
  fTotalHdr.Caption := 'TOTAL';
  fTotalHdr.Width := 52;
  fTotalHdr.Height := 25;

  fSpacer1 := TW3Panel.Create(self);
  fSpacer1.Height := 5;

  fPennyDenom := TW3Label.Create(self);
  fPennyDenom.Caption := 'Penny';
  fPennyDenom.Width := 76;
  fPennyDenom.Height := 25;

  fPennyFace := TW3Label.Create(self);
  fPennyFace.AlignText := taCenter;
  fPennyFace.Caption := '$0.01';
  fPennyFace.Width := 50;
  fPennyFace.Height := 25;

  fPennyTotal := TW3Label.Create(self);
  fPennyTotal.AlignText := taRight;
  fPennyTotal.Caption := '$0.00';
  fPennyTotal.Width := 52;
  fPennyTotal.Height := 25;

  fNickelDenom := TW3Label.Create(self);
  fNickelDenom.Caption := 'Nickel';
  fNickelDenom.Width := 76;
  fNickelDenom.Height := 25;

  fNickelFace := TW3Label.Create(self);
  fNickelFace.AlignText := taCenter;
  fNickelFace.Caption := '$0.05';
  fNickelFace.Width := 50;
  fNickelFace.Height := 25;

  fNickelTotal := TW3Label.Create(self);
  fNickelTotal.AlignText := taRight;
  fNickelTotal.Caption := '$0.00';
  fNickelTotal.Width := 52;
  fNickelTotal.Height := 25;

  fDimeDenom := TW3Label.Create(self);
  fDimeDenom.Caption := 'Dime';
  fDimeDenom.Width := 76;
  fDimeDenom.Height := 25;

  fDimeFace := TW3Label.Create(self);
  fDimeFace.AlignText := taCenter;
  fDimeFace.Caption := '$0.10';
  fDimeFace.Width := 50;
  fDimeFace.Height := 25;

  fDimeTotal := TW3Label.Create(self);
  fDimeTotal.AlignText := taRight;
  fDimeTotal.Caption := '$0.00';
  fDimeTotal.Width := 52;
  fDimeTotal.Height := 25;

  fQuarterDenom := TW3Label.Create(self);
  fQuarterDenom.Caption := 'Quarter';
  fQuarterDenom.Width := 76;
  fQuarterDenom.Height := 25;

  fQuarterFace := TW3Label.Create(self);
  fQuarterFace.AlignText := taCenter;
  fQuarterFace.Caption := '$0.25';
  fQuarterFace.Width := 50;
  fQuarterFace.Height := 25;

  fQuarterTotal := TW3Label.Create(self);
  fQuarterTotal.AlignText := taRight;
  fQuarterTotal.Caption := '$0.00';
  fQuarterTotal.Width := 52;
  fQuarterTotal.Height := 25;

  fHalfDenom := TW3Label.Create(self);
  fHalfDenom.Caption := 'Half-Dollar';
  fHalfDenom.Width := 76;
  fHalfDenom.Height := 25;

  fHalfFace := TW3Label.Create(self);
  fHalfFace.AlignText := taCenter;
  fHalfFace.Caption := '$0.50';
  fHalfFace.Width := 50;
  fHalfFace.Height := 25;

  fHalfTotal := TW3Label.Create(self);
  fHalfTotal.AlignText := taRight;
  fHalfTotal.Caption := '$0.00';
  fHalfTotal.Width := 52;
  fHalfTotal.Height := 25;

  fDollarDenom := TW3Label.Create(self);
  fDollarDenom.Caption := 'Dollar';
  fDollarDenom.Width := 76;
  fDollarDenom.Height := 25;

  fDollarFace := TW3Label.Create(self);
  fDollarFace.AlignText := taCenter;
  fDollarFace.Caption := '$1.00';
  fDollarFace.Width := 50;
  fDollarFace.Height := 25;

  fDollarTotal := TW3Label.Create(self);
  fDollarTotal.AlignText := taRight;
  fDollarTotal.Caption := '$0.00';
  fDollarTotal.Width := 52;
  fDollarTotal.Height := 25;

  fPennyEdit := TW3EditBox.Create(self);
  fPennyEdit.Height := 24;
  fPennyEdit.Width := 48;
  fPennyEdit.InputType := itNumber;
  fPennyEdit.setMin(0);
  fPennyEdit.setMax(100);
  fPennyEdit.TextAlign := taCenter;
  fPennyEdit.Text := '0';
  fPennyEdit.TagValue := 1;
  fPennyEdit.OnChanged := EditChanged;
  fPennyEdit.OnKeyUp := EditKeyUp;

  fNickelEdit := TW3EditBox.Create(self);
  fNickelEdit.Height := 24;
  fNickelEdit.Width := 48;
  fNickelEdit.InputType := itNumber;
  fNickelEdit.setMin(0);
  fNickelEdit.setMax(100);
  fNickelEdit.TextAlign := taCenter;
  fNickelEdit.Text := '0';
  fNickelEdit.TagValue := 5;
  fNickelEdit.OnChanged := EditChanged;
  fNickelEdit.OnKeyUp := EditKeyUp;

  fDimeEdit := TW3EditBox.Create(self);
  fDimeEdit.Height := 24;
  fDimeEdit.Width := 48;
  fDimeEdit.InputType := itNumber;
  fDimeEdit.setMin(0);
  fDimeEdit.setMax(100);
  fDimeEdit.TextAlign := taCenter;
  fDimeEdit.Text := '0';
  fDimeEdit.TagValue := 10;
  fDimeEdit.OnChanged := EditChanged;
  fDimeEdit.OnKeyUp := EditKeyUp;

  fQuarterEdit := TW3EditBox.Create(self);
  fQuarterEdit.Height := 24;
  fQuarterEdit.Width := 48;
  fQuarterEdit.InputType := itNumber;
  fQuarterEdit.setMin(0);
  fQuarterEdit.setMax(100);
  fQuarterEdit.TextAlign := taCenter;
  fQuarterEdit.Text := '0';
  fQuarterEdit.TagValue := 25;
  fQuarterEdit.OnChanged := EditChanged;
  fQuarterEdit.OnKeyUp := EditKeyUp;

  fHalfEdit := TW3EditBox.Create(self);
  fHalfEdit.Height := 24;
  fHalfEdit.Width := 48;
  fHalfEdit.InputType := itNumber;
  fHalfEdit.setMin(0);
  fHalfEdit.setMax(100);
  fHalfEdit.TextAlign := taCenter;
  fHalfEdit.Text := '0';
  fHalfEdit.TagValue := 50;
  fHalfEdit.OnChanged := EditChanged;
  fHalfEdit.OnKeyUp := EditKeyUp;

  fDollarEdit := TW3EditBox.Create(self);
  fDollarEdit.Height := 24;
  fDollarEdit.Width := 48;
  fDollarEdit.InputType := itNumber;
  fDollarEdit.setMin(0);
  fDollarEdit.setMax(100);
  fDollarEdit.TextAlign := taCenter;
  fDollarEdit.Text := '0';
  fDollarEdit.TagValue := 100;
  fDollarEdit.OnChanged := EditChanged;
  fDollarEdit.OnKeyUp := EditKeyUp;
  fDollarEdit.OnGotFocus := EditGotFocus;

  fSpacer2 := TW3Panel.Create(self);
  fSpacer2.Height := 5;

  fGrandTotal := TW3Label.Create(self);
  fGrandTotal.AlignText := taRight;
  fGrandTotal.Caption := 'GRAND TOTAL: $0.00';
  fGrandTotal.Height := 25;

  fLayout := Layout.Client(Layout.Margins(2).Spacing(2),
    // header
    [Layout.Top(Layout.Height(50), Layout.Left(Layout.Spacing(10),
    [fCentImg, fDenomHdr, fFaceHdr, fQtyHdr, fTotalHdr])),
    // spacer
    Layout.Top(Layout.Height(5), [fSpacer1]),
    // penny
    Layout.Top(Layout.Height(50), Layout.Left(Layout.Spacing(10),
    [fPennyImg, fPennyDenom, fPennyFace, fPennyEdit, fPennyTotal])),
    // nickel
    Layout.Top(Layout.Height(50), Layout.Left(Layout.Spacing(10),
    [fNickelImg, fNickelDenom, fNickelFace, fNickelEdit, fNickelTotal])),
    // dime
    Layout.Top(Layout.Height(50), Layout.Left(Layout.Spacing(10),
    [fDimeImg, fDimeDenom, fDimeFace, fDimeEdit, fDimeTotal])),
    // quarter
    Layout.Top(Layout.Height(50), Layout.Left(Layout.Spacing(10),
    [fQuarterImg, fQuarterDenom, fQuarterFace, fQuarterEdit, fQuarterTotal])),
    // half
    Layout.Top(Layout.Height(50), Layout.Left(Layout.Spacing(10),
    [fHalfImg, fHalfDenom, fHalfFace, fHalfEdit, fHalfTotal])),
    // dollar
    Layout.Top(Layout.Height(50), Layout.Left(Layout.Spacing(10),
    [fDollarImg, fDollarDenom, fDollarFace, fDollarEdit, fDollarTotal])),
    // spacer
    Layout.Top(Layout.Height(5), [fSpacer2]),

    // grandtotal
    Layout.Top(Layout.Height(25), [fGrandTotal])

    ]);
end;

procedure TForm1.Resize;
begin
  inherited;
  fLayout.Resize(self);
end;

initialization

Forms.RegisterForm({$I %FILE%}, TForm1);

end.
