package ab.iso {
    public class Pt2D {
        public static const Y_CORRECT : Number = Math.cos(-Math.PI / 6) * Math.SQRT2;

        public var x : int;
        public var y : int;

        public function Pt2D(x : Number = 0, y : Number = 0) : void {
            this.x = x;
            this.y = y;
        }

        public function screenToSpace(pt3D : Pt3D) : void {
            pt3D.x = y + (x * 0.5);
            pt3D.y = 0;
            pt3D.z = y - (x * 0.5);
        }
    }
}
