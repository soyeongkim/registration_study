%% Initialization
clear all;
close all;

addpath 'C:\Registration_study\datasets';
load("Point_2d.mat");

Straight(:,3) = 0;
Straight_x_y_yaw(:,3) = 0;

% rot = [1 0 0; 0 1 0; 0 0 1];
% trans = [3 0 0];
% 
% tranformation = rigid3d(rot, trans);

fixed_ptcloud = pointCloud(Straight);
target_ptcloud = pointCloud(Straight_x_y_yaw);
% target_ptcloud = pctransform(fixed_ptcloud, tranformation);

figure(1);
title("registration before");
pcshow(fixed_ptcloud);
hold on;

pcshow(target_ptcloud);
hold off;

matlab_icp_tform = pcregistericp(target_ptcloud,fixed_ptcloud, 'Metric', 'pointToPoint');
matlab_registrated_target_ptcloud = pctransform(target_ptcloud, matlab_icp_tform);   

figure(3);
title("matlab results");
pcshow(fixed_ptcloud);
hold on;

pcshow(matlab_registrated_target_ptcloud);

%% Iterative step
error_threshold = 0.1;
iter_error = 10000000;

fprintf('02. ICP \n');

tic;
while (iter_error > error_threshold)
    %% Get correspondences - Point Subset 
    correspondence_type = 1;
    
    % all points
    if(correspondence_type == 1)
        fixed_ptcloud_filtered = fixed_ptcloud;
        target_ptcloud_filtered = target_ptcloud;
    
    % uniform sub-sampling
    elseif(correspondence_type == 2)
        gridStep = 0.15;
        fixed_ptcloud_filtered = pcdownsample(fixed_ptcloud,'gridAverage',gridStep);
        target_ptcloud_filtered = pcdownsample(target_ptcloud,'gridAverage',gridStep);
    
    % random sampling
    elseif(correspondence_type == 3)
        percentage = 0.5;
        fixed_ptcloud_filtered = pcdownsample(fixed_ptcloud,'random',percentage);
        target_ptcloud_filtered = pcdownsample(target_ptcloud,'random',percentage);
    
    % feature-based sampling
    elseif(correspondence_type == 4)
        % TBD
    
    elseif(correspondence_type == 5)
    % normal space sampling
        percentage = 0.8;
        fixed_normals = pcnormals(fixed_ptcloud);
        target_normals = pcnormals(target_ptcloud);
    
        fixed_ptcloud_filtered = pointCloud(fixed_normals);
        target_ptcloud_filtered = pointCloud(target_normals);
    end
    
    fixed_ptcloud_filtered_arr = fixed_ptcloud_filtered.Location;
    target_ptcloud_filtered_arr = target_ptcloud_filtered.Location;
    
    %% Get correspondences - Data association
    
    association_type = 2;
    
    % save target-fixed point pair as [fixed target]
    correspondence_pair = zeros(length(target_ptcloud_filtered_arr), 6);

    if(association_type == 1)
        % closest point - KNN
        for target_idx = 1:length(target_ptcloud_filtered_arr)
    
            target_point = target_ptcloud_filtered_arr(target_idx, :);

            [indice_fixed,dist] = findNearestNeighbors(fixed_ptcloud_filtered,target_point,1);
            nearest_fixed_point = fixed_ptcloud_filtered_arr(indice_fixed, :);

%             figure(5);
%             pcshow(target_ptcloud_filtered);
%             hold on;
%             pcshow(fixed_ptcloud_filtered);
%             pcshow(target_point, 'MarkerSize', 20);
%             pcshow(nearest_fixed_point, 'MarkerSize', 20);
%             hold off;            
            
            correspondence_pair(target_idx, 1:3) = nearest_fixed_point;
            correspondence_pair(target_idx, 4:6) = target_point;
    
        end

    elseif(association_type == 2)
        %% dsearchn??
        [indices,dist] = dsearchn(fixed_ptcloud_filtered_arr,target_ptcloud_filtered_arr);

        for idx = 1:length(indices)
            correspondence_pair(idx, 1:3) = fixed_ptcloud_filtered_arr(indices(idx), :);

