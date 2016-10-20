

(function(){

"use strict"
    
    
(function(){
    var div = document.createElement("div");
    div.style.position ="fixed";
    div.width = "100%";
    div.height = "10px";
    div.zIndex = "9999";
    div.display = "block";
    div.innerHTML = "this is just a template website and a lot of code redesign and fixes needed"
    document.appendChild(div);
    
})();    
    


var viewNames = [ "mainview","menuview","contactsview","aboutview","blogview","portfolioview" ];

var views = document.querySelectorAll(".view");

var burger = document.getElementsByClassName("burger")[0];

var back = document.getElementsByClassName("back")[0];


var view;/*!!!!!!!!!!!!!!!!!!important!!!!!!!!!!!!!!!*/

var defaultstyle = [
    {               
        burger:"burger burgerrightburger",
        back:"back nodisplay",
        viewsclassto:" movedefault",
        hash:"main"
    },
    {           
        burger:"burger burgerleftcross",
        back:"back nodisplay",
        viewsclassto:"movemenu",
        hash:"menu"
    },
    
    {
        burger:"burger burgercentercross",
        back:"back display",   
        viewsclassto:"moveabout",
        hash:"aboutme"
    },
    {
        burger:"burger burgercentercross",
        back:"back display",            
        viewsclassto:"movecontacts",
        hash:"contactme"
    },
    {
        burger:"burger burgercentercross",
        back:"back display",
        viewsclassto: "moveportfolio",
        hash:"portfolio"
    },
    {
        burger:"burger burgercentercross",
        back:"back display",            
        viewsclassto:"moveblog",
        hash:"blog"
    }


];

(function(){
    defaultstyle.forEach(function (el,i) { 
    el.viewName = viewNames[i];
    el.obj = views[i]; 
 });
})();










var cutReplaceAppend = function (src,word,replace,append) {
    if(!src){ src = "" };

    if(!word || src.indexOf(word)<0 ){

    }else{
        if(!replace){
          src =  src.replace( word," " ) ;          
        }else{
            src = src.replace(word, replace);           
        };
    };

    if( append ){
        
        if(src.indexOf(append)<0){    
            src = src + " " + append;            
        };
        
    };
    
     
     
     return src;
     
};






(function preventdef() {
    document.querySelectorAll(".contactsview a").forEach(function (el){  
        el.setAttribute( "target","_blank" );
        el.setAttribute("rel","noopener noreferrer");
    });

})();





function setview(prevn,n) {
    view = n;

    window.location.hash = defaultstyle[n].hash;

    burger.className = defaultstyle[n].burger;
                
    back.className = defaultstyle[n].back;

    views.forEach(function(el){
            
        el.className =  cutReplaceAppend(el.className,defaultstyle[prevn].viewsclassto,defaultstyle[n].viewsclassto,defaultstyle[n].viewsclassto );             
        
    });

    
};


(function (){ 




burger.addEventListener("click",function(el){
    

   if(  !view ){

             setview(0,1);
             window.location.hash = defaultstyle[1].hash;
   }else {

             setview(view,0);
             window.location.hash = defaultstyle[0].hash;

   };   
  });

  back.addEventListener("click",function(el){
      setview(view,1);
  });




  (function () {

      var menuitems = document.querySelectorAll(".menuview>*>a");

      

      for(var i = 0, l = menuitems.length; i<l;i++  ){
      
        (function (k) {    
          menuitems[k].addEventListener("click",function () { 
              setview(view,k+2);           
        });
        })(i);

      };
  })();






 })();






/*
(function router() { 
    
    var found = false;
    if( window.location.hash ){
       for( var i = 0, l = defaultstyle.length; i < l && !found; i++ ){

           (function(k){
               if(window.location.hash ==  "#" + defaultstyle[k].hash){
                   setview(0,k);
                   found = true;
               };
           })(i);
           
       };
    }else{        
        view = 0;
        setview(view,0);
    };
 })();


*/










})();
