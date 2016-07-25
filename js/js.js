

(function(){

"use strict"
window.location.hash = "#main";

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
        hash:"#main"
    },
    {           
        burger:"burger burgerleftcross",
        back:"back nodisplay",
        viewsclassto:"movemenu",
        hash:"#menu"
    },
    
    {
            burger:"burger burgercentercross",
            back:"back display",   
            viewsclassto:"moveabout"
    },
    {
            burger:"burger burgercentercross",
            back:"back display",            
            viewsclassto:"movecontacts",
            hash:"#contact"
    },
        {
            burger:"burger burgercentercross",
            back:"back display",
            viewsclassto: "moveportfolio"
    },
    {
            burger:"burger burgercentercross",
            back:"back display",            
            viewsclassto:"moveblog"
    }


];

(function(){
    defaultstyle.forEach(function (el,i) { 
    el.viewName = viewNames[i];
    el.obj = views[i]; 
 });
})();

console.log(defaultstyle);






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

    burger.className = defaultstyle[n].burger;
                
    back.className = defaultstyle[n].back;

    views.forEach(function(el){
            
        el.className =  cutReplaceAppend(el.className,defaultstyle[prevn].viewsclassto,defaultstyle[n].viewsclassto,defaultstyle[n].viewsclassto );             
        
    });

    console.log(view);
};


(function (){ 




burger.addEventListener("click",function(el){
    

   if(  !view ){

             setview(0,1);
             
   }else {

             setview(view,0);
             window.location.hash = "#main";

   };   
  });

  back.addEventListener("click",function(el){
      setview(view,1);
  });




  (function () {

      var menuitems = document.querySelectorAll(".menuview>*>a");

      console.log(menuitems);

      for(var i = 0, l = menuitems.length; i<l;i++  ){
      
        (function (k) {    
          menuitems[k].addEventListener("click",function () { 
              setview(view,k+2);           
        });
        })(i);

      };
  })();






 })();





















})();