package ab.iso{
	import flash.display.Bitmap;

	public class IsoSprite extends Bitmap{

        private static var _IDCount : uint = 0;

        private const UID : uint = _IDCount++;

        private var _id : String;

		public function get id() : String {
			return (_id == null || _id == "") ? "node_" + UID.toString() : _id;
		}

		public function set id(id : String) : void {
			_id = id;
		}

        protected var space_pos : Pt3D = new Pt3D();

        public function set_ox(value : Number) : void {
            space_pos.x = value;            
            pos_validated = false;
        }

        public function set_oy(value : Number) : void {
            space_pos.y = value;
            pos_validated = false;
        }

        public function set_oz(value : Number) : void {
            space_pos.z = value;
            pos_validated = false;
        }

        public function set_pos(x : Number, y : Number, z : Number) : void {
            space_pos.x = x;
            space_pos.y = y;
            space_pos.z = z;

            pos_validated = false;
        }

        public var o_width : Number = 0;
        public var o_length : Number = 0;
        public var o_height : Number = 0;

        public function set_size(ow : Number, ol : Number, oh : Number) : void {
           o_width = ow;
           o_length = ol;
           o_height = oh;
        }

        protected var pos_validated : Boolean = false;

        protected var img_validated : Boolean = false;

        public function get validated() : Boolean {
            return pos_validated && img_validated;
        }

        public var mouseEnabled : Boolean = false;

        public function IsoSprite() : void {

        }

        public function render() : void {
    	         
        }

        protected var screen_pos : Pt2D = new Pt2D();

        public function validate_pos() : void {
            if(!pos_validated){
                space_pos.spaceToScreen(screen_pos);

                x = screen_pos.x;
                y = screen_pos.y;
            }

            pos_validated = true;
        }

        public function validate_img() : void {
            img_validated = true;
        }

        public function get renderData() : RenderData {
            return null;
        }
	}
}
