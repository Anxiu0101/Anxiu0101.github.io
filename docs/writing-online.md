

# Online Writing

<script>
    document.addEventListener('DOMContentLoaded', () => {
        var simplemde = new SimpleMDE({ element: document.getElementById("OnlineEditor") });


        
        document.getElementById("saveButton").addEventListener("click", function() {
            // 获取 SimpleMDE 编辑器中的内容
            var markdownContent = simplemde.value();
        
            // 创建一个 FormData 对象，用于上传文件
            var formData = new FormData();
            formData.append("markdownFile", new Blob([markdownContent], { type: "text/markdown" }), "document.md");
        
            // 发送 POST 请求，配置跨域请求
            fetch("http://localhost:8080/upload", {
                method: "POST",
                body: formData,
                mode: "cors", // 允许跨域请求
                headers: {
                    // 如果需要，可以添加其他请求头
                },
            })
            .then(response => {
                if (response.status === 200) {
                    console.log("File uploaded successfully!");
                } else {
                    console.error("File upload failed");
                }
            })
            .catch(error => {
                console.error("Error:", error);
            });
        });
        
    });
</script>

<div>
    <textarea id="OnlineEditor" rows="10" cols="50"></textarea>
</div>
<button id="saveButton">保存并上传</button>