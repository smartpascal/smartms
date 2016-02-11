unit Form337;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Layout, SmartCL.Controls.Button;

type
  TForm337 = class(TW3Form)
  private
    {$I 'Form337:intf'}
    btn: Array of TW3Button;
    fLayout: TLayout;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
  end;  

implementation
uses Unit1;
{ TForm337 }

procedure TForm337.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
 WriteLn('InitializeForm was called');
  fLayout:= Layout.Client(Layout.Margins(10),[Layout.Left(Layout.Stretch,[btn[0],btn[1],btn[2],btn[3],btn[4],btn[5],btn[6],btn[7],btn[8],btn[9],btn[10],btn[11],btn[12],btn[13],btn[14],btn[15],btn[16],btn[17],btn[18],btn[19],btn[20],btn[21],btn[22],btn[23],btn[24],btn[25],btn[26],btn[27],btn[28],btn[29],btn[30],btn[31],btn[32],btn[33],btn[34],btn[35],btn[36],btn[37],btn[38],btn[39],btn[40],btn[41],btn[42],btn[43],btn[44],btn[45],btn[46],btn[47],btn[48],btn[49],btn[50],btn[51],btn[52],btn[53],btn[54],btn[55],btn[56],btn[57],btn[58],btn[59],btn[60],btn[61],btn[62],btn[63],btn[64],btn[65],btn[66],btn[67],btn[68],btn[69],btn[70],btn[71],btn[72],btn[73],btn[74],btn[75],btn[76],btn[77],btn[78],btn[79],btn[80],btn[81],btn[82],btn[83],btn[84],btn[85],btn[86],btn[87],btn[88],btn[89],btn[90],btn[91],btn[92],btn[93],btn[94],btn[95],btn[96],btn[97],btn[98],btn[99]/*,btn[100],btn[101],btn[102],btn[103],btn[104],btn[105],btn[106],btn[107],btn[108],btn[109],btn[110],btn[111],btn[112],btn[113],btn[114],btn[115],btn[116],btn[117],btn[118],btn[119],btn[120],btn[121],btn[122],btn[123],btn[124],btn[125],btn[126],btn[127],btn[128],btn[129],btn[130],btn[131],btn[132],btn[133],btn[134],btn[135],btn[136],btn[137],btn[138],btn[139],btn[140],btn[141],btn[142],btn[143],btn[144],btn[145],btn[146],btn[147],btn[148],btn[149],btn[150],btn[151],btn[152],btn[153],btn[154],btn[155],btn[156],btn[157],btn[158],btn[159],btn[160],btn[161],btn[162],btn[163],btn[164],btn[165],btn[166],btn[167],btn[168],btn[169],btn[170],btn[171],btn[172],btn[173],btn[174],btn[175],btn[176],btn[177],btn[178],btn[179],btn[180],btn[181],btn[182],btn[183],btn[184],btn[185],btn[186],btn[187],btn[188],btn[189],btn[190],btn[191],btn[192],btn[193],btn[194],btn[195],btn[196],btn[197],btn[198],btn[199],btn[200],btn[201],btn[202],btn[203],btn[204],btn[205],btn[206],btn[207],btn[208],btn[209],btn[210],btn[211],btn[212],btn[213],btn[214],btn[215],btn[216],btn[217],btn[218],btn[219],btn[220],btn[221],btn[222],btn[223],btn[224],btn[225],btn[226],btn[227],btn[228],btn[229],btn[230],btn[231],btn[232],btn[233],btn[234],btn[235],btn[236],btn[237],btn[238],btn[239],btn[240],btn[241],btn[242],btn[243],btn[244],btn[245],btn[246],btn[247],btn[248],btn[249],btn[250],btn[251],btn[252],btn[253],btn[254],btn[255],btn[256],btn[257],btn[258],btn[259],btn[260],btn[261],btn[262],btn[263],btn[264],btn[265],btn[266],btn[267],btn[268],btn[269],btn[270],btn[271],btn[272],btn[273],btn[274],btn[275],btn[276],btn[277],btn[278],btn[279],btn[280],btn[281],btn[282],btn[283],btn[284],btn[285],btn[286],btn[287],btn[288],btn[289],btn[290],btn[291],btn[292],btn[293],btn[294],btn[295],btn[296],btn[297],btn[298],btn[299],btn[300],btn[301],btn[302],btn[303],btn[304],btn[305],btn[306],btn[307],btn[308],btn[309],btn[310],btn[311],btn[312],btn[313],btn[314],btn[315],btn[316],btn[317],btn[318],btn[319],btn[320],btn[321],btn[322],btn[323],btn[324],btn[325],btn[326],btn[327],btn[328],btn[329],btn[330],btn[331],btn[332],btn[333],btn[334],btn[335],btn[336],btn[337],btn[338],btn[339],btn[340],btn[341],btn[342],btn[343],btn[344],btn[345],btn[346],btn[347],btn[348],btn[349],btn[350],btn[351],btn[352],btn[353],btn[354],btn[355],btn[356],btn[357],btn[358],btn[359],btn[360],btn[361],btn[362],btn[363],btn[364],btn[365],btn[366],btn[367],btn[368],btn[369],btn[370],btn[371],btn[372],btn[373],btn[374],btn[375],btn[376],btn[377],btn[378],btn[379],btn[380],btn[381],btn[382],btn[383],btn[384],btn[385],btn[386],btn[387],btn[388],btn[389],btn[390],btn[391],btn[392],btn[393],btn[394],btn[395],btn[396],btn[397],btn[398],btn[399],btn[400],btn[401],btn[402],btn[403],btn[404],btn[405],btn[406],btn[407],btn[408],btn[409],btn[410],btn[411],btn[412],btn[413],btn[414],btn[415],btn[416],btn[417],btn[418],btn[419],btn[420],btn[421],btn[422],btn[423],btn[424],btn[425],btn[426],btn[427],btn[428],btn[429],btn[430],btn[431],btn[432],btn[433],btn[434],btn[435],btn[436],btn[437],btn[438],btn[439],btn[440],btn[441],btn[442],btn[443],btn[444],btn[445],btn[446],btn[447],btn[448],btn[449],btn[450],btn[451],btn[452],btn[453],btn[454],btn[455],btn[456],btn[457],btn[458],btn[459],btn[460],btn[461],btn[462],btn[463],btn[464],btn[465],btn[466],btn[467],btn[468],btn[469],btn[470],btn[471],btn[472],btn[473],btn[474],btn[475],btn[476],btn[477],btn[478],btn[479],btn[480],btn[481],btn[482],btn[483],btn[484],btn[485],btn[486],btn[487],btn[488],btn[489],btn[490],btn[491],btn[492],btn[493],btn[494],btn[495],btn[496],btn[497],btn[498],btn[499],btn[500]*/])]);
end;

procedure TForm337.InitializeObject;
begin
  inherited;
  {$I 'Form337:impl'}
 WriteLn('InitializeObject called');
  for var i:= 0 to 99 do begin
   btn[i] := TW3Button.Create(Self);
   btn[i].Caption := 'btn'+IntToStr(i);
  end;
end;
 
procedure TForm337.Resize;
begin
  inherited;
  WriteLn('Resize event was called');
  if assigned(fLayout) then
    fLayout.Resize(self);
end;

procedure TForm.FormActivated;
Begin
  inherited;
  TApplication(application).BackNextButton;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm337);
end.
