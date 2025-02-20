# Ollama First Try

## Get Start

```shell
Welcome to Ollama!

Run your first model:

        ollama run llama2

PS C:\Windows\system32> ollama run llama2
pulling manifest
pulling 8934d96d3f08... 100% ▕████████████████████████████████████████████████████████▏ 3.8 GB
pulling 8c17c2ebb0ea... 100% ▕████████████████████████████████████████████████████████▏ 7.0 KB
pulling 7c23fb36d801... 100% ▕████████████████████████████████████████████████████████▏ 4.8 KB
pulling 2e0493f67d0c... 100% ▕████████████████████████████████████████████████████████▏   59 B
pulling fa304d675061... 100% ▕████████████████████████████████████████████████████████▏   91 B
pulling 42ba7f8a01dd... 100% ▕████████████████████████████████████████████████████████▏  557 B
verifying sha256 digest
writing manifest
removing any unused layers
success
>>>
```



```python
>>> /?
Available Commands:
  /set            Set session variables
  /show           Show model information
  /load <model>   Load a session or model
  /save <model>   Save your current session
  /bye            Exit
  /?, /help       Help for a command
  /? shortcuts    Help for keyboard shortcuts

Use """ to begin a multi-line message.
```



```python
>>> /show info
Model details:
Family              llama
Parameter Size      7B
Quantization Level  Q4_0
```





```python
>>> /? shortcuts
Available keyboard shortcuts:
  Ctrl + a            Move to the beginning of the line (Home)
  Ctrl + e            Move to the end of the line (End)
   Alt + b            Move back (left) one word
   Alt + f            Move forward (right) one word
  Ctrl + k            Delete the sentence after the cursor
  Ctrl + u            Delete the sentence before the cursor

  Ctrl + l            Clear the screen
  Ctrl + c            Stop the model from responding
  Ctrl + d            Exit ollama (/bye)
```

### GPU Calling Check

```powershell
$ nvidia-smi
Tue Feb  4 08:15:11 2025
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 560.78                 Driver Version: 560.78         CUDA Version: 12.6     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                  Driver-Model | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 4060 ...  WDDM  |   00000000:06:00.0 Off |                  N/A |
| N/A   43C    P0             14W /   75W |       1MiB /   8188MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+

+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      3572      C   ...ta\Local\Programs\Ollama\ollama.exe      N/A      |
+-----------------------------------------------------------------------------------------+
```

```shell
$ ollama serve

2025/02/04 08:14:15 routes.go:1187: INFO server config env="map[CUDA_VISIBLE_DEVICES: GPU_DEVICE_ORDINAL: HIP_VISIBLE_DEVICES: HSA_OVERRIDE_GFX_VERSION: HTTPS_PROXY: HTTP_PROXY: NO_PROXY: OLLAMA_DEBUG:false OLLAMA_FLASH_ATTENTION:false OLLAMA_GPU_OVERHEAD:0 OLLAMA_HOST:http://127.0.0.1:11434 OLLAMA_INTEL_GPU:false OLLAMA_KEEP_ALIVE:5m0s OLLAMA_KV_CACHE_TYPE: OLLAMA_LLM_LIBRARY: OLLAMA_LOAD_TIMEOUT:5m0s OLLAMA_MAX_LOADED_MODELS:0 OLLAMA_MAX_QUEUE:512 OLLAMA_MODELS:C:\\Users\\Anxiu\\.ollama\\models OLLAMA_MULTIUSER_CACHE:false OLLAMA_NOHISTORY:false OLLAMA_NOPRUNE:false OLLAMA_NUM_PARALLEL:0 OLLAMA_ORIGINS:[http://localhost https://localhost http://localhost:* https://localhost:* http://127.0.0.1 https://127.0.0.1 http://127.0.0.1:* https://127.0.0.1:* http://0.0.0.0 https://0.0.0.0 http://0.0.0.0:* https://0.0.0.0:* app://* file://* tauri://* vscode-webview://*] OLLAMA_SCHED_SPREAD:false ROCR_VISIBLE_DEVICES:]"
time=2025-02-04T08:14:16.016Z level=INFO source=images.go:432 msg="total blobs: 9"
time=2025-02-04T08:14:16.017Z level=INFO source=images.go:439 msg="total unused blobs removed: 0"
time=2025-02-04T08:14:16.018Z level=INFO source=routes.go:1238 msg="Listening on 127.0.0.1:11434 (version 0.5.7)"
time=2025-02-04T08:14:16.019Z level=INFO source=routes.go:1267 msg="Dynamic LLM libraries" runners="[rocm_avx cpu cpu_avx cpu_avx2 cuda_v11_avx cuda_v12_avx]"
time=2025-02-04T08:14:16.019Z level=INFO source=gpu.go:226 msg="looking for compatible GPUs"
time=2025-02-04T08:14:16.019Z level=INFO source=gpu_windows.go:167 msg=packages count=1
time=2025-02-04T08:14:16.019Z level=INFO source=gpu_windows.go:183 msg="efficiency cores detected" maxEfficiencyClass=1
time=2025-02-04T08:14:16.019Z level=INFO source=gpu_windows.go:214 msg="" package=0 cores=14 efficiency=10 threads=18
time=2025-02-04T08:14:16.813Z level=INFO source=gpu.go:334 msg="detected OS VRAM overhead" id=GPU-74c9dff4-67cd-53d5-da84-a09cc6199351 library=cuda compute=8.9 driver=12.6 name="NVIDIA GeForce RTX 4060 Laptop GPU" overhead="857.4 MiB"
time=2025-02-04T08:14:16.815Z level=INFO source=types.go:131 msg="inference compute" id=GPU-74c9dff4-67cd-53d5-da84-a09cc6199351 library=cuda variant=v12 compute=8.9 driver=12.6 name="NVIDIA GeForce RTX 4060 Laptop GPU" total="8.0 GiB" available="6.9 GiB"
```

