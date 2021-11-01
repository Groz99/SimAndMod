% Modtech week 2 tutorial
% Script to develop a Finite Element Mesh for analysis of nodes
clear all
close all
MeshLen = [1 2 4 8 16];
FileLoc = 'H:\System modelling and simulation\Week2\Figures\';
%FileLoc = 'Figures1\';
%mkdir(FileLoc)
for idx = 1 : length(MeshLen)
    mesh(idx) = OneDimLinearMeshGen(0, 1, MeshLen(idx));
    %figure
    %displayMesh(mesh(idx))
    saveas(gcf, [FileLoc 'Mesh' num2str(MeshLen(idx)) '.fig'])
end

