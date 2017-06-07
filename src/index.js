require("./index.html");

require("./styles/null.css");
require("./styles/styles.css");

window.app = require("./Main.elm").Main.fullscreen();//{path: document.location});
            //the same as         .Main.embed(document.body);
//gonna use flages to get current location





window.app.ports.changereallocation.subscribe(function(path) {
   history.replaceState('', '', path);
   //history.pushState("", "", path);;
});
