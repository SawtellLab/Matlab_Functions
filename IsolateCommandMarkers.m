function CmdMarkers = IsolateCommandMarkers(Command, thresh_inclusive, thresh_exclusive, minwin, jitter, dt)
%minwin is in milliseconds
%right now this is only known to work for detecting negative threshold
%crossings. things would probably need to be flipped to generalize to
%positive crossings?

%Command must be a column vector (so each entry is a row)
if size(Command,2) > size(Command,1)
    return
end

nsamps = size(Command,1);

if isempty(minwin)
   minwin = 30; %default minwinsize 
end
minwinsize = round((minwin/1000)/dt);

if isempty(jitter)
    jitter = 5;
end
jittersize = round((jitter/1000)/dt);

allcrossings = Command-thresh_inclusive;
AllMarkers = zeros(nsamps,1);
sampind = 1;
while sampind < nsamps 
    if allcrossings(sampind)<= 0
        AllMarkers(sampind) = 1;
        sampind = sampind + minwinsize;         
    end
    if allcrossings(sampind)>0 
       sampind = sampind+1; 
    end
   
end
allinds = find(AllMarkers);

highcrossings = Command-thresh_exclusive;
HighMarkers = zeros(nsamps,1);
sampind = 1;
while sampind < nsamps 
    if highcrossings(sampind)<= 0
        HighMarkers(sampind) = 1;
        sampind = sampind + minwinsize;
    end
    if highcrossings(sampind)>0 
       sampind = sampind+1; 
    end
end
highinds = find(HighMarkers);

eliminds = [];
for imark = 1:size(allinds,1)
    double_exist = intersect(find(highinds>allinds(imark)-jittersize),find(highinds<allinds(imark)+jittersize));
    if ~isempty(double_exist)
       eliminds = [eliminds,allinds(imark)]; 
    end
end
AllMarkers(eliminds) = 0;

CmdMarkers = find(AllMarkers);





