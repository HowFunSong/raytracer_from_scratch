#!/bin/bash
# ===========================================
#           Build and Run Script
# ===========================================

# Step 1: Clean old build files
echo "Cleaning old build files..."
if [ -d "build" ]; then
    rm -rf build
fi

# Step 2: Create the build directory if it does not exist
mkdir -p build

# Step 3: Compile the program
echo "Compiling the program..."
g++ -H -g -Llib -o build/main main.cpp -lSDL2 -static-libgcc -static-libstdc++

# Check if the compilation was successful
if [ $? -ne 0 ]; then
    echo "Compilation failed."
    exit 1
fi

echo "Compilation successful. Running the program..."

# Step 4: Run the compiled program
# Redirect std::cout to img.ppm and keep std::clog on the console
mkdir -p out
./build/main > out/img.ppm 2> >(cat >&2)

if [ $? -ne 0 ]; then
    echo "Failed to execute the program."
    exit 1
fi

echo "Output written to out/img.ppm"

# Step 5: Use ImageMagick to convert PPM to PNG
echo "Converting img.ppm to PNG..."
magick out/img.ppm out/raytracer.png

if [ $? -ne 0 ]; then
    echo "Failed to convert img.ppm to PNG."
    exit 1
fi

echo "Successfully converted img.ppm to PNG: out/raytracer.png"
