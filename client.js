var unirest = require(process.env['HOME_PATH'] + '/node_modules/unirest');
var fs = require(process.env['HOME_PATH'] + '/node_modules/fs-extra');
var moment = require(process.env['HOME_PATH'] + '/node_modules/moment');

var utils = require(process.env['HOME_PATH'] + '/js/utils.js');
var constants = require(process.env['HOME_PATH'] + '/js/constants.js');

module.exports = {

    sendEventToClient: function (client_json, callback) {

        var client_config_prefix = '/client_';
        if (client_json.endpoint_type != null && client_json.endpoint_type=="secondary") {
            client_config_prefix = '/client_secondary_';
            delete client_json.endpoint_type;
        }

        var client_config = JSON.parse(fs.readFileSync(constants.PATH_CLIENT + client_config_prefix + utils.getInstanceId() + '.json', 'utf8'));
        var client_headers = client_config.headers;
        var client_extras = client_config.extras;

        if (client_config.method_type == "json") {

            client_json.event_json['extras'] = client_extras;

            var base64_images = [];

            if (client_config.base64_encode) {
                var event_each_img_path = null;
                if (client_json.event_json.version !=null && client_json.event_json.version == "2.0"){
                    event_each_img_path = client_json.event_json.images.pipeline;
                }
                else{
                    event_each_img_path = client_json.event_json.event.properties.path;
                }
                for (var i = 0; i < event_each_img_path.length; i++) {
                    base64_images.push(utils.base64_encode(event_each_img_path[i]));
                }

                client_json.event_json['base64_images'] = base64_images;
            }

            if (client_json.event_json.version !=null && client_json.event_json.version == "2.0"){
                if (client_json.event_json.images.cloud_images.length>0){
                    client_json.event_json.images["cloud"] = client_json.event_json.images.cloud_images
                }
                delete client_json.event_json.images.cloud_images

                if (client_json.event_json.images.local_images.length>0){
                    client_json.event_json.images["local"] = client_json.event_json.images.local_images
                }
                delete client_json.event_json.images.local_images
            }

            let copy_non_base_client_json = JSON.parse(JSON.stringify(client_json.event_json));
            delete copy_non_base_client_json.base64_images
            utils.log(constants.DEBUG_INFO, "JSON sent to Client, removed base64 string from logs \n" + utils.getPrettyJSON(copy_non_base_client_json));
            unirest.post(client_config.url)
                .headers({
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                })
                .headers(client_headers)
                .timeout(constants.APP_REQUEST_TIMEOUT)
                .send(client_json.event_json)
                .end(function (response) {

                    utils.log(constants.DEBUG_LOG, "Response from client\n" + utils.getPrettyJSON(response));
                    utils.log(constants.DEBUG_INFO, "Status code from client " + response.status);

                    console.log(response.statusType, "here is the response from " + client_config_prefix.substring(1, client_config_prefix.length-1) + " source");
                    if (response.statusType == 2) {
                        callback(true);
                    } else {
                        callback(false);
                    }
                });

        } else {

            //Client specific custom code comes here for secondary endpoint.

            callback(true);

        }
    },
    sendEventToSecondaryClient: function (client_json, callback) {
        client_json["endpoint_type"] = "secondary";
        this.sendEventToClient(client_json, function(status) {
            callback(status);
        });
    }
};
