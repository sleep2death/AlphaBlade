﻿fl.outputPanel.clear();var dom = fl.getDocumentDOM();var lib = dom.library;var URI = fl.browseForFolderURL("select input pictures..."); importFolder(URI); function importFolder(folderURI) {        fl.trace(folderURI);                var folderContents;        var fitem, i;                var libPath = folderURI.replace(URI, "");        var subLibPath = libPath.substr(1);        //去掉第一个“/”                //文件        folderContents = FLfile.listFolder(folderURI, "files");        for (i in folderContents) {                fitem = folderContents[i];                var inx = fitem.lastIndexOf(".");                if (inx > 0) {                        var ext = fitem.substr(inx+1).toLowerCase();  //扩展名                        //fl.trace(ext);                        if (ext == "jpg" ||ext == "png" || ext == "gif") {                                fl.trace("导入文件：" + fitem);                                dom.importFile(folderURI + "/" + fitem, true);                                                                if (libPath != "") {                                        lib.selectItem(fitem);                                        lib.moveToFolder(subLibPath);                                }                        }                }        }                //文件夹        folderContents = FLfile.listFolder(folderURI, "directories");        for (i in folderContents) {                fitem = folderContents[i];                fl.trace("-----------文件夹：" + fitem + "------------------");                lib.newFolder(libPath + "/" + fitem);                                importFolder(folderURI + "/" + fitem); //递归        }        }