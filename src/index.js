require("./index.html");

require("./styles/null.css");
require("./styles/styles.css");

window.app = require("./Main.elm").Main.fullscreen();
            //the same as         .Main.embed(document.body);

