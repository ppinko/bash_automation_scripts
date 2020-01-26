#!/usr/bin/env bash

# script sending an automatic email to remaind about upcomming birthday
# of a friend or a family member.
# Remainder is set to send an email 7 days before the given date, and
# in the following days up to the event.

# defining assosiative array with birthdays of your relatives and friends
declare -A birthdays
birthdays["mum"]="1970-01-15"
birthdays["dad"]="1968-02-01"
birthdays["sister"]="1992-05-01"
birthdays["brother"]="1995-11-28"
birthdays["wife"]="1989-07-30"
birthdays["friendName"]="1991-01-26"

# day of the year
day_year=`date +%j`

# main logic 
for person in "${!birthdays[@]}"
do
	temp_var=`date -d ${birthdays[$person]} +%j`
	var=`expr $temp_var - $day_year`
	echo $var
	if [[ $var -le 7 ]] && [[ $var -gt 0 ]]; then
		sudo mail -s "birthday" p.pinkowicz@gmail.com <<< "${person^} has \
birthday in $var day(s)"
	elif [[ $var -eq 0 ]]; then
		sudo mail -s "birthday" p.pinkowicz@gmail.com <<< "${person^} has \
birthday today"
	fi
done

