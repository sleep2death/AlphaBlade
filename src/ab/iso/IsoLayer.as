package ab.iso {
    import flash.display.Sprite;
    import flash.display.DisplayObject;

    public class IsoLayer extends Sprite {

        protected var children : Vector.<IsoSprite> = new Vector.<IsoSprite>();

		protected var num_children : int = 0;

        protected var children_not_validated : Vector.<IsoSprite> = new Vector.<IsoSprite>();

        public function IsoLayer() : void {
            super();
        }

        public override function addChild(child : DisplayObject) : DisplayObject {
            return addChildAt(child, numChildren);
        }

        public override function addChildAt(child : DisplayObject, index : int) : DisplayObject {
            var res : IsoSprite =  super.addChildAt(child, index) as IsoSprite;

            if(res)
                children.splice(index, 0, res);
            else
                throw new Error("Error: IsoSprite Object doesn't exist.");

			num_children = numChildren;
			trace("NumChildren:" + children.length);

            return res;
        }

        public override function removeChild(child : DisplayObject) : DisplayObject {
            return removeChildAt(getChildIndex(child));
        }

        public override function removeChildAt(index : int) : DisplayObject {
            var res : IsoSprite = super.removeChildAt(index) as IsoSprite;

            if(res)
                children.splice(index, 1);
            else
                throw new Error("Error: IsoSprite Object doesn't exist.");

			num_children = numChildren;

            return res;
        }

        public override function setChildIndex(child : DisplayObject, index : int) : void {
            var i : int = children.indexOf(child);
            if(i == index) return;

            super.setChildIndex(child, index);

            if( i > -1){
                children.splice(i, 1);
                children.splice(index, 0, child);
            }
        }

        public function render() : void {
			//sort();
		
			for(var i : int = 0; i < num_children; i++){
				var child : IsoSprite = children[i];
				child.render();
			}
        }

        protected var _isLocked : Boolean;

        public function set isLocked(value : Boolean) : void {
            _isLocked = value;    
        }

        public function get isLocked() : Boolean {
            return _isLocked;    
        }

		public static const SORT_SIMPLE : int = 1;
		public var sortType : int = SORT_SIMPLE;

        protected function sort() : void {
			//if(sortType == SORT_SIMPLE)
				//children.sortOn("y", Array.DESCENDING | Array.NUMERIC);
        }
    }
}
