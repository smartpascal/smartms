unit uReportA;

interface

uses 
  uBaseReport;

type
  TReportA = class(TBaseReport)
  published
    function BuildReport: string; override;
  end;

implementation

function TReportA.BuildReport: string;
begin
  Result:=
    ' (`-´).-><-. (`-´)   (`-´).-> '#13#10 +
    ' ( OO)_     \(OO )_  ( OO)_   '#13#10 +
    '(_)--\_) ,--./  ,-.)(_)--\_)  '#13#10 +
    '/    _ / |   `.´   |/    _ /  '#13#10 +
    '\_..`--. |  |´.´|  |\_..`--.  '#13#10 +
    '.-._)   \|  |   |  |.-._)   \ '#13#10 +
    '\       /|  |   |  |\       / '#13#10 +
    ' `-----´ `--´   `--´ `-----´  '#13#10;
end;

end.