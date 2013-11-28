%in=input('Enter the matrix to find inverse for - \n');
%in=[1 2 5; 3 8 5; 5 12 7;];
%in=[0 0 3; 3 4 5; 5 6 7;];
%in=[-3 -2 4;14 8 -18;4 2 -5;];
%in=[-3 -2 4;14 8 -18;4 2 -4;];
%in=[1 2 2 2; 2 4 6 8; 3 6 8 10;];
%in=[1 -3 2;2 -5 6;-1 0 -8];

in=input('Enter the input matrix now (Enter 0 for sample matrix)\n');
if in==0
    in=[1 2 3 4 5; 2 3 4 5 6; 3 4 5 6 7; 5 6 7 8 9; 2 3 6 4 7;]
end

n=size(in,1);
ie=true;
%Identity Matrix
id=zeros(n,n);
for i=1:n
id(i,i)=1;
end
ag=[in id];  %Augmented Matrix
disp(ag)
for i=1:n
    if round(ag(i,i)*1000)/1000==0 && i==n
        ie=false;
        break;
    elseif round(ag(i,i)*1000)/1000==0 
       m=i+1; 
       while round(ag(i,i)*1000)/1000==0 && m~=n+1
           
        fprintf('R%d<->R%d\n',i,m);  
       temp=ag(i,:); ag(i,:)=ag(m,:); ag(m,:)=temp;
       disp(ag);
       m=m+1;
       end
    end
    if round(ag(i,i)*1000)/1000~=0
    fprintf('R%d->R%d/%d\n',i,i,ag(i,i));
    ag(i,:)=ag(i,:)/ag(i,i);
    disp(ag);
    for j=1:n
        if i ~= j
            fprintf('R%d->R%d-(%d)R%d\n',j,j,ag(j,i),i);
            ag(j,:)=ag(j,:)-ag(j,i).*ag(i,:);
            disp(ag)
        end
    end
    
    if round(ag(j,1:n)*1000)/1000==zeros(1,n)  % Any row becomes zero entirely ? If yes, no Inverse exists
        ie=false;
        break;
    end
    end
end
if ie==true
    disp('Inverse Exists and the inverse is')
    disp(ag(:,n+1:2*n));
    disp('Since an inverse exists , the only solution is the trivial solution x=0 vector');
else
    disp('Inverse does not exist for this matrix');
    free=zeros(n,1);
    for i=1:n
        oneisthere=0;    
        for j=1:n
            if round(ag(j,i)*1000)/1000==1
                if oneisthere==1
                    free(i,1)=1;
                else
                    oneisthere = 1;
                end
            
            elseif round(ag(j,i)*1000)/1000~=0
               free(i,1)=1;
            end
        end
    end
    fprintf('The pivot variables are -- ');
    for i=1:n
       if free(i,1)==0
            fprintf('x%d ',i);
       end
    end
    fprintf('\n');
    
    fprintf('The free variables are  -- ');
    for i=1:n
       if free(i,1)==1
            fprintf('x%d ',i);
       end
    end
    fprintf('\n');
    fprintf('x = ');
    done=0;
    for i=1:n
        vect=zeros(n,1);
        if free(i,1)==1
            v=ag(1:n-1,i);
            m=1;
            for j=1:n
               if free(j,1)==0
                 vect(j,1)=-v(m,1);
                 m=m+1;
               elseif j==i
                   vect(j,1)=1;
               end
            end
            if done==0
                fprintf(' [');
                done=1;
            else
                fprintf('+ [');
            end
            for q=1:n 
                fprintf(' %d ',vect(q,1));
            end
            fprintf(']*x%d\n',i);
        end
       
    end
end

%q=inv(in)