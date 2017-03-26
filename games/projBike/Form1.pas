unit Form1;

interface

uses
  Smart.Core, Smart.Template,
  uDM1,
  ECMA.JSON, W3C.Console,
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    DM1: TDataModule1;
    Component1: TW3CustomControl;

  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure RenderTemplate(Const target: string; template: variant; dataSource: variant);
    procedure AttachEventHandlers;
  end;

implementation

var
  document external "document": variant;

var T_PAGE1 := #'
<header class="header-bar">
    <!--<a id="btn1" class="btn pull-left icon icon-menu"></a>-->
    <div class="center">
    	<h1 class="title">Challenges</h1>
    </div>
    <!--<a id="btn2" class="btn pull-right icon icon-settings"></a>-->
</header>
<div class="content"  style="position: relative;">

	<ul class="list">{{#each this}}
	    <li data-local="{{name}}">
	        <i class="pull-left icon icon-info-outline"></i>
	        <i class="pull-right icon icon-chevron-right"></i>
	        <a href="#link/{{@index}}" class="padded-list">{{this.name}}</a>
	        <div class="accordion-content">
	          Element 1
	        </div>
	    </li>{{/each}}
	</ul>
</div>';

var T_PAGE2 := #'
<header class="header-bar">
  <button id="btn3" class="btn pull-left icon icon-home with-circle"></button>
  <div class="center">
  	<h1 class="title">Mountains</h1>
  </div>
  <!--<button id="btn4" class="btn pull-right icon icon-arrow-forward with-circle"></button>-->
</header>
<div class="content" style="position: relative;">
<ul class="list"><li class="divider" style="background-color: #97C0DB;">{{name}}</li></ul>
	<ul class="list">{{#each mountains}}
	    <li data-owner="{{../name}}" data-place="{{name}}"">
	        <i class="pull-right icon icon-chevron-right"></i>
	        <a href="#link/{{@index}}" class="padded-list">{{this.name}}</a>
	        <div class="accordion-content">
	          Element 1
	        </div>
	    </li>{{/each}}
	</ul>
</div>';


var T_PAGE3 := #'
<header class="header-bar">
  <div class="left">
    <button id="btn5" class="btn pull-left icon icon-arrow-back" data-navigation="$previous-page"></button>
    <h1 class="title">Back</h1>
  </div>
</header>

<div class="content" style="position: relative;">
<div id="circle-shape-example">
  <img src="res/bike.jpg" class="curve"><h3>{{name}} - rank: {{rank}}</h3>
   <h6>{{elevation}} - {{ascent}} - {{distance}}</h6>
   <p>{{description}}</p>
   <p>{{trailhead}}</p>
</div>
</div>';


{ TForm1 }

procedure TForm1.RenderTemplate(Const target: string; template: variant; dataSource: variant);
begin
  var todoItemTemplate = CLASS
      render := Template7.compile( template  );
  END;
  var renderedList := todoItemTemplate.render(dataSource);
  SMS(target).html(renderedList);
end;

procedure TForm1.AttachEventHandlers;
begin
// there is no need to reattach the event handler on every dynamic DOM update
//   if you're defining them at document level
/* ╔════════════════════════════════════════╗
   ║ onChallenges click                     ║
   ╚════════════════════════════════════════╝ */

	SMS(document).on("click", "li[data-local]", procedure()
  begin
		var employeeId : variant = SMS(this).attr("data-local");

    DM1.findByChallengeId(employeeId, procedure(ds: variant)
    begin
      RenderTemplate('#component2', T_PAGE2, ds );
			Application.GotoForm('Form2', feToLeft);
		end);
	end);


/* ╔════════════════════════════════════════╗
   ║ onMountains click                      ║
   ╚════════════════════════════════════════╝ */

	SMS(document).on("click", "li[data-owner]", procedure()
  begin
		var ownerId : variant = SMS(this).attr("data-owner");
    var employeeId : variant = SMS(this).attr("data-place");
    DM1.findByChallenge(ownerId, employeeId, lambda(ds: variant)
      RenderTemplate('#component3', T_PAGE3, ds );
      Application.GotoForm('Form3', feToLeft);
		end);
	end);

/* ╔════════════════════════════════════════╗
   ║ onMenu ICON click                      ║
   ╚════════════════════════════════════════╝ */

	SMS(document).on("click", "#btn3", procedure()
  begin
    { HOME ICON CLICK }
    Application.gotoForm('Form1', feFromRight);
  end);

	SMS(document).on("click", "#btn5", procedure()
  begin
    { BACK ICON CLICK }
    Application.gotoForm('Form2', feToLeft);
  end);

end;


procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components

End;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  DM1:= TDataModule1.create;

(* COMPONENT 1 *)
  Component1 := TW3CustomControl.create(self);
  Component1.SetBounds(0,0,Self.ClientWidth, Self.ClientHeight);
  Component1.Handle.id := 'component1';
  Component1.Handle.className := '';
  Component1.Handle.ReadyExecute(procedure()
  begin
    Component1.Handle.style["width"] := null;
    Component1.Handle.style["height"] := null;
    Component1.Handle.style["width"] := '100%';
  end);

  Handle.ReadyExecute(procedure()
  begin
    RenderTemplate('#component1', T_PAGE1, DM1.challengesStore );
    { bind event handlers }
    AttachEventHandlers;
  end);

end;

procedure TForm1.Resize;
begin
  inherited;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.