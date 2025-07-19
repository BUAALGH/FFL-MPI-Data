import numpy as np
import matplotlib.pyplot as plt
from scipy import ndimage
from scipy.io import loadmat
from skimage.transform import iradon

# Load the measured voltage signal data (replace with your actual file path)
try:
    mat_data = loadmat('D:/FFL-MPI-Data/measured data/1/sensor_dataset/voltage_signal.mat')
    data = mat_data['data']  # Assume the variable name in MAT file is 'data'
except FileNotFoundError:
    print("File not found, please check the file path.")
    exit()
except Exception as e:
    print(f"Error loading file: {e}")
    exit()

# Define acquisition parameters
Angle = 31  # Number of FFL rotations
ff = 1      # Scanning frequency
fd = 3000   # Excitation frequency
Fs = 3e6    # Sampling frequency

# FFL scans the FOV twice within 1 second and averages the data
data = data[int(data.shape[0]/2):, :]

# Sinogram generation parameters
P = 25      # Number of pixels
L = data.shape[0]  # Length of raw signal
pFOV = L / P  # Length of pixel field of view

# Generate sinogram using STFT
sinogram_fft = np.zeros((P, Angle))

for i in range(Angle):
    for j in range(P):
        index = slice(int((j-1)*pFOV), int(j*pFOV))
        signal = data[index, i]
        ff_result = np.fft.fft(signal)
        # Corresponding to -imag(ff_result(181)) in MATLAB (Python index starts from 0)
        sinogram_fft[j, i] = -np.imag(ff_result[180])

# Sinogram interpolation and image reconstruction
# Using SciPy's zoom function to replace MATLAB's interp2
sinogram_fft = ndimage.zoom(sinogram_fft, 1)
ang_seq = np.arange(0, 180, 3)

# Perform FBP reconstruction using iradon
img_fft = iradon(sinogram_fft, theta=ang_seq, interpolation='spline', filter_name='cosine')

# Display the reconstructed image
plt.figure(figsize=(8, 8))
plt.imshow(img_fft, cmap='viridis')
plt.colorbar()
plt.axis('equal')
plt.axis('off')
plt.title('Reconstructed Image')
plt.tight_layout()

print(f'Image size: {img_fft.shape[0]} x {img_fft.shape[1]} pixels')
plt.show()