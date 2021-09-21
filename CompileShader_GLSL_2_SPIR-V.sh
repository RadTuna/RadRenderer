
VK_PATH=/usr/bin/glslc

if [ -f "$VK_PATH" ]; then
    echo "Compile the shader files.\n"

    cd Shader

    for CUR_FILE in *.vert
    do
        #echo $CUR_FILE
        $VK_PATH $CUR_FILE -o $CUR_FILE.spv
        echo "$CUR_FILE.spv has been created."
    done

    for CUR_FILE in *.frag
    do
        #echo $CUR_FILE
        $VK_PATH $CUR_FILE -o $CUR_FILE.spv
        echo "$CUR_FILE.spv has been created."
    done

    echo "\nShader compilation is complete."
else
    echo "Failed to find glslc file."
    echo "Use the 'sudo apt install vulkan-sdk' command or get the appropriate binary from the following link and copy it to the /usr/bin location. https://github.com/google/shaderc/blob/main/downloads.md"
fi
