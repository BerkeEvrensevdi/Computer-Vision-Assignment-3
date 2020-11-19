function peaks=meanShift (data, ind, bandwidth, stopT )
    
    selectedCenter = data(ind,:);
    
    %disp(size(data));
    
    k = 1;
    inBandwidth = zeros(size(data));
   
    while 1
        for i = 1:size(data,1)
           distance = norm(double(data(i,:))-double(selectedCenter));
           if distance <= bandwidth
               inBandwidth(k,:) = data(i,:);
               k = k + 1;
           end
         end
       
        inBandwidth1 = inBandwidth(1:k-1,:);  
        newCenter = mean(inBandwidth1);
            
         if( norm(double(newCenter)-double(selectedCenter)) <= stopT)
             peaks = selectedCenter;
             break;
         end
         
         selectedCenter = newCenter;
         k = 1;
    end
end