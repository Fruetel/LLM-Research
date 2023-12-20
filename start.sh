#!/bin/bash
git clone --depth 1 https://github.com/ggerganov/llama.cpp.git
cd llama.cpp
make LLAMA_CUBLAS=1

wget https://huggingface.co/TheBloke/Mixtral-8x7B-Instruct-v0.1-GGUF/resolve/main/mixtral-8x7b-instruct-v0.1.Q5_0.gguf

./server -m mixtral-8x7b-instruct-v0.1.Q5_0.gguf -ngl 33 -c 16384 --port 31336 --host 0.0.0.0
