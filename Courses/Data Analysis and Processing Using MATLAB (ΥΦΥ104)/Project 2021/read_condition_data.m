function [cases,deaths] = read_condition_data(cases, deaths)
%read_condition_data Read and condition data of a country
%   INPUT: cases, deaths
%   OUTPUT: cases, deaths (after conditioning)
%   Removes negative and NaN values from cases & deaths
%   For cases, to take into account reduced tests & reports during the
%   weekend, the conditioning function smooths the data over a 7-day
%   interval

for i=1:length(cases)
    if(cases(i)<0)
        cases(i) = - cases(i);
    end
    if(isnan(cases(i)))
        if(i==1 || i==length(cases))
            cases(i) = 0;
        else
            cases(i) = round((cases(i+1)+cases(i-1))/2);
        end
        if(isnan(cases(i)))
            cases(i) = 0;
        end
    end
    
    if(deaths(i)<0)
        deaths(i) = - deaths(i);
    end
    if(isnan(deaths(i)))
        if(i==1 || i==length(cases))
            deaths(i) = 0;
        else
            deaths(i) = round((deaths(i+1)+deaths(i-1))/2);
        end
        if(isnan(deaths(i)))
            deaths(i) = 0;
        end
    end
end
cases = round(smoothdata(cases,'movmean',7));
end

