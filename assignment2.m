% K.Ilambharathi - COE09B008
% Graham's Scan to find the min Convex Hull
% Reference used - http://en.wikipedia.org/wiki/Graham_scan

%Points Input
points=input('Enter the points now (Enter 0 for sample points)\n');
if points==0
    points = [1 1;1 2;3 4; 5 6; -5 6; -5 3;-4 1.5;-0.1 5]
end


xvalues=points(:,1);
yvalues=points(:,2);

% Sort the points in y-coordinate to get lowest y-coordinate value
points=sortrows(points,[2,1]);
spt=points(1,:);

% Plotting the original points on graph
plot(xvalues,yvalues,'r*');
axis([min(points(:,1))-1,max(points(:,1))+1,min(points(:,2))-1,max(points(:,2))+1]);

% Finding the Polar Angles with respect to the lowest point
polarangles=zeros(size(points,1)-1,1);
for i=2:size(points,1)
    polarangles(i-1)=atand((points(i,2)-spt(2))/(points(i,1)-spt(1)));
    if polarangles(i-1)<0 
      polarangles(i-1)=180+polarangles(i-1);
    end
end

final=[points(2:end,:) polarangles];
final=sortrows(final,3);
n=2;
stack=[spt(1) spt(2)];
stack=[stack; final(1,1) final(1,2)];
top=2;
% Graham Scan 2nd phase
while(n~=size(final,1)+1)
    x3=final(n,1); y3=final(n,2);
    x2=stack(top,1); y2=stack(top,2);
    x1=stack(top-1,1); y1=stack(top-1,2);
    turn=(x2-x1)*(y3-y1)-(y2-y1)*(x3-x1);
    if turn>=0 %Left Turn
        stack=[stack; final(n,1) final(n,2)];
        n=n+1;
        top=top+1;
    else       %Right Turn
        stack=stack(1:(end-1),:);
        top=top-1;
    end
end
stack=[stack; spt(1) spt(2)];
hold on
% Plot only the convex hull
plot(stack(:,1),stack(:,2));
hold off


