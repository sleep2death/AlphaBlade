package ab.pathfinding
{
	public class ClassifyResult {
		public function ClassifyResult()
		{
		}
		/**
		 * 直线与cell（三角形）的关系 
		 */		
		public var result:int = PathResult.NO_RELATIONSHIP;
		/**
		 * 相交边的索引
		 */		
		public var side:int = 0;
		/**
		 * 下一个邻接cell的索引
		 */		
		public var cellIndex:int = -1;
		/**
		 * 交点
		 */		
		public var intersection:Vector2f = new Vector2f();
		
		public function toString():String {
			return result.toString() + " " + cellIndex;
		}
	}
}
