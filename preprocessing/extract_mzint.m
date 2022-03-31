function [mz_out,int] = extract_mzint(files)

fiadata = mzxmlreadTS(files);
TIC = [fiadata.scan(:).totIonCurrent];
[TIC2,id] = sort(TIC','descend');

% Sum over Top 10 Scans
for i = 1:10
    [mz_out, int_out] = msresample(fiadata.scan(id(i)).peaks.mz(1:2:end-1,:),fiadata.scan(id(i)).peaks.mz(2:2:end,:),10^6,'range',[50, 1100],'Uniform',1);
    int(i,:) = int_out';
end

int = mean(int,1);

