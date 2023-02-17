function [result] = getParameterList(filePath)
    %data1 = getConfigurationData(filePath,"MVM_data_2050_MoreTechnology.mat");
    %data2 = getConfigurationData(filePath,"MVM_data_2050_BasicTechnology.mat");
    %data3 = getConfigurationData(filePath,"MVM_data_2021_MoreTechnology.mat");
    %data4 = getConfigurationData(filePath,"MVM_data_2021_BasicTechnology.mat");
    
    %data = [data1;data2;data3;data4];
    
    airportList = getAirportData(filePath);   
    
    %path = fileparts(which("MVM_data_2021_BasicTechnology.mat"));
    %files = dir(fullfile(path,'MVM_data_2*.mat'));
    %files = strrep({files.name},'MVM_data_','');
    %files = strrep(files,'.mat','');
    
    %params = cellfun(@(c) strsplit(c,'_'), files', 'UniformOutput', false);
    %params = cell2table(vertcat(params{:}),'VariableNames',{'Year','AircraftOptimism'});
    
    year.Name = "Year";
    year.Options = ["2020","2035","2050"];
    year.Values = year.Options(1);
    %year = addYearDescription(year);
    year.ParamDescription = '';
    BaseParameterList = year;
    
        
    stops.Name = "Stops";
    stops.Options = ["0","1","2+"];
    stops.Values = "2+";
    %stops = addStopsDescription(stops);
    stops.ParamDescription = '';
    BaseParameterList(end+1) = stops;
    
%     climateImpact.Name = "ClimateImpact";
%     climateImpact.Options = ["Lowest Total CO2 (Net-zero)","Lowest Direct CO2 (True-zero)"];
%     climateImpact.Values = climateImpact.Options(1);
%     climateImpact = addClimateImpactDescription(climateImpact);
%     BaseParameterList(end+1) = climateImpact;
    
    reduce.Name = "Reduce";
    reduce.Options = ["Land use","Fossil use","Biomass use","Electricity use","Fuel cost"];
    reduce.Values = "Electricity use";
    %reduce = addReduceDescription(reduce);
    reduce.ParamDescription = '';
    BaseParameterList(end+1) = reduce;
    
    optimism.Name = "AircraftOptimism";
    optimism.Icon = "RiPlaneFill";
    optimism.Colors = ["#668925","#000805"];
    %optimism.Options = string(unique(params.(optimism.Name)))';
    optimism.Options = ["Best Case","Average Case","Worst Case"];
    optimism.isMulti = false;
    optimism.Values = optimism.Options(2);
    %optimism = addAircraftOptimismDescription(optimism);
    optimism.ParamDescription = '';
    TechnologyList = optimism;
    
    fuelOptimism.Name = "FuelOptimism";
    fuelOptimism.Icon = "MdLocalGasStation";
    fuelOptimism.Colors = ["#000805","#668925","#E33E33"];
    %fuelOptimism.Options = string(unique([data.(fuelOptimism.Name){:}]))';
    fuelOptimism.Options = ["Best Case","Average Case","Worst Case"];
    fuelOptimism.isMulti = false;
    fuelOptimism.Values = fuelOptimism.Options(1);
    %fuelOptimism = addFuelOptimismDescription(fuelOptimism);
    fuelOptimism.ParamDescription = '';
    TechnologyList(end+1) = fuelOptimism;

%     tech.Name = "Technology";
%     tech.Options = string(unique(data.(tech.Name)))';
%     tech.Values = tech.Options;
%     TechnologyList(end+1) = tech;
    
%     exclude.Name = "Exclude";
%     exclude.Icon = "BsXOctagon";
%     exclude.Colors = ["#000805","#668925"];
%     exclude.Options = ["Contrail Impact","Fossil Fuel"];
%     exclude.Values = [];
%     exclude.isMulti = false;
%     ValueJudgementList = exclude;
            
    smallAirport.Name = "NetworkSelection";
    smallAirport.Options = arrayfun(@formatNetwork,unique(airportList.RankCategory));
    smallAirport.Values = smallAirport.Options(1);
    smallAirport.isMulti = false;
    %smallAirport = addNetworkSelectionDescription(smallAirport);
    smallAirport.ParamDescription = '';
    SettingsList = smallAirport;
    
    grid.Name = "Electricity";
    grid.Options = ["Grid","Solar","Onshore Wind","Offshore Wind","Hydro (incl. Pumped Storage)","Nuclear"];
    grid.Values = "Grid";
    grid.isMulti = true;
    %grid = addElectricityDescription(grid);
    grid.ParamDescription = '';
    SettingsList(end+1) = grid;
    
    aircraft.Name = "Aircraft";
    aircraft.Options = ["Oil Tanker","Bulk Carrier","Container Ship","Cruiseship"];
    aircraft.Values = "Oil Tanker";
    aircraft.isMulti = true;
    %aircraft = addAircraftDescription(aircraft);
    aircraft.ParamDescription = '';
    SettingsList(end+1) = aircraft;
% 
    fuel.Name = "Fuel";
    fuel.Options = ["Heavy Fuel Oil","LNG","Marine Diesel Oil","Raw Biomass","Ammonia (Combustion)","Ammonia (Cracking)","Methanol","Synthetic Fossil Fuel","Battery","Nuclear","Liquid Hydrogen","Biodiesel","Fermentation"];
    fuel.Values = "Heavy Fuel Oil";
    fuel.isMulti = true;
    %fuel = addFuelDescription(fuel);
    fuel.ParamDescription = '';
    SettingsList(end+1) = fuel;

% 
    fuelProd.Name = "Fuel_prod";
    fuelProd.Options = ["From Fossil Fuels","From Fossil Fuels with Carbon Capture","From Biomass","From Electricity","From Solid Waste","From Vegetable Oil","Li-Ion"];
    fuelProd.Values = "From Fossil Fuels";
    fuelProd.isMulti = true;
    %fuelProd = addFuelProdDescription(fuelProd);
    fuelProd.ParamDescription = '';
    SettingsList(end+1) = fuelProd;
% 
%     fuelName.Name = "FuelName";
%     fuelName.Options = string(unique(data.(fuelName.Name)))';
%     fuelName.Values = fuelName.Options(1:end);
%     fuelName.isMulti = true;
%     fuelName = addFuelNameDescription(fuelName);
%     SettingsList(end+1) = fuelName;

    layover.Name = "AverageLayover";
    layover.Options = [0,24];
    layover.Values = 2;
    layover.isMulti = false;
    %layover = addAverageLayoverDescription(layover);
    layover.ParamDescription = '';
    SettingsList(end+1) = layover;
    
    aircraftLoad.Name = "AircraftLoadFactor";
    aircraftLoad.Options = ["70%", "75%", "80%"];
    aircraftLoad.Values = ["75%"];
    %aircraftLoad = addAircraftLoadFactorDescription(aircraftLoad);
    aircraftLoad.ParamDescription = '';
    aircraftLoad.isMulti = false;
    SettingsList(end+1) = aircraftLoad;
    
    contrails.Name = "Contrails date and time";
    contrails.Options = ["All","Day winter","Night winter","Day summer","Night summer"];
    contrails.Values = ["All"];
    %contrails = addContrailsDescription(contrails);
    contrails.ParamDescription = '';
    contrails.isMulti = false;
    SettingsList(end+1) = contrails;
%     transport.Name = "GroundTransportation";
%     transport.Options = ["Train","Car","Bus"];
%     transport.Values = "Car";
%     transport.isMulti = false;
%     SettingsList(end+1) = transport;
    
%     excludeAirport.Name = "ExcludeAirports";
%     options = string({table2struct(getAirportData(filePath)).airport_tag_long});
%     options = strrep(options,'"',"'");
%     excludeAirport.Options = options;
%     excludeAirport.Values = [];
%     excludeAirport.isMulti = true;
%     SettingsList(end+1) = excludeAirport;
    
%     emissions.Name = "AddEmissions";
%     emissions.Options = ["Contrails","NOx","SOx"];
%     emissions.Values = [];
%     emissions.isMulti = true;
%     SettingsList(end+1) = emissions;
    
    result.BaseParameterList = BaseParameterList;
    result.TechnologyList = TechnologyList;
    result.SettingsList = SettingsList;
    result = jsonencode(result); 
end
