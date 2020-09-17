#!/bin/sh

dependencies_are_installed=`which youtube-dl`

if [ -z ${dependencies_are_installed+x} ]
then
    # install app dependencies
    echo Dependencies are not installed.....installing them
    sudo wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
    echo All packets are installed correctly....OK
else
    echo All packets are installed correctly....OK
fi

read -p 'Enter YouTube URL: ' URL
read -p 'Start time(hh:mm:ss.mi): ' start_time
read -p 'End time(hh:mm:ss.mi): ' end_time
read -p 'Name for output video: ' video_name

youtube-dl -g $URL > two_links.txt # create the input for the c++ file

g++ separate_links.cpp -o a.out # compile c++ code
./a.out # make two different files, each with its link

# get links in different variables
first_link=`cat first_link.txt` 
second_link=`cat second_link.txt`
# remove redundant files
rm two_links.txt first_link.txt second_link.txt a.out

# actually begin the downloading process of the given video, having the given time limits
ffmpeg -ss $start_time -i $first_link -ss $start_time -i $second_link -to $end_time -map 0:v -map 1:a -c:v libx264 -c:a aac $video_name