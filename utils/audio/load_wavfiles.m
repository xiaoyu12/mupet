% load_wavfiles
function handles=load_wavfiles(handles)

    handles.datadir = uigetdir;
    filelist1=dir(fullfile(handles.datadir,'*.WAV'));
    filelist2=dir(fullfile(handles.datadir,'*.wav'));
    crit = '^[^.]+';
    rxResult1 = regexp( {filelist1.name}, crit );
    rxResult2 = regexp( {filelist2.name}, crit );
    if (length(filelist1)+length(filelist2)) > 0,
        handles.flist=unique({ filelist1.name filelist2.name });
        handles.flist([cellfun(@isempty,rxResult1)==true cellfun(@isempty,rxResult2)==true])=[];
        content=handles.flist;
        [~,handles.audiodir]=fileparts(handles.datadir);
        handles.audiodir=fullfile(handles.workspace_dir,'audio',handles.audiodir);
        if ~exist(handles.audiodir,'dir')
           mkdir(handles.audiodir);
        end
    else
        content=sprintf('No wave files found in directory\n');
    end
    set(handles.wav_directory,'string',handles.datadir);
    set(handles.wavList,'value',1);
    set(handles.wavList,'string',content);

end