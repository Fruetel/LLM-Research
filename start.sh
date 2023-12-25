#!/bin/bash

# Check if the llama.cpp directory does not exist
if [ ! -d "llama.cpp" ]; then
    git clone --depth 1 https://github.com/ggerganov/llama.cpp.git
fi

cd llama.cpp
make LLAMA_CUBLAS=1

# Check if the .gguf file does not exist
if [ ! -f "mixtral-8x7b-instruct-v0.1.Q5_0.gguf" ]; then
    wget https://huggingface.co/TheBloke/Mixtral-8x7B-Instruct-v0.1-GGUF/resolve/main/mixtral-8x7b-instruct-v0.1.Q5_0.gguf
fi

pip install llama-cpp-python[server]

# ./server -m mixtral-8x7b-instruct-v0.1.Q5_0.gguf -ngl 33 -c 16384 --port 31336 --host 0.0.0.0

python3 -m llama_cpp.server --model mixtral-8x7b-instruct-v0.1.Q5_0.gguf --n_gpu_layers 33 --port 31336 --host 0.0.0.0
