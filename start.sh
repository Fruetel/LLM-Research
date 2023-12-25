#!/bin/bash

# Check if the llama.cpp directory does not exist
if [ ! -d "llama.cpp" ]; then
    git clone --depth 1 https://github.com/ggerganov/llama.cpp.git
fi

cd llama.cpp
make LLAMA_CUBLAS=1

if [ $FORCE_DL = true ]; then
  rm -f dolphin-2.6-mixtral-8x7b.Q5_0.gguf
fi

ls -al

# Check if the .gguf file does not exist
if [ ! -f "dolphin-2.6-mixtral-8x7b.Q5_0.gguf" ]; then
    echo "Downloading!"
    wget https://huggingface.co/TheBloke/dolphin-2.6-mixtral-8x7b-GGUF/resolve/main/dolphin-2.6-mixtral-8x7b.Q5_0.gguf?download=true -O dolphin-2.6-mixtral-8x7b.Q5_0.gguf
fi

./server -m dolphin-2.6-mixtral-8x7b.Q5_0.gguf -ngl 33 -c 16384 --port 31336 --host 0.0.0.0
