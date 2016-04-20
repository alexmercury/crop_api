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

## Install FFmpeg (Ubuntu)

FFmpeg has been removed from Ubuntu 14.04 and was replaced by Libav.
This decision has been reversed so that FFmpeg is available now in Ubuntu 15.04 again, but there is still no official package for 14.04.
In this tutorial, I will show you how to install FFmpeg from mc3man ppa. Add the mc3man ppa:

    sudo add-apt-repository ppa:mc3man/trusty-media
    
And confirm the following message by pressing <enter>:

    Also note that with apt-get a sudo apt-get dist-upgrade is needed for initial setup & with some package upgrades
    More info: https://launchpad.net/~mc3man/+archive/ubuntu/trusty-media
    Press [ENTER] to continue or ctrl-c to cancel adding it

Update the package list:

    sudo apt-get update
    sudo apt-get dist-upgrade
    
Now FFmpeg is available to be installed with apt:

    sudo apt-get install ffmpeg