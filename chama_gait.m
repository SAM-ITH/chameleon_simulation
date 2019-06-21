





lib_name = '';

if strcmp(computer, 'PCWIN')
  lib_name = 'dxl_x86_c';
elseif strcmp(computer, 'PCWIN64')
  lib_name = 'dxl_x64_c';
elseif strcmp(computer, 'GLNX86')
  lib_name = 'libdxl_x86_c';
elseif strcmp(computer, 'GLNXA64')
  lib_name = 'libdxl_x64_c';
elseif strcmp(computer, 'MACI64')
  lib_name = 'libdxl_mac_c';
end

% Load Libraries
if ~libisloaded(lib_name)
    [notfound, warnings] = loadlibrary(lib_name, 'dynamixel_sdk.h', 'addheader', 'port_handler.h', 'addheader', 'packet_handler.h');
end

% Control table address
ADDR_MX_TORQUE_ENABLE       = 24;           % Control table address is different in Dynamixel model
ADDR_MX_GOAL_POSITION       = 30;
ADDR_MX_PRESENT_POSITION    = 36;

% Protocol version
PROTOCOL_VERSION            = 1.0;          % See which protocol version is used in the Dynamixel

%assigning 

% Default setting
DXL_ID                      = 1;            % Dynamixel ID: 1
DXL_ID_1                    = 2;
DXL_ID_2                    = 3;
DXL_ID_3                    = 4;
DXL_ID_4                    = 5;
DXL_ID_5                    = 6;
DXL_ID_6                    = 7;
DXL_ID_7                    = 8;
DXL_ID_8                    = 9;
DXL_ID_9                    = 10;
DXL_ID_10                   = 11;
DXL_ID_11                   = 12;
DXL_ID_12                   = 13;
DXL_ID_13                   = 14;
DXL_ID_14                   = 15;
DXL_ID_15                   = 16;
DXL_ID_16                   = 17;
DXL_ID_17                   = 18;
DXL_ID_18                   = 19;
DXL_ID_19                   = 20;

BAUDRATE                    = 1000000;
DEVICENAME                  = 'COM7';       % Check which port is being used on your controller
                                            % ex) Windows: 'COM1'   Linux: '/dev/ttyUSB0' Mac: '/dev/tty.usbserial-*'

TORQUE_ENABLE               = 1;            % Value for enabling the torque
TORQUE_DISABLE              = 0;            % Value for disabling the torque
DXL_MINIMUM_POSITION_VALUE  = 150;          % Dynamixel will rotate between this value
DXL_MAXIMUM_POSITION_VALUE  = 600;         % and this value (note that the Dynamixel would not move when the position value is out of movable range. Check e-manual about the range of the Dynamixel you use.)
DXL_MOVING_STATUS_THRESHOLD = 10;           % Dynamixel moving status threshold
ROT_SPD                     = 40;
ESC_CHARACTER               = 'e';          % Key for escaping loop

COMM_SUCCESS                = 0;            % Communication Success result value
COMM_TX_FAIL                = -1001;        % Communication Tx Failed

% Initialize PortHandler Structs
% Set the port path
% Get methods and members of PortHandlerLinux or PortHandlerWindows
port_num = portHandler(DEVICENAME);

% Initialize PacketHandler Structs
packetHandler();

index = 1;
dxl_comm_result = COMM_TX_FAIL;             % Communication result
dxl_goal_position = [DXL_MINIMUM_POSITION_VALUE DXL_MAXIMUM_POSITION_VALUE];         % Goal position

dxl_error = 0;                              % Dynamixel error
dxl_present_position = 0;                   % Present position


% Open port
if (openPort(port_num))
    fprintf('Succeeded to open the port!\n');
else
    unloadlibrary(lib_name);
    fprintf('Failed to open the port!\n');
    input('Press any key to terminate...\n');
    return;
end


% Set port baudrate
if (setBaudRate(port_num, BAUDRATE))
    fprintf('Succeeded to change the baudrate!\n');
else
    unloadlibrary(lib_name);
    fprintf('Failed to change the baudrate!\n');
    input('Press any key to terminate...\n');
    return;
end


% Enable Dynamixel Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_1, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_2, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_3, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_4, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);

write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_5, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_6, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_7, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_8, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_9, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);

write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_10, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_11, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_12, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_13, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_14, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);

write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_15, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_16, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_17, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_18, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_19, ADDR_MX_TORQUE_ENABLE, TORQUE_ENABLE);

dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
else
    fprintf('Dynamixel has been successfully connected \n');
end

write2ByteTxRx(port_num, 1.0, DXL_ID, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_1, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_1, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_2, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_2, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_3, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_3, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_4, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_4, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_5, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_5, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_6, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_6, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_7, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_7, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_8, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_8, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_9, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_9, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_10, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_10, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_11, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_11, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_12, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_12, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_13, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_13, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_14, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_14, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_15, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_15, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_16, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_16, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_17, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_17, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_18, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_18, 33, typecast(int16(ROT_SPD), 'uint16'));

write2ByteTxRx(port_num, 1.0, DXL_ID_19, 32, typecast(int16(ROT_SPD), 'uint16'));
write2ByteTxRx(port_num, 1.0, DXL_ID_19, 33, typecast(int16(ROT_SPD), 'uint16'));



for i = 1:10
    
    pos1 = 813;
    pos2 = 682;
    pos3 = 331;
    pos4 = 390;
    pos5 = 541;           
     
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_GOAL_POSITION, pos1);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_1, ADDR_MX_GOAL_POSITION, pos2);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_2, ADDR_MX_GOAL_POSITION, pos3);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_3, ADDR_MX_GOAL_POSITION, pos4);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_4, ADDR_MX_GOAL_POSITION, pos5);
    %pause(1)
            
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_5, ADDR_MX_GOAL_POSITION, pos1);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_6, ADDR_MX_GOAL_POSITION, pos2);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_7, ADDR_MX_GOAL_POSITION, pos3);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_8, ADDR_MX_GOAL_POSITION, pos4);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_9, ADDR_MX_GOAL_POSITION, pos5);
    %pause(1)
       
        
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_10, ADDR_MX_GOAL_POSITION, pos1);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_11, ADDR_MX_GOAL_POSITION, pos2);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_12, ADDR_MX_GOAL_POSITION, pos3);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_13, ADDR_MX_GOAL_POSITION, pos4);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_14, ADDR_MX_GOAL_POSITION, pos5);
    %pause(1)
    
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_15, ADDR_MX_GOAL_POSITION, pos1);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_16, ADDR_MX_GOAL_POSITION, pos2);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_17, ADDR_MX_GOAL_POSITION, pos3);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_18, ADDR_MX_GOAL_POSITION, pos4);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_19, ADDR_MX_GOAL_POSITION, pos5);
    %pause(1)
        
   
        
end
for i = 1:10
    
    pos1 = 213;
    pos2 = 382;
    pos3 = 331;
    pos4 = 390;
    pos5 = 541;           
     
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_GOAL_POSITION, pos1);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_1, ADDR_MX_GOAL_POSITION, pos2);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_2, ADDR_MX_GOAL_POSITION, pos3);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_3, ADDR_MX_GOAL_POSITION, pos4);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_4, ADDR_MX_GOAL_POSITION, pos5);
    %pause(1)
            
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_5, ADDR_MX_GOAL_POSITION, pos1);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_6, ADDR_MX_GOAL_POSITION, pos2);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_7, ADDR_MX_GOAL_POSITION, pos3);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_8, ADDR_MX_GOAL_POSITION, pos4);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_9, ADDR_MX_GOAL_POSITION, pos5);
    %pause(1)
       
        
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_10, ADDR_MX_GOAL_POSITION, pos1);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_11, ADDR_MX_GOAL_POSITION, pos2);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_12, ADDR_MX_GOAL_POSITION, pos3);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_13, ADDR_MX_GOAL_POSITION, pos4);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_14, ADDR_MX_GOAL_POSITION, pos5);
    %pause(1)
    
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_15, ADDR_MX_GOAL_POSITION, pos1);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_16, ADDR_MX_GOAL_POSITION, pos2);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_17, ADDR_MX_GOAL_POSITION, pos3);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_18, ADDR_MX_GOAL_POSITION, pos4);
    %pause(1)
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_19, ADDR_MX_GOAL_POSITION, pos5);
    %pause(1)
        
   
        
end





% Disable Dynamixel Torque
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_1, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_2, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_3, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_4, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);

write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_5, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_6, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_7, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_8, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_9, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);

write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_10, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_11, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_12, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_13, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_14, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);

write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_15, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_16, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_17, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_18, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);
write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID_19, ADDR_MX_TORQUE_ENABLE, TORQUE_DISABLE);

dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= COMM_SUCCESS
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

% Close port
closePort(port_num);


% Unload Library
unloadlibrary(lib_name);

close all;
clear all;




