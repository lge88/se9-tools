function uid = nextUID_(currentUID, reversed)
FIRST_UID = 2;
LAST_UID = 176;
if reversed
    nextUIDInt = str2double(currentUID)-1;
else
    nextUIDInt = str2double(currentUID)+1;
end

if nextUIDInt > LAST_UID
    nextUIDInt = FIRST_UID;
elseif nextUIDInt < FIRST_UID
    nextUIDInt = LAST_UID;
end

uid = sprintf('%03d', nextUIDInt);
end

