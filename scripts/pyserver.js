const util = require("util");
const process = require("process");
const spawn = require("child_process").spawn;



util.log(">>>",process.argv,"<<<<<<<<");
let pyserver = spawn( "python"
    ,["-m","http.server", +process.argv[2] || 8000 ]
    ,{
      cwd: process.argv[3] || "",
      env: process.env,
      stdio: ["ignore",process.stdout, process.stdout]
    }
);


