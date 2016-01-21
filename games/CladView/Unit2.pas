unit Unit2;

interface

uses
  System.Colors, System.Types, SmartCL.System, SmartCL.Controls,
  SmartCL.Controls.Image,
  SmartCL.Layout;

type

  TXControl = class(TW3Panel)
  private
    FLayout: TLayout;

    FImage: TW3Image;
    FTotalLabel: TW3Label;
    FQtyLabel: TW3Label;
    FFaceLabel: TW3Label;
    FDenomLabel: TW3Label;

    FImageUrl: String;
    FDenomination: String;
    FFaceValue: Float;
    FQty: Integer;
    FTotal: Float;

  protected

    procedure SetQty(const aValue: Integer); virtual;
    Function GetTotal: Float; virtual;
    procedure SetFaceValue(const aValue: Float); virtual;
    procedure SetDenomination(const aValue: String); virtual;
    procedure SetImageUrl(const aValue: String); virtual;

    procedure InitializeObject; override;
    procedure FinalizeObject; override;
    procedure Resize; override;
  public
    property ImageUrl: String read FImageUrl write SetImageUrl;
    property Denomination: String read FDenomination write SetDenomination;
    property FaceValue: Float read FFaceValue write SetFaceValue;
    property Qty: Integer read FQty write SetQty;
    property Total: Float read GetTotal;
  end;

implementation

Function TXControl.GetTotal: Float;
begin
  result := FQty * FFaceValue;
end;

procedure TXControl.SetQty(const aValue: Integer);
begin
  if aValue <> FQty then
  begin
    BeginUpdate;
    FQty := aValue;
    FTotal := FQty * FFaceValue;
    FQtyLabel.Caption := IntToStr(FQty);
    FTotalLabel.Caption := '$' + format('%0.2f', [FTotal]);
    EndUpdate;
  end;
end;

procedure TXControl.SetFaceValue(const aValue: Float);
begin
  if aValue <> FFaceValue then
  begin
    BeginUpdate;
    FFaceValue := aValue;
    FFaceLabel.Caption := '$' + format('%0.2f', [FFaceValue]);
    EndUpdate;
  end;
end;

procedure TXControl.SetDenomination(const aValue: String);
begin
  if aValue <> FImageUrl then
  begin
    BeginUpdate;
    FDenomination := aValue;
    FDenomLabel.Caption := FDenomination;
    EndUpdate;
  end;
end;

procedure TXControl.SetImageUrl(const aValue: String);
begin
  if aValue <> FImageUrl then
  begin
    BeginUpdate;
    FImageUrl := aValue;
    FImage.LoadFromURL(FImageUrl);
    EndUpdate;
  end;
end;

procedure TXControl.InitializeObject;
begin
  inherited;

  FImage := TW3Image.Create(Self);
  FImage.LoadFromURL(FImageUrl);

  FLayout := Layout.Left(Layout.Stretch, [FImage]);

  { FDenomLabel:= TW3Label.Create(Self);
    FDenomLabel.AlignText:= taLeft;
    FDenomLabel.Caption:= FDenomination;
    FDenomLabel.Width:= 100;

    FFaceLabel:= TW3Label.Create(Self);
    FFaceLabel.AlignText:= taCenter;
    FFaceLabel.Caption:= '$' + format('%0.2f', [FFaceValue]);
    FFaceLabel.Width:= 100;


    FQtyLabel:= TW3Label.Create(Self);
    FQtyLabel.AlignText:= taCenter;
    FQtyLabel.Caption:= IntToStr(FQty);
    FQtyLabel.Width:= 100;

    FTotalLabel:= TW3Label.Create(Self);
    FTotalLabel.AlignText:= taRight;
    FTotalLabel.Caption:= IntToStr(FQty);
    FTotalLabel.Width:= 100; }



  // FLayout:= Layout.Left(Layout.Stretch, [FImage, FDenomLabel, FFaceLabel, FQtyLabel, FTotalLabel]);

end;

procedure TXControl.FinalizeObject;
begin
  FImage.Free;
  FImage := nil;

  // FDenomLabel.Free;
  // FDenomLabel:= nil;

  // FFaceLabel.Free;
  // FFaceLabel:= nil;

  // FQtyLabel.Free;
  // FQtyLabel:= nil;

  // FTotalLabel.Free;
  // FTotalLabel:= nil;

  inherited;
end;

procedure TXControl.Resize;
begin
  inherited;
  FLayout.Resize(Self);
end;

end.
