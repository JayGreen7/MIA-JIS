function dist_km = computeDistance(origin,destination)
    if strcmp(origin,'Shanghai') == 1
        if strcmp(destination,'Brisbane') == 1 
            dist_km = 10089.74;
        elseif strcmp(origin,'Felixstowe') == 1
            dist_km = 19035.56;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Portland') == 1
        if strcmp(destination,'Hiroshima') == 1 
            dist_km = 5004.674;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Colombo') == 1
        if strcmp(destination,'Lome') == 1 
            dist_km = 17478.25;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Felixstowe') == 1
        if strcmp(destination,'Shanghai') == 1 
            dist_km = 19035.56;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Los Angeles') == 1
        if strcmp(destination,'Rio de Janeiro') == 1 
            dist_km = 13241.09;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Montreal') == 1
        if strcmp(destination,'Toronto') == 1 
            dist_km = 577.02;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Doha') == 1
        if strcmp(destination,'Perth') == 1 
            dist_km = 9556.26;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Monaco') == 1
        if strcmp(destination,'Naples') == 1 
            dist_km = 655.37;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Oslo') == 1
        if strcmp(destination,'Lisbon') == 1 
            dist_km = 2883.01;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Reykjavik') == 1
        if strcmp(destination,'Cape Town') == 1 
            dist_km = 12173.18;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Brisbane') == 1
        if strcmp(destination,'Shanghai') == 1 
            dist_km = 10089.74;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Hiroshima') == 1
        if strcmp(destination,'Portland') == 1 
            dist_km = 5004.674;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Lome') == 1
        if strcmp(destination,'Colombo') == 1 
            dist_km = 17478.25;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Rio de Janerio') == 1
        if strcmp(destination,'Los Angeles') == 1 
            dist_km = 13241.09;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Toronto') == 1
        if strcmp(destination,'Montreal') == 1 
            dist_km = 577.02;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Perth') == 1
        if strcmp(destination,'Doha') == 1 
            dist_km = 9556.26;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Naples') == 1
        if strcmp(destination,'Monaco') == 1 
            dist_km = 655.37;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Lisbon') == 1
        if strcmp(destination,'Oslo') == 1 
            dist_km = 2883.01;
        else
            dist_km = 0;
        end
    end
    if strcmp(origin,'Cape Town') == 1
        if strcmp(destination,'Reykjavik') == 1 
            dist_km = 12173.18;
        else
            dist_km = 0;
        end
    end
end