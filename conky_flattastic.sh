#!/bin/bash
sleep 20
conky -c ~/.conky/conky-ring/conkyrc_ring &
conky -c ~/.conky/conky-weather/conkyrc_weather &
conky -c ~/.conky/conky-calendar/conkyrc_calendar &
conky -c ~/.conky/conky-rss/conkyrc_rss_archlinux &
conky -c ~/.conky/conky-dash/conkyrc_dash_archlinux
exit 0
