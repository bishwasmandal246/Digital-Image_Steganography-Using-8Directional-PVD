I = imread('babbon.bmp');
text_file = fopen('Embed.txt','rt');
text_read_ascii = fread(text_file,'uint8');
binaryString = transpose(de2bi(text_read_ascii,8));
size_binaryString = size(binaryString);
final_message = reshape(binaryString,1,size_binaryString(1)*size_binaryString(2));
final_message(length(final_message)+1:length(final_message)+30) = [0];
i1 = 1;


S=I;


while(i1 <= 510)
    for j1 = 1:3:510
        pixel_count = 0;
        for i = i1:i1+2
            for j = j1:j1+2
                pixel_count = pixel_count+1;
                if(pixel_count==5)
                    A1=i;
                    A2=j;
                    old=S(i,j);
                    
                    binary_form=de2bi(old,8);
                    if(length(final_message)==0)
                        break
                    end
                    if(length(final_message)>=1 && length(final_message)<4)
                        final_message(length(final_message)+1:3)=[0];
                    end
                    
                    binary_form(3:-1:1)=final_message(1:3);

                    final_message(1:3)=[];
                    new=bi2de(binary_form);
                    devi=old-new;
                    if(devi>8 && (new+16)>=0 && (new+16)<=255)
                        S(i,j)=new+16;
                        
                      
                    elseif(devi<(-8) && (new-16)>=0 && (new-16)<=255)
                        S(i,j)=new-16;
                        
                       
                    else
                        S(i,j)=new;
                        
                    end
                
                end
            end
            if(length(final_message)==0)
                break
            end
        end
        inner_loop=0;
        for x1=i1:i1+2
            for x2=j1:j1+2
                inner_loop=inner_loop+1;

                if(inner_loop~=5)
                    
                    if(S(x1,x2)>S(A1,A2))
                        diff=S(x1,x2)-S(A1,A2);
                    elseif(S(x1,x2)==S(A1,A2))
                        diff=0;
                    else
                        diff=S(A1,A2)-S(x1,x2);
                    end
                    
                    
                  

                    if(diff<8)
                        ti=3;
                        L=0;
                    elseif(diff>7 && diff<16)
                        ti=3;
                        L=8;
                    elseif(diff>15 && diff<32)
                        ti=3;
                        L=16;
                    elseif(diff>31 && diff<64)
                        ti=3;
                        L=32;
                    elseif(diff>63 && diff<128)
                        ti=4;
                        L=64;
                    else
                        ti=4;
                        L=128;
                    end
                    if(length(final_message)>=1 && length(final_message)<ti)
                        final_message(length(final_message)+1:ti)=[0];
                    end
                    if(length(final_message)==0)
                        break
                    end

                    X_V=bi2de(final_message(ti:-1:1));

                    final_message(1:ti)=[];
                    DD=L+X_V;
                    
                    
                    
                    
                    pii=S(A1,A2)-DD;
                    piii=S(A1,A2)+DD;
                   
                    if(S(x1,x2)>pii)
                        x=S(x1,x2)-pii;
                    elseif(S(x1,x2)==0)
                        x=0;
                    else
                        x=pii-S(x1,x2);
                    end
                    if(S(x1,x2)>piii)
                        y=S(x1,x2)-piii;
                    elseif(S(x1,x2)==piii)
                        y=0;
                    else
                        y=piii-S(x1,x2);
                    end
                        
                        
                   
                    
                    if(x<y && pii>=0 && pii<=255)
                        S(x1,x2)=pii;
                       
                 
                    else
                        S(x1,x2)=piii;

                    end

                end
                if(length(final_message)==0)
                    break
                end
            end
            if(length(final_message)==0)
                break
            end
        end
            
        
        if(length(final_message)==0)
            break
        end
        
    end
    if(length(final_message)==0)
        break
    end
    
    i1=i1+3;
end


imwrite(S,'stego_image.png'); 
