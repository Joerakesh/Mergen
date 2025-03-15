<%@ page import="java.io.*" %>
<%
    // Get the file parameter
    String fileName = request.getParameter("file");
    if (fileName == null || fileName.isEmpty()) {
        response.getWriter().write("No file specified.");
        return;
    }

    // Root path of the web app
    String baseDir = application.getRealPath("/");
    File file = new File(baseDir, fileName);

    // Check if file exists
    if (!file.exists() || !file.isFile()) {
        response.getWriter().write("File not found.");
        return;
    }

    // Set headers for file download
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");

    // Stream file to response
    FileInputStream inStream = new FileInputStream(file);
    OutputStream outStream = response.getOutputStream();
    byte[] buffer = new byte[4096];
    int bytesRead;
    while ((bytesRead = inStream.read(buffer)) != -1) {
        outStream.write(buffer, 0, bytesRead);
    }

    inStream.close();
    outStream.close();
%>
