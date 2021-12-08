const { urlencoded } = require('express')
const express = require('express')
const app = express()
const port = 3000
const fs = require('fs')

app.use(
  express.urlencoded({
    extended: true
  })
)

app.use(express.json())

app.get('/list', (req, res) => {
  var mysql = require('mysql');

  var con = mysql.createConnection({
    host: "127.0.0.1",
    user: "root",
    password: "",
    database: "mysql"
});

con.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
  //var sql = "INSERT INTO customers (name, address) VALUES ('shyam Inc', 'Highway 25')";
  con.query("CALL GetUsers",function (err, result){
    if(err)throw err;
    res.send(result);
    res.end();
    
  })
});
});


app.post("/add", (req, res) => {
  var mysql = require('mysql');

  var con = mysql.createConnection({
  host: "127.0.0.1",
  user: "root",
  password: "",
  database: "mysql"
});

con.connect(function(err) {
  if (err) throw err;
  console.log(res);
  
  let query = 'CALL AddUser(?, ?);';

  let uname=req.body.name;
  let address=req.body.address;


  con.query(query,[uname,address], (err, result)=>{
    if(err)throw err;
    console.log(result);
    res.send(result);
    res.end()
    
  })
});
})

app.listen(port, () => {
    console.log(`app listening at http://localhost:${port}`)
  });