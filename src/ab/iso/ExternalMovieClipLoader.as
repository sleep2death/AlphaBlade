package ab.iso{
        import flash.display.MovieClip;
        import flash.display.BitmapData;
        import flash.display.Loader;
        import flash.utils.Dictionary;
        import flash.geom.Rectangle;

        import ab.iso.RenderData;

        public class ExternalMovieClipLoader {

                private static var loader_pool : Dictionary = new Dictionary();

                public static function toString() : String
                {
                        var loader_count : int = 0;        
                        var img_instance : int = 0;        

                        for(var url : String in loader_pool) {
                                var loader : EmbedLoader = loader_pool[url];
                                loader_count++;
                        }

						for (var img_name : String in EmbedLoader.img_pool) {
								img_instance++;
						}

                        return ("ExternalMovieClipLoader <loaders: " + loader_count + ", bitmapdata: " + img_instance + ">"); 
                }

                public static function getBitmapDataFromURL(url : String, lk_name : String = null, callBack : Function = null, duplicate : Boolean = false) : void {
						if(EmbedLoader.img_pool[url + "_" + lk_name]){
							callBack(EmbedLoader.img_pool[url + "_" + lk_name]);
							return;
						}

                        var loader : EmbedLoader;        

                        if(!loader_pool[url]){
                                loader = EmbedLoader.getLoader();
                                loader_pool[url] = loader;
                        }else{
                                loader = loader_pool[url];
                        }
                        
                        if(loader.status < 0){
                                if(callBack != null) loader.callBacks.push({lk_name : lk_name, duplicate : duplicate, call_back : callBack});
                                loader.loadURL(url);
                        }else if(loader.status > 0){
                                var bd : BitmapData;

                                if(lk_name && lk_name.length > 0){
                                        bd = loader.getBitmapDataByName(lk_name, duplicate) as BitmapData;
                                }

                                if(callBack != null) callBack(bd);

                        }else if(loader.status == 0){
                                if(callBack != null) loader.callBacks.push({lk_name : lk_name, duplicate : duplicate, call_back : callBack});
                        }
                }

                public static function recycle(url : String) : void {
                    if(loader_pool[url]) {
                        var loader : EmbedLoader = loader_pool[url];
                        loader.recycle();

                        loader = null;
                        delete loader_pool[url];
                    }
                }
        }
}


import flash.display.Loader;
import flash.display.BitmapData;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLRequest;

import flash.display.MovieClip;
import flash.utils.Dictionary;

import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

internal class EmbedLoader extends Loader {

        private var url : String;

        //-1:unloaded; 0:loading; 1:loaded
        public var status : int = -1;

        public static var img_pool : Dictionary = new Dictionary();
        public var linkage : Array = new Array();                        
        public var callBacks : Array = new Array();

        private var context : LoaderContext;
        private var request : URLRequest;

        private static var recycle_pool : Array = new Array();

        public function loadURL(url : String) : void {
                this.url = url;

                request = new URLRequest(url);
                context = new LoaderContext(false, new ApplicationDomain());

                contentLoaderInfo.addEventListener(Event.COMPLETE, onLoaderComplete);
                contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);

                load(request, context);
                status = 0;
        }

        private function onLoaderComplete(evt : Event) : void {
                contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
                contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);

                status = 1;

                var len : int = callBacks.length;

                for (var j:uint = 0; j < len; j++) {
                        var callBack : Object = callBacks[j];

                        var f : Function = callBack['call_back'];
                        var l : String = callBack['lk_name'];
                        var d : Boolean = callBack['duplicate'];

                        if(l){
							var bd : BitmapData = getBitmapDataByName(l, d);
							f(bd);
						}else{
							var mc : MovieClip = this.content as MovieClip; 
							f(mc, mc.totalFrames);
                        }
                }

                callBacks = new Array();
        }

        private function onError(evt : IOErrorEvent) : void {
                recycle();
        }

        public function getBitmapDataByName(lk_name : String, duplicate : Boolean = false) : BitmapData {
                if(!img_pool[url + "_" + lk_name] || duplicate){
                        if(status <= 0) return null;
                        try{
                                var mcClass : Class = contentLoaderInfo.applicationDomain.getDefinition( lk_name ) as Class;

                                var bd : BitmapData = new mcClass() as BitmapData;

                                if(!duplicate) img_pool[url + "_" + lk_name] = bd;

                                return bd;
                        } catch ( e : Error ) {
                                throw new Error('Can not find the movieclip <' + lk_name + '@' +  url + '>');
                        }
                }

                return img_pool[lk_name];
        }

        public static function getLoader() : EmbedLoader {
                if(recycle_pool.length > 0)
                        return recycle_pool.shift();
                else
                        return new EmbedLoader();
        }

        public function recycle() : void {
                status = -1;

                contentLoaderInfo.removeEventListener(Event.COMPLETE, onLoaderComplete);
                contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);

                img_pool = new Dictionary();
                callBacks = new Array();
                linkage = new Array();

                recycle_pool.push(this);
        }
}

internal class MC {
    public var mc : MovieClip = null;
    public var fm : uint = 0;

    public function MC(mc : MovieClip, fm : uint = 0) : void {
        this.mc = mc;
        this.fm = fm;
    }
}
