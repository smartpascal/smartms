unit uReportC;

interface

uses
  uBaseReport;

type
  TReportC = class(TBaseReport)
  published
    function BuildReport: string; override;
  end;

implementation

function TReportC.BuildReport: string;
begin
  Result:=
    '.------..------..------.'#13#10 +
    '|S.--. ||M.--. ||S.--. |'#13#10 +
    '| :/\: || (\/) || :/\: |'#13#10 +
    '| :\/: || :\/: || :\/: |'#13#10 +
    '| ´--´S|| ´--´M|| ´--´S|'#13#10 +
    '`------´`------´`------´'#13#10;
end;

end.