# What is this?

This is just a simple example app that shows how to use the facebook graph api to retrieve content from a facebook page and its connected resources.

The app is powered by __Sinatra__ and is built to run on __Heroku__. The views are based on __HTML5 Boilerplate__ and written in __HAML__ and __SASS__. Facebook's Graph API is queried using the __Koala__ gem and responses are cached by __Redis__.

## Out of the box this apps supports

* Showing news, events, pictures and an about page of the facebook page.

* Semantic and search engine friendly representation of the data.

* Support for Google Analytics and sitemaps.

* Support for Open Graph tags.

* Built-in caching for fast responses.

* I18n support.

_Note:_
This is more or less just a proof of concept. It won't handle every use case perfectly. But it's also easy to extend and a good place to start. :)

# How to get started

## On Facebook

* Get a developer account

* Create a facebook page

* Create an app (to get the page information via the graph api)

## Install Dependencies

`$ bundle install`

## Setting Environment Variables

In order to start the application you need to set the following environment variables:

* `DATA_FACEBOOK` - Contains information about the page, app credentials and administrators.

* `DATA_GOOGLE` - Contains Google Analytics ID.

* `REDISTOGO_URL` - Only for production. Will be set __automatically__ by Heroku. :)

Example for setting the environment variables on your local dev machine:

__Facebook__

```
$ export DATA_FACEBOOK=page_id,YOUR_PAGE_ID,app_id,YOUR_APP_ID,app_secret,YOUR_APP_SECRET,fb_page_path,YOUR_PAGE_URL,admin_id,YOUR_FB_USER_ID
```

* `YOUR_PAGE_ID`- The id of the fb page you want to use

* `YOUR_APP_ID`- App id of the facebook app you want to use to query the graph API

* `YOUR_APP_SECRET`- App secret of the facebook app

* `YOUR_PAGE_URL`- The URL of your facebook page, e.g. `fb_page_path,pages/my_fb_page/1234567890`

* `YOUR_FB_USER_ID` - Your user id (for open graph meta information)

__Google__

```
$ export DATA_GOOGLE=analytics,UA-XXXXXXXX-X
```

## Create Heroku App

`heroku create --stack cedar`

Add redis for caching

`heroku addons:add redistogo:nano`

Add the environment variables to the heroku config (see above)

`heroku config:add DATA_FACEBOOK=YOUR_DATA`
`heroku config:add DATA_GOOGLE=YOUR_DATA`

Now push the app to heroku!

`git push heroku master`

Manage your Events, Images and About page via facebook and have fun! :)