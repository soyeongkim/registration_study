%%  File Name: main_registration.m
% Verify your own regisration algorithm with given development environment.
% It provides 2D & 3D point cloud pair such as ...
%   1. 2D primitives (circle, square) and 3D primitives (sphere, cube)
%   2. 3D teapot given by MATLAB
%   3. 3D real LiDAR point cloud pair which are overlapped about half
% 
% *************************************************************************
% test dataset configuration
% type: pointCloud object (moving, fixed)
% moving: source data to align to fixed data
% fixed: target data

clear all; close all; clc;

%% 00. Test Dataset Configuration
% True transformation parameters [tx, ty, yz, roll, pitch, yaw]' [m, rad]
% tf from fixed to moving points
true_x{1} = [1, 1, 1, deg2rad([0, 0, 0])]'; % [1:3 -> m], [4:6 -> rad]
true_x{2} = [3, 3, 3, deg2rad([0, 0, 0])]'; % [1:3 -> m], [4:6 -> rad]
true_x{3} = [1, 1, 1, deg2rad([0, 0, 10])]'; % [1:3 -> m], [4:6 -> rad]
true_x{4} = [3, 3, 3, deg2rad([0, 0, 10])]'; % [1:3 -> m], [4:6 -> rad]
true_x{5} = [1, 1, 1, deg2rad([0, 0, 30])]'; % [1:3 -> m], [4:6 -> rad]
true_x{6} = [3, 3, 3, deg2rad([0, 0, 30])]'; % [1:3 -> m], [4:6 -> rad]

% Testset selection
% [1: 2d Circle], [2: 2D Rectangular], [3: 3D Sphere], [4: 3D Cuboid], [5: 3D Teapot], [6: 3D Half overlapped scans]
testshape = 4;

% Noise parameters
fixed_std = 0.009;  % noise for target [m]
moving_std = 0.09;  % noise caused by sensor [m]

% Plot option
b_pcpair_plot = true; % plot a selected point cloud pair

%% 01. Test Dataset Generation
fprintf('-------------------------\n');
fprintf('01. test data generation \n');

% arr_moving = []; % moving array for all cases
% arr_fixed  = pointCloud([]); % fixed array (1: wo noise, 2: with noise)
switch testshape
    case 1 % 2d Circle
        [xyz, str_data_type] = fnGeneratePrimitive(testshape);
        b_gen_data = true;
    case 2 % 2D Rectangular
        [xyz, str_data_type] = fnGeneratePrimitive(testshape);
        b_gen_data = true;
    case 3 % 3D Sphere
        [xyz, str_data_type] = fnGeneratePrimitive(testshape);
        b_gen_data = true;
    case 4 % 3D Cuboid
        [xyz, str_data_type] = fnGeneratePrimitive(testshape);
        b_gen_data = true;
    case 5 % 3D Teapot
        xyz = double( importdata('xyzPoints.mat') );
        str_data_type = '3D';
        b_gen_data = true;
    case 6 % 3D Half overlapped scans
        % TBD 
        load('half_overlapped_scans.mat');
        str_data_type = '3D';
        b_gen_data = false;
    otherwise
        error("[main_registration] variable 'testshape' must be integer [1 ~ 6]");
end

if b_gen_data == true
    [arr_fixed(1), ~] = fnGenerateTestPoints(xyz, true_x{1}, 0, 0, false);
    [arr_fixed(2), ~] = fnGenerateTestPoints(xyz, true_x{1}, 0, 0, false);
    % without noise
    for i = 1:length(true_x)
        [~, moving_tmp(i)] = fnGenerateTestPoints(xyz, true_x{i}, 0, 0, b_pcpair_plot);
    end
    
    % with noise
    for i = 1:length(true_x)
        [~, moving_tmp_noise(i)] = fnGenerateTestPoints(xyz, true_x{i}, fixed_std, moving_std, b_pcpair_plot);
    end
    
    arr_moving = [moving_tmp, moving_tmp_noise];
else
    % use overlapped scans
    [arr_fixed(1), ~] = fnGenerateTestPoints(target.Location, [0, 0, 0, 0, 0, 0]', 0, 0, true);
    [arr_fixed(2), ~] = fnGenerateTestPoints(target.Location, [0, 0, 0, 0, 0, 0]', fixed_std, moving_std, true);
    [~, arr_moving(1)] = fnGenerateTestPoints(source.Location, [0, 0, 0, 0, 0, 0]', 0, 0, true);
    [~, arr_moving(2)] = fnGenerateTestPoints(source.Location, [0, 0, 0, 0, 0, 0]', fixed_std, moving_std, true);
    
end
fprintf('done \n');
fprintf('-------------------------\n');
