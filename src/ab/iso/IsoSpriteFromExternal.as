package ab.iso {
    import flash.display.MovieClip;

    public class IsoSpriteFromExternal extends IsoSprite {

        protected var _url : String;

        protected var _mc_name : String;

        protected var _mc : MovieClip;

        protected var _current_frame : uint = 1;

        protected var _total_frames : uint = 0;

        protected var _rd_id : String;

        public function IsoSpriteFromExternal() : void {
             
        }

        public override function validate_img() : void {
            if(!img_validated){
                _rd_id = _url.concat("_").concat(mc_name).concat("_").concat(_current_frame);

                if(!_mc){
                    ExternalMovieClipLoader.getMovieClipFromURL(_url, _mc_name, onMovieClip);
                }else{
                    draw();
                    img_validated = true;
                }
            }
        }

        protected function onMovieClip(mc : MovieClip, total_frame : uint) : void {
            _total_frames = total_frame;
            _mc = mc;
        }

        protected function draw() : void {
            var rd : RenderData = RenderData.getRenderDataFromMC(_rd_id, _mc, _current_frame);
            bitmapData = rd.bd;

            x = screen_pos.x + rd.x;
            y = screen_pos.y + rd.y;
        }

		public override function render() : void {
			nextFrame();

			validate_pos();	
			validate_img();	
		}

		public var loopType : uint = 0;
		
		public function nextFrame() : void {
			if(loopType == 0) return;

			if(loopType == 1){
				if(current_frame < total_frames)
					current_frame++;
				else
					current_frame = 0;

				img_validated = false;
			}
		}

        public function set url(value : String) : void {
            _url = value;
            img_validated = false;
        }

        public function get url() : String {
            return _url;
        }

        public function set mc_name(value : String) : void {
            _mc_name = value;
            _mc = null;

            img_validated = false;
        }

        public function get mc_name() : String {
            return _mc_name;
        }

        public function get total_frames() : uint {
            return _total_frames;
        }

        public function set current_frame(value : uint) : void {
            _current_frame = value;
            img_validated = false;
        }

        public function get current_frame() : uint {
            return _current_frame;
        }

    }
}
