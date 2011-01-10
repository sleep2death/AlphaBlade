package ab.base{
	import flash.display.BitmapData;

	import ab.iso.IsoSprite;
	import ab.iso.Pt3D;
	import ab.iso.Pt2D;
	import ab.iso.ExternalMovieClipLoader;

	public class Character extends IsoSprite {

		//Character Type
		public static const PREFIX : String = "c";
		public static const ASSETS_URL : String = "../assets/";

		public static const PREFIX_X : int = -116;
		public static const PREFIX_Y : int = -193;

		//Actions
		public static const WALK : int = 0;	

		public static const TOTAL_FRAMES : Array = [11];	

		public static const PER_ANGLE : Number = Math.PI/8;
		
		//Direction from 0~15

		public var character_type : int = 0;

		public var direction : int = 0;
		
		public var action : int = WALK;

		public var current_frame : int = 0;

		public var speed : int = 2;

		public function Character() : void {
			pos_validated = false;
		}

		public override function render() : void {

			validate_img();

			validate_pos();
		}

		public override function validate_img() : void {
			if(current_frame < TOTAL_FRAMES[action]){
				current_frame++;
			}else{
				current_frame = 0;
			}

			var img_name : String = PREFIX.concat("_").concat(action).concat("_").concat(direction).concat("_").concat(current_frame);
			ExternalMovieClipLoader.getBitmapDataFromURL(ASSETS_URL + "character_0.swf", img_name, onGetBitmapData);

		}

		public function onGetBitmapData(bd : BitmapData) : void {
			bitmapData = bd;
		}

        public override function validate_pos() : void {
            if(!pos_validated){
                space_pos.spaceToScreen(screen_pos);

				x = screen_pos.x + PREFIX_X;
				y = screen_pos.y + PREFIX_Y;

				pos_validated = true;
            }
        }

		public var isMoving : Boolean = false;
		public var target3D : Pt3D = new Pt3D();

		public function moveTo(target2D : Pt2D) : void {
			if(validatePoint(target2D)){
				target2D.screenToSpace(target3D);

				var dx : Number = target2D.x - screen_pos.x;
				var dy : Number = target2D.y - screen_pos.y;

				var angle : Number = Math.atan2(dy, dx);
				var dir : int = Math.round(angle/PER_ANGLE);

				if(dir < 4){
					direction = 12 + dir;
				}else if(dir > 4){
					direction = dir - 4;
				}else{
					direction = 0;
				}

				isMoving = true;
			}
		}

		protected function validatePoint(target2D : Pt2D) : Boolean {
			return true;
		}

	}
}
