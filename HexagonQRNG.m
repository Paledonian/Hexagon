% KTHack2020
% Hexagon Grubu
% Hexagon QRNG
% Yazar : Arda Kayaalp
% Tarih : 10.10.20

%% Temizlik İşleri
clc
close all
clear all
%% Program Ayarları
% Çıktı Dosyası İsimlendirmesi
Title_Template_Bin = "HexagonQRNG-OUT";
Extension = '.txt';
fileBin = fopen(strcat(Title_Template_Bin,date,Extension),'w');
% Üretim Metodunun Seçilmesi
Hot_Bit = true;
Even_Odd = false;
%% 
%% Dedektör Veri Girdisi(İki sayım arasındaki zaman bilgisi)
[baseName, folder] = uigetfile('*.txt','Veri Setini Seçiniz');
fullFileName = fullfile(folder, baseName);
opts = delimitedTextImportOptions("NumVariables", 1);
opts.DataLines = [1, Inf];
opts.Delimiter = ",";
opts.VariableNames = "EventTime";
opts.VariableTypes = "double";
opts.ImportErrorRule = "omitrow";
opts.MissingRule = "omitrow";
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
Dedektor_Veri = readtable(fullFileName, opts);
Dedektor_Veri = table2cell(Dedektor_Veri);
numIdx = cellfun(@(x) ~isnan(str2double(x)), Dedektor_Veri);
Dedektor_Veri(numIdx) = cellfun(@(x) {str2double(x)}, Dedektor_Veri(numIdx));
Dedektor_Veri = cell2mat(Dedektor_Veri);
clear opts
%%
if Hot_Bit    
%% Hot Bit Method
    if rem(numel(Dedektor_Veri),2)==0
       Hot_Bit_Out = zeros((numel(Dedektor_Veri)/2),1);
    else
       Hot_Bit_Out = zeros((numel(Dedektor_Veri)-1)/2,1);
    end    
    counter = 1;
    for ii = 1:2:numel(Dedektor_Veri)
        if ii+1 <= numel(Dedektor_Veri)
           t1 = Dedektor_Veri(ii);
           t2 = Dedektor_Veri(ii+1);
           if t1>t2
              Hot_Bit_Out(counter) = 1;
              counter = counter + 1;
           elseif t1<t2
               Hot_Bit_Out(counter) = 0;
               counter = counter + 1;
           elseif t1==t2
               continue
           end
        end
    end
    Binary_Out = Hot_Bit_Out;
    %%
elseif Even_Odd    
    %% Even-Odd Time Interval Method
    counter = 1;
    Even_Odd_Bit_Out = zeros(numel(Dedektor_Veri),1);
    for ii = 1:numel(Dedektor_Veri)
        if rem(ii,2)==0
            Even_Odd_Bit_Out(counter) = 0;
            counter = counter + 1;
        else
            Even_Odd_Bit_Out(counter) = 1;
            counter = counter + 1;
        end
    end
    Binary_Out = Even_Odd_Bit_Out;
    %%
end
fprintf(fileBin,'%d\n',Binary_Out);
fclose(fileBin);
fprintf('%d Kuantum Bit Uretildi.\n',numel(Binary_Out))
msgbox('Islem Tamamlandı!')

 
