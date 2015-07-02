# Ubr

A command-line Uber client. Request an Uber from your command line.

## Synopsis and Example

```
$ from_central_embassy=13.743704,100.546668
$ to_the_emquatier=13.730656,100.569770
$ ubr $from_central_embassy $to_the_emquatier -p uberX
Searching for available Ubers...
Selected: uberX
Getting the ETA...
Pickup in 4 minutes.
Estimation:
- Distance: 2.82 miles
- Pickup 09:59
- Dropoff 10:10
- Price: ฿52-61 (no surge)
Do you want to request an uberX? (y to confirm): y
Done! Please check your phone.
```

## Disclaimer

This app will request an Uber on your behalf, and
you will pay for any ride initiated by this application.

While I strive to make this tool as stable and bug-free as possible,
I could not make any guarantee that it does not contain a bug that may cause unintended requests to be sent, which may lead to monetary loss.
Therefore, please this tool at your own risk.

## Installation

```
gem install ubr
```

## Usage

To keep the Uber system safe, only an application's developer will be able to
request a ride until the app is approved by Uber.
My original `ubr` application has not been approved yet.
Therefore, you need to [create your own application](https://developer.uber.com/apps).

Set these information:

- __Callback URL:__ https://dtinth.github.io/ubr/callback.html
- __Privacy Policy URL:__ https://github.com/dtinth/ubr#privacy-policy

As of writing, it is OK to keep the webhook URLs blank.

After registering, you should get a __client ID__ and __secret__.
To login, run this command:

```
ubr login xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

It should open a browser and let you log in to the application.
Upon completion, it should redirect you to a page where it says:

```
ubr authorize 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' 'https://dtinth.github.io/ubr/callback.html'
```

Copy and paste that into the terminal.
It will ask you to provide the secret key.
Paste in the secret key and press enter.

```
Give me your secret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Hurray! Your are authorized!
The token is saved to /Users/username/.ubr
```

Now, you can request an Uber by running this command:

```
ubr PICKUP DROPOFF
```

Where __PICKUP__ and __DROPOFF__ are the coordinates to pick-up and drop-off,
specified in `LATITUDE,LONGITUDE` format.
It is useful to put these coordinates as shell variables.
You can also add `-p` option to specify product type, e.g., `-p uberX`.


## Privacy Policy

This privacy policy applies only to the authentic copy of `ubr` application.
We do not keep your personal information.
Only your `client_id` and the `authorization_code` is sent to GitHub Pages server for the purpose of making logins easier.
These two pieces of information are then combined with the `secret` key, which you supply in your own computer, to exchange for the `access_token`.
The `access_token` is then kept on your computer.
