<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Explorer</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        .container {
            max-width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #333;
        }

        .button {
            display: inline-block;
            margin: 10px;
            padding: 10px 15px;
            background: #3498db;
            color: white;
            border-radius: 5px;
            text-decoration: none;
            font-size: 14px;
        }

        .button:hover {
            background: #217dbb;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        li {
            background: #f9f9f9;
            margin: 8px 0;
            padding: 12px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            transition: 0.3s;
        }

        li:hover {
            background: #e8e8e8;
        }

        .file-icon {
            font-size: 20px;
            margin-right: 10px;
        }

        .folder {
            color: #2c3e50;
            font-weight: bold;
            text-decoration: none;
        }

        .folder:hover {
            text-decoration: underline;
        }

        .download-btn {
            text-decoration: none;
            padding: 5px 12px;
            background: #27ae60;
            color: white;
            border-radius: 5px;
            font-size: 14px;
        }

        .download-btn:hover {
            background: #1f8e4b;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>📂 File Explorer</h2>

    <%
        // Get the requested directory from the URL
        String dir = request.getParameter("dir");
        
        // Root directory (relative to the web app)
        String baseDir = application.getRealPath("/");
        String currentDir = (dir == null || dir.isEmpty()) ? baseDir : baseDir + File.separator + dir;

        File folder = new File(currentDir);

        if (folder.exists() && folder.isDirectory()) {
            // Show "Go Up" link
            if (!currentDir.equals(baseDir)) {
                String parentDir = new File(currentDir).getParent().replace(baseDir, "");
    %>
                <a class="button" href="fileExplorer.jsp?dir=<%= parentDir %>">
                    <i class="fa fa-arrow-left"></i> Go Up
                </a>
    <%
            }
    %>

        <a class="button" href="downloadAll.jsp?dir=<%= dir %>">
            <i class="fa fa-download"></i> Download All Files
        </a>

        <ul>
    <%
            File[] files = folder.listFiles();
            if (files != null) {
                for (File file : files) {
                    String filePath = (dir == null || dir.isEmpty()) ? file.getName() : dir + "/" + file.getName();
                    if (file.isDirectory()) {
                        out.println("<li><i class='file-icon fa fa-folder'></i> <a class='folder' href='fileExplorer.jsp?dir=" + filePath + "'>" + file.getName() + "</a></li>");
                    } else {
                        out.println("<li><i class='file-icon fa fa-file'></i> " + file.getName() + " <a class='download-btn' href='download.jsp?file=" + filePath + "'>Download</a></li>");
                    }
                }
            }
    %>
        </ul>
    <%
        } else {
            out.println("<p style='color:red;'>❌ Folder not found or not accessible!</p>");
        }
    %>
</div>

</body>
</html>
