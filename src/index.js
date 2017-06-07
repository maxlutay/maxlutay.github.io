require("./index.html");

require("./styles/null.css");
require("./styles/styles.css");

window.app = require("./Main.elm").Main.fullscreen();//{path: document.location});
            //the same as         .Main.embed(document.body);
//gonna use flages to get current location





window.app.ports.changereallocation.subscribe(path => {
   window.history.replaceState('', '', path);
   //history.pushState("", "", path);;
});


window.app.ports.back.subscribe(() => {  })//window.history.back(); });
window.app.ports.forward.subscribe(() => { })// window.history.forward(); });
window.app.ports.out.subscribe(path => { })//window.location = path;});