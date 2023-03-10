function output = simulateJourney(input)

    %dist_km,ship_type,fuel_type,prod_method,deadweight,speed,elec,bio
    input = jsondecode(input);

    output.Origin = input.Origin;
    output.Destination = input.Destination;
    output.BaseParameterList = input.BaseParameterList;
    output.TechnologyList = input.TechnologyList;
    output.SettingsList = input.SettingsList;

    dist_km = computeDistance(input.Origin.name,input.Destination.name);
    ship_type = 'Oil Tanker'; %Need to implement input on front end for this
    idx_fuel = find(strcmp({input.SettingsList(:).Name}, 'Fuel'));
    fuel_type = input.SettingsList(idx_fuel).Values(1);
    idx_fpro = find(strcmp({input.SettingsList(:).Name}, 'Fuel_prod'));
    prod_method = input.SettingsList(idx_fpro).Values(1);
    idx_elec = find(strcmp({input.SettingsList(:).Name}, 'Electricity'));
    elec = input.SettingsList(idx_elec).Values(1);
    bio = 'None Required'; %Need to implement input on front end for this
    deadweight = 122666; %Need to implement input on front end for this
    speed = 20; %Need to implement input on front end for this

    solutions = struct;
    solutions.('Route') = [];
    solutions.('Time')  = [0;0];
    solutions.('CO2')   = zeros(6,1);
    solutions.('Cost')  = zeros(5,1);
    solutions.('Distance') = 0;
    solutions.('Stops') = 0;
    solutions.('ContrailParameters') = [];

    solutions_fossil = struct;
    solutions_fossil.('Route') = [];
    solutions_fossil.('Time')  = [0;0];
    solutions_fossil.('CO2')   = zeros(6,1);
    solutions_fossil.('Cost')  = zeros(5,1);
    solutions_fossil.('Distance') = 0;
    solutions_fossil.('Stops') = 0;
    solutions_fossil.('ContrailParameters') = [];
            
    if strcmp(ship_type,'Oil Tanker') == 1
        data = readmatrix('OilTanker.csv');
    end
    if strcmp(ship_type,'Bulk Carrier') == 1
        data = readmatrix('BulkCarrier.csv');
    end
    if strcmp(ship_type,'Container Ship') == 1
        data = readmatrix('ContainerShip.csv');
    end
    if strcmp(ship_type,'Cruiseship') == 1 
        data = readmatrix('Cruiseship.csv');
    end        

    if strcmp(fuel_type,'Heavy Fuel Oil') == 1
        data1 = data(:,2);
    elseif strcmp(fuel_type,'Heavy Fuel Oil w/CCS') == 1
        data1 = data(:,3);
    elseif strcmp(fuel_type,'Liquid Natural Gas') == 1
        data1 = data(:,4);
    elseif strcmp(fuel_type,'Liquid Natural Gas w/CCS') == 1
        data1 = data(:,5);
    elseif strcmp(fuel_type,'Raw Biomass') == 1
        data1 = data(:,6:13);
    elseif strcmp(fuel_type,'Ammonia (Combustion)') == 1
        data1 = data(:,14:20);
    elseif strcmp(fuel_type,'Ammonia (Cracking)') == 1
        data1 = data(:,21:27);
    elseif strcmp(fuel_type,'Methanol') == 1
        data1 = data(:,28:34);
    elseif strcmp(fuel_type,'Synthetic Fossil Fuel') == 1
        data1 = data(:,35:39);
    elseif strcmp(fuel_type,'Battery') == 1
        data1 = data(:,40);
    elseif strcmp(fuel_type,'Nuclear') == 1
        data1 = data(:,41);
    elseif strcmp(fuel_type,'Liquid Hydrogen') == 1
        data1 = data(:,42:44);
    elseif strcmp(fuel_type,'Biodiesel') == 1
        data1 = data(:,45:46);
    elseif strcmp(fuel_type,'Heavy Vegetable Oil') == 1
        data1 = data(:,47);
    elseif strcmp(fuel_type,'Marine Diesel Oil') == 1
        data1 = data(:,48);
    elseif strcmp(fuel_type,'Marine Diesel Oil w/CCS') == 1
        data1 = data(:,49);
    else
        data1 = data(:,50:52);
    end

    %Different Biomass Choices
            
    if strcmp(fuel_type,'Raw Biomass') == 1
        if strcmp(bio,'Forestry Residue') == 1
            data2 = data1(:,1);
        elseif strcmp(bio,'Corn Stover') == 1
            data2 = data1(:,2);
        elseif strcmp(bio,'Miscanthus') == 1
            data2 = data1(:,3);
        elseif strcmp(bio,'Rapeseed') == 1
            data2 = data1(:,4);
        elseif strcmp(bio,'Camelina') == 1
            data2 = data1(:,5);
        elseif strcmp(bio,'UCO') == 1
            data2 = data1(:,6);
        elseif strcmp(bio,'Wood') == 1
            data2 = data1(:,7);
        else
            data2 = data1(:,8);
        end           
    elseif strcmp(fuel_type,'Ammonia (Combustion)') == 1
        if strcmp(prod_method,'Fossil Fuels (Grey)') == 1
            data2 = data1(:,1);
        elseif strcmp(prod_method,'Fossil Fuels w/CCS (Blue)') == 1
            data2 = data1(:,2);
        elseif strcmp(prod_method,'Electricity (Green)') == 1
            data2 = data1(:,3);
        else
            if strcmp(bio,'Forestry Residue') == 1
                data2 = data1(:,4);
            elseif strcmp(bio,'Corn Stover') == 1
                data2 = data1(:,5);
            elseif strcmp(bio,'Miscanthus') == 1
                data2 = data1(:,6);
            else
                data2 = data1(:,7);
            end
        end
    elseif strcmp(fuel_type,'Ammonia (Cracking)') == 1
        if strcmp(prod_method,'Fossil Fuels (Grey)') == 1
            data2 = data1(:,1);
        elseif strcmp(prod_method,'Fossil Fuels w/CCS (Blue)') == 1
            data2 = data1(:,2);
        elseif strcmp(prod_method,'Electricity (Green)') == 1
            data2 = data1(:,3);
        else
            if strcmp(bio,'Forestry Residue') == 1
                data2 = data1(:,4);
            elseif strcmp(bio,'Corn Stover') == 1
                data2 = data1(:,5);
            elseif strcmp(bio,'Miscanthus') == 1
                data2 = data1(:,6);
            else
                data2 = data1(:,7);
            end
        end
    elseif strcmp(fuel_type,'Methanol') == 1
        if strcmp(prod_method,'Fossil Fuels (Grey)') == 1
            data2 = data1(:,1);
        elseif strcmp(prod_method,'Fossil Fuels w/CCS (Blue)') == 1
            data2 = data1(:,2);
        elseif strcmp(prod_method,'Electricity (Green)') == 1
            data2 = data1(:,3);
        else
            if strcmp(bio,'Forestry Residue') == 1
                data2 = data1(:,4);
            elseif strcmp(bio,'Corn Stover') == 1
                data2 = data1(:,5);
            elseif strcmp(bio,'Miscanthus') == 1
                data2 = data1(:,6);
            else
                data2 = data1(:,7);
            end
        end
    elseif strcmp(fuel_type,'Synthetic Fossil Fuel') == 1
        if strcmp(prod_method,'MSW (Gas-FT)') == 1
            data2 = data1(:,4);
        elseif strcmp(prod_method,'Electricity (PtL)') == 1
            data2 = data1(:,5);
        else
            if strcmp(bio,'Forestry Residue') == 1
                data2 = data1(:,1);
            elseif strcmp(bio,'Corn Stover') == 1
                data2 = data1(:,2);
            else 
                data2 = data1(:,3);
            end
        end
    elseif strcmp(fuel_type,'Liquid Hydrogen') == 1
        if strcmp(prod_method,'Fossil Fuels (Grey)') == 1
            data2 = data1(:,1);
        elseif strcmp(prod_method,'Fossil Fuels w/CCS) (Blue)') == 1
            data2 = data1(:,2);
        else
            data2 = data(:,3);
        end   
    elseif strcmp(fuel_type,'Biodiesel') == 1
        if strcmp(bio,'Rapeseed') == 1
            data2 = data1(:,1);
        else
            data2 = data1(:,2);
        end
    elseif strcmp(fuel_type,'Fermentation') == 1
        if strcmp(bio,'Forestry Residue') == 1
            data2 = data1(:,1);
        elseif strcmp(bio,'Corn Stover') == 1
            data2 = data1(:,2);
        else
            data2 = data1(:,3);
        end
    else
        data2 = data1;
    end

    %Different Electricity Choices

    if strcmp(elec,'Grid') == 1
        data3 = data2(3:7);
    end
    if strcmp(elec,'Solar') == 1
        data3 = data2(8:12);
    end
    if strcmp(elec,'Onshore Wind') == 1
        data3 = data2(13:17);
    end
    if strcmp(elec,'Offshore Wind') == 1
        data3 = data2(18:22);
    end
    if strcmp(elec,'Hydro (incl. Pumped Storage)') == 1
        data3 = data2(23:27);
    end
    if strcmp(elec,'Nuclear') == 1
        data3 = data2(28:32);
    end
            
    %Account for deadweight and speed changes
    deadweight_scale_factor = (deadweight/122666)^(2/3);
    speed_scale_factor = (speed/20)^2;
    scale_factor = deadweight_scale_factor*speed_scale_factor;

    %Scale and present
    solutions.('CO2') = data3(1)*dist_km*0.001*scale_factor*(1/30);
    % = data3(2)*dist_km*0.001*scale_factor*(1/3);
    % = data3(3)*dist_km*0.001*scale_factor;
    % = data3(4)*dist_km*scale_factor*(1/7140);
    solutions.('Cost') = data3(5)*dist_km*0.001*scale_factor;
    solutions.('Distance') = dist_km;
    solutions.('Time') = dist_km/(speed*1.852001*24);

    %app.TimeDaysEditField.Value = dist_km/(speed*1.852001*24); 

    %Fossil Solutions
    fossil_data = data(:,2);
    if strcmp(elec,'Grid') == 1
        fossil_data1 = fossil_data(3:7);
    end
    if strcmp(elec,'Solar') == 1
        fossil_data1 = fossil_data(8:12);
    end
    if strcmp(elec,'Onshore Wind') == 1
        fossil_data1 = fossil_data(13:17);
    end
    if strcmp(elec,'Offshore Wind') == 1
        fossil_data1 = fossil_data(18:22);
    end
    if strcmp(elec,'Hydro (incl. Pumped Storage)') == 1
        fossil_data1 = fossil_data(23:27);
    end
    if strcmp(elec,'Nuclear') == 1
        fossil_data1 = fossil_data(28:32);
    end

    solutions_fossil.('CO2') = fossil_data1(1)*dist_km*0.001*scale_factor*(1/30);
    % = data3(2)*dist_km*0.001*scale_factor*(1/3);
    % = data3(3)*dist_km*0.001*scale_factor;
    % = data3(4)*dist_km*scale_factor*(1/7140);
    solutions_fossil.('Cost') = fossil_data1(5)*dist_km*0.001*scale_factor;
    solutions_fossil.('Distance') = dist_km;
    solutions_fossil.('Time') = dist_km/(speed*1.852001*24);

    %solutions=[solutions ; solutions_fossil];

    %Hard Code

    output.OptimizationResult.bestResults{1}.errorCode = 0;
    output.OptimizationResult.bestResults{1}.order = 1;
    output.OptimizationResult.bestResults{1}.distance = 5540;
    output.OptimizationResult.bestResults{1}.layover = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.origin.name = 'London Heathrow Airport';
    output.OptimizationResult.bestResults{1}.journey{1}.origin.type = 'large_airport';
    output.OptimizationResult.bestResults{1}.journey{1}.origin.continent = 'Europe';
    output.OptimizationResult.bestResults{1}.journey{1}.origin.iso_country = 'United Kingdom';
    output.OptimizationResult.bestResults{1}.journey{1}.origin.municipality = 'London';
    output.OptimizationResult.bestResults{1}.journey{1}.origin.iata_code = 'LHR';
    output.OptimizationResult.bestResults{1}.journey{1}.origin.coordinates = [51.4706, -0.461941];
    output.OptimizationResult.bestResults{1}.journey{1}.origin.airport_tag_short = 'London, (LHR)';
    output.OptimizationResult.bestResults{1}.journey{1}.origin.airport_tag_long = 'LHR - London, London Heathrow Airport';
    output.OptimizationResult.bestResults{1}.journey{1}.destination.name = 'John F Kennedy International Airport';
    output.OptimizationResult.bestResults{1}.journey{1}.destination.type = 'large_airport';
    output.OptimizationResult.bestResults{1}.journey{1}.destination.continent = 'North America';
    output.OptimizationResult.bestResults{1}.journey{1}.destination.iso_country = 'United States';
    output.OptimizationResult.bestResults{1}.journey{1}.destination.municipality = 'New York';
    output.OptimizationResult.bestResults{1}.journey{1}.destination.iata_code = 'JFK';
    output.OptimizationResult.bestResults{1}.journey{1}.destination.coordinates = [40.6398, -73.77];
    output.OptimizationResult.bestResults{1}.journey{1}.destination.airport_tag_short = 'New York, (JFK)';
    output.OptimizationResult.bestResults{1}.journey{1}.destination.airport_tag_long = 'JFK - New York, John F Kennedy International Airport';
    output.OptimizationResult.bestResults{1}.journey{1}.order = 1;
    output.OptimizationResult.bestResults{1}.journey{1}.duration = 22.2875;
    output.OptimizationResult.bestResults{1}.journey{1}.parameter.AircraftOptimism = 'More Technology';
    output.OptimizationResult.bestResults{1}.journey{1}.parameter.FuelOptimism = 'Average Case';
    output.OptimizationResult.bestResults{1}.journey{1}.parameter.Aircraft = 'Long Haul';
    output.OptimizationResult.bestResults{1}.journey{1}.parameter.Fuel = 'Synthetic Jet Fuel';
    output.OptimizationResult.bestResults{1}.journey{1}.parameter.Fuel_production = 'From Electricity';
    output.OptimizationResult.bestResults{1}.journey{1}.parameter.Grid = 'Onshore Wind';
    output.OptimizationResult.bestResults{1}.journey{1}.parameter.NumberPassengers = 500;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.name = 'TotalImpact';
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.labelDisplayed = 'Total Climate Forcing';
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.unit = '% of annual UK household CO2e footprint';
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.displayType = 'SingleBar';
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{1}.Total = 11.814;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{1}.Total_without_contrails = 1.909;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{1}.Contrails = 9.905;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{2}.Total = 5.602;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{2}.Total_without_contrails = 1.488;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{2}.Contrails = 4.114;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{3}.Total = 16.420;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{3}.Total_without_contrails = 2.330;
    output.OptimizationResult.bestResults{1}.journey{1}.results{1}.details{3}.Contrails = 14.090;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.name = 'Positive';
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.labelDisplayed = '+ Forcing (bad)';
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.unit = '% of annual UK household CO2e footprint';
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.displayType = 'StackedBar';
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{1}.Total = 21.12;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{1}.Fuel = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{1}.Aircraft = 11.22;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{1}.Contrails = 9.905;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{2}.Total = 15.30;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{2}.Fuel = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{2}.Aircraft = 11.19;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{2}.Contrails = 4.11;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{3}.Total = 25.33;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{3}.Fuel = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{3}.Aircraft = 11.24;
    output.OptimizationResult.bestResults{1}.journey{1}.results{2}.details{3}.Contrails = 14.09;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.name = 'Negative';
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.labelDisplayed = '- Forcing (good)';
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.unit = '% of annual UK household CO2e footprint';
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.displayType = 'StackedBar';
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{1}.Total = -9.31;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{1}.Fuel = -9.31;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{1}.Aircraft = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{1}.Contrails = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{2}.Total = -9.70;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{2}.Fuel = -9.70;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{2}.Aircraft = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{2}.Contrails = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{3}.Total = -8.91;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{3}.Fuel = -8.91;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{3}.Aircraft = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{3}.details{3}.Contrails = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.name = 'CO2';
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.labelDisplayed = 'Emissions';
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.unit = 'Kg/pass';
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.displayType = 'StackedBar';
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{1}.Total = 564;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{1}.negativeFuel = -444;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{1}.negativeAircraft = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{1}.negativeContrails = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{1}.Fuel = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{1}.Aircraft = 536;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{1}.Contrails = 473;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{2}.Total = 267;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{2}.negativeFuel = -463;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{2}.negativeAircraft = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{2}.negativeContrails = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{2}.Fuel = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{2}.Aircraft = 534;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{2}.Contrails = 196;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{3}.Total = 784;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{3}.negativeFuel = -425;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{3}.negativeAircraft = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{3}.negativeContrails = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{3}.Fuel = 0;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{3}.Aircraft = 537;
    output.OptimizationResult.bestResults{1}.journey{1}.results{4}.details{3}.Contrails = 673;
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.name = 'Cost';
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.labelDisplayed = 'Cost';
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.unit = '% of weekly UK household spend';
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.displayType = 'SingleBar';
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.details{1}.Total = 118;
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.details{1}.Fuel_production = 118;
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.details{2}.Total = 89;
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.details{2}.Fuel_production = 89;
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.details{3}.Total = 165;
    output.OptimizationResult.bestResults{1}.journey{1}.results{5}.details{3}.Fuel_production = 165;
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.name = 'ElectricityRequirements';
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.labelDisplayed = 'Electricity';
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.unit = '% of annual UK household use';
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.displayType = 'SingleBar';
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.details{1}.Total = 194;
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.details{1}.Electricity = 194;
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.details{2}.Total = 153;
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.details{2}.Electricity = 153;
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.details{3}.Total = 235;
    output.OptimizationResult.bestResults{1}.journey{1}.results{6}.details{3}.Electricity = 235;
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.name = 'LandUsage';
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.labelDisplayed = 'Land';
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.unit = 'm2-years';
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.displayType = 'SingleBar';
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.details{1}.Total = 459;
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.details{1}.Electricity = 459;
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.details{2}.Total = 363;
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.details{2}.Electricity = 363;
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.details{3}.Total = 555;
    output.OptimizationResult.bestResults{1}.journey{1}.results{7}.details{3}.Electricity = 555;

    output.OptimizationResult.baseLine{1}.errorCode = 0;
    output.OptimizationResult.baseLine{1}.order = 1;
    output.OptimizationResult.baseLine{1}.distance = 5540;
    output.OptimizationResult.baseLine{1}.layover = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.origin.name = 'London Heathrow Airport';
    output.OptimizationResult.baseLine{1}.journey{1}.origin.type = 'large_airport';
    output.OptimizationResult.baseLine{1}.journey{1}.origin.continent = 'Europe';
    output.OptimizationResult.baseLine{1}.journey{1}.origin.iso_country = 'United Kingdom';
    output.OptimizationResult.baseLine{1}.journey{1}.origin.municipality = 'London';
    output.OptimizationResult.baseLine{1}.journey{1}.origin.iata_code = 'LHR';
    output.OptimizationResult.baseLine{1}.journey{1}.origin.coordinates = [51.4706, -0.461941];
    output.OptimizationResult.baseLine{1}.journey{1}.origin.airport_tag_short = 'London, (LHR)';
    output.OptimizationResult.baseLine{1}.journey{1}.origin.airport_tag_long = 'LHR - London, London Heathrow Airport';
    output.OptimizationResult.baseLine{1}.journey{1}.destination.name = 'John F Kennedy International Airport';
    output.OptimizationResult.baseLine{1}.journey{1}.destination.type = 'large_airport';
    output.OptimizationResult.baseLine{1}.journey{1}.destination.continent = 'North America';
    output.OptimizationResult.baseLine{1}.journey{1}.destination.iso_country = 'United States';
    output.OptimizationResult.baseLine{1}.journey{1}.destination.municipality = 'New York';
    output.OptimizationResult.baseLine{1}.journey{1}.destination.iata_code = 'JFK';
    output.OptimizationResult.baseLine{1}.journey{1}.destination.coordinates = [40.6398, -73.77];
    output.OptimizationResult.baseLine{1}.journey{1}.destination.airport_tag_short = 'New York, (JFK)';
    output.OptimizationResult.baseLine{1}.journey{1}.destination.airport_tag_long = 'JFK - New York, John F Kennedy International Airport';
    output.OptimizationResult.baseLine{1}.journey{1}.order = 1;
    output.OptimizationResult.baseLine{1}.journey{1}.duration = 22.2875;
    output.OptimizationResult.baseLine{1}.journey{1}.parameter.AircraftOptimism = 'More Technology';
    output.OptimizationResult.baseLine{1}.journey{1}.parameter.FuelOptimism = 'Average Case';
    output.OptimizationResult.baseLine{1}.journey{1}.parameter.Aircraft = 'Long Haul';
    output.OptimizationResult.baseLine{1}.journey{1}.parameter.Fuel = 'Synthetic Jet Fuel';
    output.OptimizationResult.baseLine{1}.journey{1}.parameter.Fuel_production = 'From Electricity';
    output.OptimizationResult.baseLine{1}.journey{1}.parameter.Grid = 'Onshore Wind';
    output.OptimizationResult.baseLine{1}.journey{1}.parameter.NumberPassengers = 500;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.name = 'TotalImpact';
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.labelDisplayed = 'Total Climate Forcing';
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.unit = '% of annual UK household CO2e footprint';
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.displayType = 'SingleBar';
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{1}.Total = 23.95;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{1}.Total_without_contrails = 14.04;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{1}.Contrails = 9.905;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{2}.Total = 18.15;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{2}.Total_without_contrails = 14.04;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{2}.Contrails = 4.114;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{3}.Total = 28.13;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{3}.Total_without_contrails = 14.04;
    output.OptimizationResult.baseLine{1}.journey{1}.results{1}.details{3}.Contrails = 14.090;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.name = 'Positive';
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.labelDisplayed = '+ Forcing (bad)';
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.unit = '% of annual UK household CO2e footprint';
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.displayType = 'StackedBar';
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{1}.Total = 23.95;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{1}.Fuel = 2.83;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{1}.Aircraft = 11.22;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{1}.Contrails = 9.905;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{2}.Total = 18.15;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{2}.Fuel = 2.83;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{2}.Aircraft = 11.19;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{2}.Contrails = 4.11;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{3}.Total = 28.13;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{3}.Fuel = 2.83;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{3}.Aircraft = 11.24;
    output.OptimizationResult.baseLine{1}.journey{1}.results{2}.details{3}.Contrails = 14.09;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.name = 'Negative';
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.labelDisplayed = '- Forcing (good)';
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.unit = '% of annual UK household CO2e footprint';
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.displayType = 'StackedBar';
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{1}.Total = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{1}.Fuel = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{1}.Aircraft = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{1}.Contrails = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{2}.Total = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{2}.Fuel = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{2}.Aircraft = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{2}.Contrails = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{3}.Total = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{3}.Fuel = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{3}.Aircraft = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{3}.details{3}.Contrails = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.name = 'CO2';
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.labelDisplayed = 'Emissions';
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.unit = 'Kg/pass';
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.displayType = 'StackedBar';
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{1}.Total = 1144;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{1}.negativeFuel = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{1}.negativeAircraft = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{1}.negativeContrails = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{1}.Fuel = 135;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{1}.Aircraft = 536;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{1}.Contrails = 473;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{2}.Total = 868;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{2}.negativeFuel = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{2}.negativeAircraft = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{2}.negativeContrails = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{2}.Fuel = 135;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{2}.Aircraft = 536;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{2}.Contrails = 196;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{3}.Total = 1344;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{3}.negativeFuel = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{3}.negativeAircraft = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{3}.negativeContrails = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{3}.Fuel = 135;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{3}.Aircraft = 536;
    output.OptimizationResult.baseLine{1}.journey{1}.results{4}.details{3}.Contrails = 673;
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.name = 'Cost';
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.labelDisplayed = 'Cost';
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.unit = '% of weekly UK household spend';
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.displayType = 'SingleBar';
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.details{1}.Total = 40;
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.details{1}.Fuel_production = 40;
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.details{2}.Total = 40;
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.details{2}.Fuel_production = 40;
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.details{3}.Total = 40;
    output.OptimizationResult.baseLine{1}.journey{1}.results{5}.details{3}.Fuel_production = 40;
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.name = 'ElectricityRequirements';
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.labelDisplayed = 'Electricity';
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.unit = '% of annual UK household use';
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.displayType = 'SingleBar';
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.details{1}.Total = 18;
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.details{1}.Electricity = 18;
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.details{2}.Total = 18;
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.details{2}.Electricity = 18;
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.details{3}.Total = 18;
    output.OptimizationResult.baseLine{1}.journey{1}.results{6}.details{3}.Electricity = 18;
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.name = 'LandUsage';
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.labelDisplayed = 'Land';
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.unit = 'm2-years';
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.displayType = 'SingleBar';
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.details{1}.Total = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.details{1}.Production = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.details{2}.Total = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.details{2}.Production = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.details{3}.Total = 0;
    output.OptimizationResult.baseLine{1}.journey{1}.results{7}.details{3}.Production = 0;
    
    output.OptimizationResult.isSingleJourney = true;
    %output.OptimizationResult = solutions;
    output = jsonencode(output);