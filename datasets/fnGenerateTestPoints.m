function [fixed_pcd, moving_pcd] = fnGenerateTestPoints(xyz, true_x, sigma_fixed, sigma_moving, plotOn)
%% Description %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Derive rotation R and translation t using Iterative Closest Point(ICP)
% algorithm. 
%% Imput information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TBD  : file name(must be CSV file)
% xyz (3, N): x value of point set
%% Output information %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

%% fixed points (target) & moving points (source)
% check points size (more 4 points are required to avoid data confusion)
if max(size(xyz)) <= 3
    error('[func_genTestPoints] the number of input points have to be more four');
end

% check whether input data is (3 x N)
if size(xyz,1) > size(xyz,2)
    xyz = xyz';
end

dim = size(xyz, 1);
num_pts = size(xyz, 2);

if dim == 2 % 2D points
    xf = xyz(1,:)';
    yf = xyz(2,:)';
    zf = zeros(num_pts, 1);
    
    % fixed point cloud
    fixed_pcd = pointCloud([xf, yf, zf] + randn(size([xf, yf, zf]))*sigma_fixed);
    
    % moving point cloud
    tmp = eul2rotm([true_x(6), 0, 0])*[xf, yf, zf]' + true_x(1:3,:) + randn(size([xf, yf, zf]'))*sigma_moving;
    tmp(3,:) = zeros(1, num_pts);
    moving_pcd = pointCloud(tmp');
    
elseif dim == 3 % 3D points
    xf = xyz(1,:)';
    yf = xyz(2,:)';
    zf = xyz(3,:)';
    
    % fixed point cloud
    fixed_pcd = pointCloud([xf, yf, zf] + randn(size([xf, yf, zf]))*sigma_fixed);
    
    % moving point cloud
    tmp = eul2rotm([true_x(6), true_x(5), true_x(4)])*[xf, yf, zf]' + true_x(1:3,:) + randn(size([xf, yf, zf]'))*sigma_moving;
    moving_pcd = pointCloud(tmp');

end


%% Check data
  
if plotOn == true
    figure;
    hold on;
    title('Generated test set');
    pcshowpair(fixed_pcd, moving_pcd, 'MarkerSize', 20);
    grid on;
    axis equal;
    legend('Fixed (target)', 'Moving (source)', 'TextColor', 'w');
%     set(gcf,'color','w')
end