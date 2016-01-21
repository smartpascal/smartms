unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, SmartCL.Fonts,
  SmartCL.Borders, SmartCL.Application, SmartCL.Grid, SmartCL.Grid.Columns;

type
  TStudent = record
    Forename, Surname : string;
    TheoryMark, PracticalMark : integer;
  end;

  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    const MAX_STUDENTS = 3;
    Students : array[1 .. 3] of TStudent;
    TextCols : array [1 .. 4] of TW3TextColumn;
    RowCaptions : array[1 .. 4] of string := ['Forename', 'Surname', 'Theory Mark', 'Practical Mark'];
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
   end;

implementation

procedure TForm1.InitializeForm;
begin
  inherited;
  Students[1].Forename := 'Jo';
  Students[1].Surname :='Wood';
  Students[1].TheoryMark := 55;
  Students[1].PracticalMark := 66;

  Students[2].Forename := 'John';
  Students[2].Surname := 'Bode';
  Students[2].TheoryMark := 73;
  Students[2].PracticalMark := 58;

  Students[3].Forename := 'Kapil';
  Students[3].Surname := 'Shah';
  Students[3].TheoryMark := 59;
  Students[3].PracticalMark := 58;

  for var i := 1 to 4 do
    begin
      TextCols[i] := TW3TextColumn.Create(W3Grid1 as IW3ColumnsControl);
      TextCols[i].Header.Caption := RowCaptions[i];
      (TextCols[i].Header as TW3CustomControl).Font.Weight := 'bold';
      TextCols[i].Width := 110;
      W3Grid1.Columns.Add(TextCols[i]);
    end;
  W3Grid1.AddRow(MAX_STUDENTS);
  for var i := 0 to MAX_STUDENTS - 1 do
    begin
      W3Grid1.Cell[0, i].Value := Students[(i+1)].Forename;
      W3Grid1.Cell[1, i].Value := Students[(i+1)].Surname;
      W3Grid1.Cell[2, i].Value := intToStr(Students[(i+1)].TheoryMark);
      W3Grid1.Cell[3, i].Value := intToStr(Students[(i+1)].PracticalMark);
    end;
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
