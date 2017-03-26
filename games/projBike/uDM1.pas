unit uDM1;

interface

uses
  ECMA.JSON, W3C.HTML5, W3C.Console;

type
  JDataStore = variant;
  TCallback = procedure(data: JDataStore);

type
  TDataModule = class
end;

type
  TDataModule1 = class(TDataModule)
  private
    function GetChallengeStore: JDataStore;
  protected
    procedure callLater(callback: TCallback; data: JDataStore);
  public
    procedure findByChallengeId(localName: string; callback: TCallback);
    procedure findByChallenge(ownerName, localName: string; callback: TCallback);
  published
    property challengesStore: JDataStore read GetChallengeStore;
  end;


implementation

function TDataModule1.GetChallengeStore: JDataStore;
begin
  Result := JSON.parse('{"challenges":[{"name":"Tupper Lake Triad","description":"The Tupper Lake Triad is a series of three Family Friendly mountains in the immediate Tupper Lake Area.  They offer outstanding views for a minimal amount of effort.  All the mountains are summited via NYS DEC State maintained trails. Upon successful completion of the 3 climbs an individual may submit a completed form and be registered with a climbing number and receive a Triad Decal & Patch. There are 2 climbing seasons Winter and Spring thru Fall with a patch/decal for each season.","email":"unknown","website":"http://www.tupperlaketriad.com/","facebook":"https://www.facebook.com/groups/439814939683499/","address":"PO Box 795;Tupper Lake NY 12986","phone":"unknown","mountains":[{"rank":"1","name":"Mt. Arab","elevation":"2545\"","ascent":"764\"","distance":"1.1 miles","description":"Mt. Arab has a restored fire tower & observer\"s cabin at it\"s summit. There is a small museum located in the observer\"s cabin. The trail and tower are closed during big game season in the Fall. The trail is an excellent snowshoe trail","trailhead":"Take Rt3 from Tupper Lake toward Piercefield. Around 7.25 miles turn Left on to Conifer Road. Follow Conifer Road for about 2 miles and turn Left on to Mt Arab Road. After 1 mile, trailhead  is on left- parking on the Right."},{"rank":"2","name":"Coney Mtn","elevation":"2280\"","ascent":"548\"","distance":"1.1 miles","description":"Gradual looping trail leading to an open rock summit. Excellent view of Coney Mt in the distance. An excellent Snowshoe trail,","trailhead":"Take Rt#30 South from Tupper Lake. Parking area is on left side just before snowplow turnaround on the right."},{"rank":"3","name":"Goodman Mtn","elevation":"2178\"","ascent":"581","distance":"1.6 miles","description":"Trail begins at Lumberjack Spring. The first quarter mile is wheelchair accessible. Turning sharply left the trail steepens and ascends to the open summit. Coney Mt is visible in the distance. This is also a fine Snowshoe trail.","trailhead":"Take Rt#30 South from Tupper Lake. Parking is on the Left at Lumberjack Spring just before Coney Mt parking."}]},{"name":"Saranac Lake 6er","description":"The village of Saranac Lake introduced the Saranac Lake 6er program in 2013. The program challenges people to climb the six mountains listed above to earn a 6er patch. Adventurous hikers can do the mountains in the winter to earn the Winter 6er patch, or climb all of them in one day to become an Ultra 6er.","email":"info@saranaclake6er.com","website":"http://saranaclake6er.com/","facebook":"https://www.facebook.com/SaranacLake6er/","address":"39 Main St; Saranac Lake, NY 12983","phone":"518-891-4150","mountains":[{"rank":"1","name":"McKenzie","elevation":"3822"},{"rank":"2","name":"Ampersand","elevation":"3353"},{"rank":"3","name":"Scarface","elevation":"3054"},{"rank":"4","name":"St. Regis","elevation":"2874"},{"rank":"5","name":"Haystack","elevation":"2864"},{"rank":"6","name":"Baker","elevation":"2452"}]},{"name":"Lake George 12ster","description":"","email":"lakegeorge12ster@gmail.com","website":"http://www.lakegeorge12ster.com/","facebook":"https://www.facebook.com/lakegeorge12ster/","address":"unknown","phone":"518-504-0188","mountains":[{"rank":"1","name":"Black","elevation":"2665"},{"rank":"2","name":"Erebus","elevation":"2527"},{"rank":"3","name":"Sleeping Beauty","elevation":"2347"},{"rank":"4","name":"Buck","elevation":"2334"},{"rank":"5","name":"Five Mile","elevation":"2256"},{"rank":"6","name":"Huckleberry","elevation":"2232"},{"rank":"7","name":"Thomas","elevation":"2031"},{"rank":"8","name":"Brown","elevation":"1966"},{"rank":"9","name":"Cat","elevation":"1956"},{"rank":"10","name":"Fifth","elevation":"1813"},{"rank":"11","name":"French Point","elevation":"1756"},{"rank":"12","name":"First","elevation":"1586"}]},{"name":"ADK 46er","description":"","email":"46rfinisher@gmail.com","website":"http://adk46er.org/","facebook":"https://www.facebook.com/official.Adirondack.46ers/","address":"P.O. Box 46; Fort Edward, NY 12828","phone":"unknown","mountains":[{"rank":"1","name":"Marcy","elevation":"5344"},{"rank":"2","name":"Algonquin","elevation":"5114"},{"rank":"3","name":"Haystack","elevation":"4960"},{"rank":"4","name":"Skylight","elevation":"4926"},{"rank":"5","name":"Whiteface","elevation":"4867"},{"rank":"6","name":"Dix","elevation":"4857"},{"rank":"7","name":"Gray","elevation":"4840"},{"rank":"8","name":"Iroquois","elevation":"4840"},{"rank":"9","name":"Basin","elevation":"4827"},{"rank":"10","name":"Gothics","elevation":"4736"},{"rank":"11","name":"Colden","elevation":"4714"},{"rank":"12","name":"Giant","elevation":"4627"},{"rank":"13","name":"Nippletop","elevation":"4620"},{"rank":"14","name":"Santanoni","elevation":"4607"},{"rank":"15","name":"Redfield","elevation":"4606"},{"rank":"16","name":"Wright","elevation":"4580"},{"rank":"17","name":"Saddleback","elevation":"4515"},{"rank":"18","name":"Panther","elevation":"4442"},{"rank":"19","name":"TableTop","elevation":"4427"},{"rank":"20","name":"Rocky","elevation":"4420"},{"rank":"21","name":"Macomb","elevation":"4405"},{"rank":"22","name":"Armstrong","elevation":"4400"},{"rank":"23","name":"Hough","elevation":"4400"},{"rank":"24","name":"Seward","elevation":"4361"},{"rank":"25","name":"Marshall","elevation":"4360"},{"rank":"26","name":"Allen","elevation":"4340"},{"rank":"27","name":"Big Slide","elevation":"4240"},{"rank":"28","name":"Esther","elevation":"4240"},{"rank":"29","name":"Upper Wolf Jaw","elevation":"4285"},{"rank":"30","name":"Lower Wolf Jaw","elevation":"4175"},{"rank":"31","name":"Street","elevation":"4166"},{"rank":"32","name":"Phelps","elevation":"4161"},{"rank":"33","name":"Donaldson","elevation":"4140"},{"rank":"34","name":"Seymour","elevation":"4120"},{"rank":"35","name":"Sawteeth","elevation":"4100"},{"rank":"36","name":"Cascade","elevation":"4098"},{"rank":"37","name":"South Dix","elevation":"4060"},{"rank":"38","name":"Porter","elevation":"4059"},{"rank":"39","name":"Colvin","elevation":"4057"},{"rank":"40","name":"Emmons","elevation":"4040"},{"rank":"41","name":"Dial","elevation":"4020"},{"rank":"42","name":"Grace","elevation":"4012"},{"rank":"43","name":"Blake","elevation":"3960"},{"rank":"44","name":"Cliff","elevation":"3960"},{"rank":"45","name":"Nye","elevation":"3895"},{"rank":"46","name":"Couchsachraga","elevation":"3820"}]}]}').challenges;
end;

procedure TDataModule1.callLater(callback: TCallback; data: JDataStore);
begin
  (* Used to simulate async calls. This is done to provide a consistent interface
     with stores "like WebSqlStore"  that use async data access APIs
  *)
if assigned(callback) then
JWindowTimers(window).setTimeout(lambda
  //console.log('Start preloading');
  callback(data);
end, 0);
end;

procedure TDataModule1.findByChallengeId(localName: string; callback: TCallback);
var
  challenge, challenges: JDataStore;
  len: integer;

begin
  challenges:= challengesStore;
  len := challenges.length;

  for var i:= 0 to len -1 do
  begin
    if challenges[i].name = localName then
    begin
        challenge := challenges[i];
        break;
    end;
  end;
  callLater(callback, challenge);
end;


procedure TDataModule1.findByChallenge(ownerName, localName: string; callback: TCallback);
var
  challenge, employees: JDataStore;

Begin
  employees := challengesStore.filter(function(element: JDataStore): JDataStore
  begin
    result := element.name = ownerName;
      element.mountains.filter(function(ds: JDataStore): JDataStore
      begin
        if ds.name = localName then begin
          challenge := ds;
        end;
      end);
  end);
    callLater(callback, challenge);
end;

End.
