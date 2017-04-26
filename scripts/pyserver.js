

const process = require("process");
const path = require("path");
const spawn = require("child_process").spawn;



console.log(">>>",process.argv,"<<<<<<<<");
let pyserver = spawn( "python"
    ,["-m","http.server",+process.argv[2] || 8000 ]
    ,{
      cwd: process.argv[3] || "",
      env: process.env
    }

);

pyserver.stdout.on("data", (data) => {
  console.log(`stdout: ${data}`);
});

pyserver.stderr.on("data", (data) => {
  console.log(`stderr: ${data}`);
});

pyserver.on("close", (code) => {
  console.log(`pyserver terminated ${code}`);
});

pyserver.on("error",(err)=>{
    console.log("###########",err,err.what);

});

