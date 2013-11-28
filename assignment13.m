%Hungarian Algorithm
%Implementation time complexity  -   O(n^3)
% Cost matrix and Time Matrix are multiplied and given as input to the
% Hungarian Algorithm to minimize the total product.

clear all
% mat(i,j) represents cost for i-th cab to reach j-th customer.

%omat=[8,20,15,17,3;15,16,12,8,10;22,19,16,9,30;25,15,12,9,25];
%omat=[17,10,12;9,8,10;14,4,7];
%omat=[0,0,0;0,1,0;0,1,1;];
%omat=[3,20,21,22;10,11,12,13;18,7,8,9;6,50,51,52;];


fprintf('Enter the cost matrix followed by time matrix with rows as cars and columns as customers ( 0 for sample matrices ) \n');
cost=input('');
if(cost==0)
    cost=[90,75,75,80;35,85,55,65; 125,95,90,105; 45,110,95,115];
    time=[3,20,21,22;10,11,12,13;18,7,8,9;6,50,51,52;];
    cost
    time
else
    time=input('');
end
omat=cost.*time;

if(size(omat,1)>size(omat,2))
    for i=1:size(omat,1)-size(omat,2)
        omat=[omat zeros(1,size(omat,1))];
    end
    
elseif(size(omat,1)<size(omat,2))
    for i=1:size(omat,2)-size(omat,1)
        omat=[omat; zeros(1,size(omat,2))];
    end
    
end
mat=omat;

%Find Minimum in each row and subtract the whole row with that minimum
for i=1:size(mat,1)
    temp=mat(i,:);
    mmat=1000;
    for m=1:size(temp,2)
        if(temp(1,m)<mmat)
        mmat=temp(1,m);
        end
    end
    
    mat(i,:)=mat(i,:)-mmat;
end

%Same but for each column
for i=1:size(mat,2)
   temp=mat(:,1);
    mmat=1000;
    for m=1:size(temp,1)
        if(temp(m,1)<mmat)
        mmat=temp(m,1);
        end
    end
    mat(:,i)=mat(:,i)-mmat;
end

%To find the minimum number of lines



count=0;

while count<size(mat,1)
rows=ones(1,size(mat,1));
cols=ones(1,size(mat,1));
  
minin=1;
count=0;
while minin~=0
mrl=zeros(1,size(mat,1));
mcl=zeros(1,size(mat,1));

for i=1:size(mat,1)
    if rows(1,i)~=0
    mrl(1,i)=length(mat(i,find(cols)))-length(find(mat(i,find(cols))));
    end
    
    if cols(1,i)~=0
    mcl(1,i)=length(mat(find(rows),i))-length(find(mat(find(rows),i)));
    end
end
%mrl
%mcl

dir=0;
min=size(mrl,2)+2;
minin=0;
for i=1:size(mrl,2)
    if(mrl(1,i)<min && mrl(1,i)~=0)
        dir=0; %row
        min=mrl(1,i);
        minin=i;
    end
    
    if(mcl(1,i)<min && mcl(1,i)~=0)
        dir=1; %column
        min=mcl(1,i);
        minin=i;
    end
end

%min
%minin
%dir

if minin~=0  
    
    if dir==0
    val=0;
        for i=1:size(mat,1)
            if(cols(1,i)~=0 && mat(minin,i)==0)
                val=i;
            end
        end
    cols(1,val)=0;
    else
        val=0;
        for i=1:size(mat,1)
            if(rows(1,i)~=0 && mat(i,minin)==0)
                val=i;
            end
        end
     rows(1,val)=0;
    end
 %   val

    count=count+1;

end
%cols
%rows

end


mind=1000;
if count~=size(mat,1)
    q=mat([find(rows)],[find(cols)]);
    for i=1:size(q,1)
        for j=1:size(q,2)
            if(q(i,j)<mind)
                mind=q(i,j);
            end
        end
    end    

for i=1:size(mrl,2)
    if rows(1,i)==1
        mat(i,:)=mat(i,:)-mind;
    end
 
    if cols(1,i)==0
        mat(:,i)=mat(:,i)+mind;
    end
   
end
end
%mat
%rows
%cols
%count
%mind
end
%mat



rows=ones(1,size(mat,1));
cols=ones(1,size(mat,1));
minin=1;
count=0;
assign=[0,0];
while minin~=0
mrl=zeros(1,size(mat,1));
mcl=zeros(1,size(mat,1));
%mat
for i=1:size(mat,1)
    if rows(1,i)~=0
    mrl(1,i)=length(mat(i,find(cols)))-length(find(mat(i,find(cols))));
    end
    if cols(1,i)~=0
    mcl(1,i)=length(mat(find(rows),i))-length(find(mat(find(rows),i)));
    end
end
%mrl
%mcl
dir=0;
min=size(mrl,2)+2;
minin=0;
for i=1:size(mrl,2)
    if(mrl(1,i)<min && mrl(1,i)~=0)
        dir=0; %row
        min=mrl(1,i);
        minin=i;
    end
    
    if(mcl(1,i)<min && mcl(1,i)~=0)
        dir=1; %column
        min=mcl(1,i);
        minin=i;
    end
end

%min
%minin
%dir

if minin~=0   
    
    if dir==0
    val=0;
        for i=1:size(mat,1)
            if(cols(1,i)~=0 && mat(minin,i)==0)
                val=i;
                break;
            end
        end
    if val~=0    
    cols(1,val)=0;
    rows(1,minin)=0;
     assign=[assign; minin,val;];
    end
    
    else
        val=0;
        for i=1:size(mat,1)
            if(rows(1,i)~=0 && mat(i,minin)==0)
                val=i;
                break;
            end
        end
     
     rows(1,val)=0;
     cols(1,minin)=0;
     assign=[assign; val,minin;];
    end
    
end
%val
end
disp ('The optimal assignments for minimizing the total cost are as follows -');
totalcost=0;
maxtime=0;
for i=2:size(assign,1)
   fprintf('Car%d -> Customer%d , Cost - %d , Time - %d \n',assign(i,1),assign(i,2),cost(assign(i,1),assign(i,2)),time(assign(i,1),assign(i,2)));
  totalcost=totalcost+cost(assign(i,1),assign(i,2));
  if maxtime<time(assign(i,1),assign(i,2))
        maxtime=time(assign(i,1),assign(i,2));
  end
  
end
fprintf ('For this optimal assignment,the minimized total cost is %d and minimized max time is %d.\n',totalcost,maxtime);


