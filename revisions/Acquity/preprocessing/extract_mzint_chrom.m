function [mz_out,int,rt] = extract_mzint_chrom(files)

fiadata = mzxmlreadTS(files);
TIC = [fiadata.scan(:).totIonCurrent];
%[~,id] = sort(TIC','descend');




% Sum over Top 10 Scans
for i = 1:length(fiadata(1).scan)
    [mz_out, int_out] = msresample(fiadata.scan(i).peaks.mz(1:2:end-1,:),fiadata.scan(i).peaks.mz(2:2:end,:),10^6,'range',[50, 1100],'Uniform',1);
    int(i,:) = int_out';
    rt(i,1) = str2num(fiadata.scan(i).retentionTime(3:end-1));
end

%[X,Y,Z] = meshgrid(rt,mz_out,int);


%int = mean(int,1);

