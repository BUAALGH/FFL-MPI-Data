import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat
from scipy import ndimage
from skimage.transform import iradon

# Load sinogram data (replace with your actual file path)
try:
    mat_data = loadmat(r'E:\FFL-MPI-Data\simulation data\sinogram_dataset\train_dataset\K_3\imag_part\sinogram_imag_synomag_3rd.mat')
    sinogram_imag_synomag_3rd = mat_data['sinogram_imag_synomag_3rd']
except FileNotFoundError:
    print("文件未找到，请检查文件路径。")
    exit()
except Exception as e:
    print(f"加载文件时出错: {e}")
    exit()

# Extract sinogram data and perform image reconstruction
sinogram_fft = sinogram_imag_synomag_3rd[:, :, 0]  # 对应MATLAB中的(:,:,1)
sinogram_fft = ndimage.zoom(sinogram_fft, 1)      # 插值，等效于MATLAB的interp2
ang_seq = np.arange(0, 181, 3)                     # 角度序列，0:3:180

# 使用iradon进行FBP重建，filter_name='none'对应MATLAB中的"none"
img_fft = iradon(sinogram_fft, theta=ang_seq, interpolation='spline', filter_name='none')

# Display reconstructed image
plt.figure(figsize=(10, 8))
plt.imshow(img_fft, cmap='viridis')  # 使用viridis颜色映射
plt.colorbar(label='Intensity')      # 添加颜色条
plt.axis('equal')                    # 等比例显示
plt.axis('off')                      # 关闭坐标轴
plt.title('Reconstructed Image')     # 设置标题
plt.tight_layout()                   # 优化布局

# 打印图像尺寸
print(f'Image size: {img_fft.shape[0]} x {img_fft.shape[1]} pixels')

# 显示图像
plt.show()