function [xyz, str_data_type] = fnGeneratePrimitive(testshape)
%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Derive rotation R and translation t using Iterative Closest Point(ICP)
% algorithm. 
%% Imput information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TBD  : file name(must be CSV file)
% testshape: [1: 2d Circle], [2: 2D Rectangular], [3: 3D ellipsoid], [4: 3D Cuboid]
%% Output information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% xyz (3, N): x value of point set

%% primitive parameters
% circle and sphere
xc = 0; yc = 0; zc = 0; % center position [m]
r = 2; % radius of circle [m]
xr = 2; yr = 2; zr = 2; % radius of ellipsoid [m]

% square and cuboid
xs = 0; ys = 0; zs = 0; % reference point [m]
w = 2; d = 3; h = 4; % w: width for x, d: depth for y, h: height for z [m]

% data incremental interval
interval = 0.1; % data interval for angle or x (case by case)
sqrt_npts = 50; % root of number of points, npts = (sqrt_npts + 1)^2 

%% Primitive Generation 
switch testshape
    case 1 % 2d Circle
        xyz = fnMakeCircle(xc, yc, r, interval);
        xyz = xyz(:, 1:2);
        
        str_data_type = '2D';
    case 2 % 2D Rectangular
        xyz = fnMakeRectangle(xs, ys, w, d, interval);
        xyz = xyz(:, 1:2);
        
        str_data_type = '2D';
    case 3 % 3D Sphere
        xyz = fnMakeEllipsoid(xc, yc, zc, xr, yr, zr, sqrt_npts);

        str_data_type = '3D';
    case 4 % 3D Cuboid
        xyz = fnMakeCuboid(xs, ys, zs, w, d, h, interval);

        str_data_type = '3D';
    otherwise
        error("[fnGeneratePrimitive] variable 'testshape' must be integer [1 ~ 4]");
end

% remove exactly duplicated points
xyz = unique(xyz, 'row')';

%% make functions
function [xyz] = fnMakeCircle(xc, yc, r, i)
    ang = [0:i:2*pi]';
    x = r*cos(ang);
    y = r*sin(ang);
    xyz = [xc + x, yc + y, zeros(size(x,1), 1)];
end

function [xyz] = fnMakeEllipsoid(xc, yc, zc, xr, yr, zr, sqrt_npts)
    [x,y,z] = ellipsoid(xc, yc, zc, xr, yr, zr, sqrt_npts);
    xyz = [x(:), y(:), z(:)];
    % TBD
end

function [xyz] = fnMakeRectangle(xs, ys, w, d, interval)
    vertex(1, :) = [xs    , ys];
    vertex(2, :) = [xs + w, ys];
    vertex(3, :) = [xs + w, ys + d];
    vertex(4, :) = [xs    , ys + d];
    
    % make line segment 1
    pts1 = vertex(1,:); pts2 = vertex(2,:);
    ls_x = linspace(pts1(1), pts2(1), ceil(w/interval));
    ls_y = linspace(pts1(2), pts2(2), ceil(w/interval));
    xy = [ls_x; ls_y];
    % make line segment 2
    pts1 = vertex(2,:); pts2 = vertex(3,:);
    ls_x = linspace(pts1(1), pts2(1), ceil(d/interval));
    ls_y = linspace(pts1(2), pts2(2), ceil(d/interval));
    xy = [xy, [ls_x; ls_y]];
    % make line segment 3
    pts1 = vertex(3,:); pts2 = vertex(4,:);
    ls_x = linspace(pts1(1), pts2(1), ceil(d/interval));
    ls_y = linspace(pts1(2), pts2(2), ceil(d/interval));
    xy = [xy, [ls_x; ls_y]];
    % make line segment 4
    pts1 = vertex(4,:); pts2 = vertex(1,:);
    ls_x = linspace(pts1(1), pts2(1), ceil(d/interval));
    ls_y = linspace(pts1(2), pts2(2), ceil(d/interval));
    xy = [xy, [ls_x; ls_y]];
    
    xy = unique(xy', 'row');
    xyz = [xy, zeros(size(xy,1), 1)];
    
end

function [xyz] = fnMakeCuboid(xs, ys, zs, w, d, h, interval)
    startingPoint = [ xs ys zs ];
    width = w;
    depth = d;
    height = h;

    lineX = startingPoint(1) : interval : startingPoint + width;
    idx = 1;
    planeXY = [lineX' ones(size(lineX,2),1)*startingPoint(2) ones(size(lineX,2),1)*startingPoint(3)  ];
    for yi  = startingPoint(2) + interval : interval : startingPoint(2) + depth
        lineXY = [lineX' ones(size(lineX,2),1)*yi zeros(size(lineX,2),1)*startingPoint(3)  ];
        planeXY = [planeXY; lineXY];
        idx = idx + 1;
    end

    box = planeXY;
    for zi = startingPoint(3) + interval : interval : startingPoint(3) + height
        planeZ = [planeXY(:,1:2) ones(size(planeXY,1),1)*zi];
        box = [box; planeZ];  
    end
    xlim = [startingPoint(1)+interval/2 startingPoint(1)+width-interval/2];
    ylim = [startingPoint(2)+interval/2 startingPoint(2)+depth-interval/2];
    zlim = [startingPoint(3)+interval/2 startingPoint(3)+height-interval/2]; 
    roi = [xlim(1) xlim(2) ylim(1) ylim(2) zlim(1) zlim(2)];

    pcdBox = pointCloud(box);
    indices = findPointsInROI(pcdBox, roi);
    entireIdx = linspace(1,size(box,1),size(box,1));
    reverseIdx = setdiff(entireIdx,indices);
    pcdBox = select(pcdBox, reverseIdx);
    
    pcshow(pcdBox)
    
    xyz = pcdBox.Location;
end

end
