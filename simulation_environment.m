function path_info_output = simulation_environment(path_info_input,SNR,has_noise,num_samples,correlation_coefficient)
%% ��ʵ�黷������Ϊһ����ά����ϵ ÿ����λ���ȴ���1m
% target_location �Ƕ�λĿ���λ�� ��СΪ��1-2��һ������Ϊ����ԭ�㣩
% APs_location ��AP��λ�� ��СΪ��2-2-Nap 
%              Nap��ʵ�����õ���AP�ܸ�����ÿ��AP��Ӧ�������� 
%              ÿ�б�ʾһ����ά����㣬��������㼴ȷ����һ��AP�������������ڵ�
%              ƽ�档Ĭ������������о���target����ļ�Ϊ�������е�һ�����ߵ�λ
%              �ã���һ�����������������е�������Ա���һ�����ߵ�λ�ù�ϵ
% frequency ��Ϣ����Ĺ���Ƶ�� ��λ��Hz
% antenna_space AP����������֮��ľ��� ��ʾΪ�����ı���
% num_antenna ÿ��AP�����ߵĸ���
% num_subcarrier ÿ�������ϵ����ز���
% num_path ÿ��AP�ϵ�·������
% add_len ���ڷ�ֱ��·�� ·�����ȷ�Χ��(direct_len * add_len,direct_len * (add_len + 1))
% speed_light �źŴ����ٶ� m/s

%% �������
WLAN.path_info_input = path_info_input;
WLAN.SNR = SNR;
WLAN.has_noise = has_noise; % Ϊ1��������� �����������
WLAN.num_samples = num_samples;
WLAN.correlation_coefficient = correlation_coefficient;
WLAN.window_size = 2;
WLAN.grid_range = [180,90];
WLAN.precison = [1,1,0.5]'; % ��һ����AOA ��λ���� �ڶ�����TOF ��λ��m
WLAN.threshold = WLAN.precison;
WLAN.frequency = 5 * 10^9;
WLAN.antenna_space_ofwaveLen = [0.5,0.5];
WLAN.num_Rantenna = 8; % �������ߵĸ���
WLAN.num_Tantenna = 3; % �������ߵĸ���
WLAN.num_subcarrier = 64; % ���ز��ĸ���
WLAN.frequency_space = 312.5 * 10^3; % ��λ��Hz
WLAN.add_len = 1.1;
WLAN.speed_light = 3 * 10^8;
WLAN.iterateID = 1;

%% �Ȳ�����Ӧ��CSI���� ֮������MUSIC�㷨�����Ӧ��AOA��TOF

    % ����ÿ��AP��Ӧ��CSI������������յ���·����Ϣ
    CSI = simulation_generateCSI(WLAN);
    
    % ����MUSIC�㷨��CSI�����з����ÿ��·����AoA TOF
    path_info_output = mD_track(CSI,WLAN,size(WLAN.path_info_input,2));
%     path_info_output = music_SpotFi(CSI,WLAN,size(WLAN.path_info_input,1));
   

end
    