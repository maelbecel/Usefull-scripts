################
## Wakatime integration in bash
## github.com/maelbecel
################

## Input here the embeddable url from https://wakatime.com/share/embed/
## Select "JSON" and "Coding Activity" and click on "Get embeddable code"
## Then get the url in the code and paste it in apiurl

apiurl="https://wakatime.com/share/@maelbecel/d42f50c1-3a02-40ee-a8a4-7afd9a94d35c.json"

json=$(curl -s "$apiurl")

if [ -z "$json" ]; then
    echo "No data"
    exit 1
fi

res=$(echo $json | grep -o '"digital": "[^"]*' | grep -o '[^"]*$')

IFS='\n \t' read -r -a array <<< $(echo $res)

IFS=':' read -r -a today <<< $(echo ${array[-1]})


hours=0
minutes=0

for element in "${array[@]}"
do
    IFS=':' read -r -a day <<< $(echo $element)
    h=$(expr ${day[0]})
    hours=$((hours + h))
    m=$((10#$(expr ${day[1]})))
    minutes=$((minutes + m))

    if [ $minutes -ge 60 ]; then
        hours=$((hours + 1))
        minutes=$((minutes - 60))
    fi
done

average=$((hours * 60 + minutes))
average=$((average / 7))

hours_av=$((average / 60))
minutes_av=$((average % 60))

draw_bar()
{
    len=50
    fill=$1
    total=$2
    percent=$((fill * 100 / total))

    green=$((fill * len / total))
    red=$((len - green))

    if [ $percent -ge 100 ]; then
        echo -ne "\e[1;32m"
        perl -E "print '█' x $len"
        echo -ne "\e[0m"
    else
        echo -ne "\e[1;32m"
        perl -E "print '█' x $green"
        echo -ne "\e[0m"
        echo -ne "\e[1;31m"
        perl -E "print '█' x $red"
        echo -ne "\e[0m"
        echo -ne "\e[1;37m"
    fi
    echo -ne "\e[01m\e[30m\e[47m"
    percent=$((percent - 100))
    if [ $percent -ge 0 ]; then
        echo -ne " +$percent%"
    else
        echo -ne " $percent%"
    fi
    echo -e "\e[0m"
}

hours_to=$((10#${today[0]}))
minutes_to=$((10#${today[1]}))

echo -e "\e[01m\e[30m\e[47m"
echo "Total time coding this week: $hours hours and $minutes minutes."
echo "Total time coding today: $hours_to hours and $minutes_to minutes."

draw_bar $((hours_to * 60 + minutes_to)) $((average))

echo -ne "\e[01m\e[30m\e[47m"
echo -e "Average time coding this week: $hours_av hours and $minutes_av minutes  per day."
echo -e "\e[0m"

if [ -f "~/scripts/wakares.json" ]; then
    rm ~/scripts/wakares.json
fi