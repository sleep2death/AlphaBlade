package ab.pathfinding
{
	public class WayPoint {
		
		public var position:Vector2f;
		public var cell:Cell;
		
		public function WayPoint(cell:Cell, position:Vector2f)
		{
			this.cell = cell;
			this.position = position;
		}
	}
}
