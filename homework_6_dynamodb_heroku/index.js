
var ddb = require ('dynamodb')
	.ddb({
		accessKeyId: process.env.APP_BANK_GAME_HW_ACCESSKEYID,
		secretAccessKey: process.env.APP_BANK_GAME_HW_ACCESSKEYSECRET,
		endpoint: "dynamodb.us-west-2.amazonaws.com"
		});

var app = require('express')();

// "        "
var database = { cost: 0 };

app.get('/', (req, res) => {
    res.send("hello....it's me...");

});


app.get('/get-cost', (req, res) => {
  ddb.getItem('bankgame', 'newPlayer', null, {},
    function(err, dynamoResult, cap) {
      res.send(dynamoResult)
  });
});

app.get('/set-cost', (req, res) => {
  console.log(req.query.cost);
  var newData = {
    "player-id" :"newPlayer",
    cost: parseInt(req.query.cost)
  }
  
  ddb.putItem('bankgame', newData, {},
    function(err, dynamoResult, cap) {
      res.send({cost: newData.cost});
    });
});

app.listen(process.env.PORT || 3000);