%             figure(5);
%             pcshow(target_ptcloud_filtered);
%             hold on;
%             pcshow(fixed_ptcloud_filtered);
%             pcshow(target_ptcloud_filtered_arr(idx,:), 'MarkerSize', 20);
%             pcshow(correspondence_pair(idx, 1:3), 'MarkerSize', 20);
%             hold off;            
        end

        correspondence_pair(:, 4:6) = target_ptcloud_filtered_arr;

    elseif(association_type == 3)
        % normal shooting
    
    end

    %% Get center of mass
    correspondence_pair_fixed = correspondence_pair(:, 1:3);
    correspondence_pair_target = correspondence_pair(:, 4:6);

    fixed_center_mass = zeros(1,3);
    target_center_mass = zeros(1,3);

    fixed_center_mass(1) = mean(fixed_ptcloud_filtered_arr(:,1));
    fixed_center_mass(2) = mean(fixed_ptcloud_filtered_arr(:,2));
    fixed_center_mass(3) = mean(fixed_ptcloud_filtered_arr(:,3));

    target_center_mass(1) = mean(target_ptcloud_filtered_arr(:,1));
    target_center_mass(2) = mean(target_ptcloud_filtered_arr(:,2));
    target_center_mass(3) = mean(target_ptcloud_filtered_arr(:,3));
    
    %% Generate subtract center of mass point subsets
    correspondence_pair_fixed_center_of_mass = correspondence_pair_fixed - fixed_center_mass;
    correspondence_pair_target_center_of_mass = correspondence_pair_target - target_center_mass;
    
    %% SVD
    svd_w = zeros(3,3);
    
    for idx = 1:length(correspondence_pair_fixed_center_of_mass)

        svd_w = svd_w + correspondence_pair_fixed_center_of_mass(idx, :)' * correspondence_pair_target_center_of_mass(idx, :);
    
    end
    
    [svd_u, svd_s, svd_v] = svd(svd_w);
    
    icp_rotation = svd_u * svd_v';

    if (det(icp_rotation) < 0)
         svd_v = [svd_v(:,1) svd_v(:,2) -svd_v(:,3)];

         icp_rotation = svd_u * svd_v';
    end

    icp_translation = fixed_center_mass' - icp_rotation * target_center_mass';

    registrated_target_arr = icp_rotation*target_ptcloud_filtered_arr' + icp_translation;
    registrated_target_arr = registrated_target_arr';

    registrated_target_ptcloud = pointCloud(registrated_target_arr);


    %% Error function
%     error = 0;
%     
%     for idx = 1:length(correspondence_pair_fixed_center_of_mass)
%         fixed = correspondence_pair_fixed_center_of_mass(idx, :)';
%         target = correspondence_pair_target_center_of_mass(idx, :)';
%     
%         error = error + norm(fixed)^2 + norm(target)^2;
%     end
%     
%     error = error - 2*(svd_s(1,1) + svd_s(2,2) + svd_s(3,3));
%     error = error/length(correspondence_pair_fixed_center_of_mass);
%     
%     iter_error = error;
%     fprintf('icp error: %f \n', iter_error);
    error = 0;

    for idx = 1:length(correspondence_pair_fixed_center_of_mass)
        fixed = correspondence_pair_fixed_center_of_mass(idx, :);
        target = correspondence_pair_target_center_of_mass(idx, :);
    
        error = error + norm(fixed-target);
    end

    error = error/length(correspondence_pair_fixed_center_of_mass);
    iter_error = error;
    fprintf('icp error: %f \n', iter_error);
    
    %% Check registration with visualization
    
    figure(2);
    title("registration results");
    pcshow(fixed_ptcloud);
    hold on;
    pcshow(fixed_center_mass, 'MarkerSize', 30);
    pcshow(target_center_mass, 'MarkerSize', 30);
    
    pcshow(registrated_target_ptcloud, 'MarkerSize', 20);
    
    pcshow(target_ptcloud);
    hold off;

    target_ptcloud = registrated_target_ptcloud;
end

elapsed_time = toc;

fprintf('final error: %f \n', iter_error);
fprintf('elapsed time: %f \n', elapsed_time);
fprintf('-------------------------\n');
