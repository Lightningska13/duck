/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/
CKEDITOR.editorConfig=function(e){e.filebrowserBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashBrowseUrl="/ckeditor/attachment_files",e.filebrowserFlashUploadUrl="/ckeditor/attachment_files",e.filebrowserImageBrowseLinkUrl="/ckeditor/pictures",e.filebrowserImageBrowseUrl="/ckeditor/pictures",e.filebrowserImageUploadUrl="/ckeditor/pictures",e.filebrowserUploadUrl="/ckeditor/attachment_files",e.toolbar="Basic2",e.toolbar_Basic2=[["Bold","Italic","-","NumberedList","BulletedList","-","Link","Unlink","Table"],["PasteText","PasteFromWord","TextColor","BGColor","Image","RemoveFormat","Source"]],e.toolbar_Format=[["Bold","Italic","Link","Unlink","Source"]],e.filebrowserParams=function(){for(var e,r,t,o=document.getElementsByTagName("meta"),a=new Object,i=0;i<o.length;i++)switch(t=o[i],t.name){case"csrf-token":e=t.content;break;case"csrf-param":r=t.content;break;default:continue}return void 0!==r&&void 0!==e&&(a[r]=e),a},e.addQueryString=function(e,r){var t=[];if(!r)return e;for(var o in r)t.push(o+"="+encodeURIComponent(r[o]));return e+(-1!=e.indexOf("?")?"&":"?")+t.join("&")},CKEDITOR.on("dialogDefinition",function(r){var t,o,a=r.data.name,i=r.data.definition;CKEDITOR.tools.indexOf(["link","image","attachment","flash"],a)>-1&&(t=i.getContents("Upload")||i.getContents("upload"),o=null==t?null:t.get("upload"),o&&null==o.filebrowser.params&&(o.filebrowser.params=e.filebrowserParams(),o.action=e.addQueryString(o.action,o.filebrowser.params)))})};