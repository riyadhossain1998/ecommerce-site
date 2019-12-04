//var mysql = require('mysql');
var express = require('express');
var session = require('express-session');
var bodyParser = require('body-parser');
var nodemailer = require('nodemailer');
var path = require('path');
var multer = require('multer');

var posts;

//var db=require('../util/database.js');
var customerName;  // temporary
var customerId;
var app = express();


/*
app.set('view engine', 'pug');
const expressHbs=require('express-handlebars');
app.engine('hbs',expressHbs({layoutsDir:'views/layouts/',
  defaultLayout:'main-layout',
  extname: 'hbs'
}));
*/
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html')
var mysql = require('mysql');

var connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "password",
  database: "ecomdb"

});

app.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true
}));

app.use(bodyParser.urlencoded({extended : true}));
app.use(express.static(__dirname + '/public'));         //  Declared public directory for loading images on the website
app.use(bodyParser.json());


var storage = multer.diskStorage({
  destination: './public/images/',
  filename: function(req, file, cb) {
    cb(null, file.filename + '-' + Date.now() + path.extname(file.originalname));
  }
});

var upload = multer({
  storage: storage
});

app.get('/', function(request, response) {            // Website starts from here
  connection.query('SELECT * FROM products',null,function (err, posts, fields) {
    if (err) throw err;
    //console.log(result);
    response.render('mainPage.html',{posts});
  });
});

app.get('/customerLogin', function(request, response) {         // login page for customer
  response.sendFile(path.join(__dirname + '/login.html'));
});

app.post('/auth', function(request, response) {             // authorisation for the customer
  var id = request.body.id;
  customerId = id;
  var password = request.body.password;
  if (id && password) {
    connection.query('SELECT * FROM customers WHERE id = ? AND password = ?', [id, password], function(error, results, fields) {
      //console.log(results);
      if (results.length > 0) {
        request.session.loggedin = true;
        request.session.id = id;
        customerName = results[0].name;   // just for fun for now
        //console.log("Answer "+ results[0].name);


        response.redirect('/customerHomepage');
        //response.render('/customerHomepage',{results[0].name });
      } else {
        response.send('Incorrect Username and/or Password!');
      }
      response.end();
    });
  } else {
    response.send('Please enter Username and Password!');
    response.end();
  }
});

app.get('/customerHomepage', function(request, response) {          // cutomerhomepafe. Populates the page with pthe products and the name
  connection.query('SELECT * FROM products WHERE customerId <> ?',[customerId],function (err, posts, fields) {
    if (err) throw err;
    //console.log(result);
    response.render('customerHomepage.html',{customerName, posts});
  });
  //console.log(posts);


});

app.get('/contact', function(request, response) {       // redirects to the contact information page
  response.render('contact.html',{customerName});
});

app.get('/addProduct', function(request, response) {      // Redirects to the add product page
  response.render('addProduct.html',{customerName});
});

app.post('/addProduct', upload.single('photo'), function(request, response) {         // adds a product to the database
  console.log("File is " + request.file.filename);
  var title = request.body.title;
  var price = request.body.price;
  var imageURL = request.file.filename;
  var description = request.body.description;
  //var id;
  //  Listen for click
  /*
  First user fills form with information and then connection query to upload all data except imageURL
  Second form to upload picture
   */
  connection.query(
      'INSERT INTO products( title, price, imageURL, description, customerId) VALUES (?,?,?,?,?)',
      [ title, price, imageURL, description, customerId],function (err, result) {
        if (err) throw err;
        console.log("Product inserted");
  });
  // console.log("File is " + request.file.fieldname);
  console.log("File is " + title + price + imageURL + description);

  response.redirect('/customerHomepage');
});


app.post('/remove', function(request, response) {         //customer wants to remove an item from his inventory
  var id = request.body.removeId;
  connection.query(
      'DELETE FROM products WHERE id = ?',
      [id],function (err, result) {
        if (err) throw err;
        console.log("Product deleted");
      }
  );

  //console.log(id + " removed");

  response.redirect('/customerHomepage');
});

app.post('/buy', function(request, response) {      // product requested to buy. Seller will get a notification
  var id = request.body.buyId;
  connection.query(
      'UPDATE products SET sellRequested=1 WHERE id = ?',
      [id],function (err, result) {
        if (err) throw err;
        console.log("Product requested");
      }
  );

  response.redirect('/customerHomepage');
});

