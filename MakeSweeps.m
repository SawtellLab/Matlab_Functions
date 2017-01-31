function SweepsMat = MakeSweeps(ContinuousData,TriggerData,Offset)

%structures the data into sweeps initiated by each trigger of equal length
%stores info like time until next trigger so can, for example filter EOD sweeps
%separated by a minimum duration etc... 