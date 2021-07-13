# Google Tag Manager Template for TikTok Conversions API (server-side)
This template can be used in a S2S integration with Google Tag Manager. It uses the TikTok Marketing API to send events directly to TikTok. This means that events are processed similar to other information shared via other TikTok data integrations business tools.

To read more about the TikTok Marketing API being used [click here](https://ads.tiktok.com/marketing_api/docs?rid=q442fp0md9d&id=1701890979375106)


## Getting started
1. Download the template.tpl file
2. Navigate to your Google Tag Manager Server Container
3. In the left pane click `Templates`
4. Under Tag Templates click the `New` button
5. In the top right corner click the three dots and import the template.tpl file from the previous step
6. Fill in the Access Token and Pixel Code field in the Tag configuration ([see TikTok Auth Requirements for info on how to get an Access Token](https://ads.tiktok.com/marketing_api/docs?rid=q442fp0md9d&id=1701890979375106))
7. Save the template and go back
8. In the left pane click `Tags` and add a Trigger for the newly imported Tag

## Supported events
Currently this template only allows for tracking conversions.

--------
Example event:
```
{
  "event_name": "purchase",
  "currency": "EUR",
  "value": 123
}
```