app.get('/logout', function(request, response) {        // Logs out the customer
  request.session.loggedin = false;
  response.redirect('/');
});

app.get('/showAllMyProducts', function(request, response) {         // Show All my products from the database

  var id = customerId;        // only prints out the product belong to the user
  //console.log(id);
  connection.query('SELECT * FROM products WHERE customerId = ?',[id],function (err, posts, fields) {
    if (err) throw err;
    response.render('showAllMyProducts.html',{customerName, posts});
  });
});



app.get('/home', function(request, response) {        // Goes to home
  if (request.session.loggedin) {
    response.send('Welcome back, ' + request.session.password + '!');

  } else {
    response.send('Please login to view this page!');
  }
  response.end();
});

app.post('/send-email', function (req, res) {         // send email

  var transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'rashikhassan',
      pass: 'R'
    }
  });

  var mailOptions = {
    from: 'bsse0826@iit.du.ac.bd',
    to: req.body.to,
    subject: req.body.subject,
    text: req.body.body
  };

  transporter.sendMail(mailOptions, (error, info) => {
    if (error) {
      return console.log(error);
    }
    console.log('Message %s sent: %s', info.messageId, info.response);
    res.redirect('/customerHomepage');
  });
});

// app.post('/upload', upload.single('photo'), (req, res) => {           // uploads the file and stores in the folder img
//   if(req.file) {
//     res.json(req.file);
//   }
//   else throw 'error';
// });

// Admin functions starts here
// *********************************************************Admin***********************************************************************

app.post('/adminauth', function(request, response) {
  var id = request.body.id;
  customerId = id;
  var password = request.body.password;
  if (id && password) {
    connection.query('SELECT * FROM admincredentials WHERE id = ? AND password = ?', [id, password], function(error, results, fields) {
      console.log(error);
      if (results.length > 0) {
        request.session.loggedin = true;
        request.session.id = id;
        customerName = results[0].name;   // just for fun for now
        //console.log("Answer "+ results[0].name);


        response.redirect('/adminHomepage');
        //response.render('/customerHomepage',{results[0].name });
      } else {
        response.send('Incorrect Username and/or Password!');
      }
      response.end();
    });
  } else {
    response.send('Please enter Username and Password!');
    response.end();
  }
});



// the href takes you here, then you render the page
app.get('/adminHomepage', function(request, response) {
  connection.query('SELECT * FROM products',function (err, posts, fields) {
    if (err) throw err;
    //console.log(result);
    response.render('adminHomepage.html',{customerName, posts});
  });
  //console.log(posts);


});


// for pending products
app.get('/showPendingProducts', function(request, response) {
  connection.query('SELECT * FROM pendingproducts',function (err, posts, fields) {
    if (err) throw err;
    //console.log(result);
    response.render('showPendingProduct.html',{customerName, posts});
  });
  //console.log(posts);


});

// .get for remove pending items. called from showPendingProduct.html

app.post('/removependingproduct', function(request, response) {         //customer wants to remove an item from his inventory
  var id = request.body.Id;
  connection.query(
      'DELETE FROM pendingproducts WHERE id = ?',
      [id],function (err, result) {
        if (err) throw err;
        console.log("Product removed from pending deleted");
      }
  );

  //console.log(id + " removed");

  response.redirect('/showPendingProducts');// redirect takes you back to the get function
});


// admin approving the product to be added
app.post('/approveproduct', function(request, response) {         //customer wants to remove an item from his inventory
  var id = request.body.Id;

  connection.query('SELECT * FROM pendingproducts WHERE id = ?',[id],function (err, result, fields) {
    console.log(result);
    connection.query(
        'INSERT INTO products( id,title, price, imageURL, description, customerId) VALUES (?,?,?,?,?,?)',
        [ id, result[0].title, result[0].price, result[0].imageURL, result[0].description, result[0].customerId],function (err, result) {
          if (err) throw err;
        })
    if (err) throw err;
  });






// need to also delete from pending products table

  connection.query(
      'DELETE FROM pendingproducts WHERE id = ?',
      [id],function (err, result) {
        if (err) throw err;
      }
  );



  response.redirect('/showPendingProducts');// redirect takes you back to the get function
});







var port = '3306';
app.set('port', port);
//app.listen(3306);

module.exports = app;


