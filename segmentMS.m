function [labels, peaks]=segmentMS(image, bandwidth, stopT)

   [height,width,z] = size(image);
   I = uint8(image);
   data = reshape(I,[width*height,3]);
   
   peaks = zeros(size(data));
   index = 1;
   for i=1:size(data,1)
       peak = meanShift(data,i,bandwidth,stopT);
       peaks(index,:) = peak;
       for k=1:index-1
            if(norm(double(peak)-double(peaks(k,:)))<=bandwidth/2)
                peaks(index,:) = [0,0,0];
                index = index - 1;
                break;
            end
       end
       index = index + 1;
   end
   peaks = peaks(1:index-1,:);
   labels = zeros(size(image));
   
   for p=1:size(peaks,1)
       for i =1:width
           for j=1:height
               if(norm(double(peaks(p,:)) - double(data(height*(i-1)+j,:)))<= bandwidth)
                    labels(j,i,:) =peaks(p,:);
               end
           end
       end
   end
   labels = uint8(labels);
end 