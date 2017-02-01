function [out, dt] =dnsample_data(in,oldRate,newRate)
%for this to work, the data must be along one row, with columns as samples
% didflip=0;
% if find(max(size(data)))==1
%     data=data';
%     didflip=1;
% end

bin = round(oldRate/newRate);

out = in(1:bin:end,1);

dt_old = 1/oldRate;

dt = dt_old * bin;


