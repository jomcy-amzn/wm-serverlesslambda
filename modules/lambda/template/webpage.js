var AWS = require('aws-sdk');
var lambda = new AWS.Lambda();
var RES;
exports.handler = function(event,context,callback) {
    var userName=event.userName;
    var passWord=event.passWord;
    var params = {
        FunctionName: 'ServiceAuthentication', // the lambda function we are going to invoke
        InvocationType: 'RequestResponse',
        LogType: 'Tail',
        Payload: '{ "userName": "'+userName+'","passWord": "'+passWord+'" }'
    };

    lambda.invoke(params, function(err, data) {
        if (err) {
            context.fail(err);

        } else {
            //context.succeed('ServiceAuthentication said '+data.Payload);
            var response=data.Payload;
            console.log("Response received is : ",response);
            if(response === true){
                RES = '{"ResponseJSON":{"Body":{"Datalist":{"Authentication":'+response+'}}}}';
            }else{
                RES = '{"ResponseJSON":{"Body":{"Datalist":{"Authentication":'+response+'}}}}';
            }
            callback(null, JSON.parse(RES));
        }});
};
