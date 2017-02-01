%%
r = rigdef('Sawtell');


%%
clear expt;
expt.name = '20170126_006_IV';

exptfoldername = expt.name;

expt = ImportExpt_Spike7_txt(r.Dir.Server,[exptfoldername '/']);

save(fullfile(r.Dir.Server,exptfoldername,expt.name),'expt')

%% use function to parse command markers

%plot first to get thresholds and jitter values
thresh_inclusive = -0.0005;
thresh_exclusive = -0.002;
minwin = [];
jitter = [];
dt = expt.dt;

CmdMarkers = IsolateCommandMarkers(expt.Cmd, thresh_inclusive, thresh_exclusive, minwin, jitter, dt);
expt.CmdMarkers = CmdMarkers;

save(fullfile(r.Dir.Server,exptfoldername,expt.name),'expt')
%% make sweeps

SweepsMat = MakeSweeps(ContinuousData,TriggerData,Offset);

expt.SweepsMat = SweepsMat;

save(fullfile(r.Dir.Server,exptfoldername,expt.name),'expt')


%% filter out any trials that were really abberant based on fields of SweepsMat
expt=filtesweeps(expt,0,'trial',[1:32]);
      
save(fullfile(r.Dir.Server,exptfoldername,expt.name),'expt')



%% plot all trials at each holding

Vmexpt=filtesweeps(expt,0,'Vm',0);

hfig=plotallVm(Vmexpt,expt.analysis.params.steptime,expt.analysis.params.testAmp);

