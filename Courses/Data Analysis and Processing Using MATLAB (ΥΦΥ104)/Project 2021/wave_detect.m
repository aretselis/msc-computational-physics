function [wave_start,wave_end,date_start_string,date_end_string] = wave_detect(dates, incidents, percent)
%wave_detect Detects beginning and end of wave for a given percent
%   INPUT: dates, incidents (could be cases or deaths), percent
%   OUTPUT: wave_start and wave_end as values or as strings (to be printed)
%   User needs to give a cut-off percent for the function to work with. For
%   most European countries, 0.1 (10%) is sufficient, but for some the
%   percentage needs to be higher.

wave_start = 1;
max_incidents = max(incidents(1:(length(incidents)/2))); % Find max cases in first half of 2020
for i=1:length(dates)-7
    if(mean(incidents(i:i+5))<max_incidents*percent)
        continue
    elseif(mean(incidents(i:i+5))>max_incidents*percent)
        wave_start = i;
        for j=wave_start+30:length(dates)-7
            if(mean(incidents(j:j+7))<max_incidents*percent)
                wave_end = j;
                break;
            end
        end
        break;
    end
end

date_start_string = datestr(dates(wave_start)+datenum('30-Dec-1899'));
date_end_string = datestr(dates(wave_end)+datenum('30-Dec-1899'));
fprintf('Wave one starts on %s and ends on %s\n', date_start_string,...
    date_end_string);
end
