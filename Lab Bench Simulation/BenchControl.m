% PLEASE READ: You MUST run 'BenchControl.m' in order for the gui to work
% properly. If you do not run it, none of the handles, etc. are created and
% it will not work.

function varargout = BenchControl(varargin)
% BENCHCONTROL MATLAB code for BenchControl.fig
%      BENCHCONTROL, by itself, creates a new BENCHCONTROL or raises the existing
%      singleton*.
%
%      H = BENCHCONTROL returns the handle to a new BENCHCONTROL or the handle to
%      the existing singleton*.
%
%      BENCHCONTROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BENCHCONTROL.M with the given input arguments.
%
%      BENCHCONTROL('Property','Value',...) creates a new BENCHCONTROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BenchControl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BenchControl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BenchControl

% Last Modified by GUIDE v2.5 21-May-2018 15:10:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BenchControl_OpeningFcn, ...
                   'gui_OutputFcn',  @BenchControl_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before BenchControl is made visible.
function BenchControl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BenchControl (see VARARGIN)

% Choose default command line output for BenchControl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes BenchControl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = BenchControl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ph3_R_1.
function ph3_R_1_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_R_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ph3_R_2.
function ph3_R_2_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_R_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in phA_R.
function phA_R_Callback(hObject, eventdata, handles)
% hObject    handle to phA_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in phB_R.
function phB_R_Callback(hObject, eventdata, handles)
% hObject    handle to phB_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in phC_R.
function phC_R_Callback(hObject, eventdata, handles)
% hObject    handle to phC_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in phA_AUX.
function phA_AUX_Callback(hObject, eventdata, handles)
% hObject    handle to phA_AUX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phB_AUX.
function phB_AUX_Callback(hObject, eventdata, handles)
% hObject    handle to phB_AUX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phC_AUX.
function phC_AUX_Callback(hObject, eventdata, handles)
% hObject    handle to phC_AUX (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ph3_AUX_1.
function ph3_AUX_1_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_AUX_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ph3_AUX_2.
function ph3_AUX_2_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_AUX_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ph3_AUX_3.
function ph3_AUX_3_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_AUX_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phA_CFL.
function phA_CFL_Callback(hObject, eventdata, handles)
% hObject    handle to phA_CFL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phB_CFL.
function phB_CFL_Callback(hObject, eventdata, handles)
% hObject    handle to phB_CFL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phC_CFL.
function phC_CFL_Callback(hObject, eventdata, handles)
% hObject    handle to phC_CFL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ph3_C_1.
function ph3_C_1_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_C_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ph3_C_2.
function ph3_C_2_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_C_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phA_C.
function phA_C_Callback(hObject, eventdata, handles)
% hObject    handle to phA_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phB_C.
function phB_C_Callback(hObject, eventdata, handles)
% hObject    handle to phB_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phC_C.
function phC_C_Callback(hObject, eventdata, handles)
% hObject    handle to phC_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ph3_L_1.
function ph3_L_1_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_L_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in ph3_L_2.
function ph3_L_2_Callback(hObject, eventdata, handles)
% hObject    handle to ph3_L_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phA_L.
function phA_L_Callback(hObject, eventdata, handles)
% hObject    handle to phA_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phB_L.
function phB_L_Callback(hObject, eventdata, handles)
% hObject    handle to phB_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in phC_L.
function phC_L_Callback(hObject, eventdata, handles)
% hObject    handle to phC_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in save_values.
function save_values_Callback(hObject, eventdata, handles)
% hObject    handle to save_values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% getting handles for each check box
R_handles = [handles.ph3_R_1; handles.ph3_R_2; handles.phA_R; handles.phB_R; handles.phC_R];
L_handles = [handles.ph3_L_1; handles.ph3_L_2; handles.phA_L; handles.phB_L; handles.phC_L];
C_handles = [handles.ph3_C_1; handles.ph3_C_2; handles.phA_C; handles.phB_C; handles.phC_C];
CFL_handles = [handles.phA_CFL; handles.phB_CFL; handles.phC_CFL];
AUX_handles = [handles.ph3_AUX_1; handles.ph3_AUX_2; handles.ph3_AUX_3; handles.phA_AUX; handles.phB_AUX; handles.phC_AUX];
% setting checkbox value (1 or 0) to each array - these values control the
% switches in the Simulink model
R_cont = cell2mat(get(R_handles, 'Value')); assignin('base','R_cont',R_cont);
L_cont = cell2mat(get(L_handles, 'Value')); assignin('base','L_cont',L_cont);
C_cont = cell2mat(get(C_handles, 'Value')); assignin('base','C_cont',C_cont);
CFL_cont = cell2mat(get(CFL_handles, 'Value')); assignin('base','CFL_cont',CFL_cont);
Aux_cont = cell2mat(get(AUX_handles, 'Value')); assignin('base','Aux_cont',Aux_cont);


% --- Executes on button press in run_simulation.
function run_simulation_Callback(hObject, eventdata, handles)
% hObject    handle to run_simulation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf('\nRunning Simulation....\n');
S = sim('EATON_LabBench_fix.slx', 'SimulationMode', 'normal'); % saves structure containing all "toWorkspace" variables and additional simulation information
fprintf('Simulation Complete\n\n');
Time = S.get('tout'); % creating Time variable
V = S.V_sys.get('Data'); % creating Voltage variable
I = S.I_sys.get('Data'); % creating Current variable
assignin('base', 'S', S);
assignin('base', 'V', V);
assignin('base', 'I', I);
assignin('base', 'Time', Time);
% Optional save line (change the name in single quotes to what you want it
% to be saved as
fprintf('Saving Values....\n');
save('test', 'S', 'V', 'I', 'Time');
fprintf('Save Complete\n');

