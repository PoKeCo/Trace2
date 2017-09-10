function [Start,Stop,CropPath]=GetAhead(Road,Position,Length)
    
    Stop =Road(end,:);
    CropPath=Road;        
    [Start,d,istart]=GetNearest(Road,Position);
    s=0;
    iend=size(Road,1);
    
    c=Start;
    i=istart;

    k=1;
    Step=0;    
    while(1)
        CropPath(k,:)=c;
        ni=i+1;
        k=k+1;
        if( ni>iend)
            Stop=Road(end,:);
            CropPath(k,:)=Stop;
            break;
        end
        n=Road(ni,:);
        NormCmN=norm(c-n);
        NextStep=Step+NormCmN;        
        if( Step <= Length && Length < NextStep )
            Stop = c+(n-c)/NormCmN*(Length-Step);            
            CropPath(k,:)=Stop;
            break;
        end
        Step = NextStep;
        c=Road(ni,:);
        i=ni;
    end   
    
                    
    CropPath=CropPath(1:k,:);
    
    Start=[Start,...
           atan2( CropPath(2,2)-CropPath(1,2), ...
                  CropPath(2,1)-CropPath(1,1) )];
    
    Stop=[Stop,...
           atan2( CropPath(end,2)-CropPath(end-1,2), ...
                  CropPath(end,1)-CropPath(end-1,1) )];
                  
end