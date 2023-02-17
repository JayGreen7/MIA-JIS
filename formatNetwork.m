function name = formatNetwork(rank)
    if(mod(rank,10) == 0)
        name = strcat("Top",num2str(rank),"Airports");
    elseif(rank > 4000)
        name = "AllAirports";
    end
end