package ab.pathfinding
{
	public final class PointClassification
	{
		public static const ON_LINE:int = 0;		// The point is on, or very near, the line
		public static const LEFT_SIDE:int = 1;		// looking from endpoint A to B, the test point is on the left
		public static const RIGHT_SIDE:int = 2;		// looking from endpoint A to B, the test point is on the right
	}
}
