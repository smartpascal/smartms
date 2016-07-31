unit uReportB;

interface

uses
  uBaseReport;

type
  TReportB = class(TBaseReport)
  published
    function BuildReport: string; override;
  end;

implementation

function TReportB.BuildReport: string;
begin
  Result:=
    '   .-´´´-. ,---.    ,---.   .-´´´-.  '#13#10 +
    '  / _     \|    \  /    |  / _     \ '#13#10 +
    ' (`´ )/`--´|  ,  \/  ,  | (`´ )/`--´ '#13#10 +
    '(_ o _).   |  |\_   /|  |(_ o _).    '#13#10 +
    ' (_,_). ´. |  _( )_/ |  | (_,_). ´.  '#13#10 +
    '.---.  \  :| (_ o _) |  |.---.  \  : '#13#10 +
    '\    `-´  ||  (_,_)  |  |\    `-´  | '#13#10 +
    ' \       / |  |      |  | \       / '#13#10 +
    '  `-...-´  ´--´      ´--´  `-...-´ '#13#10;
end;

end.