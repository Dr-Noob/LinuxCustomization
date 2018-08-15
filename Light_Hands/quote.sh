#!/bin/bash -u

quote_file='/tmp/.conky_quote'
author_file='/tmp/.conky_author'
regex_quote='<dt>(.*)</dt>'
regex_author='<dd class="author"><b>(<a href[^>]+>)?([^<]+).*'
max_chars=140
num_online_quotes=39802
ret=1

while [ $ret -ne 0 ]
do
  rand_online=$[ ( $RANDOM % $num_online_quotes ) + 1 ]
  #rand_online=4719
  #echo $rand_online
  quote_page=$(wget -q -O - "http://www.quotationspage.com/quote/$rand_online.html")
  quote=$(echo "$quote_page" | grep -e '<dt>')
  author=$(echo "$quote_page" | grep -e '<dd class="author">')

  if [[ $quote = *"ERROR"* ]]; then
    ret=1
  else

    # Get quote
    if [[ $quote =~ $regex_quote ]]
    then
        quote="${BASH_REMATCH[1]}"
        #Remove <br> if present
        quote=${quote//<br>/}

        #Check quote is small enough
        if [ $(echo $quote | wc | awk '{print $3}') -lt $max_chars ];
        then
          # Quote is ok, get author
          if [[ $author =~ $regex_author ]]
          then
              author="${BASH_REMATCH[2]}"
              ret=0
          else
              ret=1
          fi
        fi


    else
        ret=1
    fi

  fi

done

#Output to where conky expects it
echo -n '"'$quote'"' > $quote_file
echo -n '- '$author > $author_file
