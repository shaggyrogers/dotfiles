#!/bin/bash
lockimg='/home/michael/Pictures/Wallpapers/orangemountain2560x1600.png'

# Time & Date
timepos='x+0.5*w-0.5*cw:y+0.5*h-0.5*ch'
timecolor='#FFFFFFCC'
timesize=48
datecolor='#FFFFFFCC'
datesize=24
tdopts="--timepos='$timepos' --timecolor='$timecolor' --timesize=$timesize --datecolor='$datecolor' --datesize='$datesize'"

# Status Indicator - Inside, Status Text
veriftext=''
wrongtext=''
radius=60
indpos="x+1.8*r:y+h-1.8*r"
insidevercolor='#FFFFFF88'
insidewrongcolor='#FF111188'
insidecolor='#00000000'
siopts="--indicator --radius=$radius --indpos='$indpos' --veriftext='$veriftext' --wrongtext='$wrongtext' --insidevercolor='$insidevercolor' --insidewrongcolor='$insidewrongcolor' --insidecolor='$insidecolor'"

# Status Indicator - Ring
ringcolor='#FFFFFFCC'
ringvercolor='#FFFFFFCC'
ringwrongcolor='#FFFFFFCC'
linecolor='#00000000'
separatorcolor='#00000000'
keyhlcolor='#11FF11CC'
bshlcolor='#FF1111CC'
siropts="--ringvercolor='$ringvercolor' --ringwrongcolor='$ringwrongcolor' --ringcolor='$ringcolor' --linecolor='$linecolor' --separatorcolor='$separatorcolor' --keyhlcolor='$keyhlcolor' --bshlcolor='$bshlcolor'"

#eval $lockCmd
echo $lockCmd
