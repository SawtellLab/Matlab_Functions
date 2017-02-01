function [indx_up,indx_down] = crossing_zero_directional(y)

%find zero crossings
t1=y(1:end-1);
t2=y(2:end);
tt=t1.*t2;
indx=find(tt<0);

dt        = t2-t1;
indx_up   = find( (tt<0) & (dt>0) ) ;
indx_down = find( (tt<0) & (dt<0) ) ;