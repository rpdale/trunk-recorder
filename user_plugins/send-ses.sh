### This will email the audio file for talkgroup IDs you want

#!/bin/bash

sesFile="$1"

# Define the list of TGIDs
string_list=("109-" "220-" "229-" "242-" "243-" "391-" "241-") #Replace with the talkgroup IDs you want emailed

# Flag to track if a match is found
match_found=false

# Loop through the list of strings
for item in "${string_list[@]}"; do

  if grep -q -e "$item" <<< "$1"; then
    match_found=true
    break # Exit the loop once a match is found
  fi
done

if $match_found; then
sesAccess='xxx'
sesSecret='xxx'
sesFromName="From Name"
sesFromAddress="from.email@.com"
sesToName="To Name"
sesToAddress="to.email@.com"
sesSubject="Subject"
sesSMTP="email-smtp.us-east-1.amazonaws.com" #Or whatever Amazon server you use
sesPort="465"
sesMessage="MessageTitle"
sesMIMEType=`file --mime-type "$sesFile" | sed 's/.*: //'`

eval "curl -v --url smtps://$sesSMTP:$sesPort --ssl-reqd  --mail-from $sesFromAddress --mail-rcpt $sesToAddress  --user $sesAccess:$sesSecret -F '=(;type=multipart/mixed' -F \"=$sesMessage;type=text/plain\" -F \"file=@$sesFile;type=audio/x-wav;encoder=base64\" -F '=)' -H \"Subject: $sesSubject\" -H \"From: $sesFromName <$sesFromAddress>\" -H \"To: $sesToName <$sesToAddress>\" > /dev/null 2>&1"
fi


#### Call this with
####   "uploadScript": "/app/send-ses.sh"
#### In your "systems" section
