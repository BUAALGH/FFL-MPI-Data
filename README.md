# 🌟 FFL-MPI-Data

This repository serves as the official project page for ​**FFL-MPI-Data**​, *A public projection imaging dataset for field free line magnetic particle imaging*.

The FFL-MPI-Data provides a comprehensive collection of both **measured** and **simulated** data, offering critical resources for developing and evaluating image reconstruction algorithms for field free line magnetic particle imaging, especially for challenging tasks like limited-angle and sparse-angle reconstruction.

---

## 💾 Dataset Availability & Overview

### Dataset Access

The full dataset is available on Zenodo:

https://doi.org/10.5281/zenodo.16563447

### Authors

* **Guanghui Li** (liguanghui@buaa.edu.cn), **Haicheng Du**, Ziwei Chen, et al

### FFL-MPI-Data Content Breakdown

The dataset is categorized into two main groups:

#### 1. Measured Datasets

* **Acquisition System:** Collected using a self-developed, open-sided FFL-MPI system.
* **Phantoms:** Features **100 unique 3D-printed shape phantoms** filled with **synomag** magnetic nanoparticles (diameter: 70nm).
* **Data Included:** Provides the complete data pipeline:
  * **Voltage Signals** (Raw Sensor Data).
  * ​**Sinograms**​.
  * ​**Reconstructed Image Data**​.
  * Detailed information on the **2nd to 7th harmonics** of the voltage signals.

#### 2. Simulated Datasets

* **Digital Phantoms:** Uses the **MNIST handwritten digit dataset** as the basis for digital phantoms.
* **Scale:** Includes **60,000 training samples** and ​**10,000 testing samples**​.
* **Simulation Model:** The digital phantoms are processed using a **simulation framework built based on the MJA model** (Magnetic Joint Action Model), ensuring realism in the simulated signal responses.

---

## 🏗 FFL-MPI-Data Construction Workflow

The construction of the FFL-MPI-Data involves careful processing from raw signal acquisition (measured) or Langevin modeling (simulated) to the final sinogram and image domains.

---

## 📂 Folder Structure and Directory

The repository is organized to provide clear access to reconstruction, simulation, and deep learning examples:

```
FFL-MPI-Data/
├── 1_reconstruction_codes/         # Signal Processing and Traditional Reconstruction (MATLAB/Python)
│   ├── measured_sensor.*           # Process raw voltage signals (signal -> STFT -> sinogram -> FBP -> image)
│   ├── measured_sinogram.*         # Process measured sinograms (sinogram -> FBP -> image)
│   └── simulated_sinogram.*        # Process simulated sinograms (sinogram -> FBP -> image)
├── 2_simulation_framework/         # Calibrated MPI simulation framework
│   ├── main_function.m             # main function to run
│   ├── Datasets                    # MNIST train & test dataset and lables
│   ├── Noise                       # FFL-MPI Scanner background noises with harmonics image
|   ├── Models                      # SPIOs model with Langevin function
|   ├── Modules                     # functinal modules: Basic_setup, Magnetic_Field_Generation, Signal_Generation, Visualization_2
|   └── Phantom_Photos              # example phantom photos
├── 3_deep_learning_demo/           # Deep learning based reconstruction examples
│   ├── limited_angle_task/         # Limited-Angle Reconstruction Task
│   └── sparse_angle_task/          # Sparse-Angle Reconstruction Task
└── README.md                       # This file
```

---

## 🛠 Code Usage and Functionality

This project provides example codes for loading and processing the dataset.

### 1. `reconstruction_codes`: Signal Processing and Image Reconstruction Example Codes

This module contains scripts that demonstrate loading the dataset and performing basic reconstruction using traditional FBP methods across different data domains.

| **Script Name**        | **Data Domain**   | **Dataset Type** | **Key Procedures**                      |
| ---------------------- | ------------------------- | ------------------------ | ----------------------------------------------- |
| `measured_sensor`        | Sensor Domain (Voltage) | Measured               | Reading Voltage Signals, STFT Processing, FBP |
| `measured_sinogram`      | Sinogram Domain         | Measured               | Reading Sinograms, FBP-based Reconstruction   |
| `simulated_sinogram`     | Sinogram Domain         | Simulated              | Reading Sinograms, FBP-based Reconstruction   |

If the user is processing voltage signals from the measured dataset, use `measured_sensor.m`;  
if processing sinograms from the measured dataset, use `measured_sinogram.m`;  
if processing sinograms from the simulated dataset, use `simulated_sinogram.m`.  

The user only needs to modify their own data storage path to complete the image reconstruction.  
Our sample code provides a single-data processing method. If batch data processing is required, simply add an additional loop for handling.

### 2. `simulation_tool`:open-sourced simulation framework codes

This module provides the calibrated MPI simulation framework used to generate large-scale synthetic datasets. We provide 3 sample phantoms, including vascular phantoms and an "S" letter phantom, which users can directly call for demonstration.

