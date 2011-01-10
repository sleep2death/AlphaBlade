package ab.iso {
    public class Pt3D {
        public static const Y_CORRECT : Number = Math.cos(-Math.PI / 6) * Math.SQRT2;

        public var x : Number;
        public var y : Number;
        public var z : Number;

        public function Pt3D(x : Number = 0, y : Number = 0, z : Number = 0) : void {
            this.x = x;
            this.y = y;
            this.z = z;
        }

        public function spaceToScreen(pt2D : Pt2D) : void {
            pt2D.x = x - z;
            pt2D.y = y * Y_CORRECT + (x + z)  * 0.5;
        }
    }
}
