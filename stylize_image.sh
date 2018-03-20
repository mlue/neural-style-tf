set -e
# Get a carriage return into `cr`
cr=`echo $'\n.'`
cr=${cr%.}

# Parse arguments
content_image="$1"
content_dir=$(dirname "$content_image")
content_filename=$(basename "$content_image")
default_max_size=512

style_image="$2"
style_dir=$(dirname "$style_image" )
style_filename=$(basename "$style_image")
max_size=${4:-$default_max_size}

echo "Rendering stylized image. This may take a while..."
python neural_style.py \
       --content_img "${content_filename}" \
       --content_img_dir "${content_dir}" \
       --style_imgs "${style_filename}" \
       --style_imgs_dir "${style_dir}" \
       --device '/gpu:0' \
       --style_weight "$3" \
       --verbose \
       --max_size "$4" \
&& imgur-uploader --image image_output/result/result.png;
