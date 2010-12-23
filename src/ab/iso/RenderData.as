package ab.dor.iso {
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.display.Graphics;
    import flash.utils.Dictionary;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;

    public class RenderData {

        public var bd : BitmapData;

        public function RenderData(bd : BitmapData, offset_x : Number, offset_y : Number) : void {
            this.bd = bd;
            mtx.tx = offset_x;
            mtx.ty = offset_y;

            cache();
        }

        public var x : Number;
        public var y : Number;
        public var w : Number;
        public var h : Number;

        protected function cache() : void {
            x = mtx.tx;
            y = mtx.ty;

            w = bd.width - 1;
            h = bd.height - 1;
        }

        protected var mtx : Matrix = new Matrix();

        private static var rd_pool : Dictionary = new Dictionary();

        public static function getRenderDataFromMC(id : String, mc : MovieClip, frame : int) : RenderData {
            if(!rd_pool[id]){
                mc.gotoAndStop(frame);

                var rect : Rectangle = mc.getBounds(mc);
                var bd : BitmapData = new BitmapData(rect.width + 1, rect.height + 1, true, 0x00);

                var mtx : Matrix = new Matrix(1, 0, 0, 1, -rect.x, -rect.y);
                bd.draw(mc, mtx);

                rd_pool[id] = new RenderData(bd, rect.x, rect.y);
            }

            return rd_pool[id];
        }
    }
}
