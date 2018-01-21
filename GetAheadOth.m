function [Start,Stop,CropPath]=GetAheadOth(Road,Position,Length)
    
    Stop =Road(end,1:2);
    CropPath=Road;        
    [Start,d,istart]=GetNearestOth(Road,Position);
    s=0;
    iend=size(Road,1);
    
    c=Start;
    i=istart;

    k=1;
    Step=0;    
    while(1)
        CropPath(k,1:2)=c;        
        k=k+1;
        NormCmN=0;
        while( NormCmN == 0 )
            ni=i+1;
            if( ni>iend)
                break;
            end        
            n=Road(ni,1:2);
            NormCmN=norm(c-n);
            i=ni;
        end
        
        if( ni>iend)
            Stop=Road(end,1:2);
            CropPath(k,1:2)=Stop;
            break;
        end        
        
        NextStep=Step+NormCmN;        
        if( Step <= Length && Length < NextStep )
            Stop = c+(n-c)/NormCmN*(Length-Step);            
            CropPath(k,1:2)=Stop;
            break;
        end
        Step = NextStep;
        c=Road(ni,1:2);        
    end   
    
                    
    CropPath=CropPath(1:k,:);
    
    Start=[Start,...
           atan2( CropPath(2,2)-CropPath(1,2), ...
                  CropPath(2,1)-CropPath(1,1) )];
    
    Stop=[Stop,...
           atan2( CropPath(end,2)-CropPath(end-1,2), ...
                  CropPath(end,1)-CropPath(end-1,1) )];
                  
end