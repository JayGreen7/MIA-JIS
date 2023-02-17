function airportList = getAirportList(network,exclude,filePath)
    airportList = getAirportData(filePath);
    rank = regexp(network, '(\d*)','match');
    if(~isempty(rank))
        airportList = airportList(airportList.RankCategory <= str2double(rank),:);
    end
    airportList.RankCategory = [];
    airportList = jsonencode(airportList);
end

