package ab.iso {
    import flash.display.Sprite;
    import flash.display.DisplayObject;

    public class IsoLayer extends Sprite {
        protected var children : Vector.<IsoSprite> = new Vector.<IsoSprite>();
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

        protected var render_list : Vector.<IsoSprite> = new Vector.<IsoSprite>();

        public function add_To_render(target : IsoSprite) : void {
            if(children.indexOf(target) > 0 && render_list.indexOf(target) < 0) {
            }
        }

        public function render() : void {
        }

        protected var _isLocked : Boolean;

        public function set isLocked(value : Boolean) : void {
            _isLocked = value;    
        }

        public function get isLocked() : Boolean {
            return _isLocked;    
        }

        protected function sort() : void {
        }
    }
}
