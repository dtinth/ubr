# Ubr

A command-line Uber client. Request an Uber from your command line.

## Synopsis and Example

```
$ work=13.742441,100.547168
$ apartment=...
$ ubr $from_apartment $to_office -p uberx
Searching for available Ubers...
Selected: uberX
Getting the ETA...
Pickup in 4 minutes.
Estimation:
- Distance: 2.69 miles
- Pickup 09:59
- Dropoff 10:10
- Price: ฿52-61 (no surge)
Do you want to request an uberX? (y to confirm): y
Done! Please check your phone.
```

## Disclaimer

This app will request an Uber on your behalf.
You will pay for the ride initiated by this application.

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

Set the callback URL to `https://dtinth.github.io/ubr/callback.html`.
As of writing, it is OK to keep the webhook URLs blank.


```
ubr login
```



```
ubr PICKUP DROPOFF
```
