function AirportList = getAirportData(filePath)
    filePath = fullfile(filePath,'airport_database.mat');
    data = load(filePath,'airport_databaseCopy');
    AirportList = data.airport_databaseCopy;
    AirportList = movevars(AirportList, 'name', 'Before', 'type');
    AirportList.coordinates = cell2mat(AirportList.coordinates);
end

