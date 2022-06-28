load Outlier_data

histogram(vertcat(NEG.mzx,POS.mzx))
xlabel('mz')
ylabel('Frequency')