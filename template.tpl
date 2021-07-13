___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "TikTok Conversions API Tag",
  "categories": ["CONVERSIONS"],
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "access_token",
    "displayName": "Access Token",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "pixel_code",
    "displayName": "Pixel Code",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_SERVER___

const setResponseBody = require('setResponseBody');
const setResponseStatus = require('setResponseStatus');
const setResponseHeader = require('setResponseHeader');
const getTimestampMillis = require('getTimestampMillis');
const sendHttpRequest = require('sendHttpRequest');
const JSON = require('JSON');
const getAllEventData = require('getAllEventData');
const makeString = require('makeString');
const makeNumber = require('makeNumber');

// Constants
const API_ENDPOINT = "https://ads.tiktok.com/open_api";
const API_VERSION = "v1.2";

// Mapping of incoming event to TikTok event.
const GTM_EVENT_MAPPINGS = {
  "purchase": "Purchase",
};

// Mapping of incoming event to TikTok endpoint.
const EVENT_API_MAPPINGS = {
  "purchase": "pixel/track/"
};

const eventModel = getAllEventData();

const eventName = GTM_EVENT_MAPPINGS[eventModel.event_name];
const event = {
  "pixel_code": data.pixel_code,
  "event": eventName,
  "timestamp": makeString(getTimestampMillis()),
};

if (eventName == "Purchase") {
  event.properties = {
    currency: eventModel.currency,
    value: makeNumber(eventModel.value)
  };
}

// Complete endpoint based on incoming event.
const endpoint = [API_ENDPOINT, API_VERSION, EVENT_API_MAPPINGS[eventModel.event_name]].join("/");

// HTTP Request sent to TikTok to trigger a conversion
sendHttpRequest(endpoint, (statusCode, headers, body) => {
  setResponseBody(body);
  setResponseHeader(headers);
  setResponseStatus(statusCode);
  if (statusCode >= 200 && statusCode <= 300) {
    data.gtmOnSuccess();
  } else {
    data.gtmOnFailure();
  }
}, {headers: {
  'Content-Type': 'application/json',
  'Access-Token': data.access_token,
}, method: 'POST', timeout: 2000}, JSON.stringify(event));


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_response",
        "versionId": "1"
      },
      "param": [
        {
          "key": "writeResponseAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "writeHeaderAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://ads.tiktok.com/open_api/*"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 12/07/2021, 14:45:24


