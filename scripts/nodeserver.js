const http = require("http");
const fs = require("fs");
const path = require("path");
const url = require("url");
const zip = require("zlib");


const logger = (...rest) =>{
    const date = new Date();
    const datetimestring = `${date.toLocaleString()}\'${date.getMilliseconds()} - `;
    console.log.apply(null,[datetimestring].concat(rest) );
};

const process = require("process");


//////
logger(">>>",process.argv,"<<<<<<<<");

const secondisport = !!process.argv[2] && /^\d{4,5}$/g.test(process.argv[2]);



///////
const wantedpath = ((secondisport ? process.argv[3] : process.argv[2]) || "").trim();





http.createServer((...rest) => servercallback.apply(this,rest)
                 ).listen(secondisport ? + process.argv[2].trim() : 8000);


const mimeFns = {
    "text": (ext) => ext != "js"? "text/" + ext : "text/javascript"
    ,"image": (ext) => "image/" + ext
    ,undefined: () => undefined
}

const mimeTypes = {
    "html": "text"
    ,"jpg": "image"
    ,"jpeg":"image"
    ,"png": "image"
    ,"js":"text"
    ,"css":"text"
}

const base = path.join( process.cwd(),wantedpath);

const servercallback = (clReq,seRes) => {
    
    let file = path.join( base ,url.parse(clReq.url).pathname.slice(1) );
    //logger("start: "+ file);
    return new Promise(checkFileExists(file) //got factory
    ).then( ()  => 
    sendFile(seRes,file)
    ).catch(err =>
     sendFile(seRes,file = path.join( base,"index.html") )
    ).catch(err => 
    sendError(seRes,err)
    );
};

function checkFileExists(filename) {    
    return (resolve, reject) =>
    fs.access(filename, err =>{
        if( err ){             
            logger(`no such file: ${filename}. Got err: ${err}  ` );
            reject(err);
         };
        //logger(`file exists: ${filename}`);        
        resolve();
    });

};


function sendError(res,err){
    logger(`got error: ${err}`)
    res.writeHead(404,{"Content-Type": "text/plain"});
    res.write(`index.html Not Found or Not Accessible : error code: ${err}`);
    if(!res.finished){ res.end()};
};


function sendFile(res,filepath){
    return new Promise((resolve,reject) => {
        let tmp;
        if( !fs.lstatSync(filepath).isFile() ){ 
            reject(new Error("not a filename"));
            return;
         };

        const ext = path.extname(filepath).slice(1);
        res.writeHead(200,{
            "Content-Type": mimeFns[mimeTypes[ext]](ext) || "text/plain",
            "Content-Encoding": "gzip"
        });

        const raw = fs.createReadStream(filepath);
        raw.pipe(zip.createGzip()).pipe(res);
        
        setImmediate(()=>{ 
            logger("file sent: " + filepath);
            resolve();
            return;
        });
    });
};




