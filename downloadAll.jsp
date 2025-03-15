<%@ page import="java.io.*, java.util.zip.*" %>
<%
    // Get the directory from request
    String dir = request.getParameter("dir");

    // Fix: If "dir" is null or empty, use the root directory
    String baseDir = application.getRealPath("/");
    String currentDir = (dir == null || dir.equals("null") || dir.isEmpty()) ? baseDir : baseDir + File.separator + dir;

    File folder = new File(currentDir);

    // Check if folder exists
    if (!folder.exists() || !folder.isDirectory()) {
        response.getWriter().write("❌ Directory not found.");
        return;
    }

    // ZIP file path
    String zipFileName = "AllFiles.zip";
    File zipFile = new File(baseDir, zipFileName);

    try {
        FileOutputStream fos = new FileOutputStream(zipFile);
        ZipOutputStream zos = new ZipOutputStream(fos);

        // Recursively add files and folders to ZIP
        addFilesToZip(folder, folder.getAbsolutePath(), zos);

        zos.close();
        fos.close();
    } catch (IOException e) {
        response.getWriter().write("❌ Error creating ZIP file.");
        return;
    }

    // Set response headers for download
    response.setContentType("application/zip");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + zipFile.getName() + "\"");

    // Stream ZIP file to response
    FileInputStream zipInStream = new FileInputStream(zipFile);
    OutputStream zipOutStream = response.getOutputStream();
    byte[] buffer = new byte[4096];
    int bytesRead;
    while ((bytesRead = zipInStream.read(buffer)) != -1) {
        zipOutStream.write(buffer, 0, bytesRead);
    }

    zipInStream.close();
    zipOutStream.close();

    // Cleanup: Delete ZIP file after download
    zipFile.delete();
%>

<%! 
// Recursive method to add files & folders to ZIP
private void addFilesToZip(File file, String basePath, ZipOutputStream zos) throws IOException {
    File[] files = file.listFiles();
    if (files == null) return;

    for (File f : files) {
        String zipEntryName = f.getAbsolutePath().substring(basePath.length() + 1);
        
        if (f.isDirectory()) {
            // Add folder entry (needed to preserve folder structure)
            zos.putNextEntry(new ZipEntry(zipEntryName + "/"));
            zos.closeEntry();
            
            // Recursively add subfolder contents
            addFilesToZip(f, basePath, zos);
        } else {
            // Add file to ZIP
            FileInputStream fis = new FileInputStream(f);
            zos.putNextEntry(new ZipEntry(zipEntryName));

            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = fis.read(buffer)) != -1) {
                zos.write(buffer, 0, bytesRead);
            }

            zos.closeEntry();
            fis.close();
        }
    }
}
%>
