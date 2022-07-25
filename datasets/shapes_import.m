SimData = load('Point_3d.mat');
%% Straight Data
% Straight_point = SimData.Straight;
% Straight_x_point = SimData.Straight_x;
% Straight_y_point = SimData.Straight_y;
% Straight_yaw_point = SimData.Straight_x_y_yaw;
% Straight_x_y_yaw_point = SimData.Straight_x_y_yaw;
visualization = true;
% make pcd first, then put object into array.
zAxis = linspace(0,0,size(SimData.Straight,1))';
referenceShapes2d(1) = pointCloud([SimData.Straight(:,1:2) zAxis] );
referenceShapes2d(2) = pointCloud([SimData.Straight_x(:,1:2) zAxis] );
referenceShapes2d(3) = pointCloud([SimData.Straight_y(:,1:2) zAxis]);
referenceShapes2d(4) = pointCloud([SimData.Straight_yaw(:,1:2) zAxis]);
referenceShapes2d(5) = pointCloud([SimData.Straight_x_y_yaw(:,1:2) zAxis]);

if(visualization)
straightLineVisFigure = figure("Name","reference data - straight line.");
straightLineVisAxes = axes(straightLineVisFigure);
straightLineVisFigure.Position = [500 500 500 500];

plot(referenceShapes2d(1).Location(:,1),referenceShapes2d(1).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(2).Location(:,1),referenceShapes2d(2).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(3).Location(:,1),referenceShapes2d(3).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(4).Location(:,1),referenceShapes2d(4).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(5).Location(:,1),referenceShapes2d(5).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
end

%% Sinewave Data
% Sinuous_point = SimData.Sinuous;
% Sinuous_x_point = SimData.Sinuous_x;
% Sinuous_y_point = SimData.Sinuous_y;
% Sinuous_yaw_point = SimData.Sinuous_yaw;
% Sinuous_x_y_yaw_point = SimData.Sinuous_x_y_yaw;

zAxis = linspace(0,0,size(SimData.Sinuous,1))';
referenceShapes2d(6) = pointCloud([SimData.Sinuous(:,1:2) zAxis]);
referenceShapes2d(7) = pointCloud([SimData.Sinuous_x(:,1:2) zAxis]);
referenceShapes2d(8) = pointCloud([SimData.Sinuous_y(:,1:2) zAxis]);
referenceShapes2d(9) = pointCloud([SimData.Sinuous_yaw(:,1:2) zAxis]);
referenceShapes2d(10) = pointCloud([SimData.Sinuous_x_y_yaw(:,1:2) zAxis]);
if(visualization)
SinuousPointVisFigure = figure("Name","reference data - Sinuous_point.");
SinuousPointVisAxes = axes(SinuousPointVisFigure);
SinuousPointVisFigure.Position = [500 500 500 500];

plot(referenceShapes2d(6).Location(:,1), referenceShapes2d(6).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(7).Location(:,1), referenceShapes2d(7).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(8).Location(:,1), referenceShapes2d(8).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(9).Location(:,1), referenceShapes2d(9).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(10).Location(:,1), referenceShapes2d(10).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
end
%% Corner Data
% Corner_point = SimData.Corner;
% Corner_x_point = SimData.Corner_x;
% Corner_y_point = SimData.Corner_y;
% Corner_yaw_point = SimData.Corner_yaw;
% Corner_x_y_yaw_point = SimData.Corner_x_y_yaw;

zAxis = linspace(0,0,size(SimData.Corner,1))';
referenceShapes2d(11) = pointCloud([SimData.Corner(:,1:2) zAxis]);
referenceShapes2d(12) = pointCloud([SimData.Corner_x(:,1:2) zAxis]);
referenceShapes2d(13) = pointCloud([SimData.Corner_y(:,1:2) zAxis]);
referenceShapes2d(14) = pointCloud([SimData.Corner_yaw(:,1:2) zAxis]);
referenceShapes2d(15) = pointCloud([SimData.Corner_x_y_yaw(:,1:2) zAxis]);
if(visualization)
CornerPointVisFigure = figure("Name","reference data - CornerPoint.");
CornerPointVisAxes = axes(CornerPointVisFigure);
CornerPointVisFigure.Position = [500 500 500 500];

plot(referenceShapes2d(11).Location(:,1), referenceShapes2d(11).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(12).Location(:,1), referenceShapes2d(12).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(13).Location(:,1), referenceShapes2d(13).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(14).Location(:,1), referenceShapes2d(14).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(15).Location(:,1), referenceShapes2d(15).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
end
%% Rectangle Data
% Rectangular_point = SimData.Rectangular;
% Rectangular_x_point = SimData.Rectangular_x;
% Rectangular_y_point = SimData.Rectangular_y;
% Rectangular_yaw_point = SimData.Rectangular_yaw;
% Rectangular_x_y_yaw_point = SimData.Rectangular_x_y_yaw;

zAxis = linspace(0,0,size(SimData.Rectangular,1))';
referenceShapes2d(16) = pointCloud([SimData.Rectangular(:,1:2) zAxis]);
referenceShapes2d(17) = pointCloud([SimData.Rectangular_x(:,1:2) zAxis]);
referenceShapes2d(18) = pointCloud([SimData.Rectangular_y(:,1:2) zAxis]);
referenceShapes2d(19) = pointCloud([SimData.Rectangular_yaw(:,1:2) zAxis]);
referenceShapes2d(20) = pointCloud([SimData.Rectangular_x_y_yaw(:,1:2) zAxis]);
if(visualization)
RectangularPointVisFigure = figure("Name","reference data - RectangularPoint.");
RectangularPointVisAxes = axes(RectangularPointVisFigure);
RectangularPointVisFigure.Position = [500 500 500 500];

plot(referenceShapes2d(16).Location(:,1), referenceShapes2d(16).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(17).Location(:,1), referenceShapes2d(17).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(18).Location(:,1), referenceShapes2d(18).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(19).Location(:,1), referenceShapes2d(19).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(20).Location(:,1), referenceShapes2d(20).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
end
%% Circle Data
% Circle_point = SimData.Circle;
% Circle_x_point = SimData.Circle_x;
% Circle_y_point = SimData.Circle_y;
% Circle_yaw_point = SimData.Circle_yaw;
% Circle_x_y_yaw_point = SimData.Circle_x_y_yaw;

zAxis = linspace(0,0,size(SimData.Rectangular,1))';
referenceShapes2d(21) = pointCloud([SimData.Circle(:,1:2) zAxis]);
referenceShapes2d(22) = pointCloud([SimData.Circle_x(:,1:2) zAxis]);
referenceShapes2d(23) = pointCloud([SimData.Circle_y(:,1:2) zAxis]);
referenceShapes2d(24) = pointCloud([SimData.Circle_yaw(:,1:2) zAxis]);
referenceShapes2d(25) = pointCloud([SimData.Circle_x_y_yaw(:,1:2) zAxis]);
if(visualization)
CirclePointVisFigure = figure("Name","reference data - CirclePoint.");
CirclePointVisAxes = axes(CirclePointVisFigure);
CirclePointVisFigure.Position = [500 500 500 500];

plot(referenceShapes2d(21).Location(:,1), referenceShapes2d(21).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(22).Location(:,1), referenceShapes2d(22).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(23).Location(:,1), referenceShapes2d(23).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(24).Location(:,1), referenceShapes2d(24).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(25).Location(:,1), referenceShapes2d(25).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
end
%% Random point Data
% Random_point = SimData.Random;
% Random_x_point = SimData.Random_x;
% Random_y_point = SimData.Random_y;
% Random_yaw_point = SimData.Random_yaw;
% Random_x_y_yaw_point = SimData.Random_x_y_yaw;
zAxis = linspace(0,0,size(SimData.Random,1))';
referenceShapes2d(26) = pointCloud([SimData.Random(:,1:2) zAxis]);
referenceShapes2d(27) = pointCloud([SimData.Random_x(:,1:2) zAxis]);
referenceShapes2d(28) = pointCloud([SimData.Random_y(:,1:2) zAxis]);
referenceShapes2d(29) = pointCloud([SimData.Random_yaw(:,1:2) zAxis]);
referenceShapes2d(30) = pointCloud([SimData.Random_x_y_yaw(:,1:2) zAxis]);
if(visualization)
RandomPointVisFigure = figure("Name","reference data - RandomPoint.");
RandomPointVisAxes = axes(RandomPointVisFigure );
RandomPointVisFigure.Position = [500 500 500 500];

plot(referenceShapes2d(26).Location(:,1), referenceShapes2d(26).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(27).Location(:,1), referenceShapes2d(27).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(28).Location(:,1), referenceShapes2d(28).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(29).Location(:,1), referenceShapes2d(29).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
plot(referenceShapes2d(30).Location(:,1), referenceShapes2d(30).Location(:,2),"LineStyle","none","Marker",".","MarkerSize",6);
hold on
end