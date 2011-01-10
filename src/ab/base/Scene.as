package ab.base{
	import flash.events.MouseEvent;
	import flash.events.Event;

	import ab.iso.IsoView;
	import ab.iso.IsoLayer;
	import ab.iso.Pt2D;
	import ab.iso.Pt3D;

	public class Scene extends IsoView{
		public static const SCREEN_WIDTH : int = 750;
		public static const SCREEN_HEIGHT : int = 450;

		public static const CENTER_X : int = 375;
		public static const CENTER_Y : int = 225;

		public static const PREFIX_X : int = 0;
		public static const PREFIX_Y : int = 40;

		public function Scene() : void {
		}

		private var characters : IsoLayer;

		private var myCharacter : Character;

		public override function init() : void {
			super.init();

			characters = new IsoLayer();

			myCharacter = new Character();
			characters.addChild(myCharacter);

			addLayer(characters);

			this.start();
		}

		public var mouse2D : Pt2D = new Pt2D();

		public override function onMouseDown(evt : MouseEvent) : void {
			mouse2D.x = this.mouseX;
			mouse2D.y = this.mouseY;

			//mouse2D.screenToSpace(mouse3D);
			myCharacter.moveTo(mouse2D);
		}

		public override function onRendering(evt : Event) : void {
           for(var i : int = 0; i < length; i++) {
               var layer : IsoLayer = children[i];
               layer.render();
           }

		   lockToCenter();
		}

		protected function lockToCenter() : void {
			this.x = myCharacter.screen_pos.x + CENTER_X;
			this.y = myCharacter.screen_pos.y + CENTER_Y + 40;
		}
	}
}
