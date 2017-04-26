//require("./styles.css");
require("./index.html");
window.app = require("./Main.elm").Main.fullscreen();//.Main.embed(document.body);

app.ports.title.subscribe((title)=>{
    document.title = title;
});

//require("./Head.elm")//.Head.embed(document.head);