import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat
from skimage.transform import iradon

# 设置中文字体支持
plt.rcParams["font.family"] = ["SimHei", "WenQuanYi Micro Hei", "Heiti TC"]

# 加载正弦图数据（请替换为实际文件路径）
try:
    mat_data = loadmat(r'E:\FFL-MPI-Data\measured data\1\sinogram_dataset\K_3\imag_part\sinogram_imag.mat')
    sinogram_fft = mat_data['sinogram_imag']  # 假设MAT文件中的变量名是'sinogram_imag'
except FileNotFoundError:
    print("文件未找到，请检查文件路径。")
    exit()
except Exception as e:
    print(f"加载文件时出错: {e}")
    exit()

# 定义角度序列（对应MATLAB中的0:3:180）
ang_seq = np.arange(0, 181, 3)

# 使用iradon进行FBP重建，filter_name='cosine'对应MATLAB中的"Cosine"
img_fft = iradon(sinogram_fft, theta=ang_seq, interpolation='spline', filter_name='cosine')

# 显示重建图像
plt.figure(figsize=(10, 8))
plt.imshow(img_fft, cmap='viridis')  # 使用viridis颜色映射
plt.colorbar(label='强度')           # 添加颜色条
plt.axis('equal')                    # 等比例显示
plt.axis('off')                      # 关闭坐标轴
plt.title('重建图像')                # 设置标题
plt.tight_layout()                   # 优化布局

# 打印图像尺寸
print(f'图像尺寸: {img_fft.shape[0]} x {img_fft.shape[1]} 像素')

# 显示图像
plt.show()