# README

We are creating a mobile app that allows a user to trim videos.
User uploads video and defines timing parameters: start time, end time.
After that video will be trimmed using that timing.
You will need to create a backend server that will provide an API for this app.

### The main app functionalities

- User can use the mobile app to upload video and define timing parameters.
After that, the request must be processed in the background.
- User can see the list of the request with their statuses(done, failed, scheduled, processing).
- User can restart failed requests.
- When a new user starts using a mobile app, the app sends a request to the server for a unique key which is used to subscribe user requests to identify user.
- API has to return information about all errors in proper format including validation errors.
- All videos should be returned in form of a link to the video and video duration
- We will need to handle different  versions of the app depending for different clients.
That’s why we need API versioning mechanism

### Requirements

- You need to implement backend and create an API format with API documentation
- You can use any language and any framework of your choice as well as third party libraries.
- You need to use noSql database

Please note that you can implement a real video processing using any library you want.
Another option is to emulate video processing using time delay (from 20 seconds to 2 minutes) and returning link to the source video.
