function expt=filtesweeps(expt,bOR,varargin)
[expt.sweeps ind]=filtsweeps(expt.sweeps,bOR, varargin{:});

allfields = fieldnames(expt.wc);

for ifield = 1:length(allfields)
    
    expt.wc.(allfields{ifield}) =expt.wc.(allfields{ifield})(ind,:);
%     eval(s)
end


end