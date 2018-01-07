%Img Stech


img_cnt=28
scale=20;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if( 1 )
    for i=1:img_cnt
        finame=sprintf('./gcrop/image%03d.jpg',i);
        foname=sprintf('./gcrop/i%03d.jpg',i);
        org_img=imread(finame);
        org_img_size=size(org_img);
        sml_img_size=org_img_size/scale;
        sml_img=uint8(zeros(sml_img_size));
        for y=1:sml_img_size(2)
            for x=1:sml_img_size(1)
                sml_img(x,y)=uint8(mean(mean(org_img((x-1)*scale+(1:scale),(y-1)*scale+(1:scale)))));
            end
        end
        imwrite(sml_img,foname);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if( 1 )
    img_synth=uint8(128*ones(160*20/scale,310*20/scale));
    img_synth_size=size(img_synth);
    i=1;
    foname=sprintf('./gcrop/i%03d.jpg',i);
    org_img=imread(foname);
    img_synth(5+(1:sml_img_size(1)),5+(1:sml_img_size(2)))=org_img;
    err_mtrx=zeros(img_cnt,2);
    for i=2:img_cnt
        foname=sprintf('./gcrop/i%03d.jpg',i);
        sml_img=imread(foname);
        err.x=0;
        err.y=0;
        err.min=255*sml_img_size(1)*sml_img_size(2);
        for ys=0:(img_synth_size(2)-sml_img_size(2)-1)
            for xs=0:(img_synth_size(1)-sml_img_size(1)-1)
                diff_img=double(sml_img) - double(img_synth( xs+(1:sml_img_size(1)), ys+(1:sml_img_size(2))));
                tmperr=sum(sum(abs(diff_img)));
                if( tmperr <= err.min )
                    err.x = xs;
                    err.y = ys;
                    err.min = tmperr;                
                end
            end
        end
        img_synth( err.x+(1:sml_img_size(1)),err.y+(1:sml_img_size(2))) = sml_img;    
        err_mtrx(i,:)=[err.x,err.y];
        imwrite(img_synth,'./gcrop/synth_sml.jpg');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if( 1 )
    img_synth=uint8(128*ones(160*20,310*20));
    img_synth_size=size(img_synth);
    i=1;
    foname=sprintf('./gcrop/image%03d.jpg',i);
    org_img=imread(foname);
    sml_img_size=size(org_img);
    img_synth(5*scale+(1:sml_img_size(1)),5*scale+(1:sml_img_size(2)))=org_img;
    for i=2:img_cnt
        foname=sprintf('./gcrop/image%03d.jpg',i);
        sml_img=imread(foname);
        sml_img_size=size(sml_img);
        err.x=0;
        err.y=0;
        err.min=255*sml_img_size(1)*sml_img_size(2);
        for ys=err_mtrx(i,2)*scale+(0*scale:scale);
            for xs=err_mtrx(i,1)*scale+(0*scale:scale);
                diff_img=double(sml_img) - double(img_synth( xs+(1:sml_img_size(1)), ys+(1:sml_img_size(2))));
                tmperr=sum(sum(abs(diff_img)));
                if( tmperr <= err.min )
                    err.x = xs;
                    err.y = ys;
                    err.min = tmperr;
                end
            end
        end
        img_synth( err.x+(1:sml_img_size(1)),err.y+(1:sml_img_size(2))) = sml_img;    
        imwrite(img_synth,'./gcrop/synth.jpg');
        %input x
    end
end

