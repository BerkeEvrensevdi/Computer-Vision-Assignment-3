function [stitchedImage]= Stitch2(image1, image2, hom, homInv) 
   
  [height, width, k] = size(image2);
  %disp(hom);
  %disp(width);
  topLeft = [1, 1];
  topRight =[width,1];
  bottomLeft =[1,height];
  bottomRight = [width,height];
  
  [x1,y1] =  Project(topLeft(1,1), topLeft(1,2), homInv);
  [x2,y2] =  Project(topRight(1,1), topRight(1,2), homInv);
  [x3,y3] =  Project(bottomLeft(1,1), bottomLeft(1,2), homInv);
  [x4,y4] =  Project(bottomRight(1,1), bottomRight(1,2), homInv);
  
  top = min(1,int32(min(y1,y2)));  
  left = min(1,int32(min(x1,x3)));
  bottom = max(size(image1,1),int32(max(y4,y3)));
  right = max(size(image1,2),int32(max(x4,x2)));

  newWidth = round(right - left);
  newHeight = round(bottom - top);
   panorama = zeros([newHeight newWidth 3]);

    for y = 1 : size(image1,1)
      for x = 1 : size(image1,2)
           for z = 1 : 3
            panorama(y + abs(top), x + abs(left),z) = image1(y,x,z);
           end
      end
    end
    figure; imshow(panorama);
    
    
   
  for y = top : bottom
    for x = left : right
            x = double(x);
            y = double(y);
            [xp, yp] = Project(x, y , hom);
            
        if( xp >= 1 && xp <= width && yp >= 1 && yp <= height )   
            xp = uint32(xp);
            yp = uint32(yp);
            
            if(x + abs(left) <= size(panorama,2) && y + abs(top) <= size(panorama,1) && x + abs(left) ~= 0 && y + abs(top) ~= 0)
                if(panorama(y + abs(top),x + abs(left),1) == 0 && panorama(y + abs(top),x + abs(left),2) == 0 && panorama(y + abs(top),x + abs(left),3) == 0)
                    panorama(y + abs(top) ,x + abs(left) ,1) = image2(abs(yp),abs(xp),1);
                    panorama(y + abs(top),x + abs(left) ,2) = image2(abs(yp),abs(xp),2);
                    panorama(y + abs(top) ,x + abs(left) ,3) = image2(abs(yp),abs(xp),3);
                end
            end
        end
     end
  end
       
   
   
   
stitchedImage = panorama;