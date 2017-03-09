# Flattastic-Conky
Conky theme made for Flattastic GTK Theme.

# Installation
1. Install conky, bash, lua, curl, wget, python and python-feedparser packages.Ubuntu(and derivatives) users also have to install aptitude package.

# First of All
1. Open conky_flattastic.sh file and change archlinux to ubuntu (for Ubuntu users).
2. Open ~/.conky/conky-dash/gmail.py file and enter your username and password.
3. Open ~/.conky/conky-weather/conkyrc_weather file and search for "29389202" and replace it with the WOEID of your own location. To find your WOEID, browse or search for your city from the Yahoo Weather home page - http://weather.yahoo.com/ . The WOEID is in the URL for the forecast page for that city. To switch between unit modes (Celsius and Fahrenheit) search for "&u=c" and change it to "&u=f".

# To Start Conky
```bash
$ sh conky_flattastic.sh
```
or add this command to your startup applications. 

# Note
Conky-rss uses ~/Pictures folder for slidshow. To change it open ~/.conky/conky-rss/slideshow.sh and put your desired folder,but you have to keep formatting. Also you can change rss url address for feeds in file ~/.conky/conky-rss/rss.py.

There is two calendar conkys. First is simple calendar,and second is calendar with events from google calendar. You have to edit conky_flattastic.sh file if you want to include google calendar events(change conkyrc_calendar to conkyrc_google_calendar). To make google calendar to work you have to open file ~/.conky/conky-calendar/conkyrc_google_calendar and put your private rss address. See here how to get the address: https://support.google.com/calendar/answer/37648
Also it is very important to set the same language in google calendar and in your system,in order to work this conky widget. If you have problem to set language,there is a trick to get rss on desired language,just put on the end of url "?hl=en" without quotes ("en" for english, "de" for german etc.)  

If you have screen resolution other than 1920x1080 it is possible that some images and text won't be properly aligned. Then you have to adjust settings in lua and conkyrc files.

# Screenshot
![image](http://s24.postimg.org/w10ur3wxh/conky_flat.jpg)

# Credit to
[nale12](http://nale12.deviantart.com/)

