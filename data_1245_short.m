

sz=size(data_1245);

[~,i]=min(abs(20-data_1245(:,1)));
[~,j]=min(abs(40-data_1245(:,1)));

data_1245_seg=data_1245(i:j,:);