**Components of the Simulation Tool:**
##### 1. Dataset
- **Source**: MNIST dataset is employed as the digital phantom source.
- **Split**: 60,000 samples for training and 10,000 samples for testing.

##### 2. Models
- **Implemented Model**: The framework currently includes the **Langevin Model** for magnetic particle modeling.
- **Extensibility**: Additional particle models can be incorporated by adding corresponding files to the `Models` folder. To use a new model, update the model index in `Modules/Basic_setups.m`.

##### 3. Noise
- **Availability**: Background noise files (`noise_k_2.mat` to `noise_k_7.mat`) are provided.
- **Specifications**: 
  - The noise is defined in the image domain.
  - Each noise sample has a size of `[49, 49]`.
  - It is added directly onto the simulated images.

##### 4. Modules
The simulation framework is organized into the following modular components:

| Module | Description |
|--------|-------------|
| `Basic_setups.m` | Configures fundamental parameters, including: <br> • Gradient strength <br> • Excitation magnetic field amplitude <br> • ADC sampling specifications <br> • Nanoparticle type selection |
| `Magnetic_Field_Generation.m` | Generates the magnetic field required for imaging based on the configurations set in `Basic_setups.m`. |
| `Phantoms_Load.m` | Loads digital images (e.g., from MNIST) for use as simulation phantoms. |
| `Signal_Generation.m` | Computes nanoparticle magnetization-induced signals based on the selected particle model (e.g., modified Jiles–Atherton) and the generated magnetic field. |
| `visualization.m` | Visualizes imaging results, including sinograms and reconstructed images. |

##### 5. Main Function
- **File**: `main_function.m`
- **Purpose**: Contains the main simulation pipeline.
- **Usage**: Execute `main_function.m` to run the complete simulation process.

**Running Results:**
<img width="1920" height="954" alt="Output" src="https://github.com/user-attachments/assets/6320c364-747c-46aa-b32b-6a11c8fcba40" />
Users can add `save img_simulated_imag.mat img_simulated_imag` to save the output image. 

Similarly, we provide single-image sample code. If users need to run large-scale MNIST data, they can:

1. In `Phantom_Load.m`, **delete or comment out**:
   - Line 14: `load phantom.mat % loading the example phantom`
   - Line 15: `train_images = phantom; % change the data type of phantom, if you have multiple phantoms`

2. **Add**:
   ```matlab
   img_imag_synomag_2nd(:,:,n) = img_simulated_imag;
   save img_imag_synomag_2nd.mat img_imag_synomag_2nd
to create and save batch data.

3. Additionally, in `main_function.m`, modify this line:
   `N_phantoms = 1; % Number of phantoms to process`

Set the number to define how many MNIST data samples to run.

## 3. `deep_learning_demo`

To demonstrate the dataset's utility in deep learning-based reconstruction, we have developed and open-sourced a demo featuring two representative projection imaging challenges.

#### Reconstruction Scenarios

| Challenge Type | Configuration | Full Configuration |
| :------------: | :----------: | :---------------: |
| Limited-angle Reconstruction | 7 angles | 31 angles |
| Sparse-view Reconstruction | 0°:12°:180° | 0°:3°:180° |

#### Network Architecture

**FBPConvNet Architecture** - A U-Net variant with Filtered Back Projection (FBP) integration, specifically tailored for image reconstruction tasks.

#### Training Configuration

| Parameter | Pre-training Phase | Fine-tuning Phase |
| :-------: | :----------------: | :---------------: |
| Dataset | 10,000 simulated phantoms | 80 measured phantoms (training) + 20 (validation) |
| Epochs | 200 | 200 |
| Optimizer | Adam | Adam |
| Learning Rate | 10⁻⁴ | 10⁻⁵ |
| Loss Function | PSNR loss | PSNR loss |
| Batch Size | 8 | 8 |
| GPU | NVIDIA RTX 4090 | NVIDIA RTX 4090 |
| Environment | Standard deep learning framework with CUDA acceleration | Standard deep learning framework with CUDA acceleration |

#### Demo Results:


## 🖼 Data Examples

The data encompasses a wide variety of reconstructed images, ranging from controlled digital phantoms (MNIST) in the simulated dataset to complex physical phantoms in the measured dataset.

---
![论文Figures_09](https://github.com/user-attachments/assets/8f19adc6-183e-49db-bef7-28a9a4ccff68)


## 📧 Project Contact

Project Contact: **Guanghui Li** (liguanghui@buaa.edu.cn)

---

## 🙏 Acknowledgement

We sincerely appreciate your interest in the **FFL-MPI-Data** project. We hope this dataset will significantly contribute to **FFL-MPI** image reconstruction research, addressing the need for high-quality, domain-specific data.

If you have any suggestions, questions, or discover any errors, please feel free to contact us!
