
/**
 * Module dependencies.
 */

var express = require('express');
var http = require('http');
var path = require('path');
var device = require('express-device');

var app = express();

// all environments
app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(device.capture());
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', function (req, res) {
    if (req.device.type === 'desktop') {
        res.render('desktop/index');
    } else {
        res.render('mobile/index');
    }
});

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
